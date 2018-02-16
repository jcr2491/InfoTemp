using log4net;
using NPOI.SS.UserModel;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Automotriz
{
    public class PruebaCargaAutomotriz
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Productividad");
            Console.WriteLine("Se inició la carga del archivo Productividad");

            string tipoArchivo = TipoArchivo.DataAutomotriz.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            //Nota: estamos asumiendo que delante vendra la fecha del archivo
            var cargaBase = new CargaBase<DataAutomotriz>(tipoArchivo);


            var filesNames = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");
            //Se cargan las posiciones de las columnas del excel                
            try
            {
                if (filesNames.Length > 0)
                {
            
                    var split = filesNames[0].Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = 1;
                    int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                    int año = Convert.ToInt32(onlyName.Substring(2, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);
                    DateTime fechaModificacion = File.GetLastWriteTime(filesNames[0]);

                    var cabecera = CabeceraCargaBL.GetInstance().GetCabeceraCargaProcesado(tipoArchivo, fechaFile);
                    if (cabecera != null)
                    {
                        if (fechaModificacion.GetDateTimeToString() ==
                            cabecera.FechaModificacionArchivo.GetDateTimeToString())
                        {
                            
                            goto salir;
                        }
                           
                    }

                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.DataAutomotriz, EstadoCarga.Iniciado, fechaFile);
                    cabeceraId = cargaBase.AgregarCabecera(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });

                    Console.WriteLine("Se está procesando el archivo: " + filesNames[0]);
                    Logger.InfoFormat("Se está procesando el archivo: " + filesNames[0]);

                    var fileBase = new FileStream(filesNames[0], FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, 0);
                    DataTable dt = Utils.CrearCabeceraDataTable<DataAutomotriz>();
                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);


                    //TODO: Aqui se debe hacer la logica para consumir de la tabla excel de configuracion

                    while (row != null)
                    {
                        //

                        string pase = excel.GetCellToString(row, _indexCol["NroPrestamo"]);
                        if (pase != string.Empty)
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["Moneda"] = Utils.GetValueColumn("Soles");

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "DataAutomotriz");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);

                    //Se coloca el Id del empleado a los registros
                    CargaArchivoBL.GetInstance().AddEmpleadoId("DataAutomotriz", "Empleado", "EmpleadoId");
                }


            }
            catch (Exception ex)
            {
                cargaBase.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            salir:

            Logger.Info("Se terminó la carga del archivo Productividad");
            Console.WriteLine("Se terminó la carga del archivo Productividad");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            DataRow dr = dt.NewRow();
            dr["NroPrestamo"] = excel.GetIntCellValue(row, _indexCol["NroPrestamo"]);
            dr["TipoDoc"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["TipoDoc"]));
            dr["Documento"] = excel.GetIntCellValue(row, _indexCol["Documento"]);
            dr["Empleado"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Empleado"]));
            dr["FechaDesembolso"] = excel.GetDateCellValue(row, _indexCol["FechaDesembolso"]);
            dr["Canal"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Canal"]));
            dr["Captacion"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Captacion"]));
            dr["Promotor"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Promotor"]));
            dr["Asistente"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Asistente"]));
            dr["TipoSeguro"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["TipoSeguro"]));
            dr["Precio"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Precio"]));
            dr["CuotaInicial"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CuotaInicial"]));
            dr["Monto"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Monto"]));
            string interm = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Intermediacion"]), string.Empty);
            dr["Intermediacion"] = interm;

            return dr;
        }

        #endregion

        #region Validation
        public static bool ValidateExcel(GenericExcel excel, Dictionary<string, int> _indexCol, int FilaIni, ref List<ResponseError> response, ref DataTable dt)
        {


            int rowNum = FilaIni - 1, cont = 0, iterador = 0;
            var row = excel.Sheet.GetRow(rowNum);
            string campo = "", codigo = "";
            try
            {
                // Recorriendo el archivo excel
                while (row != null)
                {
                    string pase = excel.GetCellToString(row, _indexCol["NroPrestamo"]);
                    if (pase != string.Empty)
                    {
                        cont++;
                        DataRow dr = GetDataRow(dt, excel, row);
                        dr["CargaId"] = 0;
                        dr["Secuencia"] = cont;
                        dr["Moneda"] = Utils.GetValueColumn("Soles");
                        dr["NroPrestamo"] = excel.GetIntCellValue(row, _indexCol["NroPrestamo"]);
                        dr["TipoDoc"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["TipoDoc"]));
                        dr["Documento"] = excel.GetIntCellValue(row, _indexCol["Documento"]);
                        dr["Empleado"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Empleado"]));
                        dr["FechaDesembolso"] = excel.GetDateCellValue(row, _indexCol["FechaDesembolso"]);
                        dr["Canal"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Canal"]));
                        dr["Captacion"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Captacion"]));
                        dr["Promotor"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Promotor"]));
                        dr["Asistente"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Asistente"]));
                        dr["TipoSeguro"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["TipoSeguro"]));
                        dr["Precio"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Precio"]));
                        dr["CuotaInicial"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CuotaInicial"]));
                        dr["Monto"] = Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Monto"]));
                        string interm = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Intermediacion"]), string.Empty);
                        dr["Intermediacion"] = interm;


                        dt.Rows.Add(dr);
                    }

                    rowNum++;
                    row = excel.Sheet.GetRow(rowNum);
                }
            }
            catch (Exception e)
            {

            }


            return true;
        }
        #endregion
    }
}