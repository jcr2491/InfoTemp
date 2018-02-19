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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.BParticipación
{
    public class CargaRIParticipacionMaestro
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo RIParticipacionMaestro");
            Console.WriteLine("Se inició la carga del archivo RIParticipacionMaestro");
            var cargaBase = new CargaBase<RIParticipacionMaestro>();
            string tipoArchivo = TipoArchivo.RIParticipacionMaestro.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            bool cargaError = true;

            try
            {
                cargaBase = new CargaBase<RIParticipacionMaestro>(tipoArchivo);

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

                    FileStream fileBase = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                    GenericExcel excel = new GenericExcel(fileBase, cargaBase.HojaBd.NombreHoja);
                    DataTable dt = Utils.CrearCabeceraDataTable<RIParticipacionMaestro>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    cont = 0;
                    string Tienda = string.Empty;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        }

                        Tienda = Utils.GetValueColumn(
                                excel.GetStringCellValue(row,
                                    cargaBase.PropiedadCol.First(p => p.Key == "Tienda").Value.PosicionColumna),
                                Tienda);

                        if (Tienda.StartsWith("Esquema", StringComparison.InvariantCultureIgnoreCase))
                            break;
                        if (!string.IsNullOrWhiteSpace(Tienda) &&
                             !Tienda.StartsWith("Zona", StringComparison.InvariantCultureIgnoreCase) &&
                             !Tienda.StartsWith("Total", StringComparison.InvariantCultureIgnoreCase) &&
                             !Tienda.StartsWith("Esquema", StringComparison.InvariantCultureIgnoreCase))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;
                            dr["TiendaRatail"] = TiendaRetail.Maestro;
                            dr["DiferenciaParticipacionMeta"] = (Convert.ToDouble(dr["ParticipacionCMR"]) - Convert.ToDouble(dr["CMRMeta"]));
                            dt.Rows.Add(dr);
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }
                    cargaBase.RegistrarCarga(dt, "RIParticipacion");
                    //Se coloca el Id del Tienda-SucursalId a los registros
                    //CargaArchivoBL.GetInstance().AddSucursalId("RIParticipacion", "Tienda", "TiendaId");
                }
            }
            catch (Exception ex)
            {
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo RIParticipacionMaestro");
            Console.WriteLine("Se terminó la carga del archivo RIParticipacionMaestro");
        }

        #endregion

    }
}
