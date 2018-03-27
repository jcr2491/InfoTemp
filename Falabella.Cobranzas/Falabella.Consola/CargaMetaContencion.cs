using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Enums;
using Falabella.Entity;
using log4net;

namespace Falabella.Consola
{
    public class CargaMetaContencion
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo MetaContencion");
            Console.WriteLine("Se inició la carga del archivo MetaContencion");

            string ruta = ConfigurationManager.AppSettings["RutaMetaContencion"];
            string[] campos = null;
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "*MetaContencion.csv");
                const char separador = ',';

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(6, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(4, 2));
                    int año = Convert.ToInt32(onlyName.Substring(0, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance()
                        .GetCabeceraCargaProcesado(TipoArchivo.MetaContencion.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.MetaContencion, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.UTF8);
                    DataTable dt = Utils.CrearCabeceraDataTable<MetaContencion>();

                    //Leemos la cabecera del archivo
                    string line = file.ReadLine();
                    var columnas = line.Split(separador);
                    cont = 0;
                    int cont2 = 0;

                    while ((line = file.ReadLine()) != null)
                    {
                        cont++;
                        campos = line.Split(separador);

                        if (campos.All(string.IsNullOrEmpty)) continue;

                        for (int i = 1; i < columnas.Length; i++)
                        {
                            cont2++;
                            DataRow dr = GetDataRow(dt, campos);
                            dr["CabeceraCargaId"] = cabeceraId;
                            dr["Secuencia"] = cont2;
                            dr["Fecha"] = fechaFile;
                            dr["Tramo"] = Regex.Replace(columnas[i], @"[^\d]", "");
                            dr["Meta"] = Utils.GetPorcentaje(campos[i]);

                            dt.Rows.Add(dr);
                        }
                    }

                    file.Close();
                    fileError = false;
                    CabeceraCargaBL.GetInstance().Add(dt, "MetaContencion");

                    //Se actualiza a procesado la tabla CabeceraCarga
                    UtilsLocal.ActualizarCabecera(cabeceraId, EstadoCarga.Procesado);
                }
            }
            catch (Exception ex)
            {
                UtilsLocal.ActualizarCabecera(cabeceraId, EstadoCarga.Fallido);

                //Se incrementa en 1 debido a que la lectura empieza en la segunda linea
                cont++;
                string messageError = UtilsLocal.GetMessageError(fileError, campos, cont, ex.Message);
                Console.WriteLine(messageError);
                Logger.Error(messageError);
            }

            Logger.Info("Se terminó la carga del archivo MetaContencion");
            Console.WriteLine("Se terminó la carga del archivo MetaContencion");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["Dia"] = Utils.GetValueColumn(campos[0]);

            return dr;
        }

        #endregion
    }
}