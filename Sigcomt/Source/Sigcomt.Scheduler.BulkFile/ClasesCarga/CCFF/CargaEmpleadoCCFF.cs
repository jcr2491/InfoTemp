using System;
using System.Collections.Generic;
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
using Sigcomt.Scheduler.BulkFile.Core;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.CCFF
{
    public class CargaEmpleadoCCFF
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static Dictionary<string, int> _indexCol;

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo EmpleadoCCFF");
            Console.WriteLine("Se inició la carga del archivo EmpleadoCCFF");
            var cargaBase = new CargaBase<EmpleadoCCFF>();
            string tipoArchivo = TipoArchivo.EmpleadoCCFF.GetStringValue();
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;
            const char separador = '|';

            try
            {
                 cargaBase = new CargaBase<EmpleadoCCFF>(tipoArchivo);

                var filesNames = Directory.GetFiles(cargaBase.ExcelBd.Ruta, $"*{cargaBase.ExcelBd.Nombre}");
                //Se cargan las posiciones de las columnas del archivo
 

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

                    StreamReader file = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-1"));
                    DataTable dt = Utils.CrearCabeceraDataTable<EmpleadoCCFF>();

                    //Leemos la cabecera del archivo
                    file.ReadLine();

                    string line;
                    cont = 0;

                    while ((line = file.ReadLine()) != null)
                    {
                        cont++;
                        var campos = line.Split(separador);
                        DataRow dr = GetDataRow(dt, campos);
                        dr["CargaId"] = cabeceraId;
                        dr["Secuencia"] = cont;

                        dt.Rows.Add(dr);
                    }

                    file.Close();

                    fileError = false;
                    CargaArchivoBL.GetInstance().Add(dt, "EmpleadoCCFF");

                    
                    

                }
            }
            catch (Exception ex)
            {
                

                string messageError = UtilsLocal.GetMessageError(ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo EmpleadoCCFF");
            Console.WriteLine("Se terminó la carga del archivo EmpleadoCCFF");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["CodigoEmpleado"] = Utils.GetStringColumn(campos[_indexCol["CodigoEmpleado"]]);
            dr["PrimerNombre"] = Utils.GetStringColumn(campos[_indexCol["PrimerNombre"]]);
            dr["SegundoNombre"] = Utils.GetStringColumn(campos[_indexCol["SegundoNombre"]]);
            dr["ApellidoPaterno"] = Utils.GetStringColumn(campos[_indexCol["ApellidoPaterno"]]);
            dr["ApellidoMaterno"] = Utils.GetStringColumn(campos[_indexCol["ApellidoMaterno"]]);
            dr["CargoId"] = Utils.GetStringColumn(campos[_indexCol["CargoId"]]);
            dr["Cargo"] = Utils.GetStringColumn(campos[_indexCol["Cargo"]]);
            dr["SucursalId"] = Utils.GetStringColumn(campos[_indexCol["SucursalId"]]);
            dr["Sucursal"] = Utils.GetStringColumn(campos[_indexCol["Sucursal"]]);
            dr["ZonaId"] = Utils.GetStringColumn(campos[_indexCol["ZonaId"]]);
            dr["Zona"] = Utils.GetStringColumn(campos[_indexCol["Zona"]]);
            dr["FechaIngreso"] = Utils.GetStringColumn(campos[_indexCol["FechaIngreso"]]);
            dr["FechaCese"] = Utils.GetStringColumn(campos[_indexCol["FechaCese"]]);
            dr["Estado"] = Utils.GetStringColumn(campos[_indexCol["Estado"]]);
            dr["SubEstadoId"] = Utils.GetStringColumn(campos[_indexCol["SubEstadoId"]]);
            dr["SubEstado"] = Utils.GetStringColumn(campos[_indexCol["SubEstado"]]);

            return dr;
        }

        #endregion
    }
}