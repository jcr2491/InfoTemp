using Sigcomt.Business.Entity;
using Sigcomt.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;

namespace Sigcomt.Scheduler.BulkFile.Core
{
    public class EnvioEmail
    {
        public static bool EnvioCorreo(List<DetalleLogCarga> errorList)
        {
            bool success = true;
            List<ResponseError> listError = new List<ResponseError>();
            List<ResponseTipoComision> listaTipoComision = new List<ResponseTipoComision>();
            List<ResponseInput> listaInput = new List<ResponseInput>();

            ResponseError Entityerror = null;
            ResponseInput EntityInput = null;
            ResponseTipoComision EntityTipoComision = null;

            var groupTipoComisionList = errorList.GroupBy(p => p.TipoComision).ToList().FirstOrDefault();
            var groupTipoArchivo = errorList.GroupBy(p => p.TipoArchivoId).ToList().FirstOrDefault();
      
            foreach (var error in errorList)
            {
                Entityerror = new ResponseError();
                Entityerror.TipoComision = error.TipoComision;
                Entityerror.TipoArchivo = error.TipoArchivo;
                Entityerror.NumeroFila = error.NumFila;
                Entityerror.PosicionColumna = error.PosicionColumna;
                Entityerror.Mensaje = error.DetalleLog;
                if (error.TipoLog == "1") Entityerror.TipoError = "Validacion de Datos";
                if (error.TipoLog == "2") Entityerror.TipoError = "Carga de datos";
                listError.Add(Entityerror);
            }
            if (groupTipoArchivo !=null)
            {
                foreach (var input in groupTipoArchivo.ToList())
                {
                    EntityInput = new ResponseInput();
                    EntityInput.Input = input.Archivo;
                    EntityInput.TipoLog = input.TipoLog;
                    listaInput.Add(EntityInput);
                }
            }

            if (groupTipoComisionList!=null )
            {
                foreach (var tipocomision in groupTipoComisionList.ToList())
                {
                    EntityTipoComision = new ResponseTipoComision();
                    EntityTipoComision.Reporte = tipocomision.TipoComision;
                    listaTipoComision.Add(EntityTipoComision);
                }
            }
           
            if (listError.Count > 0)
            {
                bool estadoEnvio = SendWithTemplateModel(new DataEmail
                {
                    HoraEjecucion = Convert.ToDateTime(DateTime.Now).ToShortTimeString(),
                    inputList = listaInput,
                    tipoComisionList = listaTipoComision,
                    ErrorList = listError
                });

                if (!estadoEnvio)
                {
                    Console.WriteLine("Error al enviar correo");
                    success = false;
                }
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
