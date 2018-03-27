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
    public class CargaTampJ
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo TAMPJ");
            Console.WriteLine("Se inició la carga del archivo TAMPJ");

            string ruta = ConfigurationManager.AppSettings["RutaTampJ"];
            string[] campos = null;
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "TAMPJ_*.txt");
                //const char separador = '|';
                var datosColumn = GetLenghtColumns();

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(12, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(10, 2));
                    int año = Convert.ToInt32(onlyName.Substring(6, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance().GetCabeceraCargaProcesado(TipoArchivo.TampJ.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.TampJ, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-1"));
                    DataTable dt = Utils.CrearCabeceraDataTable<TampJ>();

                    //Leemos la cabecera del archivo
                    file.ReadLine();
                    file.ReadLine();
                    string line;
                    cont = 0;

                    while ((line = file.ReadLine()) != null)
                    {
                        cont++;
                        //var campos = line.Split(separador);
                        campos = GetDataColumn(line, datosColumn);
                        DataRow dr = GetDataRow(dt, campos);
                        dr["CabeceraCargaId"] = cabeceraId;
                        dr["Secuencia"] = cont;
                        dr["InformacionAl"] = fechaFile;

                        dt.Rows.Add(dr);
                    }

                    file.Close();
                    fileError = false;
                    CabeceraCargaBL.GetInstance().Add(dt, "TampJ");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    UtilsLocal.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);
                }
            }
            catch (Exception ex)
            {
                UtilsLocal.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                //Se incrementa en 2 debido a que la lectura empieza en la segunda linea
                cont += 2;
                string messageError = UtilsLocal.GetMessageError(fileError, campos, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo TAMPJ");
            Console.WriteLine("Se terminó la carga del archivo TAMPJ");
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
            dr["CodGesto"] = Utils.GetValueColumn(campos[0]);
            dr["NroCuenta"] = Utils.GetValueTrimStart(campos[1], '0');
            dr["Dias"] = Utils.GetValueColumn(campos[2]);
            dr["NumeroTarjeta"] = Utils.GetValueColumn(campos[3]);
            dr["SaldoDeuda"] = Utils.GetValueColumn(campos[4]);
            dr["MontoProtesto"] = Utils.GetValueColumn(campos[5]);
            dr["Capital"] = Utils.GetValueColumn(campos[6]);
            dr["InteresJudicial"] = Utils.GetValueColumn(campos[7]);
            dr["CargoJudicial"] = Utils.GetValueColumn(campos[8]);
            dr["InteresMorator"] = Utils.GetValueColumn(campos[9]);
            dr["CargoCobranza"] = Utils.GetValueColumn(campos[10]);
            dr["Situacion"] = Utils.GetValueColumn(campos[11]);
            dr["FechaProtes"] = Utils.GetDateFormat4(campos[12]);
            dr["FechaCastig"] = Utils.GetDateFormat4(campos[13]);
            dr["FechaAsigna"] = Utils.GetDateFormat4(campos[14]);
            dr["TipoDocumento"] = Utils.GetValueColumn(campos[15]);
            dr["NroDocumento"] = Utils.GetValueColumn(campos[16]);
            dr["DireccionParticular"] = Utils.GetValueColumn(campos[17]);
            dr["DistritoParticular"] = Utils.GetValueColumn(campos[18]);
            dr["UbigeoParticular"] = Utils.GetValueColumn(campos[19]);
            dr["DireccionComercial"] = Utils.GetValueColumn(campos[20]);
            dr["DistritoComercial"] = Utils.GetValueColumn(campos[21]);
            dr["Ubigeo"] = Utils.GetValueColumn(campos[22]);
            dr["Celular"] = Utils.GetValueColumn(campos[23]);
            dr["TelfParticular"] = Utils.GetValueColumn(campos[24]);
            dr["TelfComercial"] = Utils.GetValueColumn(campos[25]);
            dr["CorreoParticular"] = Utils.GetValueColumn(campos[26]);
            dr["CorreoComercial"] = Utils.GetValueColumn(campos[27]);
            //dr["InformacionAl"] = Utils.GetDateFormat4(campos[28]);
            dr["Col1"] = Utils.GetValueColumn(campos[29]);
            dr["Col2"] = Utils.GetValueColumn(campos[30]);
            dr["NombreCompleto"] = Utils.GetValueColumn(campos[31]);
            dr["NombreEmpresa"] = Utils.GetValueColumn(campos[32]);
            dr["FechaUltimo"] = Utils.GetDateFormat4(campos[33]);
            dr["MontoUltimoPago"] = Utils.GetValueColumn(campos[34]);
            dr["InteresCompens"] = Utils.GetValueColumn(campos[35]);
            dr["DeptoParticular"] = Utils.GetValueColumn(campos[36]);
            dr["ProvinciaParticular"] = Utils.GetValueColumn(campos[37]);
            dr["DeptoComercial"] = Utils.GetValueColumn(campos[38]);
            dr["ProvinciaComercial"] = Utils.GetValueColumn(campos[39]);

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
                new Tuple<int, int>(9, 12),
                new Tuple<int, int>(22, 5),
                new Tuple<int, int>(28, 16),
                new Tuple<int, int>(45, 15),
                new Tuple<int, int>(61, 15),
                new Tuple<int, int>(77, 15),
                new Tuple<int, int>(93, 15),
                new Tuple<int, int>(109, 15),
                new Tuple<int, int>(125, 15),
                new Tuple<int, int>(141, 15),
                new Tuple<int, int>(157, 4),
                new Tuple<int, int>(162, 8),
                new Tuple<int, int>(171, 8),
                new Tuple<int, int>(180, 8),
                new Tuple<int, int>(189, 20),
                new Tuple<int, int>(210, 25),
                new Tuple<int, int>(236, 80),
                new Tuple<int, int>(317, 20),
                new Tuple<int, int>(338, 80),
                new Tuple<int, int>(419, 80),
                new Tuple<int, int>(500, 80),
                new Tuple<int, int>(581, 6),
                new Tuple<int, int>(588, 13),
                new Tuple<int, int>(602, 13),
                new Tuple<int, int>(616, 13),
                new Tuple<int, int>(630, 50),
                new Tuple<int, int>(681, 50),
                new Tuple<int, int>(732, 8),
                new Tuple<int, int>(741, 4),
                new Tuple<int, int>(746, 4),
                new Tuple<int, int>(751, 80),
                new Tuple<int, int>(832, 80),
                new Tuple<int, int>(913, 8),
                new Tuple<int, int>(922, 15),
                new Tuple<int, int>(938, 15),
                new Tuple<int, int>(954, 20),
                new Tuple<int, int>(975, 20),
                new Tuple<int, int>(996, 20),
                new Tuple<int, int>(1017, 19)
            };

            return columns;
        }

        #endregion
    }
}