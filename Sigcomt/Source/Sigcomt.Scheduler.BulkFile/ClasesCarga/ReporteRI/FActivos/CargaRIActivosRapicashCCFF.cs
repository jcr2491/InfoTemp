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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.CCFF
{
    public class CargaRIActivosRapicashCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);        

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo RapicashCCFF");
            Console.WriteLine("Se inició la carga del archivo RapicashCCFF");
            var cargaBase = new CargaBase<RIActivosRapicashCCFF>();
            string tipoArchivo = TipoArchivo.RIActivosRapicashCCFF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                 cargaBase = new CargaBase<RIActivosRapicashCCFF>(tipoArchivo);
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

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<Business.Entity.RIActivosRapicashCCFF>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);
                    string CCFFId = string.Empty;
                    string CCFF = string.Empty;
                    string Zona = string.Empty;
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
                        CCFFId = excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna);
                        CCFF = excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFF").Value.PosicionColumna);

                        if (CCFFId.StartsWith("Zona", StringComparison.InvariantCultureIgnoreCase))
                        {
                            Zona = CCFFId;
                        }
                        else if (CCFFId != string.Empty && !CCFFId.StartsWith("Total", StringComparison.InvariantCultureIgnoreCase))
                        {
                            if (CCFF != string.Empty)
                            {
                                cont++;
                                DataRow dr = cargaBase.AsignarDatos(dt);
                                dr["Secuencia"] = cont;
                            
                                dt.Rows.Add(dr);
                            }
                        }
                        else
                        {
                            dt.Select(string.Format("[Zona] = '{0}'", ""))
                             .ToList<DataRow>()
                             .ForEach(r =>
                             {
                                 r["Zona"] = Zona;
                             });
                            Zona = "";
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "RIActivosRapicashCCFF");
                }
            }
            catch (Exception ex)
            {
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo RapicashCCFF");
            Console.WriteLine("Se terminó la carga del archivo RapicashCCFF");
        }

        #endregion

    }
}
