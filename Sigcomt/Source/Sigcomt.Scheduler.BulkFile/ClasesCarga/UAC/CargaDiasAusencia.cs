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


namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.UAC
{
    public class CargaDiasAusencia
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);        

        #region Métodos Públicos

        /// <summary>
        /// 
        /// </summary>
        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo DiasAusencia");
            Console.WriteLine("Se inició la carga del archivo DiasAusencia");
            var cargaBase = new CargaBase<Productividad>();
            string tipoArchivo = TipoArchivo.DiasAusencia.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                 cargaBase = new CargaBase<Productividad>(tipoArchivo);
                var filesNames = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");

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

                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.DiasAusencia, EstadoCarga.Iniciado, fechaFile);
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
                    var excel = new GenericExcel(fileBase, 0);
                    DataTable dt = Utils.CrearCabeceraDataTable<DiasAusencia>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;                    
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;
                    string Empresa = string.Empty;
                    
                    //TODO: Aqui se debe hacer la logica para consumir de la tabla excel de configuracion

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        string pase = excel.GetStringCellValue(row, cargaBase.PropiedadCol.First(p => p.Key == "Empresa").Value.PosicionColumna);
                        if (!string.IsNullOrWhiteSpace(pase))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;                            
                           
                            dt.Rows.Add(dr);
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                        }                       
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "DiasAusencia");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);
                    
                    //Se coloca el Id del empleado a los registros
                    CargaArchivoBL.GetInstance().AddEmpleadoId("DiasAusencia", "Empleado", "EmpleadoId");

                }
            }
            catch (Exception ex)
            {
                cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Productividad");
            Console.WriteLine("Se terminó la carga del archivo Productividad");
        }

        #endregion

        //#region Métodos Privados

        //private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        //{
        //    DataRow dr = dt.NewRow();
        //    dr["EmpresaId"] = excel.GetIntCellValue(row, _indexCol["EmpresaId"]);            
        //    dr["Empresa"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Empresa"]));
        //    dr["Empleado"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Empleado"]));
        //    dr["Anio"] = excel.GetIntCellValue(row, _indexCol["Anio"]);
        //    dr["Mes"] = excel.GetIntCellValue(row, _indexCol["Mes"]);
        //    dr["Correlativo"] = excel.GetIntCellValue(row, _indexCol["Correlativo"]);
        //    dr["FechaProc"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["FechaProc"]),"");
        //    dr["TotDiasNoLabor"] = excel.GetDoubleCellValue(row, _indexCol["TotDiasNoLabor"]);

        //    return dr;
        //}

        //#endregion
    }
}