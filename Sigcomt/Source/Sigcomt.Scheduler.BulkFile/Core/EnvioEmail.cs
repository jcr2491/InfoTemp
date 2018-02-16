using Sigcomt.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Web;
using System.Web.Hosting;

namespace Sigcomt.Scheduler.BulkFile.Core
{
    public class EnvioEmail
    {
        public static bool EnvioCorreo() //PARAMETRO :lista de errores y lista correctas
        {
            bool success = true;
            var listError = new List<ResponseError>();
            var listCorrecto = new List<ResponseCorrecto>();
            ResponseError Entityerror = null;
            //listError.Add(new ResponseError { Reporte = "Ejemplo ", Input = "Automotriz", TipoArchivo = "ReporteRI", NombreCampo = "Base", NumeroFila = 2, NombreHoja = "A", Mensaje = "Error al convertir un dato" });
            //Informacion 
            foreach (var error in UtilsLocal.ErrorCargaList)
            {
                Entityerror = new ResponseError();
                Entityerror.NombreColumna = error.NombreColumna;
                Entityerror.NumeroFila = error.Fila;
                Entityerror.PosicionColumna = error.PosicionColumna;
                Entityerror.Mensaje = error.DetalleError;
                Entityerror.NombreHoja = "Prueba";
                listError.Add(Entityerror);
            }

            DataEmail data = new DataEmail();
            bool estadoEnvio = SendWithTemplateModel(new DataEmail
            {
                Reporte = "REPORTE AUTOMOTRIZ", //ejemplo
                HoraEjecucion = Convert.ToDateTime(DateTime.Now).ToShortTimeString(),
                Mes = "JULIO",
                ErrorList = listError
            });

            //var estadoEnvio = SendWithTemplateModel(data);

            if (!estadoEnvio) {
                Console.WriteLine("Error al enviar correo");
                success = false;
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
                    .ReplyTo(ConfigurationManager.AppSettings["CorreoCC"])
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


    }
}
