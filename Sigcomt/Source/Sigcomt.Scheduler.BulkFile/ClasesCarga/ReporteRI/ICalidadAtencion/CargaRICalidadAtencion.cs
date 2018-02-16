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
    public class CargaRICalidadAtencion
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Calidad Atención");
            Console.WriteLine("Se inició la carga del archivo Calidad Atención");
            var cargaBase = new CargaBase<RICalidadAtencion>();
            string tipoArchivo = TipoArchivo.RICalidadAtencion.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;
            int num = 0;
            try
            {
                cargaBase = new CargaBase<RICalidadAtencion>(tipoArchivo);
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
                    DataTable dt = Utils.CrearCabeceraDataTable<RICalidadAtencion>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    string CCFFId = string.Empty;
                    cont = 0;
                    DateTime date;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                         CCFFId = Utils.GetValueColumn(excel.GetCellToString(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFFId").Value.PosicionColumna), CCFFId);

                        if (CCFFId != string.Empty && Char.IsNumber(CCFFId,0) )
                        {
                                cont++;
                                DataRow dr = cargaBase.AsignarDatos(dt);
                                dr["Secuencia"] = cont;
                                dt.Rows.Add(dr); 
                        }
                        num++;
                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;

                    CargaArchivoBL.GetInstance().Add(dt, "RICalidadAtencion");

                    cargaError = false;
                    //Se actualiza a procesado la tabla CabeceraCarga
                    cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);

                    //Se coloca el Id del empleado a los registros
                    //CargaArchivoBL.GetInstance().AddEmpleadoId("MetaTiendaRapicash", "Empleado", "EmpleadoId");
                }
            }
            catch (Exception ex)
            {
                if (cargaError) cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);
                int n = num;
                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Calidad Atención");
            Console.WriteLine("Se terminó la carga del archivo Calidad Atención");
        }

        #endregion

        #region Métodos Privados

        public static DataTable GroupBy(DateTime FechaFile, DataTable i_dSourceTable, int CargaID)
        {
            DataTable query = i_dSourceTable.AsEnumerable().Where(name => name.Field<bool>("IngresoBack") == true).CopyToDataTable();
            var query2 = query.AsEnumerable().GroupBy(r1 => new
            {
                CCFFId = r1.Field<string>("CCFFId"),
                CCFF = r1.Field<string>("CCFF"),
                Zona = r1.Field<string>("Zona")
            }).Select(g => new
            {
                CCFFId = g.Key.CCFFId,
                CCFF = g.Key.CCFF,
                Zona = g.Key.Zona,
                Count = Convert.ToDouble(g.Count())
            });
            DataTable dt2 = Utils.LinqQueryToDataTable(query2);

            query = i_dSourceTable.AsEnumerable().CopyToDataTable();
            var query3 = query.AsEnumerable().GroupBy(r1 => new {
                CCFFId = r1.Field<string>("CCFFId"),
                CCFF = r1.Field<string>("CCFF"),
                Zona = r1.Field<string>("Zona")
            }).Select(g => new
            {
                CCFFId = g.Key.CCFFId,
                CCFF = g.Key.CCFF,
                Zona = g.Key.Zona,
                Count = Convert.ToDouble(g.Count())
            });
            DataTable dt3 = Utils.LinqQueryToDataTable(query3);

            DataTable dtResult = new DataTable();
            dtResult.Columns.Add("CCFFId", typeof(string));
            dtResult.Columns.Add("CCFF", typeof(string));
            dtResult.Columns.Add("Zona", typeof(string));
            dtResult.Columns.Add("FechaFile", typeof(DateTime));
            dtResult.Columns.Add("Logro", typeof(double));

            var InnerJoin = from a in dt2.AsEnumerable()
                            join b in dt3.AsEnumerable()
                            on a.Field<string>("CCFFId") equals b.Field<string>("CCFFId")
                            select dtResult.LoadDataRow(new object[]
                            {
                               a.Field<string>("CCFFId"),
                               a.Field<string>("CCFF"),
                               a.Field<string>("Zona"),
                               FechaFile,
                               Math.Round(a.Field<double>("Count") / b.Field<double>("Count"), 3)
                            }, false);
            dtResult = InnerJoin.CopyToDataTable();

            dtResult.Columns.Add("CargaId", typeof(int)).SetOrdinal(0);
            dtResult.Columns.Add("Secuencia", typeof(int)).SetOrdinal(1);
            int secuencia = 0;

            foreach (DataRow row in dtResult.Rows)
            {
                string id = row["CCFFId"].ToString();
                int number;
                if (!Int32.TryParse(id, out number))
                {
                    row.Delete();
                }
            }
            dtResult.AcceptChanges();

            foreach (DataRow row in dtResult.Rows)
            {
                row["CargaID"] = CargaID;
                row["Secuencia"] = secuencia++;
            }

            return dtResult;
        }
        #endregion
    }
}
