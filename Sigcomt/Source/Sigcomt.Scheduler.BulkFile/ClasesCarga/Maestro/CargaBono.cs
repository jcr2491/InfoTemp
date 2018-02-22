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
using Sigcomt.Scheduler.BulkFile.Core;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Maestro
{
    public class CargaBono
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Bono");
            Console.WriteLine("Se inició la carga del archivo Bono");

            var cargaBase = new CargaBase<Bono>();
            string tipoArchivo = TipoArchivo.Bono.GetStringValue();
            int cont = 0;
            bool cargaError = true;

            try
            {
                cargaBase = new CargaBase<Bono>(tipoArchivo);
                var filesNames = cargaBase.GetNombreArchivos();

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);
                    DateTime fechaModificacion = File.GetLastWriteTime(fileName);

                    var cabecera = CabeceraCargaBL.GetInstance().GetCabeceraCargaProcesado(tipoArchivo, fechaFile);
                    if (cabecera != null)
                    {
                        if (fechaModificacion.GetDateTimeToString() ==
                            cabecera.FechaModificacionArchivo.GetDateTimeToString()) continue;
                    }

                    cargaBase.AgregarCabecera(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    FileStream fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);

                    GenericExcel excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<Bono>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    string CargoId = string.Empty;

                    cont = 0;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);

                        if (!isValid)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        CargoId = Utils.GetValueColumn(
                                excel.GetCellToString(row,
                                cargaBase.PropiedadCol.First(p => p.Key == "CargoId").Value.PosicionColumna), "");

                        if (CargoId != string.Empty && Char.IsNumber(CargoId, 0))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);

                            dt.Rows.Add(dr);
                        }
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "Bono");
                }
            }
            catch (Exception ex)
            {
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Bono");
            Console.WriteLine("Se terminó la carga del archivo Bono");
        }

        #endregion
    }
}
