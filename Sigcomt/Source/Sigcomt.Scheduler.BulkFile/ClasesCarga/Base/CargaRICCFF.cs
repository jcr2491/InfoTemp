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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Base
{
    public class CargaRICCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static bool CargarArchivo()
        {
            bool result = true;
            Logger.Info("Se inició la carga del archivo Informacion Comercial");
            Console.WriteLine("Se inició la carga del archivo Informacion Comercial");

            string tipoArchivo = TipoArchivo.InfoComercial.GetStringValue();
            var cargaBase = new CargaBase(tipoArchivo, "InfoComercial");

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

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    var cont = 0;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        }

                        string ccff = Utils.GetValueColumn(
                            excel.GetStringCellValue(row,
                                cargaBase.PropiedadCol.First(p => p.Key == "CCFF").Value.PosicionColumna),
                            string.Empty);

                        if (!string.IsNullOrWhiteSpace(ccff))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "InfoComercial");
                    if (UtilsLocal.LogCargaList.Any(p => p.TipoLog != "4"))
                    {
                        result = false;
                    }
                }
            }
            catch (Exception ex)
            {
                result = false;
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Informacion Comercial");
            Console.WriteLine("Se terminó la carga del archivo Informacion Comercial");

            return result;
        }

        #endregion
    }
}