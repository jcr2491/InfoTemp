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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.HSeguros
{
    public class CargaRISeguroCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo RISeguroCCFF");
            Console.WriteLine("Se inició la carga del archivo RISeguroCCFF");
            var cargaBase = new CargaBase<RISeguroCCFF>();
            string tipoArchivo = TipoArchivo.RISeguroCCFF.GetStringValue();
           
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            {
                cargaBase = new CargaBase<RISeguroCCFF>(tipoArchivo);
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
                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.RISeguroCCFF, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<RISeguroCCFF>();
                    
                    int rowNum =cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;
                    string Tienda = string.Empty;
                    while (row != null)
                    {
                        //Validation row
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };
                        Tienda = Utils.GetValueColumn(
                           excel.GetStringCellValue(row,
                               cargaBase.PropiedadCol.First(p => p.Key == "Tienda").Value.PosicionColumna),
                           Tienda);


                        if (!string.IsNullOrWhiteSpace(Tienda) && !Tienda.StartsWith("Total", StringComparison.InvariantCultureIgnoreCase) &&
                            !Tienda.StartsWith("Tienda", StringComparison.InvariantCultureIgnoreCase))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["Tienda"] = Tienda;
                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                    DataTable dt2 = _DataRISeguroVSC();
              
                    DataTable dtResult = new DataTable();
                    dtResult.Columns.Add("CargaId", typeof(int));
                    dtResult.Columns.Add("Secuencia", typeof(int));
                    dtResult.Columns.Add("CCFFId", typeof(int));
                    dtResult.Columns.Add("Zona", typeof(string));
                    dtResult.Columns.Add("Tienda", typeof(string));
                    dtResult.Columns.Add("TPNetoEC", typeof(decimal));
                    dtResult.Columns.Add("TPNetoCP", typeof(decimal));
                    dtResult.Columns.Add("TPNetoPR", typeof(decimal));
                    dtResult.Columns.Add("TPCuotaCP", typeof(decimal));
                    dtResult.Columns.Add("TPCuotaPR", typeof(decimal));
                    dtResult.Columns.Add("VidaSNeto", typeof(decimal));
                    dtResult.Columns.Add("VidaSCuota", typeof(decimal));
           
                    fileError = false;
                    var InnerJoin = from a in dt.AsEnumerable()
                                    join b in dt2.AsEnumerable()
                                    on a.Field<int>("CCFFId") equals b.Field<int>("CCFFId")
                                    select dtResult.LoadDataRow(new object[]
                                    {
                                        a.Field<int>("CCFFId"),
                                        a.Field<int>("CargaId"),
                                        a.Field<int>("Secuencia"),
                                        a.Field<string>("Zona"),
                                        a.Field<string>("Tienda"),
                                        a.Field<decimal>("TPNetoEC"),
                                        a.Field<decimal>("TPNetoCP"),
                                        a.Field<decimal>("TPNetoPR"),
                                        a.Field<decimal>("TPCuotaCP"),
                                        a.Field<decimal>("TPCuotaPR"),
                                        b.Field<decimal>("VidaSNeto"),
                                        b.Field<decimal>("VidaSCuota"),
                                    },false);


                    dt = InnerJoin.CopyToDataTable();

                    CargaArchivoBL.GetInstance().Add(dt, "RISeguroCCFF");

                    cargaError = false;
                    
                    

                    //Se coloca el Id del empleado a los registros
                    //CargaArchivoBL.GetInstance().AddEmpleadoId("MetaTiendaRapicash", "Empleado", "EmpleadoId");
                }
            }
            catch (Exception ex)
            {
                

                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo RISeguroCCFF");
            Console.WriteLine("Se terminó la carga del archivo RISeguroCCFF");
        }


        //Carga de Reporte VSC

        public static DataTable _DataRISeguroVSC()
        {
            DataTable dt = new DataTable();
            var cargaBase = new CargaBase<RISeguroVSC>();
            string tipoArchivo = TipoArchivo.RISeguroVSC.GetStringValue();

            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;
            try
            {
                var RISeguroVSC = new object { };
                //Inicio de Carga
                 cargaBase = new CargaBase<RISeguroVSC>(tipoArchivo);
        

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
                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);

                    dt = Utils.CrearCabeceraDataTable<RISeguroVSC>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;
                    var CCFFId = string.Empty;

                    while (row != null)
                    {
                        //Validation row
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) continue;
                        CCFFId = Utils.GetValueColumn(
                           excel.GetStringCellValue(row,
                               cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna),
                           CCFFId);
                   

                        if (!string.IsNullOrWhiteSpace(CCFFId) && char.IsNumber(CCFFId,0))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CCFFId"] = CCFFId;
                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                }
            }
            catch (Exception ex)
            {
                

                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            return dt;
        }



        #endregion

    }
}
