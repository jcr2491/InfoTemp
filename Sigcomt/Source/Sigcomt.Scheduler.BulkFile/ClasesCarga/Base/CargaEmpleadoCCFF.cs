using log4net;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.Scheduler.BulkFile.Core;
using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Base
{
    public class CargaEmpleadoCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static bool CargarArchivo()
        {
            bool result = true;

            Logger.Info("Se inició la carga del archivo EmpleadoCCFF");
            Console.WriteLine("Se inició la carga del archivo EmpleadoCCFF");

            string tipoArchivo = TipoArchivo.EmpleadoCCFF.GetStringValue();
            var cargaBase = new CargaBase(tipoArchivo, "EmpleadoCCFF");
            const char separador = '|';

            try
            {
                cargaBase.ValidarExisteDirectorio();
                var filesNames = cargaBase.GetNombreArchivos();

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(0, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(2, 2));
                    int año = Convert.ToInt32(onlyName.Substring(4, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

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

                    cargaBase.AgregarCabeceraCarga(new CabeceraCarga
                    {
                        TipoArchivo = tipoArchivo,
                        FechaCargaIni = DateTime.Now,
                        FechaArchivo = fechaFile,
                        FechaModificacionArchivo = fechaModificacion,
                        EstadoCarga = EstadoCarga.Iniciado.GetNumberValue()
                    });

                    Console.WriteLine("Se está procesando el archivo: " + fileName + " Hoja: " +
                                      cargaBase.HojaBd.NombreHoja);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName + " Hoja: " +
                                      cargaBase.HojaBd.NombreHoja);

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

                    cargaBase.RegistrarCarga(dt, "EmpleadoCCFF");

                    if (UtilsLocal.LogCargaList.Any(p => p.TipoLog != "4"))
                    {
                        result = false;
                    }
                }
            }
            catch (Exception ex)
            {
                result = false;
                cargaBase.AgregarErrorGeneral(ex);
                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo EmpleadoCCFF");
            Console.WriteLine("Se terminó la carga del archivo EmpleadoCCFF");

            return result;
        }

        #endregion
    }
}