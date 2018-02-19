using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using log4net;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.UAC
{
    public class CargaSlaUac
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        
        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo SLAUAC");
            Console.WriteLine("Se inició la carga del archivo SLAUAC");
            
            string tipoArchivo = TipoArchivo.SLA.GetStringValue();
            var cargaBase = new CargaBase<Productividad>(tipoArchivo);
            int cont = 0;

            try
            {                
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

                    cargaBase.AgregarCabecera(new CabeceraCarga
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
                    DataTable dt = Utils.CrearCabeceraDataTable<SlaUac>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    string grupo = string.Empty;
                    string supervisor = string.Empty;
                    cont = 0;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);

                        if (isValid)
                        {
                            grupo = Utils.GetValueColumn(
                                excel.GetStringCellValue(row,
                                cargaBase.PropiedadCol.First(p => p.Key == "Grupo").Value.PosicionColumna), grupo);

                            if (!(supervisor.StartsWith("Total", StringComparison.InvariantCultureIgnoreCase) ||
                                  grupo.StartsWith("Total", StringComparison.InvariantCultureIgnoreCase)))
                            {
                                cont++;
                                DataRow dr = cargaBase.AsignarDatos(dt);
                                dr["Secuencia"] = cont;
                                dr["Grupo"] = grupo;

                                dt.Rows.Add(dr);
                            }

                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                        }
                    }

                    cargaBase.RegistrarCarga(dt, "SLAUAC");

                    //Se coloca el Id del empleado a los registros
                    CargaArchivoBL.GetInstance().AddEmpleadoId("SLAUAC", "Empleado", "EmpleadoId");

                    //Se coloca el Id del grupo a los registros
                    CargaArchivoBL.GetInstance().AddGrupoId("SLAUAC");
                }
            }
            catch (Exception ex)
            {
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo SLAUAC");
            Console.WriteLine("Se terminó la carga del archivo SLAUAC");
        }

        #endregion
    }
}