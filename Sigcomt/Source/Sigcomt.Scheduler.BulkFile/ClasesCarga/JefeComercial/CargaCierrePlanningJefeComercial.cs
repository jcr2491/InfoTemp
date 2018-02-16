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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.JefeComercial
{
    public class CargaCierrePlanningJefeComercial
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Cierre Planning");
            Console.WriteLine("Se inició la carga del archivo Cierre Planning");
            var cargaBase = new CargaBase<CargaCierrePlanningJefeComercial>();
            string tipoArchivo = TipoArchivo.CierrePlanningJefeComercial.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            {
                 cargaBase = new CargaBase<CargaCierrePlanningJefeComercial>(tipoArchivo);

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
                    //cabeceraId = cargaBase.AgregarCabecera(TipoArchivo.CierrePlanningJefeComercial, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    var fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    var excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<CierrePlanningJefeComercial>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    string Zona = string.Empty;
                    cont = 0;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        Zona = Utils.GetValueColumn(
                           excel.GetStringCellValue(row,
                               cargaBase.PropiedadCol.First(p => p.Key == "Zona").Value.PosicionColumna),
                           Zona);

                        if (! string.IsNullOrWhiteSpace(Zona))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["CargaId"] = cabeceraId;
                            dr["Secuencia"] = cont;
                            dr["Zona"] = Zona;

                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "CierrePlanningJefeComercial");

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

                string messageError = UtilsLocal.GetMessageError(fileError, null, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Cierre Planning");
            Console.WriteLine("Se terminó la carga del archivo Cierre Planning");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, GenericExcel excel, IRow row)
        {
            DataRow dr = dt.NewRow();
            dr["CodigoCCFF"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CodigoCCFF"]),"0");
            dr["Nombre"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["Nombre"]),"0");
            dr["Cargo"] = Utils.GetValueColumn(excel.GetStringCellValue(row, _indexCol["Cargo"]),"0");
            dr["CalidadTELogro"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadTELogro"]));
            dr["CalidadTEMeta"] =Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadTEMeta"]));
            dr["CalidadCILogro"] =Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadCILogro"]));
            dr["CalidadCIMeta"] =Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadCIMeta"]));
            dr["CalidadCIResultado"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadCIResultado"]));
            dr["CalidadCIPromotorLogro"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadCIPromotorLogro"]));
            dr["CalidadCIPromotorMeta"] = Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadCIPromotorMeta"]));
            dr["CalidadCIPromotorResultado"] =Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadCIPromotorResultado"]));
            dr["CalidadCIEECCPromotorLogro"] =Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadCIEECCPromotorLogro"]));
            dr["CalidadCIEECCPromotorMeta"] =Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadCIEECCPromotorMeta"]));
            dr["CalidadCIEECCPromotorResultado"] =Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadCIEECCPromotorResultado"]));
            dr["CalidadNPSLogro"] = Utils.GetPorcentaje(excel.GetCellToString( row, _indexCol["CalidadNPSLogro"]));
            dr["CalidadNPSMeta"] =Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadNPSMeta"]));
            dr["CalidadNPSResultado"] =Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["CalidadNPSResultado"]));
            dr["TarjetaCMRCSTPPLogro"] =Utils.GetPorcentaje(excel.GetCellToString(row, _indexCol["TarjetaCMRCSTPPLogro"]));
            dr["TarjetaCMRCSTPPMeta"] =excel.GetCellToString(row, _indexCol["TarjetaCMRCSTPPMeta"]);
            dr["ActivoPasivoCPLogro"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["ActivoPasivoCPLogro"]),"0");
            dr["ActivoPasivoCPMeta"] =Utils.GetValueColumn (excel.GetCellToString(row, _indexCol["ActivoPasivoCPMeta"]),"0");
            dr["ActivoCVLogro"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["ActivoCVLogro"]),"0");
            dr["ActivoCVMeta"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["ActivoCVMeta"]),"0");
            dr["PasivoTarjetaCLogro"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivoTarjetaCLogro"]),"0");
            dr["PasivoTarjetaCMeta"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivoTarjetaCMeta"]),"0");
            dr["PasivoCSALogro"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivoCSALogro"]),"0");
            dr["PasivoCSAMeta"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["PasivoCSAMeta"]),"0");
            dr["CrucePAPLogro"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CrucePAPLogro"]),"0");
            dr["CrucePAPMeta"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CrucePAPMeta"]),"0");
            dr["CrucePEECCPLogro"] =Utils.GetValueColumn( excel.GetCellToString(row, _indexCol["CrucePEECCPLogro"]),"0");
            dr["CrucePEECCPMeta"] =Utils.GetValueColumn(excel.GetCellToString(row, _indexCol["CrucePEECCPMeta"]),"0");

            return dr;
        }

        #endregion
    }
}
