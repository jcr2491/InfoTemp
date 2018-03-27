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
    public class CargaCastigoHc
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo CastigoHc");
            Console.WriteLine("Se inició la carga del archivo CastigoHc");

            string ruta = ConfigurationManager.AppSettings["RutaCastigoHc"];
            string[] campos = null;
            int cont = 0;
            int cabeceraId = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "*castigohc.csv");
                const char separador = ',';

                Console.WriteLine($"ruta: {ruta}");

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    Console.WriteLine($"nombre: {onlyName}");

                    int dia = Convert.ToInt32(onlyName.Substring(0, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(2, 2));
                    int año = Convert.ToInt32(onlyName.Substring(4, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance()
                        .GetCabeceraCargaProcesado(TipoArchivo.CastigoHc.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.CastigoHc, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.UTF8);
                    DataTable dt = Utils.CrearCabeceraDataTable<CastigoHc>();

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
                        dr["Fecha"] = fechaFile;

                        dt.Rows.Add(dr);
                    }

                    file.Close();
                    fileError = false;
                    CabeceraCargaBL.GetInstance().Add(dt, "CastigoHc");

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

            Logger.Info("Se terminó la carga del archivo CastigoHc");
            Console.WriteLine("Se terminó la carga del archivo CastigoHc");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["NroCuenta"] = Utils.GetValueTrimStart(campos[0], '0');
            dr["Sit"] = Utils.GetStringColumn(campos[1]);
            dr["FechaCastigo"] = Utils.GetDateFormat5(campos[2]);
            dr["Considerar"] = GetValueColumnConsiderar(campos[3]);

            return dr;
        }

        private static object GetValueColumnConsiderar(string value)
        {
            value = value.Trim();
            if (value != string.Empty)
            {
                return value.ToUpper().StartsWith("SI");
            }

            return DBNull.Value;
        }

        #endregion
    }
}