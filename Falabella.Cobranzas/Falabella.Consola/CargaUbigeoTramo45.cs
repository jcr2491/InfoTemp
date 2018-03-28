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
using Enums = Falabella.CrossCutting.Enums;
using Falabella.Entity;
using log4net;

namespace Falabella.Consola
{
    public class CargaUbigeoTramo45
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private static List<Zona> _zonas = new List<Zona>();
        private static List<TipoZona> _tipoZonas = new List<TipoZona>();
        private static readonly List<int> ZonasNuevasId = new List<int>();
        private static readonly List<int> TipoZonasNuevasId = new List<int>();

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo UbigeoTramo4-5");
            Console.WriteLine("Se inició la carga del archivo UbigeoTramo4-5");

            string ruta = ConfigurationManager.AppSettings["RutaUbigeoTramo45"];
            string[] campos = null;
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "*UbigeoTramo4_5.csv");
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
                        .GetCabeceraCargaProcesado(Enums.TipoArchivo.UbigeoTramo45.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(Enums.TipoArchivo.UbigeoTramo45, Enums.EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-1"));
                    DataTable dt = Utils.CrearCabeceraDataTable<UbigeoTramo45>();

                    //Leemos la cabecera del archivo
                    file.ReadLine();
                    string line;
                    cont = 0;

                    while ((line = file.ReadLine()) != null)
                    {
                        cont++;
                        campos = line.Split(separador);
                        DataRow dr = GetDataRow(dt, campos);
                        dr["CabeceraCargaId"] = cabeceraId;
                        dr["Secuencia"] = cont;
                        dr["Fecha"] = fechaFile;

                        dt.Rows.Add(dr);
                    }

                    file.Close();
                    fileError = false;

                    InsertarDatosZona();
                    InsertarDatosTipoZona();
                    CabeceraCargaBL.GetInstance().Add(dt, "UbigeoTramo45");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    UtilsLocal.ActualizarCabecera(cabeceraId, Enums.EstadoCarga.Procesado);
                }
            }
            catch (Exception ex)
            {
                UtilsLocal.ActualizarCabecera(cabeceraId, Enums.EstadoCarga.Fallido);

                //Se incrementa en 1 debido a que la lectura empieza en la segunda linea
                cont++;
                string messageError = UtilsLocal.GetMessageError(fileError, campos, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo UbigeoTramo4-5");
            Console.WriteLine("Se terminó la carga del archivo UbigeoTramo4-5");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["Ubigeo"] = Utils.GetValueColumn(campos[0]);
            dr["EsCore"] = campos[3].Trim().ToUpper() == "CORE";
            dr["Tramo"] = Utils.GetValueColumn(campos[4]);

            string descripcion = campos[1].Trim();
            var zona = _zonas.FirstOrDefault(p => p.Descripcion == descripcion);
            int zonaId;

            if (zona != null)
            {
                zonaId = zona.Id;
            }
            else
            {
                int id = _zonas.Any() ? _zonas.Max(p => p.Id) + 1 : 1;
                _zonas.Add(new Zona {Descripcion = descripcion, Id = id});
                ZonasNuevasId.Add(id);

                zonaId = id;
            }

            descripcion = CompletarDescripcionTipoZona(campos[2].Trim());
            var tipozona = _tipoZonas.FirstOrDefault(p => p.Descripcion == descripcion);
            if (tipozona != null)
            {
                dr["TipoZonaId"] = tipozona.Id;
            }
            else
            {
                int id = _tipoZonas.Any() ? _tipoZonas.Max(p => p.Id) + 1 : 1;
                _tipoZonas.Add(new TipoZona
                {
                    Descripcion = descripcion,
                    ZonaId = zonaId,
                    Id = id
                });
                TipoZonasNuevasId.Add(id);

                dr["TipoZonaId"] = id;
            }

            return dr;
        }

        private static void CargarDatos()
        {
            _zonas = UbigeoTramo45BL.GetInstance().GetZonas();
            _tipoZonas = UbigeoTramo45BL.GetInstance().GetTipoZonas();
        }

        private static void InsertarDatosZona()
        {
            if (!ZonasNuevasId.Any()) return;

            DataTable dt = Utils.CrearCabeceraDataTable<Zona>();

            foreach (var id in ZonasNuevasId)
            {
                var zona = _zonas.First(p => p.Id == id);
                DataRow dr = dt.NewRow();
                dr["Id"] = zona.Id;
                dr["Descripcion"] = zona.Descripcion;

                dt.Rows.Add(dr);
            }

            CabeceraCargaBL.GetInstance().Add(dt, "Zona");
        }

        private static void InsertarDatosTipoZona()
        {
            if (!TipoZonasNuevasId.Any()) return;

            DataTable dt = Utils.CrearCabeceraDataTable<TipoZona>();

            foreach (var id in TipoZonasNuevasId)
            {
                var tipozona = _tipoZonas.First(p => p.Id == id);
                DataRow dr = dt.NewRow();
                dr["Id"] = tipozona.Id;
                dr["Descripcion"] = tipozona.Descripcion;
                dr["ZonaId"] = tipozona.ZonaId;

                dt.Rows.Add(dr);
            }

            CabeceraCargaBL.GetInstance().Add(dt, "TipoZona");
        }

        private static string CompletarDescripcionTipoZona(string descripcion)
        {
            switch (descripcion.ToUpper())
            {
                case "N":
                    descripcion = "NORTE";
                    break;
                case "S":
                    descripcion = "SUR";
                    break;
                case "C":
                    descripcion = "CENTRO";
                    break;
            }

            return descripcion;
        }

        #endregion
    }
}