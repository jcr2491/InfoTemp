using log4net;
using NPOI.SS.UserModel;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;


namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.UAC
{
    public class CargaMonitoreo
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);        

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Productividad");
            Console.WriteLine("Se inició la carga del archivo Productividad");
            var cargaBase = new CargaBase<Productividad>();
            string tipoArchivo = TipoArchivo.Monitoreo.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                 cargaBase = new CargaBase<Productividad>(tipoArchivo);
                var filesNames = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);
                    DateTime fechaModificacion = File.GetLastWriteTime(fileName);

                    var cabecera = CabeceraCargaBL.GetInstance().GetCabeceraCargaProcesado(tipoArchivo, fechaFile);
                    if (cabecera != null)
                    {
                        if (fechaModificacion.GetDateTimeToString() ==
                            cabecera.FechaModificacionArchivo.GetDateTimeToString()) continue;
                    }

                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.Monitoreo, EstadoCarga.Iniciado, fechaFile);                    
                    cabeceraId = cargaBase.AgregarCabecera(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<Monitoreo>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    string grupo = string.Empty;
                    string supervisor = string.Empty;
                    cont = 0;

                    //TODO: Aqui se debe hacer la logica para consumir de la tabla excel de configuracion

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        string pase = excel.GetStringCellValue(row, cargaBase.PropiedadCol.First(p => p.Key == "Semana").Value.PosicionColumna);
                        if (pase != string.Empty)
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;                            
                            
                            dt.Rows.Add(dr);

                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                        }   else { goto saltar; }                    
                    }
                saltar:
                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "Monitoreo");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);

                    //Se coloca el Id del empleado a los registros
                    CargaArchivoBL.GetInstance().AddEmpleadoId("Monitoreo", "Empleado", "EmpleadoId");

                }
            }
            catch (Exception ex)
            {
                cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Monitoreo");
            Console.WriteLine("Se terminó la carga del archivo Monitoreo");
        }

        #endregion

        //#region Métodos Privados

        //private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        //{
        //    DataRow dr = dt.NewRow();
        //    dr["Semana"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Semana"]));
        //    dr["FechaMuestra"] = excel.GetDateCellValue(row, _indexCol["FechaMuestra"]);
        //    dr["Mes"] = excel.GetIntCellValue(row, _indexCol["Mes"]);
        //    dr["Incidente"] = excel.GetIntCellValue(row, _indexCol["Incidente"]);
        //    dr["Empleado"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Empleado"]));
        //    dr["Proceso"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Proceso"]));
        //    dr["TipoMonitoreo"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["TipoMonitoreo"]));
        //    dr["CR1"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CR1"]));
        //    dr["CR2"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CR2"]));
        //    dr["CR3"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CR3"]));
        //    dr["CR4"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CR4"]));
        //    dr["CR5"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CR5"]));
        //    dr["CR6"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CR6"]));
        //    dr["CR7"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CR7"]));
        //    dr["CS1"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CS1"]));
        //    dr["CS2"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CS2"]));
        //    dr["CP1"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CP1"]));
        //    dr["OR1"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["OR1"]));
        //    dr["OR2"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["OR2"]));
        //    dr["VR1"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["VR1"]));
        //    dr["VR2"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["VR2"]));
        //    dr["VR3"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["VR3"]));
        //    dr["VR4"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["VR4"]));
        //    dr["MR1"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["MR1"]));
        //    dr["MR2"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["MR2"]));
        //    dr["MR3"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["MR3"]));

        //    return dr;
        //}

        //#endregion
    }
}