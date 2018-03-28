using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Reflection;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Enums;
using Falabella.Entity;
using log4net;

namespace Falabella.Consola
{
    public class CargaRefinanciados
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Refinanciados");
            Console.WriteLine("Se inició la carga del archivo Refinanciados");

            string ruta = ConfigurationManager.AppSettings["RutaRefinanciados"];
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "*rptreporterefinanciacionesdetalle.xlsx");

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(0, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(2, 2));
                    int año = Convert.ToInt32(onlyName.Substring(4, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance()
                        .GetCabeceraCargaProcesado(TipoArchivo.Refinanciados.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.Refinanciados, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new ExcelXlsx(fileBase, 0);
                    DataTable dt = Utils.CrearCabeceraDataTable<Refinanciados>();
                    int rowNum = 20;
                    cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);

                    while (row != null)
                    {
                        cont++;
                        DataRow dr = dt.NewRow();
                        dr["CabeceraCargaId"] = cabeceraId;
                        dr["Secuencia"] = cont;
                        dr["NroCuenta"] = Utils.GetValueTrimStart(excel.GetStringCellValue(row, 3), '0');
                        dr["EstadoActual"] = Utils.GetValueColumn(excel.GetStringCellValue(row, 25));
                        dr["SaldoCapital"] = excel.GetDoubleCellValue(row, 12);
                        dr["FechaOperacion"] = excel.GetDateCellValue(row, 8);

                        dt.Rows.Add(dr);

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CabeceraCargaBL.GetInstance().Add(dt, "Refinanciados");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    UtilsLocal.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);
                }
            }
            catch (Exception ex)
            {
                UtilsLocal.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Refinanciados");
            Console.WriteLine("Se terminó la carga del archivo Refinanciados");
        }

        #endregion
    }
}