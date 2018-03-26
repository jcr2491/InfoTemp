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
using Sigcomt.WinForms.BulkCopy.Core;

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.BParticipación
{
    public class CargaRIParticipacionTR
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargaArchivo()
        {
            string tipoArchivo = TipoArchivo.RIParticipacion.GetStringValue();
            if (!UtilsLocal.PermitirCargaArchivo(tipoArchivo)) return;
           
            UtilsLocal.AsignarEstadoInicioCarga(tipoArchivo);
            var cargaBase = new CargaBase(tipoArchivo, "RIParticipacion");

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

                    UtilsLocal.AsignarEstado(string.Format(Constantes.ProcesandoArchivo, fileName, cargaBase.HojaBd.NombreHoja));
                    DataTable dt = cargaBase.CrearCabeceraDataTable();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    int cont = 0;

                    while (!cargaBase.EsFilaVacia(excel, row))
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        }

                        string tienda = Utils.GetValueColumn(
                            excel.GetStringCellValue(row,
                                cargaBase.PropiedadCol.First(p => p.Key == "Tienda").Value.PosicionColumna),
                            string.Empty);

                        if (!string.IsNullOrWhiteSpace(tienda) &&
                            !tienda.StartsWith("Región", StringComparison.InvariantCultureIgnoreCase) &&
                            !tienda.StartsWith("Total", StringComparison.InvariantCultureIgnoreCase) &&
                            !tienda.StartsWith("Zona", StringComparison.InvariantCultureIgnoreCase))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["Tienda"] = tienda;
                            if (tienda.ToUpper().Contains("SAGA") || tienda.ToUpper().Contains("SF"))
                                dr["TiendaRatail"] = TiendaRetail.SagaFalabella;
                            if (tienda.ToUpper().Contains("TOTTUS") || tienda.ToUpper().Contains("TT"))
                                dr["TiendaRatail"] = TiendaRetail.Tottus;
                            if (tienda.ToUpper().Contains("SODIMAC")) dr["TiendaRatail"] = TiendaRetail.Sodimac;
                            if (tienda.ToUpper().Contains("MAESTRO")) dr["TiendaRatail"] = TiendaRetail.Maestro;

                            // dr["TiendaRatail"] = TiendaRetail.SagaFalabella;
                            dr["DiferenciaParticipacionMeta"] =
                                (Convert.ToDouble(dr["ParticipacionCMR"]) - Convert.ToDouble(dr["CMRMeta"]));
                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                        tienda = string.Empty;
                    }

                    cargaBase.RegistrarCarga(dt, "RIParticipacion");

                    //Se coloca el Id del empleado a los registros
                    CargaArchivoBL.GetInstance().AddSucursalId("RIParticipacion", "Tienda", "TiendaId");
                }
            }
            catch (Exception ex)
            {
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                UtilsLocal.AsignarEstadoError(messageError);
                Logger.Error(messageError);
            }
            
            UtilsLocal.AsignarEstadoFinCarga(tipoArchivo);
        }
    
        #endregion
    }
}