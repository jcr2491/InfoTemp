using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using Sigcomt.Business.Entity;
using Sigcomt.Common;
using log4net;
using System.Reflection;
using Sigcomt.Business.Logic;
using Sigcomt.Common.Enums;

namespace Sigcomt.WinForms.BulkCopy.Core
{
    public class EnvioEmail
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Metodos Publicos

        public static bool EnvioCorreo(List<DetalleLogCarga> errorList, List<Archivo> archivoCarga)
        {
            bool success = true;
            string rutaArchivoIn = ConfigurationManager.AppSettings["RutaArchivoIn"];
            string rutaArchivoOut = ConfigurationManager.AppSettings["RutaArchivoOut"];
            string nombreArchivo = ConfigurationManager.AppSettings["NombreArchivo"];
            string rutaCopy = ConfigurationManager.AppSettings["RutaArchivoCopy"];

            int archivosCorrecto = archivoCarga.Count(p => p.Estado == 1);
            int archivosIncorrecto = archivoCarga.Count(p => p.Estado != 1);
            string pathApp = AppDomain.CurrentDomain.BaseDirectory;

            var fileBase = new FileStream(pathApp + rutaArchivoIn + nombreArchivo, FileMode.Open, FileAccess.Read);

            var excel = new GenericExcel(fileBase, 0);
            if (errorList.Count > 0)
            {
                var response = GenerarCuerpoReporte(excel, errorList);
                string fecha = errorList.Max(p => p.FechaLog).ToShortDateString().Replace("/", "-");
                string hora = errorList.Max(p => p.FechaLog).ToShortTimeString().Replace(":", " ").Replace(".", "");
                if (response)
                {
                    using (var file = new FileStream(pathApp + rutaArchivoOut + nombreArchivo, FileMode.Create, FileAccess.Write))
                    {
                        excel.WorkBook.Write(file);
                    }
                    excel.WorkBook.Close();
                    File.Copy( pathApp + rutaArchivoOut + nombreArchivo, $"{rutaCopy}{fecha + "_" + hora + ".xlsx"}", true);
                }

                if (errorList.Count > 0)
                {
                    bool estadoEnvio = EnviarCorreoTemplate(new DataEmail
                    {
                        HoraEjecucion = Convert.ToDateTime(DateTime.Now).ToShortTimeString(),
                        ArchivosCorrecto = archivosCorrecto,
                        ArchivosIncorrecto = archivosIncorrecto,
                        Ruta = $"{rutaCopy}{fecha + "_" + hora + ".xlsx"}",
                        ArchivosEstado = archivoCarga
                    });

                    if (!estadoEnvio)
                    {
                        UtilsLocal.AsignarEstadoError(Constantes.ErrorEnviarCorreo);
                        success = false;
                    }
                }
            }
            return success;
        }

        #endregion

        #region Metodo Privado

        private static bool EnviarCorreoTemplate(DataEmail data)
        {
            try
            {
                string pathApp = AppDomain.CurrentDomain.BaseDirectory;
                string htmlTemplatePrograma = pathApp + "Template/Plantilla-Email.html";
                Email.FromDefault()
                    .UsingClient(GetClient())
                    .To(ConfigurationManager.AppSettings["Correo"])
                    .CarbonCopy(ConfigurationManager.AppSettings["CorreoCC"])
                    .Subject(ConfigurationManager.AppSettings["Subject"])
                    .UsingTemplateFromFile(htmlTemplatePrograma, data)
                    .Send();

                UtilsLocal.AsignarEstadoCorrecto(Constantes.CorreoEnviadoSatisfactoriamente);

                return true;
            }
            catch (Exception exception)
            {
                UtilsLocal.AsignarEstadoError(exception.Message);
                Logger.Info(exception);
            }
            return false;
        }

        /// <summary>
        /// Se obtiene la configuracion del correo de la base de datos y se crea un objeto SmtpClient.
        /// </summary>
        /// <returns></returns>
        private static SmtpClient GetClient()
        {
            var conf = ConfiguracionBL.GetInstance().GetConfiguracion(TipoConfiguracion.Email.GetStringValue());

            var client = new SmtpClient
            {
                Host = conf.Host,
                Port = conf.Puerto,
                Credentials = new NetworkCredential(conf.Usuario, Encriptador.Desencriptar(conf.Clave))
            };

            return client;
        }

        private static bool GenerarCuerpoReporte(GenericExcel excel, List<DetalleLogCarga> listLog)
        {
            bool success = true;
            int numRow = 1;
            if (listLog.Count > 0)
            {
                foreach (var error in listLog)
                {
                    var row = excel.Sheet.CreateRow(numRow);
                    row.CreateCell(0).SetCellValue(error.NombreResponsable);
                    row.CreateCell(1).SetCellValue(error.TipoComision);
                    row.CreateCell(2).SetCellValue(error.TipoArchivo);
                    row.CreateCell(3).SetCellValue(TipoLogCarga(error.TipoLog));
                    row.CreateCell(4).SetCellValue(error.NombreArchivo);
                    row.CreateCell(5).SetCellValue(error.NombreHoja);
                    row.CreateCell(6).SetCellValue(error.NombreCampo);
                    row.CreateCell(7).SetCellValue(error.PosicionColumna);
                    row.CreateCell(8).SetCellValue(error.NumFila);
                    row.CreateCell(9).SetCellValue(error.DetalleLog);
                    numRow++;
                }

            }
            else { success = false; }

            return success;
        }

        private static string TipoLogCarga(string tipo)
        {
            string respuesta;
            switch (tipo)
            {
                case "1":
                    respuesta = "Validacion de Datos";
                    break;
                case "2":
                    respuesta = "Carga de datos";
                    break;
                case "3":
                    respuesta = "Archivo ya cargado";
                    break;
                case "4":
                    respuesta = "Archivo Cargado correctamente";
                    break;
                case "5":
                    respuesta = "No existe archivo";
                    break;
                case "6":
                    respuesta = "Nombre Archivo Invalido";
                    break;
                case "8":
                    respuesta = "Hoja del excel no existe";
                    break;
                case "9":
                    respuesta = "No existe directorio del archivo";
                    break;
                case "10":
                    respuesta = "Reporte generado correctamente";
                    break;
                case "11":
                    respuesta = "Error al generar reporte";
                    break;
                default:
                    respuesta = "Error en general";
                    break;
            }
            return respuesta;
        }

        #endregion
    }
}