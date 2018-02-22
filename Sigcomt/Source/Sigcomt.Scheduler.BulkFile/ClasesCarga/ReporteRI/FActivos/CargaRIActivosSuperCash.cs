﻿using log4net;
using NPOI.SS.UserModel;
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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.FActivos
{
    public class CargaRIActivosSuperCash
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);        

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo RIActivosSuperCash");
            Console.WriteLine("Se inició la carga del archivo RIActivosSuperCash");
            var cargaBase = new CargaBase<RIActivosSuperCash>();
            string tipoArchivo = TipoArchivo.RIActivosSuperCash.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;

            try
            {
                 cargaBase = new CargaBase<RIActivosSuperCash>(tipoArchivo);
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

                    cabeceraId = cargaBase.AgregarCabecera(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<RIActivosSuperCash>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;                    
                    string CCFF = string.Empty;
                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        string CCFFId = excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna);
                        CCFF= Utils.GetValueColumn(excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFF").Value.PosicionColumna), "");
                        
                        if (!string.IsNullOrWhiteSpace(CCFFId) && !string.IsNullOrWhiteSpace(CCFF) &&
                            !CCFF.StartsWith("Zona", StringComparison.InvariantCultureIgnoreCase))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;

                            dt.Rows.Add(dr);
                        }
                        else if (!CCFF.StartsWith("Total", StringComparison.InvariantCultureIgnoreCase))
                        {
                            break;
                        }
                   
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                    cargaBase.RegistrarCarga(dt, "RIActivosSuperCash");
                    
                }
            }
            catch (Exception ex)
            {
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo RIActivosSuperCash");
            Console.WriteLine("Se terminó la carga del archivo RIActivosSuperCash");
        }

        #endregion

    }
}
