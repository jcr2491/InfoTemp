using log4net;
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
    public class CargaJefeGerenteCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo CargaJefeGerenteCCFF");
            Console.WriteLine("Se inició la carga del archivo CargaJefeGerenteCCFF");
            var cargaBase = new CargaBase<JefeGerenteCCFF>();
            string tipoArchivo = TipoArchivo.JefeGerenteCCFF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                //Nota: estamos asumiendo que delante vendra la fecha del archivo
                 cargaBase = new CargaBase<JefeGerenteCCFF>(tipoArchivo);

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

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, "Gerentes y Jefes");
                    DataTable dt = Utils.CrearCabeceraDataTable<JefeGerenteCCFF>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);
                    string FechaIngreso = string.Empty;
                    string FechaCese = string.Empty;
                    string CCFFId = string.Empty;
                    //TODO: Aqui se debe hacer la logica para consumir de la tabla excel de configuracion

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) continue;
                        CCFFId = Utils.GetValueColumn(
                           excel.GetStringCellValue(row,
                               cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna),
                           CCFFId);

            
                        if (!string.IsNullOrWhiteSpace(CCFFId))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Fecha"] = fechaFile;
                            dr["Secuencia"] = cont;
                            dr["CCFFId"] = cont;
                            FechaIngreso = Utils.GetValueColumn(
                                            excel.GetStringCellValue(row,
                                                cargaBase.PropiedadCol.First(p => p.Key == "FechaIngreso").Value.PosicionColumna),
                                            FechaIngreso);
                            dr["FechaIngreso"] = FechaIngreso;
                            FechaCese = Utils.GetValueColumn(
                                        excel.GetStringCellValue(row,
                                            cargaBase.PropiedadCol.First(p => p.Key == "FechaCese").Value.PosicionColumna),
                                        FechaIngreso);
                            dr["FechaCese"] = FechaCese;
                            dt.Rows.Add(dr);

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "BaseJefesyGerentesCCFF");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);

                    //Se coloca el Id del empleado a los registros
                    CargaArchivoBL.GetInstance().AddEmpleadoId("BaseJefesyGerentesCCFF", "NombreCorto", "EmpleadoId");
                }
            }
            catch (Exception ex)
            {
                cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo CargaJefeGerenteCCFF");
            Console.WriteLine("Se terminó la carga del archivo CargaJefeGerenteCCFF");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            DataRow dr = dt.NewRow();
            dr["EmpleadoCodigo"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["EmpleadoCodigo"]));
            dr["Empleado"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Empleado"]));
            dr["CargoCodigo"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CargoCodigo"]));
            dr["Cargo"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Cargo"]));
            dr["DiasLaborados"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["DiasLaborados"]));
            dr["Vacaciones"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Vacaciones"]));
            dr["DM"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["DM"]));
            dr["Lic"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Lic"]));
            dr["Maternidad"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Maternidad"]));
            dr["UsuarioRed"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["UsuarioRed"]));
            dr["UsuarioRedJefe"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["UsuarioRedJefe"]));
            
            return dr;
        }

        #endregion

    }
}
