using log4net;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;
using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Automotriz
{
    public class CargaDataAutomotriz
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo DataAutomotriz");
            Console.WriteLine("Se inició la carga del archivo DataAutomotriz");

            string tipoArchivo = TipoArchivo.DataAutomotriz.GetStringValue();
            var cargaBase = new CargaBase(tipoArchivo, "DataAutomotriz");

            try
            {
                cargaBase.ValidarExisteDirectorio();
                var filesNames = cargaBase.GetNombreArchivos();
                foreach (var fileName in filesNames)
                {
                    DateTime fechaFile = cargaBase.GetFechaArchivo(fileName);
                    DateTime fechaModificacion = File.GetLastWriteTime(fileName);

                    var cabecera = CabeceraCargaBL.GetInstance().GetCabeceraCargaProcesado(tipoArchivo, fechaFile);
                    if (cabecera != null)
                    {
                        if (fechaModificacion.GetDateTimeToString() ==
                            cabecera.FechaModificacionArchivo.GetDateTimeToString())
                        {
                            continue;
                        }
                    }

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

                    //DataTable dt = Utils.CrearCabeceraDataTable<DataAutomotriz>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    int cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);
                    string empleado = string.Empty;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);

                        if (!isValid)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        }

                        empleado = Utils.GetValueColumn(
                            excel.GetCellToString(row,
                                cargaBase.PropiedadCol.First(p => p.Key == "Empleado").Value.PosicionColumna),
                            empleado);

                        if (!string.IsNullOrWhiteSpace(empleado))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;
                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                        empleado = string.Empty;
                    }

                    cargaBase.RegistrarCarga(dt, "DataAutomotriz");
                    //Se coloca el Id del empleado a los registros
                    CargaArchivoBL.GetInstance().AddEmpleadoId("DataAutomotriz", "Empleado", "EmpleadoId");
                    CargaArchivoBL.GetInstance().AddEmpleadoId("DataAutomotriz", "Promotor", "PromotorId");
                    CargaArchivoBL.GetInstance().AddEmpleadoId("DataAutomotriz", "Asistente", "AsistenteId");
                }
            }
            catch (Exception ex)
            {
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo DataAutomotriz");
            Console.WriteLine("Se terminó la carga del archivo DataAutomotriz");
        }

        #endregion 
    }
}