using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Enums;
using Falabella.Entity;
using log4net;

namespace Falabella.Consola
{
    public class CargaEstudioRangoTramo1
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region M�todos P�blicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inici� la carga del archivo EstudioRangoTramo1");
            Console.WriteLine("Se inici� la carga del archivo EstudioRangoTramo1");

            string ruta = ConfigurationManager.AppSettings["RutaEstudioRangoTramo1"];
            string[] campos = null;
            int cabeceraId = 0;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "*EstudioRangoTramo1.csv");
                const char separador = ',';

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(6, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(4, 2));
                    int a�o = Convert.ToInt32(onlyName.Substring(0, 4));
                    DateTime fechaFile = new DateTime(a�o, mes, dia);

                    var cabecera = CabeceraCargaBL.GetInstance()
                        .GetCabeceraCargaProcesado(TipoArchivo.EstudioRangoTramo1.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.EstudioRangoTramo1, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se est� procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se est� procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-1"));
                    DataTable dt = Utils.CrearCabeceraDataTable<EstudioRangoTramo1>();

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

                        dt.Rows.Add(dr);
                    }

                    file.Close();
                    fileError = false;
                    CabeceraCargaBL.GetInstance().Add(dt, "EstudioRangoTramo1");

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

            Logger.Info("Se termin� la carga del archivo EstudioRangoTramo1");
            Console.WriteLine("Se termin� la carga del archivo EstudioRangoTramo1");
        }

        #endregion

        #region M�todos Privados

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["Fecha"] = Utils.GetDateFormat5(campos[0]);
            dr["Rango"] = Utils.GetValueColumn(campos[1]);
            dr["Meta"] = Utils.GetPorcentaje(campos[2]);
            dr["Dia"] = Utils.GetValueColumn(campos[3]);

            return dr;
        }

        #endregion
    }
}