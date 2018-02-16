using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Reflection;
using log4net;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga
{
    public class CargaProducContactenos
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Productividad");
            Console.WriteLine("Se inició la carga del archivo Productividad");

            string ruta = ConfigurationManager.AppSettings["RutaEmpleado"];
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                //Nota: estamos asumiendo que delante vendra la fecha del archivo
                var filesNames = Directory.GetFiles(ruta, "*DiasAusencia.xlsx");

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance()
                        .GetCabeceraCargaProcesado(TipoArchivo.ProducContactenos.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.ProducContactenos, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, 0);
                    DataTable dt = Utils.CrearCabeceraDataTable<ProducContactenos>();
                    int rowNum = 7;
                    cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);
                    //string grupo = string.Empty;
                    //string supervisor = string.Empty;

                    //TODO: Aqui se debe hacer la logica para consumir de la tabla excel de configuracion

                    while (row != null)
                    {
                        cont++;
                        DataRow dr = dt.NewRow();
                        dr["CargaId"] = cabeceraId;
                        dr["Secuencia"] = cont;
                        dr["Empleado"] = Utils.GetValueColumn(excel.GetStringCellValue(row, 0));
                        dr["TotalAtentido"] = excel.GetIntCellValue(row, 1);
                        dr["DiasLaborados"] = excel.GetIntCellValue(row, 2);                        
                        dr["MetaDiaria"] = excel.GetIntCellValue(row, 3);
                        dr["MetaMes"] = excel.GetIntCellValue(row, 4);
                        dr["Productividad"] = Utils.GetValueColumn(excel.GetCellToString(row, 6));                        

                        dt.Rows.Add(dr);

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "ProducContactenos");

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

            Logger.Info("Se terminó la carga del archivo Productividad");
            Console.WriteLine("Se terminó la carga del archivo Productividad");
        }

        #endregion
    }
}
