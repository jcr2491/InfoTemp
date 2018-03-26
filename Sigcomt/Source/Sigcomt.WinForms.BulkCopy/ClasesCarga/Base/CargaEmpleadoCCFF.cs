using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using log4net;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.WinForms.BulkCopy.Core;

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.Base
{
    public class CargaEmpleadoCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static bool CargarArchivo()
        {
            bool result = true;
            string tipoArchivo = TipoArchivo.EmpleadoCCFF.GetStringValue();
            if (!UtilsLocal.PermitirCargaArchivo(tipoArchivo)) return false;

            UtilsLocal.AsignarEstadoInicioCarga(tipoArchivo);

            var cargaBase = new CargaBase(tipoArchivo, "Empleado");
            const char separador = '|';

            try
            {
                cargaBase.ValidarExisteDirectorio();

                var filesNames = cargaBase.GetNombreArchivos();

                if (filesNames.Any())
                {
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

                        int cabeceraId = cargaBase.AgregarCabeceraCarga(new CabeceraCarga
                        {
                            TipoArchivo = tipoArchivo,
                            FechaCargaIni = DateTime.Now,
                            FechaArchivo = fechaFile,
                            FechaModificacionArchivo = fechaModificacion,
                            EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                        });

                        UtilsLocal.AsignarEstado(string.Format(Constantes.ProcesandoArchivo, fileName, cargaBase.HojaBd.NombreHoja));
                        

                        StreamReader file = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-1"));
                        DataTable dt = cargaBase.CrearCabeceraDataTable();

                        //Leemos la cabecera del archivo
                        file.ReadLine();

                        string line;
                        int cont = 0;

                        while ((line = file.ReadLine()) != null)
                        {
                            cont++;
                            var campos = line.Split(separador);

                            bool isValid = cargaBase.ValidarDatos(campos, cont);

                            if (isValid)
                            {
                                DataRow dr = cargaBase.AsignarDatos(dt);
                                dr["Secuencia"] = cont;

                                dt.Rows.Add(dr);
                            }
                        }

                        file.Close();

                        cargaBase.RegistrarCarga(dt, "Empleado");

                        if (UtilsLocal.LogCargaList.Any(p => p.TipoLog != "4" && p.CargaId == cabeceraId))
                        {
                            result = false;
                        }
                    }
                }
                else
                {
                    result = false;
                }
            }
            catch (Exception ex)
            {                
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                UtilsLocal.AsignarEstadoError(messageError);
                Logger.Error(messageError);
                result = false;
            }

            
            UtilsLocal.AsignarEstadoFinCarga(tipoArchivo);

            return result;
        }

        #endregion
    }
}