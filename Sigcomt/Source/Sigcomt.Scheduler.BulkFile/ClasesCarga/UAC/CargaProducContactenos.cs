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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.UAC
{
    public class CargaProducContactenos
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo ProducContactenos");
            Console.WriteLine("Se inició la carga del archivo ProducContactenos");
            var cargaBase = new CargaBase<ProducContactenos>();
            string tipoArchivo = TipoArchivo.ProducContactenos.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            { 

                 cargaBase = new CargaBase<ProducContactenos>(tipoArchivo);
                var filesNames = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");
                //Se cargan las posiciones de las columnas del excel

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
                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.ProducContactenos, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<ProducContactenos>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;
                    string Empleado = string.Empty;
                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };
                       
                        Empleado = Utils.GetValueColumn(excel.GetStringCellValue(row, cargaBase.PropiedadCol.First(p => p.Key == "Empleado").Value.PosicionColumna), Empleado);
                        //string empleado = excel.GetCellToString(row, _indexCol["Empleado"]);
                        if (Empleado.Replace(" ", "").StartsWith("TotalGeneral", StringComparison.InvariantCultureIgnoreCase)) break;
                        if (!(Empleado.StartsWith("Total", StringComparison.InvariantCultureIgnoreCase)))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "ProducContactenos");

                    cargaError = false;
                    //Se actualiza a procesado la tabla CabeceraCarga
                    cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);

                    //Se coloca el Id del empleado a los registros
                    CargaArchivoBL.GetInstance().AddEmpleadoId("ProducContactenos", "Empleado", "EmpleadoId");
                }
            }
            catch (Exception ex)
            {
                if (cargaError) cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo ProducContactenos");
            Console.WriteLine("Se terminó la carga del archivo ProducContactenos");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            DataRow dr = dt.NewRow();
            dr["Empleado"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Empleado"]));
            dr["TotalAtendido"] = excel.GetIntCellValue(row, _indexCol["TotalAtendido"]);
            dr["DiasLaborados"] = excel.GetIntCellValue(row, _indexCol["DiasLaborados"]);
            dr["MetaDiaria"] = excel.GetIntCellValue(row, _indexCol["MetaDiaria"]);
            dr["MetaMes"] = excel.GetIntCellValue(row, _indexCol["MetaMes"]);
            dr["Productividad"] = Math.Round(excel.GetDoubleCellValue(row, _indexCol["Productividad"]),2);

            return dr;
        }

        #endregion
    }
}