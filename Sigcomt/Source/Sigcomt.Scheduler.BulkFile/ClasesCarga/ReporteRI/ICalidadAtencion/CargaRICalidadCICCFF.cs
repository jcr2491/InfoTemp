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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.ICalidadAtencion
{
    public class CargaRICalidadCICCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);        

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo RICalidadCICCFF");
            Console.WriteLine("Se inició la carga del archivo RICalidadCICCFF");
            var cargaBase = new CargaBase<RICalidadCICCFF>();
            string tipoArchivo = TipoArchivo.RICalidadCICCFF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                 cargaBase = new CargaBase<RICalidadCICCFF>(tipoArchivo);
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
                    DataTable dt = Utils.CrearCabeceraDataTable<RICalidadCICCFF>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);
                    string CCFFId = string.Empty;
                    string Zona = "";
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
                        CCFFId = Utils.GetValueColumn(excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna), string.Empty);

                        if (CCFFId.StartsWith("Zona", StringComparison.InvariantCultureIgnoreCase))
                        {
                            Zona = CCFFId;
                        }
                        else if (CCFFId != string.Empty)
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["CCFFId"] = CCFFId;
                            dr["Zona"] = "";
                            dt.Rows.Add(dr);
                        }
                        else
                        {
                            dt.Select(string.Format("[Zona] = '{0}'", ""))
                             .ToList<DataRow>()
                             .ForEach(r => {
                                 r["Zona"] = Zona;
                             });
                            Zona = "";
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "CICCFF");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);

                }
            }
            catch (Exception ex)
            {
                cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo CICCFF");
            Console.WriteLine("Se terminó la carga del archivo CICCFF");
        }

        #endregion

        #region Métodos Privados

        //private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        //{            
        //    DataRow dr = dt.NewRow();            
        //    dr["CCFF"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CCFF"]), "");                        
        //    dr["LogroREL"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["LogroREL"]), "0");
        //    dr["MetaREL"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["MetaREL"]), "0");
        //    dr["PorcentajeLogroREL"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PorcentajeLogroREL"]), "0.0");
        //    dr["LogroEECC"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["LogroEECC"]), "0");
        //    dr["MetaEECC"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["MetaEECC"]), "0");
        //    dr["PorcentajeLogroEECC"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PorcentajeLogroEECC"]), "0.0");
        //    dr["LogroCAJ"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["LogroCAJ"]), "0");
        //    dr["MetaCAJ"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["MetaCAJ"]), "0");
        //    dr["PorcentajeLogroCAJ"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PorcentajeLogroCAJ"]), "0.0");
        //    dr["LogroPRO"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["LogroPRO"]), "0");
        //    dr["MetaPRO"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["MetaPRO"]), "0");
        //    dr["PorcentajeLogroPRO"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PorcentajeLogroPRO"]), "0.0");
        //    dr["LogroTotal"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["LogroTotal"]), "0");
        //    dr["MetaTotal"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["MetaTotal"]), "0");
        //    dr["PorcentajeLogroTotal"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PorcentajeLogroTotal"]), "0.0");

        //    return dr;
        //}

        #endregion
    }
}