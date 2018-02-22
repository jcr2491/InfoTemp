using Sigcomt.Scheduler.BulkFile.ClasesCarga.Automotriz;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.CCFF;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.UAC;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.Rapicash;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.EjecutivosPromotores;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.JefeComercial;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.ADirectorio;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.BParticipación;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.CTarjetas;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.DTiemposdeEspera;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.EPasivos;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.FActivos;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.HSeguros;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.ICalidadAtencion;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.JDerivacióndeCanalesElectrónicos;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.LAmpliacionesdeLínea;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.MOperaciones;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.Referido;
using Sigcomt.Scheduler.BulkFile.ClasesCarga.Maestro;
using Sigcomt.Scheduler.BulkFile.Core;
using System;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using System.Collections.Generic;

namespace Sigcomt.Scheduler.BulkFile
{
    class Program
    {        
        static void Main(string[] args)
        {
            UtilsLocal.CargarDatosIniciales();

            try
            {
                CargaUAC.CargarArchivos();
                //CargaDataAutomotriz.CargarArchivo();
                //CargaRI.CargaArchivos();


                //var email = ParametrosBL.GetInstance().GetParametros("CorreoAnalistaBI");


                //Maestro
                //CargaPuntajeKPI.CargarArchivo();
                //CargaBono.CargarArchivo();
                //CargaMaestroAutomotriz.CargarArchivo();

                //CargaUAC.CargarArchivos();
                //CargaFFVV.CargarArchivos();

                //Base
                //CargaEmpleadoCCFF.CargarArchivo();
                //CargaRICCFF.CargarArchivo();

                //Automotriz
                CargaDataAutomotriz.CargarArchivo();


                //Ejecutivo Promotores
                //CargaTarjetaPromotorCCFF.CargarArchivo();

                //Jefe Comercial
                //CargaCierrePlanningJefeComercial.CargarArchivo();
                //CargaPesoCCFF.CargarArchivo();
                ////CCFF
                //CargaEmpleadoCCFF.CargarArchivo();
                //CargaAmpliacionesCCFF.CargarArchivo();
                //CargaCICCFF.CargarArchivo();
                //CargaDerivacionCCFF.CargarArchivo();    //pendiente
                //CargaInformeVentaCCFF.CargarArchivo();  //pendiente
                //CargaJefeGerenteCCFF.CargarArchivo();
                //CargaNPSCCFF.CargarArchivo();

                //CargaRapicashCCFF.CargarArchivo();
                //RIActivosRapicashCCFF.CargarArchivo();
                //CargarPasivosCCFF.CargarArchivo();
                //CargaSegurosCCFF.CargarArchivo();



                //Rapicash 
                //CargaDetalleSFRapicash.CargarArchivo();

                //CargaMetaRetail.CargarArchivo();
                //CargaMetaSagaRapicash.CargarArchivo();
                //CargaMetaMaestroRapicash.CargarArchivo();
                //CargaMetaSodimacRapicash.CargarArchivo();

                //CargaResumenSFRapicash.CargarArchivo();
                //CargaResumenTottusRapicash.CargarArchivo();
                //CargaDetalleTottusRapicash.CargarArchivo();
                //CargaPlanillaTottusRapicash.CargarArchivo();
                //CargaResumenMaestroRapicash.CargarArchivo();
                //CargaDetalleMaestroRapicash.CargarArchivo();
                //CargaResumenSodimacRapicash.CargarArchivo();
                //CargaDetalleSodimacRapicash.CargarArchivo();
                //CargaPlanillaCajeroTottusRapicash.CargarArchivo();
                //CargaSodimacMetaRapicash.CargarArchivo();



                //CCFF
                //CargaRISeguroCCFF.CargarArchivo();


                //Referido
                // CargaReferidoCCFF.CargarArchivo();


                //UAC
                //CargaUACMonitoreo.CargarArchivo();
                //CargaProductividad.CargarArchivo();



                #region Reporte RI
                //CargaRI.CargasArchivos();   
                #endregion


                var errorList = UtilsLocal.RegistrarLogCarga();

                //Envio Correo

                EnvioEmail.EnvioCorreo(errorList);
                Console.WriteLine("Se completó la carga de todos los archivos inputs.");

                //Console.ReadLine();
            }
            catch (Exception e) {
                string mensaje = e.Message.ToString();
            }
        }
    }
}