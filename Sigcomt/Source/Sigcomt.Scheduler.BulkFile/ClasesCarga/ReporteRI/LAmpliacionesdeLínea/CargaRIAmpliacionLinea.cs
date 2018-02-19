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


namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.LAmpliacionesdeLínea
{
   public class CargaRIAmpliacionLinea
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);        

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo Ampliacion de Linea");
            Console.WriteLine("Se inició la carga del archivo Ampliacion de Linea");
            var cargaBase = new CargaBase<RIAmpliacionLinea>();
            string tipoArchivo = TipoArchivo.RIAmpliacionLinea.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool cargaError = true;

            try
            {
                 cargaBase = new CargaBase<RIAmpliacionLinea>(tipoArchivo);
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
                    DataTable dt = Utils.CrearCabeceraDataTable<RIAmpliacionLinea>();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    var row = excel.Sheet.GetRow(rowNum);
                    string CCFF = string.Empty;
                    cont = 0;

                    while (row != null)
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        if (!isValid) {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        };

                        CCFF = Utils.GetValueColumn(excel.GetStringCellValue(row, cargaBase.PropiedadCol.First(p => p.Key == "CCFF").Value.PosicionColumna), CCFF);

                        if (!(CCFF.StartsWith("ZONA", StringComparison.InvariantCultureIgnoreCase)))
                        {
                            cont++;
                            DataRow dr = cargaBase.AsignarDatos(dt);
                            dr["Secuencia"] = cont;
                            dt.Rows.Add(dr);
                        }
                        else if (!(CCFF.StartsWith("TOTAL", StringComparison.InvariantCultureIgnoreCase))) {
                            break;
                        }

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "RIAmpliacionLinea");                    

                }
            }
            catch (Exception ex)
            {
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo Ampliacion de Linea");
            Console.WriteLine("Se terminó la carga del archivo Ampliacion de Linea");
        }

        #endregion
    }
}
