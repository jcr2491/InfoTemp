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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.DTiemposdeEspera
{
    public class CargaRITECCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Tiempo de Espera - CCFF");
            Console.WriteLine("Se inició la carga del archivo Tiempo de Espera - CCFF");

            string tipoArchivo = TipoArchivo.RITiempoEsperaCCFF.GetStringValue();
            var cargaBase = new CargaBase(tipoArchivo, "RITECCFF");

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

                        string id = Utils.GetValueColumn(
                            excel.GetCellToString(row,
                                cargaBase.PropiedadCol.First(p => p.Key == "TECCFFId").Value.PosicionColumna),
                            string.Empty);

                        if ((id != string.Empty) &&
                            !(id.StartsWith("Zona", StringComparison.InvariantCultureIgnoreCase)) &&
                            !(id.StartsWith("Banco", StringComparison.InvariantCultureIgnoreCase)))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "RITECCFF");
                }
            }
            catch (Exception ex)
            {
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Tiempo de Espera - CCFF");
            Console.WriteLine("Se terminó la carga del archivo Tiempo de Espera - CCFF");
        }

        #endregion
    }
}