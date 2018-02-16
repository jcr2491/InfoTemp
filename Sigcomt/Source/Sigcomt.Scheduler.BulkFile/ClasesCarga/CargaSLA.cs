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
    public class CargaSLA
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Productividad");
            Console.WriteLine("Se inició la carga del archivo Productividad");

            string ruta = ConfigurationManager.AppSettings["RutaProductividad"];
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                //Nota: estamos asumiendo que delante vendra la fecha del archivo
                var filesNames = Directory.GetFiles(ruta, "*Productividad.xlsx");

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance()
                        .GetCabeceraCargaProcesado(TipoArchivo.SLA.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.SLA, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, 0);
                    DataTable dt = Utils.CrearCabeceraDataTable<SLA>();
                    int rowNum = 6;
                    cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);
                    string grupo = string.Empty;
                    string supervisor = string.Empty;

                    //TODO: Aqui se debe hacer la logica para consumir de la tabla excel de configuracion

                    while (row != null)
                    {
                        cont++;
                        DataRow dr = dt.NewRow();
                        dr["CargaId"] = cabeceraId;
                        dr["Secuencia"] = cont;

                        supervisor = Utils.GetValueColumn(excel.GetStringCellValue(row, 0), supervisor);
                        grupo = Utils.GetValueColumn(excel.GetStringCellValue(row, 1), grupo);

                        dr["Supervisor"] = supervisor;
                        dr["Grupo"] = grupo;
                        dr["Empleado"] = Utils.GetValueColumn(excel.GetStringCellValue(row, 2));
                        dr["FueraPlazo"] = Utils.GetValueColumn(excel.GetCellToString(row, 3));
                        dr["DentroPlazo"] = Utils.GetValueColumn(excel.GetCellToString(row, 4));
                        dr["TotalGeneral"] = Utils.GetValueColumn(excel.GetCellToString(row, 5));
                        dr["SLAConAjuste"] = Utils.GetValueColumn(excel.GetCellToString(row, 7));
                        dr["SLASinAjuste"] = Utils.GetValueColumn(excel.GetCellToString(row, 9));

                        dt.Rows.Add(dr);

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "SLA");

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
