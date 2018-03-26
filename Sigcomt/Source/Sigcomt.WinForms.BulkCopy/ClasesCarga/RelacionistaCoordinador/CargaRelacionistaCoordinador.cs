using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using log4net;
using NPOI.SS.Util;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.WinForms.BulkCopy.Core;

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.RelacionistaCoordinador
{
    public class CargaRelacionistaCoordinador
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            string tipoArchivo = TipoArchivo.RelacionistaCoodinador.GetStringValue();
            if (!UtilsLocal.PermitirCargaArchivo(tipoArchivo)) return;
           
            UtilsLocal.AsignarEstadoInicioCarga(tipoArchivo);
            var cargaBase = new CargaBase(tipoArchivo, "RelacionistaCoordinador");
            int cont = 0;

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

                    UtilsLocal.AsignarEstado(string.Format(Constantes.ProcesandoArchivo, fileName, cargaBase.HojaBd.NombreHoja));
                    DataTable dt = cargaBase.CrearCabeceraDataTable();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    var kpiList = ObtenerKpiId(excel, cargaBase);

                    while (!cargaBase.EsFilaVacia(excel, row))
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        }

                        foreach (var kpi in kpiList)
                        {
                            var propResultado = cargaBase.PropiedadCol.First(p => p.Value.PosicionColumna == kpi.Value);
                            var propMeta = cargaBase.PropiedadCol.First(p => p.Value.PosicionColumna == kpi.Value + 1);
                            var propLogro =
                                cargaBase.PropiedadCol.First(p => p.Value.PosicionColumna == kpi.Value + 2);

                            if (string.IsNullOrEmpty(propResultado.Value.Valor) &&
                                string.IsNullOrEmpty(propMeta.Value.Valor) &&
                                string.IsNullOrEmpty(propLogro.Value.Valor))
                            {
                                continue;
                            }

                            bool continuar = true;

                            if (string.IsNullOrEmpty(propResultado.Value.Valor))
                            {
                                cargaBase.AgregarLogValidacionDatos(propResultado, rowNum + 1, "Falta ingresar valor");
                                continuar = false;
                            }

                            if (string.IsNullOrEmpty(propMeta.Value.Valor))
                            {
                                cargaBase.AgregarLogValidacionDatos(propMeta, rowNum + 1, "Falta ingresar valor");
                                continuar = false;
                            }

                            if (string.IsNullOrEmpty(propLogro.Value.Valor))
                            {
                                cargaBase.AgregarLogValidacionDatos(propLogro, rowNum + 1,
                                    "Falta ingresar valor");
                                continuar = false;
                            }

                            if (!continuar) continue;

                            cont++;
                            cargaBase.PropiedadCol["Resultado"].Valor = propResultado.Value.Valor;
                            cargaBase.PropiedadCol["Meta"].Valor = propMeta.Value.Valor;
                            cargaBase.PropiedadCol["Logro"].Valor = propLogro.Value.Valor;

                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;
                            dr["IndicadorId"] = kpi.Key;

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "RelacionistaCoordinador");
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

        #region

        private static List<KeyValuePair<int, int>> ObtenerKpiId(GenericExcel excel, CargaBase cargaBase)
        {
            var row = excel.Sheet.GetRow(cargaBase.HojaBd.FilaIni - 3);
            var propLogro = cargaBase.PropiedadCol["Logro"];
            var propMeta = cargaBase.PropiedadCol["Meta"];
            var propResultado = cargaBase.PropiedadCol["Resultado"];
            int numCol = propResultado.PosicionColumna;
            var kpiList = new List<KeyValuePair<int, int>>();
            char separador = '_';
            string valor = excel.GetCellToString(row, numCol);

            while (valor != string.Empty)
            {
                var kpi = valor.Split(separador);
                kpiList.Add(new KeyValuePair<int, int>(Convert.ToInt32(kpi[0]), numCol));

                if (propLogro.PosicionColumna != numCol)
                {
                    cargaBase.AgregarPropiedadCol($"{kpi[1]} - Resultado", AddPropiedadCol(propResultado, numCol));
                    cargaBase.AgregarPropiedadCol($"{kpi[1]} - Meta", AddPropiedadCol(propMeta, numCol + 1));
                    cargaBase.AgregarPropiedadCol($"{kpi[1]} - Logro", AddPropiedadCol(propLogro, numCol + 2));
                }

                numCol += 3;
                valor = excel.GetCellToString(row, numCol);
            }

            return kpiList;
        }

        private static PropiedadColumna AddPropiedadCol(PropiedadColumna prop, int numCol)
        {
            return new PropiedadColumna
            {
                TipoDato = prop.TipoDato,
                PermiteNulo = prop.PermiteNulo,
                ValorDefecto = prop.ValorDefecto,
                ValorIgnorar = prop.ValorIgnorar,
                LetraColumna = CellReference.ConvertNumToColString(numCol),
                PosicionColumna = numCol,
                OmitirPropiedad = true
            };
        }

        #endregion
    }
}