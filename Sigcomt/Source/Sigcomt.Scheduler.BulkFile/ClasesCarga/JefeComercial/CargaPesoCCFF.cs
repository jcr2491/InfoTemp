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


namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.JefeComercial
{
    public class CargaPesoCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo PesoCCFF");
            Console.WriteLine("Se inició la carga del archivo PesoCCFF");
            var cargaBase = new CargaBase<PesoCCFF>();
            string tipoArchivo = TipoArchivo.PesoCCFF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            {
                 cargaBase = new CargaBase<PesoCCFF>(tipoArchivo);


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

                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.PesoCCFF, EstadoCarga.Iniciado, fechaFile);
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
                    DataTable dt = Utils.CrearCabeceraDataTable<PesoCCFF>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;
                    string CodigoCCFF = string.Empty;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        CodigoCCFF = Utils.GetValueColumn(
                           excel.GetStringCellValue(row,
                               cargaBase.PropiedadCol.First(p => p.Key == "CodigoCCFF").Value.PosicionColumna),
                           CodigoCCFF);


                        if (!string.IsNullOrWhiteSpace(CodigoCCFF))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["CodigoCCFF"] = CodigoCCFF;
                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "PesoCCFF");

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

            Logger.Info("Se terminó la carga del archivo PesoCCFF");
            Console.WriteLine("Se terminó la carga del archivo PesoCCFF");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            DataRow dr = dt.NewRow();
            dr["CCFF"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CCFF"]),"0");
            dr["Cargo"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Cargo"]),"0");
            dr["CTSEPlataforma"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CTSEPlataforma"]));
            dr["TarjetaCMRATarjeta"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["TarjetaCMRATarjeta"]));
            dr["TajetaCMRAColocaciones"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["TajetaCMRAColocaciones"]));
            dr["TarjetaCMRACruceVSC"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["TarjetaCMRACruceVSC"]));
            dr["PSCuentaHaberes"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["PSCuentaHaberes"]));
            dr["TarjetaCMRASaldoPasivo"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["TarjetaCMRASaldoPasivo"]));
            dr["RetailCMRParticipacionCMRSaga"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["RetailCMRParticipacionCMRSaga"]));
            dr["DerivacionPlataforma"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["DerivacionPlataforma"]));
            dr["CSEnCPlataforma"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CSEnCPlataforma"]));
            dr["CSEnCPromotor"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CSEnCPromotor"]));
            dr["CSEncuestaCalidadCCFF"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CSEncuestaCalidadCCFF"]));
            dr["CSNPS"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CSNPS"]));
            return dr;
        }

        #endregion
    }
}