﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using log4net;
using NPOI.SS.UserModel;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Rapicash
{
   public class CargaDetalleMaestroRapicash
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo DetalleMaestroRapicash");
            Console.WriteLine("Se inició la carga del archivo DetalleMaestroRapicash");
            var cargaBase = new CargaBase<DetalleMaestroRapicash>();
            string tipoArchivo = TipoArchivo.DetalleMaestroRapicash.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            {

                cargaBase = new CargaBase<DetalleMaestroRapicash>(tipoArchivo);


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

                    cabeceraId = cargaBase.AgregarCabecera(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });

                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.ResumenSagaRapicash, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<DetalleMaestroRapicash>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;
                    string Sucursal = string.Empty;
                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        Sucursal = Utils.GetValueColumn(
                           excel.GetStringCellValue(row,
                               cargaBase.PropiedadCol.First(p => p.Key == "Sucursal").Value.PosicionColumna),
                           Sucursal);


                        if (!string.IsNullOrWhiteSpace(Sucursal))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["Sucursal"] = Sucursal;

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "DetalleMaestroRapicash");

                    cargaError = false;
                    //Se actualiza a procesado la tabla CabeceraCarga
                    cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);

                    //Se coloca el Id del empleado a los registros
                    //CargaArchivoBL.GetInstance().AddEmpleadoId("ResumenSagaRapicash", "Empleado", "EmpleadoId");
                }
            }
            catch (Exception ex)
            {
                if (cargaError) cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo DetalleMaestroRapicash");
            Console.WriteLine("Se terminó la carga del archivo DetalleMaestroRapicash");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            DataRow dr = dt.NewRow();
            dr["Anio"] = excel.GetIntCellValue(row, _indexCol["Anio"]);
            dr["Mes"] = excel.GetIntCellValue(row, _indexCol["Mes"]);
            dr["DiaCompraoRetiro"] = excel.GetIntCellValue(row, _indexCol["DiaCompraoRetiro"]);
            dr["DiaProceso"] = excel.GetIntCellValue(row, _indexCol["DiaProceso"]);
            dr["CodEmpleado"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CodEmpleado"]), "");
            dr["NombreEmpleado"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["NombreEmpleado"]), "");
            dr["Cargo"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Cargo"]), "");
            dr["Transaccion"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Transaccion"]), "");
            dr["Tipo"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Tipo"]), "");
            dr["Monto"] = excel.GetIntCellValue(row, _indexCol["Monto"]);
            dr["POS"] = excel.GetIntCellValue(row, _indexCol["POS"]);


            return dr;
        }

        #endregion
    }
}