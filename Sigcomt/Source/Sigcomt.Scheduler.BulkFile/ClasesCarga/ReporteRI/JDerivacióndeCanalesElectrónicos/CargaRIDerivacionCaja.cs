using log4net;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.JDerivacióndeCanalesElectrónicos
{
    public class CargaRIDerivacionCaja
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo RIDerivacionCaja");
            Console.WriteLine("Se inició la carga del archivo RIDerivacionCaja");

            string tipoArchivo = TipoArchivo.RIDerivacionCajaAtencionesCaja.GetStringValue();
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
                            cabecera.FechaModificacionArchivo.GetDateTimeToString()) continue;
                    }

                    cargaBase.AgregarCabeceraCarga(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });

                    foreach (var hoja in cargaBase.ExcelBd.HojasList)
                    {
                        cargaBase.AsignarHojaBd(hoja.TipoArchivo);
                        GenericExcel excel = cargaBase.GetHojaExcel(fileName);

                        Console.WriteLine($"Se está procesando el archivo: {fileName} Hoja: {cargaBase.HojaBd.NombreHoja}");

                        int rowNum = cargaBase.HojaBd.FilaIni - 1;
                        var row = excel.Sheet.GetRow(rowNum);

                        while (row != null)
                        {
                            bool isValid = cargaBase.ValidarDatos(excel, row);
                            if (!isValid)
                            {
                                rowNum++;
                                row = excel.Sheet.GetRow(rowNum);
                                continue;
                            }

                            bool esRepetido = derivacionCajaList.Any(p =>
                                p.TipoArchivo == hoja.TipoArchivo && p.PropiedadCol["CCFFId"].Valor == cargaBase.PropiedadCol["CCFFId"].Valor);

                            if (esRepetido)
                            {
                                cargaBase.AgregarLogValidacionDatos(
                                    cargaBase.PropiedadCol.First(p => p.Key == "CCFFId"),
                                    rowNum + 1, "Valor repetido");
                            }

                            derivacionCajaList.Add(new DerivacionCaja
                            {
                                TipoArchivo = hoja.TipoArchivo,
                                PropiedadCol = cargaBase.PropiedadCol
                            });

                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                        }

                        Console.WriteLine($"Se terminó la lectura del archivo: {fileName} Hoja: {cargaBase.HojaBd.NombreHoja}");
                    }

                    if (!cargaBase.ErrorCargaList.Any())
                    {
                        DataTable dt = cargaBase.CrearCabeceraDataTable();
                        int cont = 0;
                        //TODO: falta logica de guardar
                        foreach (var item in derivacionCajaList)
                        {

                        }

                        cargaBase.RegistrarCarga(dt, "RIDerivacionCaja");
                    }
                }
            }
            catch (Exception ex)
            {
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo RIDerivacionCaja");
            Console.WriteLine("Se terminó la carga del archivo RIDerivacionCaja");
        }

        #endregion
    }
}