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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.DTiemposdeEspera
{
   public class CargaRITECajero
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Tiempo de Espera - Cajero");
            Console.WriteLine("Se inició la carga del archivo Tiempo de Espera - Cajero");
            var cargaBase = new CargaBase<RITECajero>();
            string tipoArchivo = TipoArchivo.RITiempoEsperaCajeroReg.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            {
                 cargaBase = new CargaBase<RITECajero>(tipoArchivo);
               
                var filesNames = Directory.GetFiles( cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");
                //Se cargan las posiciones de las columnas del excel
                if (filesNames.Length == 0)
                {
                    tipoArchivo = TipoArchivo.RITiempoEsperaCajero.GetStringValue();
                     cargaBase = new CargaBase<RITECajero>(tipoArchivo);
                    filesNames = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");
                }

            

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

                   // cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.RITiempoEsperaCajero, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<RITECajero>();
                    
                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;
                    string CCFFId = string.Empty;
                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        CCFFId = Utils.GetValueColumn(
                                excel.GetStringCellValue(row,
                                    cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna),
                                CCFFId);
         
                       if (!(string.IsNullOrWhiteSpace(CCFFId)) && !(CCFFId.StartsWith("Zona", StringComparison.InvariantCultureIgnoreCase)) && !(CCFFId.StartsWith("Banco", StringComparison.InvariantCultureIgnoreCase)))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["TECCFFId"] = CCFFId;
                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "RITECajero");

                    cargaError = false;
                    //Se actualiza a procesado la tabla CabeceraCarga
                    cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);

                    //Se coloca el Id del empleado a los registros
                    //CargaArchivoBL.GetInstance().AddEmpleadoId("MetaTiendaRapicash", "Empleado", "EmpleadoId");
                }
            }
            catch (Exception ex)
            {
                if (cargaError) cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Tiempo de Espera - Cajero");
            Console.WriteLine("Se terminó la carga del archivo Tiempo de Espera - Cajero");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            DataRow dr = dt.NewRow();
            dr["TECCFF"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECCFF"]), "0");
            dr["TECajeroAten_10Min"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECajeroAten_10Min"]), "0");
            dr["TECajeroTotalAten"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECajeroTotalAten"]), "0");
            dr["TECajeroLogro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECajeroLogro"]), "0");
            dr["TECajeroMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECajeroMeta"]), "0");

            return dr;
        }

        #endregion
    }
}
