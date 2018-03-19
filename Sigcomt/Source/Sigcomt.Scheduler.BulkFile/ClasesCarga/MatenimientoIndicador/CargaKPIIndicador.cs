using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using log4net;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.MatenimientoIndicador
{
    public class CargaKPIIndicador
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo KPI Indicador");
            Console.WriteLine("Se inició la carga del archivo KPI Indicador");

            string tipoArchivo = TipoArchivo.KPIIndicador.GetStringValue();
            var cargaBase = new CargaBase(tipoArchivo, "KPIIndicador");

            try
            {
                cargaBase.ValidarExisteDirectorio();
                var filesNames = cargaBase.GetNombreArchivos();

                foreach (var fileName in filesNames)
                {
                    DateTime fechaFile = cargaBase.GetFechaArchivo(fileName);
                    DateTime fechaModificacion = File.GetLastWriteTime(fileName);

                    var cabecera = CabeceraCargaBL.GetInstance().GetCabeceraCargaProcesado(tipoArchivo, fechaFile);
                    if (cabecera != null && cabecera.FechaModificacionArchivo == fechaModificacion) continue;

                    GenericExcel excel = cargaBase.GetHojaExcel(fileName);

                    cargaBase.AgregarCabeceraCarga(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });

                    Console.WriteLine("Se está procesando el archivo: " + fileName + " Hoja: " +
                                      cargaBase.HojaBd.NombreHoja);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName + " Hoja: " +
                                      cargaBase.HojaBd.NombreHoja);

                    DataTable dt = cargaBase.CrearCabeceraDataTable();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    int cont = 0;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        }

                        string kpiId = Utils.GetValueColumn(
                            excel.GetCellToString(row,
                                cargaBase.PropiedadCol.First(p => p.Key == "KpiId").Value.PosicionColumna),
                            string.Empty);

                        if (!string.IsNullOrWhiteSpace(kpiId) && Char.IsNumber(kpiId, 0))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;

                            string estado = Utils.GetValueColumn(
                                excel.GetCellToString(row,
                                    cargaBase.PropiedadCol.First(p => p.Key == "Estado").Value.PosicionColumna),
                                string.Empty);

                            if (estado == "Activo" || estado == "ACTIVO")
                            {
                                dr["Estado"] = 1; //Activo
                            }
                            else
                            {
                                dr["Estado"] = 2; //Inactivo
                            }

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "KPIIndicador");
                }
            }
            catch (Exception ex)
            {
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo KPI Indicador");
            Console.WriteLine("Se terminó la carga del archivo KPI Indicador");
        }

        #endregion
    }
}
