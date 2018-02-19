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
    public class CargaSegurosCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo SegurosCCFF");
            Console.WriteLine("Se inició la carga del archivo SegurosCCFF");
            var cargaBase = new CargaBase<SegurosCCFF>();
            string tipoArchivo = TipoArchivo.SegurosCCFF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                //Nota: estamos asumiendo que delante vendra la fecha del archivo
                cargaBase = new CargaBase<SegurosCCFF>(tipoArchivo);

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

                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.SegurosCCFF, EstadoCarga.Iniciado, fechaFile);
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
                    var excel = new GenericExcel(fileBase, "SegurosCCFF");
                    DataTable dt = Utils.CrearCabeceraDataTable<SegurosCCFF>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);
                    string CCFFId = string.Empty;

                    //TODO: Aqui se debe hacer la logica para consumir de la tabla excel de configuracion

                    while (row != null)
                    {
                        CCFFId = excel.GetStringCellValue(row, _indexCol["CCFFId"]);

                        if (CCFFId != string.Empty)
                        {                            
                            cont++;
                            DataRow dr = GetDataRow(dt, excel, row);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["CCFFId"] = CCFFId;
                            dt.Rows.Add(dr);
                         }     

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "SegurosCCFF");

                    
                    

                }
            }
            catch (Exception ex)
            {
                

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo SegurosCCFF");
            Console.WriteLine("Se terminó la carga del archivo SegurosCCFF");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            int TPCJLogro = 0;
            int TPPRLogro = 0;
            DataRow dr = dt.NewRow();
            dr["Zona"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Zona"]), "");            
            dr["CCFF"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CCFF"]), "");
            TPCJLogro = excel.GetIntCellValue(row, _indexCol["VSCLogro"]);
            dr["TPCJLogro"] = TPCJLogro;
            dr["VSCMeta"] = excel.GetIntCellValue(row, _indexCol["VSCMeta"]);
            dr["TPCJLogro"] = excel.GetIntCellValue(row, _indexCol["TPCJLogro"]);
            dr["TPCJMeta"] = excel.GetIntCellValue(row, _indexCol["TPCJMeta"]);
            TPPRLogro = excel.GetIntCellValue(row, _indexCol["TPPRLogro"]);
            dr["TPPRLogro"] = TPPRLogro;
            dr["TPPRMeta"] = excel.GetIntCellValue(row, _indexCol["TPPRMeta"]);
            dr["TPECC"] = excel.GetIntCellValue(row, _indexCol["TPECC"]);
            dr["TotalTPLogro"] = TPCJLogro + TPPRLogro;

            return dr;
        }

        #endregion
    }
}
