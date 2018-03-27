using System;
using System.Collections.Generic;
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
    public class CargaPagosHc
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo PagosHc");
            Console.WriteLine("Se inició la carga del archivo PagosHc");

            string ruta = ConfigurationManager.AppSettings["RutaPagosHc"];
            string[] campos = null;
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "*Pagos.txt");
                var datosColumn = GetLenghtColumns();

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(6, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(4, 2));
                    int año = Convert.ToInt32(onlyName.Substring(0, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance().GetCabeceraCargaProcesado(TipoArchivo.PagosHc.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.PagosHc, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-1"));
                    DataTable dt = Utils.CrearCabeceraDataTable<PagoHc>();

                    string line;
                    cont = 0;

                    while ((line = file.ReadLine()) != null)
                    {
                        cont++;
                        campos = GetDataColumn(line, datosColumn);
                        DataRow dr = GetDataRow(dt, campos);
                        dr["CabeceraCargaId"] = cabeceraId;
                        dr["Secuencia"] = cont;

                        dt.Rows.Add(dr);
                    }

                    file.Close();
                    fileError = false;
                    CabeceraCargaBL.GetInstance().Add(dt, "PagoHc");

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

            Logger.Info("Se terminó la carga del archivo PagosHc");
            Console.WriteLine("Se terminó la carga del archivo PagosHc");
        }

        #endregion

        #region Métodos Privados

        private static string[] GetDataColumn(string line, List<Tuple<int, int>> lenghtColumns)
        {
            string[] datos = lenghtColumns.Select(p => line.Substring(p.Item1, p.Item2)).ToArray();

            return datos;
        }

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["FechaPago"] = Utils.GetDateFormat4(campos[0]);
            dr["NroCuenta"] = Utils.GetValueTrimStart(campos[2], '0');
            dr["Descripcion"] = Utils.GetValueColumn(campos[4]);
            dr["Monto"] = Utils.GetValueColumn(campos[5]);

            return dr;
        }

        /// <summary>
        /// Devuelve una lista de Tuplas: inicio y longitud
        /// </summary>
        /// <returns></returns>
        private static List<Tuple<int, int>> GetLenghtColumns()
        {
            List<Tuple<int, int>> columns = new List<Tuple<int, int>>
            {
                new Tuple<int, int>(0, 8),
                new Tuple<int, int>(8, 2),
                new Tuple<int, int>(10, 10),
                new Tuple<int, int>(20, 10),
                new Tuple<int, int>(30, 31),
                new Tuple<int, int>(61, 139)
            };

            return columns;
        }

        #endregion
    }
}