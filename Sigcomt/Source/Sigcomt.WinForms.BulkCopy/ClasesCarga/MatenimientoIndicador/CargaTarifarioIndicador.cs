﻿using System;
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

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.MatenimientoIndicador
{
    public class CargaTarifarioIndicador
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static bool CargarArchivo()
        {
            bool result = true;

            string tipoArchivo = TipoArchivo.TarifarioIndicador.GetStringValue();
            if (!UtilsLocal.PermitirCargaArchivo(tipoArchivo)) return false;
           
            UtilsLocal.AsignarEstadoInicioCarga(tipoArchivo);
            var cargaBase = new CargaBase(tipoArchivo, "TarifarioIndicador");

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

                    int cabeceraId= cargaBase.AgregarCabeceraCarga(new CabeceraCarga
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

                        string cargoId = Utils.GetValueColumn(
                            excel.GetCellToString(row,
                                cargaBase.PropiedadCol.First(p => p.Key == "CargoId").Value.PosicionColumna),
                            string.Empty);

                        if (!string.IsNullOrWhiteSpace(cargoId) && Char.IsNumber(cargoId, 0))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;
                            string diaLab = Utils.GetValueColumn(
                                excel.GetCellToString(row,
                                    cargaBase.PropiedadCol.First(p => p.Key == "DependeDiasLabSiNo").Value
                                        .PosicionColumna),
                                string.Empty);


                            if (diaLab == "SI")
                            {
                                dr["DependeDiasLabSiNo"] = 1; //SI
                            }
                            else if (diaLab == "NO")
                            {
                                dr["DependeDiasLabSiNo"] = 0; //NO
                            }

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "TarifarioIndicador");
                    if (UtilsLocal.LogCargaList.Where(p => p.TipoLog != "4" && p.CargaId == cabeceraId).Count() > 0)
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
                UtilsLocal.AsignarEstadoError(messageError);
                Logger.Error(messageError);
            }
            
            UtilsLocal.AsignarEstadoFinCarga(tipoArchivo);
            return result;
        }

        #endregion
    }
}