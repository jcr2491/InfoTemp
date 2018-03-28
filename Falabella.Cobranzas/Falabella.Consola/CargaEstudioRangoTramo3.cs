using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Enums;
using Falabella.Entity;
using log4net;

namespace Falabella.Consola
{
    public class CargaEstudioRangoTramo3
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo EstudioRangoTramo3");
            Console.WriteLine("Se inició la carga del archivo EstudioRangoTramo3");

            string ruta = ConfigurationManager.AppSettings["RutaEstudioRangoTramo3"];
            string[] campos = null;
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "*EstudioRangoTramo3.csv");
                const char separador = ',';

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(6, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(4, 2));
                    int año = Convert.ToInt32(onlyName.Substring(0, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance()
                        .GetCabeceraCargaProcesado(TipoArchivo.EstudioRangoTramo3.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.EstudioRangoTramo3, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-1"));
                    DataTable dt = Utils.CrearCabeceraDataTable<EstudioRangoTramo3>();

                    //Leemos la cabecera del archivo
                    file.ReadLine();
                    string line;
                    cont = 0;

                    while ((line = file.ReadLine()) != null)
                    {
                        campos = line.Split(separador);

                        if (campos.All(string.IsNullOrEmpty)) continue;

                        var ubigeos = campos[4].Split('o', 'O');
                        foreach (string ubigeo in ubigeos)
                        {
                            cont++;
                            DataRow dr = GetDataRow(dt, campos);
                            dr["CabeceraCargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["Ubigeo"] = Utils.GetValueReplace(ubigeo, "x", "%");

                            dt.Rows.Add(dr);
                        }
                    }

                    file.Close();
                    fileError = false;
                    CabeceraCargaBL.GetInstance().Add(dt, "EstudioRangoTramo3");

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

            Logger.Info("Se terminó la carga del archivo EstudioRangoTramo3");
            Console.WriteLine("Se terminó la carga del archivo EstudioRangoTramo3");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["Fecha"] = Utils.GetDateFormat5(campos[0]);
            dr["Estudio"] = Utils.GetValueColumn(campos[1]);
            dr["Rango"] = Utils.GetValueColumn(campos[2]);
            dr["Meta"] = Utils.GetPorcentaje(campos[3]);

            return dr;
        }

        #endregion
    }
}