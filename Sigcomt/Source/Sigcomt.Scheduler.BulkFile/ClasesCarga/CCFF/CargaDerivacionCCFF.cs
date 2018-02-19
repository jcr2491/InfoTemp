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
    public class CargaDerivacionCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo DerivacionCCFF");
            Console.WriteLine("Se inició la carga del archivo DerivacionCCFF");
            var cargaBase = new CargaBase<DerivacionCCFF>();
            string tipoArchivo = TipoArchivo.DerivacionCCFF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                //Nota: estamos asumiendo que delante vendra la fecha del archivo
                 cargaBase = new CargaBase<DerivacionCCFF>(tipoArchivo);

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
                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.DerivacionCCFF, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, "DerivacionCCFF");
                    DataTable dt = Utils.CrearCabeceraDataTable<DerivacionCCFF>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);                    
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


                        if (CCFFId != string.Empty)
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["CCFFId"] = CCFFId;
                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                    rowNum = cargaBase.HojaBd.FilaIni - 1;
                    row = excel.Sheet.GetRow(rowNum);
                    while (row != null)
                    {
                        CCFFId = excel.GetStringCellValue(row, _indexCol["NmrCCFFId"]);
                        
                        if (CCFFId != string.Empty)
                        {
                            DataRow dr = GetDataRowNmr(dt, excel, row, CCFFId, cont, cabeceraId);                            
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                    rowNum = 2;
                    row = excel.Sheet.GetRow(rowNum);

                    while (row != null)
                    {
                        CCFFId = excel.GetStringCellValue(row, _indexCol["NrrCCFFId"]);

                        if (CCFFId != string.Empty)
                        {
                          //  bool isNumeric = int.TryParse(CCFFId, out var result);
                           // if (isNumeric)
                            //{
                                DataRow dr = GetDataRowNmr(dt, excel, row, CCFFId, cont, cabeceraId);
                            //}
                        }
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                    rowNum = 2;
                    row = excel.Sheet.GetRow(rowNum);
                    while (row != null)
                    {
                        CCFFId = excel.GetStringCellValue(row, _indexCol["NrpCCFFId"]);

                        if (CCFFId != string.Empty)
                        {
                            //bool isNumeric = int.TryParse(CCFFId, out var result);
                            //if (isNumeric)
                            //{
                                DataRow dr = GetDataRowNmr(dt, excel, row, CCFFId, cont, cabeceraId);
                            //}
                        }
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "DerivacionCCFF");

                    
                    

                }
            }
            catch (Exception ex)
            {
                

                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo DerivacionCCFF");
            Console.WriteLine("Se terminó la carga del archivo DerivacionCCFF");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRowNmp(DataTable dt, GenericExcel excel, IRow row)
        {            
            DataRow dr = dt.NewRow();
            dr["Zona"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["NmpZona"]), "");
            dr["CCFFId"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["NmpCCFFId"]), "");
            var NmpMetaPago = excel.GetCellToString(row, _indexCol["NmpMetaPago"]);
            //bool isNumeric = int.TryParse(NmpMetaPago, out var result);
            //dr["NumMetaPagos"] = isNumeric == true ? int.Parse(NmpMetaPago) * 100 : 0;            

            return dr;
        }

        private static DataRow GetDataRowNrr(DataTable dt, GenericExcel excel, IRow row, string CCFFId, int cont, int cabeceraId)
        {
            DataRow dr = dt.Select(string.Format("CCFFId={0}", CCFFId)).FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
            if (dr != null)
            {                               
                dr["NumResultadoRetiro"] = excel.GetIntCellValue(row, _indexCol["NrrRI"]);
            }
            else
            {
                dr = dt.NewRow();
                dr["CargaId"] = cabeceraId;
                dr["Zona"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["NrrZona"]), "");
                dr["Secuencia"] = cont;
                dr["CCFFId"] = CCFFId;
                var NrrRI = excel.GetCellToString(row, _indexCol["NrrRI"]);
               // bool isNumeric = int.TryParse(NrrRI, out var result);
                //dr["NumResultadoRetiro"] = isNumeric == true ? int.Parse(NrrRI) : 0;
                //dt.Rows.Add(dr);
            }

            return dr;
        }

        private static DataRow GetDataRowNrp(DataTable dt, GenericExcel excel, IRow row, string CCFFId, int cont, int cabeceraId)
        {
            DataRow dr = dt.Select(string.Format("CCFFId={0}", CCFFId)).FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
            if (dr != null)
            {               
                dr["NumResultadoPagos"] = excel.GetIntCellValue(row, _indexCol["NrpPagosTC"]);
            }
            else
            {
                dr = dt.NewRow();
                dr["CargaId"] = cabeceraId;
                dr["Zona"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["NrpZona"]), "");
                dr["Secuencia"] = cont;
                dr["CCFFId"] = CCFFId;                
                dr["NumResultadoPagos"] = excel.GetIntCellValue(row, _indexCol["NrpPagosTC"]);
                dt.Rows.Add(dr);
            }

            return dr;
        }

        private static DataRow GetDataRowNmr(DataTable dt, GenericExcel excel, IRow row, string CCFFId, int cont, int cabeceraId)
        {
            DataRow dr = dt.Select(string.Format("CCFFId={0}", CCFFId)).FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
            if (dr != null)
            {
                var NmrRI = excel.GetCellToString(row, _indexCol["NmrRI"]);
                //bool isNumeric = int.TryParse(NmrRI, out var result);
                //dr["NumMetaRetiro"] = isNumeric == true ? int.Parse(NmrRI) * 100 : 0;
            }
            else
            {
                dr = dt.NewRow();
                dr["CargaId"] = cabeceraId;
                dr["Secuencia"] = cont;
                dr["CCFFId"] = CCFFId;
                dr["Zona"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["NmrZona"]), "");
                var NmrRI = excel.GetCellToString(row, _indexCol["NmrRI"]);
                //bool isNumeric = int.TryParse(NmrRI, out var result);
                //dr["NumMetaRetiro"] = isNumeric == true ? int.Parse(NmrRI) * 100 : 0;
                dt.Rows.Add(dr);
            }

            return dr;
        }
        #endregion
    }
}
