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
    public class CargarPasivosCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo PasivosCCFF");
            Console.WriteLine("Se inició la carga del archivo PasivosCCFF");
            var cargaBase = new CargaBase<PasivosCCFF>();
            string tipoArchivo = TipoArchivo.PasivosCCFF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                //Nota: estamos asumiendo que delante vendra la fecha del archivo
                 cargaBase = new CargaBase<PasivosCCFF>(tipoArchivo);

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
                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.PasivosCCFF, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, "PasivosCCFF");
                    DataTable dt = Utils.CrearCabeceraDataTable<PasivosCCFF>();

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
                        CCFFId = excel.GetStringCellValue(row, _indexCol["CCFFId"]);

                        if ((CCFFId != string.Empty) && !(CCFFId.StartsWith("Total", StringComparison.InvariantCultureIgnoreCase)))
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
                    CargaArchivoBL.GetInstance().Add(dt, "PasivosCCFF");

                    
                    

                }
            }
            catch (Exception ex)
            {
                

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo PasivosCCFF");
            Console.WriteLine("Se terminó la carga del archivo PasivosCCFF");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {            
            DataRow dr = dt.NewRow();
            dr["PasivoCortoPlazoReal"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivoCortoPlazoReal"]), "0");
            dr["PasivoLargoPlazoReal"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivoLargoPlazoReal"]), "0");
           
            return dr;
        }

        #endregion
    }
}