using Sigcomt.Business.Entity;
using Sigcomt.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;

namespace Sigcomt.Scheduler.BulkFile.Core
{
    public class EnvioEmail
    {

        #region Metodos Publicos
        public static bool EnvioCorreo(List<DetalleLogCarga> errorList, List<Archivo> archivoCarga)
        {
            bool success = true;
            string rutaArchivoIn = ConfigurationManager.AppSettings["RutaArchivoIn"];
            string rutaArchivoOut = ConfigurationManager.AppSettings["RutaArchivoOut"];
            string nombreArchivo = ConfigurationManager.AppSettings["NombreArchivo"];
            string rutaCopy = ConfigurationManager.AppSettings["RutaArchivoCopy"];

            int archivosCorrecto = archivoCarga.Where(p => p.Estado == 1).Count();
            int archivosIncorrecto = archivoCarga.Where(p => p.Estado != 1).Count();
            string pathApp = AppDomain.CurrentDomain.BaseDirectory;

            var data = "";
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
                    File.Copy( pathApp + rutaArchivoOut + nombreArchivo, string.Format("{0}{1}", rutaCopy, fecha + "_" + hora + ".xlsx"), true);
                }

                if (errorList.Count > 0)
                {
                    bool estadoEnvio = SendWithTemplateModel(new DataEmail
                    {
                        HoraEjecucion = Convert.ToDateTime(DateTime.Now).ToShortTimeString(),
                        ArchivosCorrecto = archivosCorrecto,
                        ArchivosIncorrecto = archivosIncorrecto,
                        Ruta = string.Format("{0}{1}", rutaCopy, fecha + "_" + hora + ".xlsx"),
                        ArchivosEstado = archivoCarga
                    });

                    if (!estadoEnvio)
                    {
                        Console.WriteLine("Error al enviar correo");
                        success = false;
                    }
                }
            }
            else
            {
                Console.WriteLine("No hay archivos para procesa");
            }
            return success;
        }
        static bool SendWithTemplateModel(DataEmail Data)
        {
            try
            {
                string htmlTemplatePrograma = "Template/Plantilla-Email.html";
                Email.FromDefault()
                    .To(ConfigurationManager.AppSettings["Correo"])
                    .CarbonCopy(ConfigurationManager.AppSettings["CorreoCC"])
                    .Subject(ConfigurationManager.AppSettings["Subject"])
                    //.UseSsl()
                    .UsingTemplateFromFile(htmlTemplatePrograma, Data)
                    .Send();
                Console.WriteLine("Se envió el correo satisfactoriamente");
                return true;
            }
            catch (Exception exception)
            {
                Console.WriteLine("Ocurrió un error " + exception.Message);
            }
            return false;
        }
        public static bool GenerarCuerpoReporte(GenericExcel excel, List<DetalleLogCarga> listLog)
        {
            bool success = true;
            int numRow = 1;
            if (listLog.Count > 0)
            {
                foreach (var error in listLog)
                {
                    success = true;
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
        #endregion

        #region Metodo Privado
        private static string TipoLogCarga(string tipo)
        {
            string respuesta = "";
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
                default:
                    respuesta = "Error en general";
                    break;
            }
            return respuesta;
        }
        #endregion
    }
}
