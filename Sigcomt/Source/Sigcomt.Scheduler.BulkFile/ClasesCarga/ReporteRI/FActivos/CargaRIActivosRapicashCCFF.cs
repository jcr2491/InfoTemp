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
                                dr["CargaId"] = cabeceraId;
                                dr["Secuencia"] = cont;
                                dr["Zona"] = Zona;
                                dr["CCFFId"] = CCFFId;
                                dr["CCFF"] = CCFF;
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

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "RIActivosRapicashCCFF");

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

            Logger.Info("Se terminó la carga del archivo RapicashCCFF");
            Console.WriteLine("Se terminó la carga del archivo RapicashCCFF");
        }

        #endregion

        #region Métodos Privados

        //private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        //{
        //    DataRow dr = dt.NewRow();

        //    var pifSolesLogro = excel.GetDoubleCellValue(row, _indexCol["PifSolesLogro"]);
        //    var PifSolesMeta = excel.GetDoubleCellValue(row, _indexCol["PifSolesMeta"]);
        //    var ATMSolesLogro = excel.GetDoubleCellValue(row, _indexCol["ATMSolesLogro"]);
        //    var ATMSolesMeta = excel.GetDoubleCellValue(row, _indexCol["ATMSolesMeta"]);

        //    dr["PifSolesLogro"] = Convert.ToDecimal(pifSolesLogro);
        //    dr["PifSolesMeta"] = Convert.ToDecimal(PifSolesMeta);
        //    if ((double) pifSolesLogro > 0 && (double) PifSolesMeta > 0)
        //    {

        //        dr["PifSolesLogroProy"] = Convert.ToDecimal(pifSolesLogro) / Convert.ToDecimal(PifSolesMeta); ;
        //    }
        //    else
        //    {
        //        dr["PifSolesLogro"] = 0;
        //        dr["PifSolesMeta"] = 0;
        //        dr["PifSolesLogroProy"] = 0;
        //    }

        //    dr["ATMSolesLogro"] = Convert.ToDecimal(ATMSolesLogro);
        //    dr["ATMSolesMeta"] = Convert.ToDecimal(ATMSolesMeta);
        //    if ((double) ATMSolesLogro > 0 && (double) ATMSolesMeta > 0)
        //    {
        //        dr["ATMSolesLogroProy"] = Convert.ToDecimal(ATMSolesLogro) / Convert.ToDecimal(ATMSolesMeta); ;
        //    }
        //    else
        //    {
        //        dr["ATMSolesLogro"] = 0;
        //        dr["ATMSolesMeta"] = 0;
        //        dr["ATMSolesLogroProy"] = 0;
        //    }


        //    dr["TotalSolesLogro"] = pifSolesLogro + ATMSolesLogro;
        //    dr["TotalSolesMeta"] = PifSolesMeta + ATMSolesMeta;

        //    if ((double) dr["TotalSolesLogro"] > 0 && (double) dr["TotalSolesMeta"] > 0)
        //    {
        //        dr["TotalSolesLogroProy"] = Convert.ToDecimal(Convert.ToDecimal(dr["TotalSolesLogro"]) / Convert.ToDecimal(dr["TotalSolesMeta"]));
        //    }
        //    else
        //    {
        //        dr["TotalSolesLogroProy"] = 0;
        //    }

        //    return dr;
        //}

        #endregion
    }
}
