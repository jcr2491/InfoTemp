using System;
using System.Collections.Generic;
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

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.JDerivacióndeCanalesElectrónicos
{
    public class CargaRIDerivacionCaja
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {

            string tipoArchivo = TipoArchivo.RIDerivacionCajaAtencionesCaja.GetStringValue();
            if (!UtilsLocal.PermitirCargaArchivo(tipoArchivo)) return;
           
            UtilsLocal.AsignarEstadoInicioCarga(tipoArchivo);
            var cargaBase = new CargaBase(tipoArchivo, "RIDerivacionCaja");
            var derivacionCajaList = new List<DerivacionCaja>();

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
                            continue;
                    }

                    cargaBase.AgregarCabeceraCarga(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });

                    int contAnterior = 0;
                    int cont;

                    foreach (var hoja in cargaBase.ExcelBd.HojasList)
                    {
                        cargaBase.AsignarHojaBd(hoja.TipoArchivo);
                        GenericExcel excel = cargaBase.GetHojaExcel(fileName);

                        UtilsLocal.AsignarEstado(string.Format(Constantes.ProcesandoArchivo, fileName, cargaBase.HojaBd.NombreHoja));

                        int rowNum = cargaBase.HojaBd.FilaIni - 1;
                        var row = excel.Sheet.GetRow(rowNum);
                        cont = 0;

                        while (!cargaBase.EsFilaVacia(excel, row))
                        {
                            cont++;
                            bool isValid = cargaBase.ValidarDatos(excel, row);

                            if (!isValid)
                            {
                                rowNum++;
                                row = excel.Sheet.GetRow(rowNum);
                                continue;
                            }

                            bool esRepetido = derivacionCajaList.Any(p =>
                                p.TipoArchivo == hoja.TipoArchivo && p.PropiedadCol["CCFFId"].Valor ==
                                cargaBase.PropiedadCol["CCFFId"].Valor);

                            if (esRepetido)
                            {
                                cargaBase.AgregarLogValidacionDatos(
                                    cargaBase.PropiedadCol.First(p => p.Key == "CCFFId"),
                                    rowNum + 1, "Valor repetido");
                            }

                            derivacionCajaList.Add(new DerivacionCaja
                            {
                                TipoArchivo = hoja.TipoArchivo,
                                PropiedadCol = cargaBase.PropiedadCol.Clone()
                            });

                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                        }

                        if(contAnterior == 0) contAnterior = cont;

                        if (cont != contAnterior)
                        {
                            cargaBase.AgregarLogValidacionDatos(string.Format(Constantes.FilasDiferente, cargaBase.HojaBd.NombreHoja));
                        }

                        UtilsLocal.AsignarEstado(string.Format(Constantes.FinLectura, fileName, cargaBase.HojaBd.NombreHoja));
                    }

                    if (!cargaBase.ErrorCargaList.Any())
                    {
                        DataTable dt = cargaBase.CrearCabeceraDataTable();
                        cont = 0;

                        var idList = derivacionCajaList.Select(p => p.PropiedadCol["CCFFId"].Valor).Distinct().ToList();

                        foreach (var id in idList)
                        {
                            cont++;
                            DataRow dr = dt.NewRow();
                            dr["CargaId"] = cargaBase.CabeceraCargaId;
                            dr["Secuencia"] = cont;

                            foreach (var hoja in cargaBase.ExcelBd.HojasList)
                            {
                                var derivacion = derivacionCajaList.FirstOrDefault(p =>
                                    p.PropiedadCol["CCFFId"].Valor == id && p.TipoArchivo == hoja.TipoArchivo);

                                if(derivacion != null)
                                {
                                    cargaBase.AsignarDatos(dr, derivacion.PropiedadCol);
                                }
                                else
                                {
                                    cargaBase.AgregarLogValidacionDatos(string.Format(Constantes.FaltaCentroFinanciero,
                                        id, cargaBase.HojaBd.NombreHoja));
                                }
                            }

                            dt.Rows.Add(dr);
                        }

                        cargaBase.RegistrarCarga(dt, "RIDerivacionCaja");
                    }
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