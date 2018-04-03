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
using Sigcomt.WinForms.BulkCopy.Core;

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.Automotriz
{
    public class CargaDataAutomotriz
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            string tipoArchivo = TipoArchivo.DataAutomotriz.GetStringValue();
            if (!UtilsLocal.PermitirCargaArchivo(tipoArchivo)) return;
           
            UtilsLocal.AsignarEstadoInicioCarga(tipoArchivo);
            var cargaBase = new CargaBase(tipoArchivo, "DataAutomotriz");

            try
            {
                cargaBase.ValidarExisteDirectorio();
                var filesNames = cargaBase.GetNombreArchivos();

                foreach (var fileName in filesNames)
                {
                    DateTime fechaFile = cargaBase.GetFechaArchivo(fileName);
                    DateTime fechaModificacion = File.GetLastWriteTime(fileName);

                    var cabecera = CabeceraCargaBL.GetInstance().GetCabeceraCargaProcesado(tipoArchivo, fechaFile);
                    if (cabecera != null)
                    {
                        if (fechaModificacion.GetDateTimeToString() ==
                            cabecera.FechaModificacionArchivo.GetDateTimeToString())
                        {
                            continue;
                        }
                    }

                    GenericExcel excel = cargaBase.GetHojaExcel(fileName);

                    cargaBase.AgregarCabeceraCarga(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });

                    UtilsLocal.AsignarEstado(string.Format(Constantes.ProcesandoArchivo, fileName,
                        cargaBase.HojaBd.NombreHoja));
                    DataTable dt = cargaBase.CrearCabeceraDataTable();

                    int rowNum = cargaBase.HojaBd.FilaIni - 1;
                    int cont = 0;
                    var row = excel.Sheet.GetRow(rowNum);

                    while (!cargaBase.EsFilaVacia(excel, row))
                    {
                        bool isValid = cargaBase.ValidarDatos(excel, row);
                        bool isValidAsis = true;
                        isValid = isValid && cargaBase.ValidarCodigoEmpleado("Promotor", "Promotor", rowNum);
                        isValidAsis = isValidAsis && cargaBase.ValidarCodigoEmpleado("Asistente", "Asistente", rowNum);

                        if (!isValid || !isValidAsis)
                        {
                            rowNum++;
                            row = excel.Sheet.GetRow(rowNum);
                            continue;
                        }

                        cont++;
                        DataRow dr = cargaBase.AsignarDatos(dt);
                        dr["Secuencia"] = cont;
                        dt.Rows.Add(dr);

                        rowNum++;
                        row = excel.Sheet.GetRow(rowNum);
                    }

                    cargaBase.RegistrarCarga(dt, "DataAutomotriz");
                }
            }
            catch (Exception ex)
            {
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                UtilsLocal.AsignarEstadoError(messageError);
                Logger.Error(messageError);
            }
            
            UtilsLocal.AsignarEstadoFinCarga(tipoArchivo);
        }

        #endregion 
    }
}