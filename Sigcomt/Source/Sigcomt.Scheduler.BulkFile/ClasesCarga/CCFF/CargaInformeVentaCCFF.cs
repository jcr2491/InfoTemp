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
    public class CargaInformeVentaCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo InformeVentaCCFF");
            Console.WriteLine("Se inició la carga del archivo InformeVentaCCFF");
            var cargaBase = new CargaBase<InformeVentaCCFF>();
            string tipoArchivo = TipoArchivo.InformeVentaCCFF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                //Nota: estamos asumiendo que delante vendra la fecha del archivo
                 cargaBase = new CargaBase<InformeVentaCCFF>(tipoArchivo);

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
                    var excel = new GenericExcel(fileBase, "Informe Venta");
                    DataTable dt = Utils.CrearCabeceraDataTable<InformeVentaCCFF>();

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
                        if (!isValid) continue;
                        CCFFId = Utils.GetValueColumn(
                           excel.GetStringCellValue(row,
                               cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna),
                           CCFFId);

                        CCFF = Utils.GetValueColumn(
                     excel.GetStringCellValue(row,
                        cargaBase.PropiedadCol.First(p => p.Key == "CCFF").Value.PosicionColumna),
                    CCFF);


                        if (CCFFId.StartsWith("Zona", StringComparison.InvariantCultureIgnoreCase))
                        {
                            Zona = CCFFId;
                        }
                        else if (CCFFId != string.Empty)
                        {
                            if (CCFFId == "533" || CCFFId == "800" || CCFFId == "601" || CCFFId == "3")
                            {
                                Zona = "";
                            }
                            if (CCFF != string.Empty)
                            {
                                cont++;
                                DataRow dr = cargaBase.AsignarDatos(dt);
                                dr["CargaId"] = cabeceraId;
                                dr["Secuencia"] = cont;
                                dr["Zona"] = Zona;
                                dr["CCFFId"] = CCFFId;
                                dr["CCFF"] = CCFF;

                                dt.Rows.Add(dr);
                            }
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "InformeVentaCCFF");

                    
                    

                }
            }
            catch (Exception ex)
            {
                

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo CmrRatificada");
            Console.WriteLine("Se terminó la carga del archivo CmrRatificada");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            DataRow dr = dt.NewRow();
            dr["TECCFFMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECCFFMeta"]), "0");
            dr["TECliAtenPlatMen10Logro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECliAtenPlatMen10Logro"]), "0");
            dr["TECliAtenPlatLogro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECliAtenPlatLogro"]), "0");
            dr["TEPlatMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TEPlatMeta"]), "0");
            dr["TECliAtenCajaMen10Logro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECliAtenCajaMen10Logro"]), "0");
            dr["TECliAtenCajaLogro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECliAtenCajaLogro"]), "0");
            dr["TECajaMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["TECajaMeta"]), "0");
            dr["PasivosAhorNormLogro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosAhorNormLogro"]), "0");
            dr["PasivosAhorNormMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosAhorNormMeta"]), "0");
            dr["PasivosCTSLogro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosCTSLogro"]), "0");
            dr["PasivosCTSMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosCTSMeta"]), "0");
            dr["PasivosAhorPlazoFijoLogro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosAhorPlazoFijoLogro"]), "0");
            dr["PasivosAhorPlazoFijoMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosAhorPlazoFijoMeta"]), "0");
            dr["PasivosCtaSuelNoCorpLogro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosCtaSuelNoCorpLogro"]), "0");
            dr["PasivosCtaSuelNoCorpMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosCtaSuelNoCorpMeta"]), "0");
            dr["PasivosCtaSuelIndepLogro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosCtaSuelIndepLogro"]), "0");
            dr["PasivosCtaSuelIndepMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosCtaSuelIndepMeta"]), "0");
            dr["PasivosAhorSimpleLogro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosAhorSimpleLogro"]), "0");
            dr["PasivosAhorSimpleMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivosAhorSimpleMeta"]), "0");
            dr["ServAfilEmailingLogro"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["ServAfilEmailingLogro"]), "0");
            dr["ServAfilEmailingMeta"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["ServAfilEmailingMeta"]), "0");

            return dr;
        }

        #endregion
    }
}
