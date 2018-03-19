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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.EjecutivosPromotores
{
    public class CargaTarjetaPromotorCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo TarjetaPromotorCCFF");
            Console.WriteLine("Se inició la carga del archivo TarjetaPromotorCCFF");

            // string tipoArchivo = TipoArchivo.TarjetaPromotorCCFF.GetStringValue();
            string tipoArchivo = "";

            var cargaBase = new CargaBase(tipoArchivo, "TarjetaPromotorCCFF");

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
                            cabecera.FechaModificacionArchivo.GetDateTimeToString()) continue;
                    }

                    GenericExcel excel = cargaBase.GetHojaExcel(fileName);

                    var cabeceraId = cargaBase.AgregarCabeceraCarga(new CabeceraCarga
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
                    int cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);

                    while (row != null)
                    {
                        //Validation row
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        }

                        string empleadoId = Utils.GetValueColumn(
                            excel.GetStringCellValue(row,
                                cargaBase.PropiedadCol.First(p => p.Key == "EmpleadoId").Value.PosicionColumna),
                            string.Empty);

                        if (!string.IsNullOrWhiteSpace(empleadoId))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["EmpleadoId"] = empleadoId;
                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "TarjetaPromotorCCFF");
                }
            }
            catch (Exception ex)
            {
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo AmpliacionesCCFF");
            Console.WriteLine("Se terminó la carga del archivo AmpliacionesCCFF");
        }

        #endregion
    }
}