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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.ADirectorio
{
    public class CargaRICCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Informacion Comercial");
            Console.WriteLine("Se inició la carga del archivo Informacion Comercial");
            var cargaBase = new CargaBase<RICCFF>();
            string tipoArchivo = TipoArchivo.RICCFF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            {
                 cargaBase = new CargaBase<RICCFF>(tipoArchivo);
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
                    DataTable dt = Utils.CrearCabeceraDataTable<RICCFF>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    string CCFF = string.Empty;
                    string Caja = string.Empty;
                    cont = 0;
                  
                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        CCFF = Utils.GetValueColumn(
                                excel.GetStringCellValue(row,
                                    cargaBase.PropiedadCol.First(p => p.Key == "CCFF").Value.PosicionColumna),
                                CCFF);

                        Caja = Utils.GetValueColumn(
                                 excel.GetStringCellValue(row,
                                     cargaBase.PropiedadCol.First(p => p.Key == "Caja").Value.PosicionColumna),
                                 Caja);

                        if (Caja == "SI")
                            Caja = "1";
                        if (Caja == "NO")
                            Caja = "0";
                        if (!string.IsNullOrWhiteSpace(CCFF))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["CCFF"] = CCFF;
                            dr["Caja"] =Caja;

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "CCFF");

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

            Logger.Info("Se terminó la carga del archivo Informacion Comercial");
            Console.WriteLine("Se terminó la carga del archivo Informacion Comercial");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            DataRow dr = dt.NewRow();
            dr["Id"] =excel.GetIntCellValue(row, _indexCol["Id"]);
            dr["Formato"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Formato"]),"");
            dr["GerenteOJefeCCFF"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["GerenteOJefeCCFF"]),"");
            dr["Cargo"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Cargo"]), "");
            dr["Direccion"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Direccion"]), "");
            dr["Departamento"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Departamento"]), "");
            dr["Provincia"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Provincia"]), "");
            dr["Distrito"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Distrito"]), "");
     
            return dr;
        }

        #endregion
    }
}
