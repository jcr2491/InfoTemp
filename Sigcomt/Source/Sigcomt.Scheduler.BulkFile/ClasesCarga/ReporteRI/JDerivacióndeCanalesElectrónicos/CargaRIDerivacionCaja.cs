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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.JDerivacióndeCanalesElectrónicos
{
    public class CargaRIDerivacionCaja
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        
        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo RIDerivacionCaja");
            Console.WriteLine("Se inició la carga del archivo RIDerivacionCaja");
            var cargaBase = new CargaBase<RIDerivacionCaja>();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;
            //FileStream fileBase = new FileStream(AppDomain.CurrentDomain.BaseDirectory + "archivo.xlsx",FileMode.OpenOrCreate,FileAccess.Write);
            DataTable dt = Utils.CrearCabeceraDataTable<RIDerivacionCaja>();
            DateTime fechaFile;
            DateTime fechaModificacion;
            try
            {
                string tipoArchivo = TipoArchivo.RIDerivacionCajaAtencionesCaja.GetStringValue();
                 cargaBase = new CargaBase<RIDerivacionCaja>(tipoArchivo);
                var filesNames = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");
                int col = 0;
                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    fechaFile = new DateTime(año, mes, dia);
                    fechaModificacion = File.GetLastWriteTime(fileName);

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

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    int i = 0;
                    DateTime fechaExcel;
                    string fecha = string.Empty;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;                    

                    while (row != null)
                    {
                        fecha = excel.GetCellToString(row, i);
                        if (col == 0)
                        {
                            while (!string.IsNullOrWhiteSpace(fecha))
                            {
                                fecha = excel.GetCellToString(row, i);
                                if (DateTime.TryParse(fecha, out fechaExcel)) { fechaExcel = Convert.ToDateTime(fechaExcel); }
                                if (fechaExcel == fechaFile)
                                {
                                    col = i;
                                    rowNum++;
                                    row = excel.Sheet.GetRow(rowNum);
                                    break;
                                }
                                i++;
                            }
                        }

                        if (col != 0)
                        {
                            cargaBase.PropiedadCol.First(p => p.Key == "AtencionesCaja").Value.PosicionColumna = col;

                            bool isValid = cargaBase.ValidarDatos(excel, row);
                            if (!isValid) {
                                rowNum++;
                                row = excel.Sheet.GetRow(rowNum);
                                continue;
                            };

                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            string CCFFId = Utils.GetValueColumn(excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna), string.Empty);
                            if (Char.IsNumber(CCFFId, 0))
                            {
                                dr["CCFFId"] = CCFFId;
                                dr["CCFF"] = Utils.GetValueColumn(excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFF").Value.PosicionColumna), string.Empty);
                                string resultado = excel.GetCellToString(row, col);
                                if (Char.IsNumber(resultado, 0)) { dr["AtencionesCaja"] = resultado; }
                                else { dr["AtencionesCaja"] = 0.0; }

                                dt.Rows.Add(dr);
                            }                           
                        }
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                }

                if (col == 0)
                {
                    string error = "No se encuentra el nombre de la hoja registrada en la BD para este archivo.";                    
                }
                string tipoArchivoMR = TipoArchivo.RIDerivacionCajaMetaRetiro.GetStringValue();
                cargaBase = new CargaBase<RIDerivacionCaja>(tipoArchivoMR);
                var filesNamesMR = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");

                foreach (var fileName in filesNamesMR)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    fechaFile = new DateTime(año, mes, dia);
                    fechaModificacion = File.GetLastWriteTime(fileName);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    int i = 0;
                    DateTime fechaExcel;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0; col=0;
                    string fecha = string.Empty;

                    while (row != null)
                    {
                        fecha = excel.GetCellToString(row, i);
                        if (col == 0)
                        {
                            while (!string.IsNullOrWhiteSpace(fecha))
                            {
                                fecha = excel.GetCellToString(row, i);
                                if (DateTime.TryParse(fecha, out fechaExcel)) { fechaExcel = Convert.ToDateTime(fechaExcel); }
                                if (fechaExcel == fechaFile)
                                {
                                    col = i;
                                    rowNum++;
                                    row = excel.Sheet.GetRow(rowNum);
                                    break;
                                }
                                i++;
                            }
                        }

                        if (col != 0)
                        {
                            cargaBase.PropiedadCol.First(p => p.Key == "MetaRetiros").Value.PosicionColumna = col;
                            bool isValid = cargaBase.ValidarDatos(excel, row);
                            if (!isValid) {
                                rowNum++;
                                row = excel.Sheet.GetRow(rowNum);
                                continue;
                            };

                            string total = excel.GetCellToString(row, col);
                            foreach (DataRow fila in dt.Rows)
                            {
                                string CcffId = fila["CCFFId"].ToString();
                                if (CcffId == excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna))
                                {
                                    fila["Zona"] = Utils.GetValueColumn(excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna));
                                    fila["MetaRetiros"] = Char.IsNumber(total, 0) == true ? total : "0.0";
                                    break;
                                }
                            }
                        }
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                }            

                string tipoArchivoMPTC = TipoArchivo.RIDerivacionCajaMetaPagoTC.GetStringValue();
                cargaBase = new CargaBase<RIDerivacionCaja>(tipoArchivoMPTC);
                var filesNamesMPTC = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");

                foreach (var fileName in filesNamesMPTC)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    fechaFile = new DateTime(año, mes, dia);
                    fechaModificacion = File.GetLastWriteTime(fileName);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    int i = 0;
                    DateTime fechaExcel;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0; col = 0;
                    string fecha = string.Empty;

                    while (row != null)
                    {
                        fecha = excel.GetCellToString(row, i);
                        if (col == 0)
                        {
                            while (!string.IsNullOrWhiteSpace(fecha))
                            {
                                fecha = excel.GetCellToString(row, i);
                                if (DateTime.TryParse(fecha, out fechaExcel)) { fechaExcel = Convert.ToDateTime(fechaExcel); }
                                if (fechaExcel == fechaFile)
                                {
                                    col = i;
                                    rowNum++;
                                    row = excel.Sheet.GetRow(rowNum);
                                    break;
                                }
                                i++;
                            }
                        }

                        if (col != 0)
                        {
                            cargaBase.PropiedadCol.First(p => p.Key == "MetaPagoTC").Value.PosicionColumna = col;
                            bool isValid = cargaBase.ValidarDatos(excel, row);
                            if (!isValid)
                            {
                                rowNum++;
                                row = excel.Sheet.GetRow(rowNum);
                                continue;
                            };

                            string Meta = excel.GetCellToString(row, col);
                            foreach (DataRow fila in dt.Rows)
                            {
                                string CcffId = fila["CCFFId"].ToString();
                                if (CcffId == excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna))
                                {
                                    fila["MetaPagoTC"] = Char.IsNumber(Meta, 0) == true ? Meta : "0.0";
                                    break;
                                }
                            }
                        }
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                }
            

                string tipoArchivoCPTC = TipoArchivo.RIDerivacionCajaPagoTC.GetStringValue();
                cargaBase = new CargaBase<RIDerivacionCaja>(tipoArchivoCPTC);
                var filesNamesCPTC = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");

                foreach (var fileName in filesNamesCPTC)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    fechaFile = new DateTime(año, mes, dia);
                    fechaModificacion = File.GetLastWriteTime(fileName);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    int i = 0;
                    DateTime fechaExcel;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0; col = 0;
                    string fecha = string.Empty;

                    while (row != null)
                    {
                        fecha = excel.GetCellToString(row, i);
                        if (col == 0)
                        {
                            while (!string.IsNullOrWhiteSpace(fecha))
                            {
                                fecha = excel.GetCellToString(row, i);
                                if (DateTime.TryParse(fecha, out fechaExcel)) { fechaExcel = Convert.ToDateTime(fechaExcel); }
                                if (fechaExcel == fechaFile)
                                {
                                    col = i;
                                    rowNum++;
                                    row = excel.Sheet.GetRow(rowNum);
                                    break;
                                }
                                i++;
                            }
                        }

                        if (col != 0)
                        {
                            cargaBase.PropiedadCol.First(p => p.Key == "PagoTC").Value.PosicionColumna = col;
                            bool isValid = cargaBase.ValidarDatos(excel, row);
                            if (!isValid)
                            {
                                rowNum++;
                                row = excel.Sheet.GetRow(rowNum);
                                continue;
                            };

                            string Pago = excel.GetCellToString(row, col);
                            foreach (DataRow fila in dt.Rows)
                            {
                                string CcffId = fila["CCFFId"].ToString();
                                if (CcffId == excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna))
                                {
                                    fila["PagoTC"] = Char.IsNumber(Pago, 0) == true ? Pago : "0.0";
                                    break;
                                }

                            }
                        }
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                }
           
                string tipoArchivoTCCPif = TipoArchivo.RIDerivacionCajaRetirosTCCajaPIF.GetStringValue();
                cargaBase = new CargaBase<RIDerivacionCaja>(tipoArchivoTCCPif);
                var filesNamesTCCPif = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");

                foreach (var fileName in filesNamesTCCPif)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    fechaFile = new DateTime(año, mes, dia);
                    fechaModificacion = File.GetLastWriteTime(fileName);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    int i = 0;
                    DateTime fechaExcel;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0; col = 0;
                    string fecha = string.Empty;

                    while (row != null)
                    {              

                        fecha = excel.GetCellToString(row, i);
                        if (col == 0)
                        {
                            while (!string.IsNullOrWhiteSpace(fecha))
                            {
                                fecha = excel.GetCellToString(row, i);
                                if (DateTime.TryParse(fecha, out fechaExcel)) { fechaExcel = Convert.ToDateTime(fechaExcel); }
                                if (fechaExcel == fechaFile)
                                {
                                    col = i;
                                    rowNum++;
                                    row = excel.Sheet.GetRow(rowNum);
                                    break;
                                }
                                i++;
                            }
                        }

                        if (col != 0)
                        {
                            cargaBase.PropiedadCol.First(p => p.Key == "RetirosTCCajaPIF").Value.PosicionColumna = col;
                            bool isValid = cargaBase.ValidarDatos(excel, row);
                            if (!isValid)
                            {
                                rowNum++;
                                row = excel.Sheet.GetRow(rowNum);
                                continue;
                            };

                            string Meta = excel.GetCellToString(row, col);
                            foreach (DataRow fila in dt.Rows)
                            {
                                string CcffId = fila["CCFFId"].ToString();
                                if (CcffId == excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna))
                                {
                                    fila["RetirosTCCajaPIF"] = Char.IsNumber(Meta, 0) == true ? Meta : "0.0";
                                    break;
                                }
                            }
                        }
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                }
            

                string tipoArchivoTDCPif = TipoArchivo.RIDerivacionCajaRetirosTDCajaPIF.GetStringValue();
                cargaBase = new CargaBase<RIDerivacionCaja>(tipoArchivoTDCPif);
                var filesNamesTDCPif = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");

                foreach (var fileName in filesNamesTDCPif)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    fechaFile = new DateTime(año, mes, dia);
                    fechaModificacion = File.GetLastWriteTime(fileName);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    int i = 0;
                    DateTime fechaExcel;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0; col = 0;
                    string fecha = string.Empty;

                    while (row != null)
                    {
                        fecha = excel.GetCellToString(row, i);
                        if (col == 0)
                        {
                            while (!string.IsNullOrWhiteSpace(fecha))
                            {
                                fecha = excel.GetCellToString(row, i);
                                if (DateTime.TryParse(fecha, out fechaExcel)) { fechaExcel = Convert.ToDateTime(fechaExcel); }
                                if (fechaExcel == fechaFile)
                                {
                                    col = i;
                                    rowNum++;
                                    row = excel.Sheet.GetRow(rowNum);
                                    break;
                                }
                                i++;
                            }
                        }

                        if (col != 0)
                        {
                            cargaBase.PropiedadCol.First(p => p.Key == "RetirosTDCajaPIF").Value.PosicionColumna = col;
                            bool isValid = cargaBase.ValidarDatos(excel, row);
                            if (!isValid)
                            {
                                rowNum++;
                                row = excel.Sheet.GetRow(rowNum);
                                continue;
                            };

                            string Meta = excel.GetCellToString(row, col);
                            foreach (DataRow fila in dt.Rows)
                            {
                                string CcffId = fila["CCFFId"].ToString();
                                if (CcffId == excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna))
                                {
                                    fila["RetirosTDCajaPIF"] = Char.IsNumber(Meta, 0) == true ? Meta : "0.0";
                                    double RetirosTCCajaPIF = Convert.ToDouble(fila["RetirosTCCajaPIF"].ToString());
                                    double RetirosTDCajaPIF = Convert.ToDouble(fila["RetirosTDCajaPIF"].ToString());
                                    double RetirosCaja = RetirosTCCajaPIF + RetirosTDCajaPIF;
                                    fila["RetirosCajaPIF"] = Math.Round(RetirosCaja, 4);
                                }
                            }
                        }
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                }

                cargaBase.RegistrarCarga(dt, "RIDerivacionCaja");
                CargaArchivoBL.GetInstance().AddCCFFSucursal("RIDerivacionHeavyPlataforma", "CCFFId", "CCFF");

            }
            catch (Exception ex)
            {                
                
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            //fileError = false;
            

            
            

            //Se coloca el Id del Tienda-SucursalId a los registros
            

            Logger.Info("Se terminó la carga del archivo RIDerivacionCaja");
            Console.WriteLine("Se terminó la carga del archivo RIDerivacionCaja");
        }

        #endregion
    }
}
