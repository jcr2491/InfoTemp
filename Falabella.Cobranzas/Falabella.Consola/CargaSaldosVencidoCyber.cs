using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Reflection;
using System.Text;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Enums;
using Falabella.Entity;
using log4net;

namespace Falabella.Consola
{
    public class CargaSaldosVencidoCyber
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo SaldosVencidoCyber");
            Console.WriteLine("Se inició la carga del archivo SaldosVencidoCyber");

            string ruta = ConfigurationManager.AppSettings["RutaSaldosVencidoCyber"];
            int cabeceraId = 0;
            string[] campos = null;
            int cont = 0;
            bool fileError = true;

            try
            {
                var filesNames = Directory.GetFiles(ruta, "*SaldosVencidosCyber_.txt");
                const char separador = '|';

                foreach (var fileName in filesNames)
                {
                    var split = fileName.Split('\\');
                    string onlyName = split[split.Length - 1];

                    int dia = Convert.ToInt32(onlyName.Substring(6, 2));
                    int mes = Convert.ToInt32(onlyName.Substring(4, 2));
                    int año = Convert.ToInt32(onlyName.Substring(0, 4));
                    DateTime fechaFile = new DateTime(año, mes, dia);

                    var cabecera =
                        CabeceraCargaBL.GetInstance()
                            .GetCabeceraCargaProcesado(TipoArchivo.SaldosVencidoCyber.GetStringValue(), fechaFile);
                    if (cabecera != null) continue;

                    cabeceraId = UtilsLocal.AgregarCabecera(TipoArchivo.SaldosVencidoCyber, EstadoCarga.Iniciado, fechaFile);

                    Console.WriteLine("Se está procesando el archivo: " + fileName);
                    Logger.InfoFormat("Se está procesando el archivo: " + fileName);

                    StreamReader file = new StreamReader(fileName, Encoding.GetEncoding("iso-8859-1"));
                    DataTable dt = Utils.CrearCabeceraDataTable<SaldosVencidoCyber>();

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
                        dr["Informacional"] = fechaFile;

                        dt.Rows.Add(dr);
                    }

                    file.Close();
                    fileError = false;
                    CabeceraCargaBL.GetInstance().Add(dt, "SaldosVencidoCyber");

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

            Logger.Info("Se terminó la carga del archivo SaldosVencidoCyber");
            Console.WriteLine("Se terminó la carga del archivo SaldosVencidoCyber");
        }

        #endregion

        #region Métodos Privados

        private static DataRow GetDataRow(DataTable dt, string[] campos)
        {
            DataRow dr = dt.NewRow();
            dr["NroCuenta"] = Utils.GetValueTrimStart(campos[1], '0');
            dr["SituacionCuenta"] = Utils.GetValueColumn(campos[2]);
            dr["DiaVencimiento"] = Utils.GetValueColumn(campos[3]);
            dr["MontoMora"] = Utils.GetValueColumn(campos[4]);
            dr["SaldoDeuda"] = Utils.GetValueColumn(campos[5]);
            dr["Capital"] = Utils.GetValueColumn(campos[6]);
            dr["MontoAcelerado"] = Utils.GetValueColumn(campos[7]);
            dr["FechaAceleracion"] = Utils.GetDateFormat1(campos[8]);
            dr["DiasMora"] = Utils.GetValueColumn(campos[9]);
            dr["EtapaMora"] = Utils.GetValueColumn(campos[10]);
            dr["InicioMora"] = Utils.GetDateFormat1(campos[11]);
            dr["HabitoPago"] = Utils.GetValueColumn(campos[12]);
            dr["ColaActual"] = Utils.GetValueColumn(campos[13]);
            dr["Agencia"] = Utils.GetValueColumn(campos[14]);
            dr["FechaAsignacion"] = Utils.GetDateFormat1(campos[15]);
            dr["Behavior"] = Utils.GetValueColumn(campos[16]);
            dr["Bar"] = Utils.GetValueColumn(campos[17]);
            dr["CodSubProducto"] = Utils.GetValueColumn(campos[18]);
            dr["Ubigeo"] = Utils.GetValueTrimStart(campos[19], '0');
            dr["Pan"] = Utils.GetValueColumn(campos[20]);
            dr["Celular"] = Utils.GetValueColumn(campos[21]);
            dr["FonoCasa"] = Utils.GetValueColumn(campos[22]);
            dr["TipoDoc"] = Utils.GetValueColumn(campos[23]);
            dr["NroDoc"] = Utils.GetValueColumn(campos[24]);
            dr["CondicionCliente"] = Utils.GetValueColumn(campos[25]);
            dr["Empleado"] = "SI".Equals(campos[26], StringComparison.InvariantCultureIgnoreCase);
            dr["FechaProxContacto"] = Utils.GetDateFormat1(campos[27]);
            dr["UltimaFechaPago"] = Utils.GetDateFormat2(campos[28]);
            dr["UltimoMontoPagado"] = campos[29];
            dr["Venc1"] = Utils.GetDateFormat2(campos[30]);
            dr["Venc2"] = Utils.GetDateFormat2(campos[31]);
            dr["Venc3"] = Utils.GetDateFormat2(campos[32]);
            dr["Venc4"] = Utils.GetDateFormat2(campos[33]);
            dr["Cuota1"] = Utils.GetValueColumn(campos[34]);
            dr["Cuota2"] = Utils.GetValueColumn(campos[35]);
            dr["Cuota3"] = Utils.GetValueColumn(campos[36]);
            dr["Cuota4"] = Utils.GetValueColumn(campos[37]);
            dr["SaldoSuperCash"] = Utils.GetValueColumn(campos[38]);
            dr["Cola3"] = Utils.GetValueColumn(campos[39]);
            dr["FechaRefinanciacion"] = Utils.GetDateFormat2(campos[40]);
            dr["Cedente"] = Utils.GetValueColumn(campos[41]);

            return dr;
        }

        #endregion
    }
}