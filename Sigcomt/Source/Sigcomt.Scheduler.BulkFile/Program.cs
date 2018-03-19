using Sigcomt.Scheduler.BulkFile.ClasesCarga.Automotriz;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.Base;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.UAC;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.Rapicash;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.EjecutivosPromotores;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.JefeComercial;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.Referido;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.MatenimientoIndicador;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.Maestro;
using Sigcomt.Scheduler.BulkFile.Core;
using System;

namespace Sigcomt.Scheduler.BulkFile
{
    class Program
    {        
        static void Main(string[] args)
        {
            try
            {
                UtilsLocal.CargarDatosIniciales();

                //Base
                if (CargaBaseArchivo.CargaArchivos())
                {
                    //Mantenimiento de Indicadores
                    //CargaMantenimientoIndicador.CargarArchivos();

                    //////UAC
                    //CargaUAC.CargarArchivos();

                    //Automotriz
                    //CargaDataAutomotriz.CargarArchivo();

                    //Maestro
                    //CargaMantenimientoRapicash.CargaArchivos();

                    //////Rapicash
                    //CargaRapicashMaestro.CargarArchivos();
                    CargaRapicashTottus.CargarArchivos();
                    CargaRapicashSodimac.CargarArchivos();
                    //CargaRapicashSaga.CargarArchivos();

                    //////Reporte RI
                    //CargaRI.CargasArchivos();

                    ////Ejecutivo Promotores
                    //CargaTarjetaPromotorCCFF.CargarArchivo();

                    ////Jefe Comercial
                    //CargaCierrePlanningJefeComercial.CargarArchivo();
                    //CargaPesoCCFF.CargarArchivo();

                    ////Referido
                    //CargaReferidoCCFF.CargarArchivo();

                    Console.WriteLine("Se completó la carga de todos los archivos inputs.");
                }
                else
                {
                    Console.WriteLine("Ocurrió un error al cargar los archivos Base fundamentales, por favor verifique su correo para mas detalle.");
                }

                var errorList = UtilsLocal.RegistrarLogCarga();
                var archivoEstadocarga = UtilsLocal.GetArchivoEstadoCarga();

                //Envio Correo
                EnvioEmail.EnvioCorreo(errorList, archivoEstadocarga);
                Console.ReadLine();
            }
            catch (Exception e) {
                string mensaje = e.Message;
            }
        }
    }
}