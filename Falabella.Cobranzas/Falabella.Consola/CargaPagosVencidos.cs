using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Reflection;
using System.Text;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Enums;
using Falabella.Entity;
using log4net;

namespace Falabella.Consola
{
    public class CargaPagosVencidos
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo PagosVencidos");
            Console.WriteLine("Se inició la carga del archivo PagosVencidos");

            string ruta = ConfigurationManager.AppSettings["RutaPagosVencidos"];
            string[] campos = null;
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "*PAGOS_VENC.txt");
                const char separador = '|';

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(6, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(4, 2));
                    int año = Convert.ToInt32(onlyName.Substring(0, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance().GetCabeceraCargaProcesado(TipoArchivo.PagosVencidos.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.PagosVencidos, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-1"));
                    DataTable dt = Utils.CrearCabeceraDataTable<PagosVencidos>();

                    //Leemos la cabecera del archivo
                    file.ReadLine();
                    string line;
                    cont = 0;

                    while ((line = file.ReadLine()) != null)
                    {
                        cont++;
                        campos = line.Split(separador);
                        DataRow dr = GetDataRow(dt, campos);
                        dr["CabeceraCargaId"] = cabeceraId;
                        dr["Secuencia"] = cont;

                        dt.Rows.Add(dr);
                    }

                    file.Close();
                    fileError = false;
                    CabeceraCargaBL.GetInstance().Add(dt, "PagosVencidos");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    UtilsLocal.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);
                }
            }
            catch (Exception ex)
            {
                UtilsLocal.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                //Se incrementa en 1 debido a que la lectura empieza en la segunda linea
                cont++;
                string messageError = UtilsLocal.GetMessageError(fileError, campos, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo PagosVencidos");
            Console.WriteLine("Se terminó la carga del archivo PagosVencidos");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["Fecha"] = Utils.GetDateFormat5(campos[0]);
            dr["Hora"] = Utils.GetHourFormat(campos[1]);
            dr["NroCuentaOrigen"] = Utils.GetValueTrimStart(campos[2], '0');
            dr["NroCreditoVencido"] = Utils.GetValueColumn(campos[3]);
            dr["Moneda"] = Utils.GetValueColumn(campos[4]);
            dr["Local"] = Utils.GetValueColumn(campos[5]);
            dr["Terminal"] = Utils.GetValueColumn(campos[6]);
            dr["CodigoPago"] = Utils.GetValueColumn(campos[7]);
            dr["Descripcion"] = Utils.GetValueColumn(campos[8]);
            dr["Monto"] = Utils.GetValueColumn(campos[9]);
            dr["FechaRegularizacion"] = Utils.GetDateFormat5(campos[10]);

            return dr;
        }

        #endregion
    }
}