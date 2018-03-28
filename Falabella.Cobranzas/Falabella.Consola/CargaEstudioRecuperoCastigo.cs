using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.Entity;
using log4net;

namespace Falabella.Consola
{
    public class CargaEstudioRecuperoCastigo
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static List<RegionEstudio> _regionEstudios = new List<RegionEstudio>();
        private static List<TipoEstudio> _tipoEstudios = new List<TipoEstudio>();
        private static readonly List<int> RegionEstudioIds = new List<int>();
        private static readonly List<int> TipoEstudioIds = new List<int>();

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo EstudioRecuperoCastigo");
            Console.WriteLine("Se inició la carga del archivo EstudioRecuperoCastigo");

            string ruta = ConfigurationManager.AppSettings["RutaEstudioRecuperoCastigo"];
            string[] campos = null;
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "*EstudioRecuperoCastigo.csv");
                const char separador = ',';

                CargarDatos();

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(6, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(4, 2));
                    int año = Convert.ToInt32(onlyName.Substring(0, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance()
                        .GetCabeceraCargaProcesado(CrossCutting.Enums.TipoArchivo.EstudioRecuperoCastigo.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(CrossCutting.Enums.TipoArchivo.EstudioRecuperoCastigo,
                        CrossCutting.Enums.EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.UTF8);
                    DataTable dt = Utils.CrearCabeceraDataTable<EstudioRecuperoCastigo>();

                    //Leemos la cabecera del archivo
                    file.ReadLine();
                    string line;
                    cont = 0;

                    while ((line = file.ReadLine()) != null)
                    {
                        cont++;
                        campos = line.Split(separador);

                        if (campos.All(string.IsNullOrEmpty)) continue;
                        DataRow dr = GetDataRow(dt, campos);
                        dr["CabeceraCargaId"] = cabeceraId;
                        dr["Secuencia"] = cont;
                        dr["Fecha"] = fechaFile;

                        dt.Rows.Add(dr);
                    }

                    file.Close();
                    fileError = false;

                    InsertarRegionEstudio();
                    InsertarTipoEstudio();
                    CabeceraCargaBL.GetInstance().Add(dt, "EstudioRecuperoCastigo");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    UtilsLocal.ActualizarCabecera(cabeceraId, CrossCutting.Enums.EstadoCarga.Procesado);
                }
            }
            catch (Exception ex)
            {
                UtilsLocal.ActualizarCabecera(cabeceraId, CrossCutting.Enums.EstadoCarga.Fallido);

                //Se incrementa en 1 debido a que la lectura empieza en la segunda linea
                cont++;
                string messageError = UtilsLocal.GetMessageError(fileError, campos, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo EstudioRecuperoCastigo");
            Console.WriteLine("Se terminó la carga del archivo EstudioRecuperoCastigo");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["Codigo"] = Utils.GetValueColumn(campos[0]);
            dr["Nombre"] = Utils.GetValueColumn(campos[1]);
            dr["CodigoAuxiliar"] = Utils.GetValueColumn(campos[3]);

            string nombre = campos[4].Trim();
            var region = _regionEstudios.FirstOrDefault(p => p.Nombre.Equals(nombre, StringComparison.CurrentCultureIgnoreCase));

            if (region != null)
            {
                dr["RegionId"] = region.Id;
            }
            else
            {
                int id = _regionEstudios.Any() ? _regionEstudios.Max(p => p.Id) + 1 : 1;
                _regionEstudios.Add(new RegionEstudio {Nombre = nombre, Id = id});
                RegionEstudioIds.Add(id);

                dr["RegionId"] = id;
            }

            nombre = campos[2].Trim();
            var tipoEstudio = _tipoEstudios.FirstOrDefault(p => p.Nombre.Equals(nombre, StringComparison.CurrentCultureIgnoreCase));

            if (tipoEstudio != null)
            {
                dr["TipoEstudioId"] = tipoEstudio.Id;
            }
            else
            {
                int id = _tipoEstudios.Any() ? _tipoEstudios.Max(p => p.Id) + 1 : 1;
                _tipoEstudios.Add(new TipoEstudio {Nombre = nombre, Id = id});
                TipoEstudioIds.Add(id);

                dr["TipoEstudioId"] = id;
            }

            return dr;
        }

        private static void CargarDatos()
        {
            _regionEstudios = EstudioBL.GetInstance().GetRegionEstudios();
            _tipoEstudios = EstudioBL.GetInstance().GetTipoEstudios();
        }

        private static void InsertarRegionEstudio()
        {
            if (!RegionEstudioIds.Any()) return;

            DataTable dt = Utils.CrearCabeceraDataTable<RegionEstudio>();

            foreach (var id in RegionEstudioIds)
            {
                var region = _regionEstudios.First(p => p.Id == id);
                DataRow dr = dt.NewRow();
                dr["Id"] = region.Id;
                dr["Nombre"] = region.Nombre;

                dt.Rows.Add(dr);
            }

            CabeceraCargaBL.GetInstance().Add(dt, "RegionEstudio");
        }

        private static void InsertarTipoEstudio()
        {
            if (!TipoEstudioIds.Any()) return;

            DataTable dt = Utils.CrearCabeceraDataTable<TipoEstudio>();

            foreach (var id in TipoEstudioIds)
            {
                var tipozona = _tipoEstudios.First(p => p.Id == id);
                DataRow dr = dt.NewRow();
                dr["Id"] = tipozona.Id;
                dr["Nombre"] = tipozona.Nombre;

                dt.Rows.Add(dr);
            }

            CabeceraCargaBL.GetInstance().Add(dt, "TipoEstudio");
        }

        #endregion
    }
}