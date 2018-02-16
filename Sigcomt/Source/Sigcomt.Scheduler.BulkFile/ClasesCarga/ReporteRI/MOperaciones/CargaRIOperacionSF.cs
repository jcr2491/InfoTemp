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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.MOperaciones
{
    public class CargaRIOperacionSF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);        

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Operaciones");
            Console.WriteLine("Se inició la carga del archivo Operaciones");
            var cargaBase = new CargaBase<RIOperacionSF>();
            string tipoArchivo = TipoArchivo.RIOperacionSF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            {
                 cargaBase = new CargaBase<RIOperacionSF>(tipoArchivo);
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
                    DataTable dt = Utils.CrearCabeceraDataTable<RIOperacionSF>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    string fechaRegistro = string.Empty;
                    cont = 0;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        fechaRegistro = Utils.GetDateToString(excel.GetDateCellValue(row, cargaBase.PropiedadCol.First(p => p.Key == "OPFechaRegistro").Value.PosicionColumna)??default(DateTime));
                        
                        if (Convert.ToDateTime(fechaRegistro).Month == mes &&
                            Convert.ToDateTime(fechaRegistro).Year == año)
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            //dr["OPFechaRegistro"] = fechaRegistro;
                            dt.Rows.Add(dr);

                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);

                    }

                    DataTable dtResult = GroupBy("OPCodCCFF", "OPCodCCFF", dt);

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dtResult, "RIOperacionSF");

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

            Logger.Info("Se terminó la carga del archivo Operaciones");
            Console.WriteLine("Se terminó la carga del archivo Operaciones");
        }

        #endregion

        #region Métodos Privados

        //private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        //{
        //    DataRow dr = dt.NewRow();
      
        //    dr["OPCodigo"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["OPCodigo"]), "");
        //    dr["OPCodCCFF"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["OPCodCCFF"]), "");
        //    dr["OPCCFF"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["OPCCFF"]), "-");
        //    dr["OPNombre"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["OPNombre"]), "-");
        //    return dr;
        //}


        public  static DataTable GroupBy(string i_sGroupByColumn, string i_sAggregateColumn, DataTable i_dSourceTable)
        {

            DataView dv = new DataView(i_dSourceTable);

            DataTable dtGroup = dv.ToTable(true);
            dtGroup.Columns.Add("OPSobranFaltan", typeof(int));

            foreach (DataRow dr in dtGroup.Rows)
            {
                dr["OPSobranFaltan"] = i_dSourceTable.Compute("Count(" + i_sAggregateColumn + ")", i_sGroupByColumn + " = '" + dr[i_sGroupByColumn] + "'");
            }
            return dtGroup;
        }

        #endregion
    }
}
