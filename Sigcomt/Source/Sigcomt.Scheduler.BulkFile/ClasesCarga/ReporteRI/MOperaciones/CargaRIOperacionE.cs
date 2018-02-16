using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using log4net;
using NPOI.SS.UserModel;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;
using System.Globalization;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.MOperaciones
{
   public class CargaRIOperacionE
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);        

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Operaciones - Errores");
            Console.WriteLine("Se inició la carga del archivo Operaciones - Errores");
            var cargaBase = new CargaBase<RIOperacionE>();
            string tipoArchivo = TipoArchivo.RIOperacionE.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            {
                 cargaBase = new CargaBase<RIOperacionE>(tipoArchivo);
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
                    if (cabecera != null && cabecera.FechaModificacionArchivo == fechaModificacion) continue;

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

                    FileStream fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);

                    GenericExcel excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<RIOperacionE>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    int Anio = 0;
                    int Mes = 0;
                    cont = 0;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        //fechaRegistro = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["OPFecha"]),"");
                        Anio = excel.GetIntCellValue(row, cargaBase.PropiedadCol.First(p => p.Key == "APAnio").Value.PosicionColumna);
                        Mes = excel.GetIntCellValue(row, cargaBase.PropiedadCol.First(p => p.Key == "APMes").Value.PosicionColumna);
                        
                        if (Mes == mes && Anio == año)
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["OPAnio"] = Anio;
                            dr["OPMes"] = Mes;
                            dt.Rows.Add(dr);

                        }
                        
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);

                    }

                    DataTable dtResult = GroupBy("OPCCFFId", "OPCCFFId", dt);

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dtResult, "RIOperacionE");

                    cargaError = false;

                }
            }
            catch (Exception ex)
            {
                if (cargaError) cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Operaciones - Errores");
            Console.WriteLine("Se terminó la carga del archivo Operaciones - Errores");
        }

        #endregion

        #region Métodos Privados

        //private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        //{
        //    DataRow dr = dt.NewRow();
        //    dr["OPMoneda"] = excel.GetStringCellValue(row, _indexCol["OPMoneda"]);
        //    dr["OPCCFFId"] = excel.GetCellToString(row, _indexCol["OPCCFFId"]);
           
       
        //    return dr;
        //}


        public static DataTable GroupBy(string i_sGroupByColumn, string i_sAggregateColumn, DataTable i_dSourceTable)
        {

            DataView dv = new DataView(i_dSourceTable);

            DataTable dtGroup = dv.ToTable(true);
            dtGroup.Columns.Add("OPErrores", typeof(int));

            foreach (DataRow dr in dtGroup.Rows)
            {
                dr["OPErrores"] = i_dSourceTable.Compute("Count(" + i_sAggregateColumn + ")", i_sGroupByColumn + " = '" + dr[i_sGroupByColumn] + "'");
            }
            return dtGroup;
        }

        #endregion
    }
}
