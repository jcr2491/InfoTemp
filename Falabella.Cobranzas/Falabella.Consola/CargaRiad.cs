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
    public class CargaRiad
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private const int LengthLinea = 195;
        //Estos códigos identifican que se trata de una tarjeta de credito (TC)
        private static readonly string[] CodigosTc = {"411", "413", "414", "416", "430", "431", "432", "433", "434", "435", "436"};

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo RI1AD");
            Console.WriteLine("Se inició la carga del archivo RI1AD");

            string ruta = ConfigurationManager.AppSettings["RutaRiad"];
            string[] campos = null;
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "RI1AD*.txt");
                var datosColumn = GetLenghtColumns();

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(11, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(9, 2));
                    int año = Convert.ToInt32(onlyName.Substring(5, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance().GetCabeceraCargaProcesado(TipoArchivo.Riad.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.Riad, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-1"));
                    DataTable dt = Utils.CrearCabeceraDataTable<Riad>();
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
                    CabeceraCargaBL.GetInstance().Add(dt, "Riad");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    UtilsLocal.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);
                }
            }
            catch (Exception ex)
            {
                UtilsLocal.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, campos, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo RI1AD");
            Console.WriteLine("Se terminó la carga del archivo RI1AD");
        }

        #endregion

        #region Métodos Privados

        private static string[] GetDataColumn(string line, List<Tuple<int, int>> lenghtColumns)
        {
            // Se hace esta validación para casos en los cuales el campo nombre presenta menos de 50 caracteres
            if (line.Length < LengthLinea)
            {
                string spaces = string.Empty.PadRight(LengthLinea - line.Length);
                line = line.Insert(115, spaces);
            }

            string[] datos = lenghtColumns.Select(p => line.Substring(p.Item1, p.Item2)).ToArray();

            return datos;
        }

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["Fecha"] = Utils.GetDateFormat3(campos[0]);
            dr["NroCuenta"] = Utils.GetValueTrimStart(campos[1], '0');
            dr["CSbs"] = Utils.GetValueColumn(campos[2]);
            dr["TipoDoc"] = Utils.GetValueColumn(campos[3]);
            dr["NroDoc"] = Utils.GetValueColumn(campos[4]);
            dr["Nombres"] = Utils.GetValueColumn(campos[5]);
            dr["SubProducto"] = Utils.GetValueColumn(campos[6]);
            dr["DiasMora"] = Utils.GetValueColumn(campos[7]);
            dr["EstadoCuenta"] = Utils.GetValueColumn(campos[8]);
            dr["CatProducto"] = Utils.GetValueColumn(campos[9]);
            dr["CatInterna"] = Utils.GetValueColumn(campos[10]);
            dr["CatSbs"] = Utils.GetValueColumn(campos[11]);
            dr["CatExterna"] = Utils.GetValueColumn(campos[12]);
            dr["Capital"] = Utils.GetValueColumn(campos[13]);
            dr["ProvAlineada"] = Utils.GetValueColumn(campos[14]);
            dr["ProvInterna"] = Utils.GetValueColumn(campos[15]);
            dr["TipoCredito"] = Utils.GetValueColumn(campos[16]);
            dr["Tienda"] = Utils.GetValueColumn(campos[17]);
            dr["FolioErrado"] = Utils.GetValueColumn(campos[18]);
            if (CodigosTc.Any(p => p == campos[6].Trim())) dr["EsTarjetaCredito"] = true;

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
                new Tuple<int, int>(0, 6),
                new Tuple<int, int>(6, 12),
                new Tuple<int, int>(18, 27),
                new Tuple<int, int>(45, 1),
                new Tuple<int, int>(46, 20),
                new Tuple<int, int>(66, 50),
                new Tuple<int, int>(116, 3),
                new Tuple<int, int>(119, 4),
                new Tuple<int, int>(123, 2),
                new Tuple<int, int>(125, 1),
                new Tuple<int, int>(126, 1),
                new Tuple<int, int>(127, 1),
                new Tuple<int, int>(128, 1),
                new Tuple<int, int>(129, 18),
                new Tuple<int, int>(147, 18),
                new Tuple<int, int>(165, 18),
                new Tuple<int, int>(183, 1),
                new Tuple<int, int>(184, 4),
                new Tuple<int, int>(188, 7)
            };

            return columns;
        } 

        #endregion
    }
}