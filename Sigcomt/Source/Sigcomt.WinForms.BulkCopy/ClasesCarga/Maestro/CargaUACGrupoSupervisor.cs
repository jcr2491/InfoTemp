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

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.Maestro
{
    public class CargaUACGrupoSupervisor
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static bool CargarArchivo()
        {
            bool result = true;
           
            string tipoArchivo = TipoArchivo.GrupoSupervisorUAC.GetStringValue();
            if (!UtilsLocal.PermitirCargaArchivo(tipoArchivo)) return false;

            UtilsLocal.AsignarEstadoInicioCarga(tipoArchivo);
            var cargaBase = new CargaBase(tipoArchivo, "GrupoSupervisorUAC");

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

                        string grupo = Utils.GetValueColumn(
                            excel.GetCellToString(row,
                                cargaBase.PropiedadCol.First(p => p.Key == "Grupo").Value.PosicionColumna), string.Empty);

                        if (grupo != string.Empty)
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;
                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "GrupoSupervisorUAC");                    
                    if (UtilsLocal.LogCargaList.Any(p => p.TipoLog != "4" && p.CargaId == cargaBase.CabeceraCargaId))
                    {                        
                        result = false;
                    }
                    CargaArchivoBL.GetInstance().AddGrupoId("GrupoSupervisorUAC");
                }
            }
            catch (Exception ex)
            {                
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                UtilsLocal.AsignarEstadoError(messageError);
                Logger.Error(messageError);
                result = false;
            }
            
            UtilsLocal.AsignarEstadoFinCarga(tipoArchivo);
            return result;

        }

        #endregion
    }
}