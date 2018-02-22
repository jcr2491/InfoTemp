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
   public class CargaUACMonitoreo
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Productividad - Monitoreo");
            Console.WriteLine("Se inició la carga del archivo Productividad - Monitoreo");
            var cargaBase = new CargaBase<UACMonitoreo>();
            string tipoArchivo = TipoArchivo.Monitoreo.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                cargaBase = new CargaBase<UACMonitoreo>(tipoArchivo);
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

                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.Monitoreo, EstadoCarga.Iniciado, fechaFile);                    
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

                    FileStream fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    GenericExcel excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<UACMonitoreo>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
              
                    string Empleado = string.Empty;
                    cont = 0;

                    //TODO: Aqui se debe hacer la logica para consumir de la tabla excel de configuracion

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
                        if (Empleado != string.Empty)
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;
                            dt.Rows.Add(dr);

                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                        }
                        
                    }
                   cargaBase.RegistrarCarga(dt, "Monitoreo");
                }
            }
            catch (Exception ex)
            {
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Monitoreo - Monitoreo");
            Console.WriteLine("Se terminó la carga del archivo Monitoreo - Monitoreo");
        }

        #endregion
    }
}
