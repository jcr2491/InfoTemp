using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using log4net;
using NPOI.SS.UserModel;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Rapicash
{
    public class CargaPlanillaCajeroTottusRapicash
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Planilla Maestro");
            Console.WriteLine("Se inició la carga del archivo Planilla Maestro");
            var cargaBase = new CargaBase<CajeroTottusRapicash>();
            string tipoArchivo = TipoArchivo.PlanillaMaestroRapicash.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            {
                 cargaBase = new CargaBase<CajeroTottusRapicash>(tipoArchivo);
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

                    cabeceraId = cargaBase.AgregarCabecera(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });
                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.MetaTottusRapicash, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<CajeroTottusRapicash>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;
                    string Tienda = string.Empty;
                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        Tienda = Utils.GetValueColumn(
                           excel.GetStringCellValue(row,
                               cargaBase.PropiedadCol.First(p => p.Key == "Tienda").Value.PosicionColumna),
                           Tienda);

                        if (!string.IsNullOrWhiteSpace(Tienda))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["Tienda"] = Tienda;

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "PlanillaCajeroTottusRapicash");

                    cargaError = false;
                    //Se actualiza a procesado la tabla CabeceraCarga
                    cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);

                    //Se coloca el Id del empleado a los registros
                    //CargaArchivoBL.GetInstance().AddEmpleadoId("MetaTiendaRapicash", "Empleado", "EmpleadoId");
                }
            }
            catch (Exception ex)
            {
                if (cargaError) cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Planilla Maestro");
            Console.WriteLine("Se terminó la carga del archivo Planilla Maestro");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            DataRow dr = dt.NewRow();
            dr["TiendaId"] = TiendaRetail.Maestro.GetStringValue();
            dr["Mes"] = excel.GetIntCellValue(row, _indexCol["Mes"]);
            dr["Anio"] = excel.GetIntCellValue(row, _indexCol["Anio"]);
            dr["Tienda"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Tienda"]), "");
            dr["Plla"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Plla"]), "");
            dr["Puesto"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Puesto"]), "");
            dr["Codigo"] = excel.GetIntCellValue(row, _indexCol["Codigo"]);
            string apellidoParterno = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["ApellidoPaterno"]), "");
            string apellidoMaterno = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["ApellidoMaterno"]), "");
            string Colaborador = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Colaborador"]), "");
            dr["Colaborador"] = apellidoParterno + " " + apellidoMaterno + " " + Colaborador;
            dr["DNI"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["DNI"]), "");
            return dr;
        }

        #endregion
    }
}
