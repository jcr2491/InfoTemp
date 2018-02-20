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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI
{
    
    public class CargaRI
    {
        #region Métodos Públicos

        public static void CargaArchivos()
        {
            CargaRITarjetaAdicional.CargarArchivo();              //CARGÓ
            CargaRITEPlataforma.CargarArchivo();                    //CARGÓ
            CargaRITECCFF.CargarArchivo();                        //CARGÓ
            CargaRITECajero.CargarArchivo();                      //CARGÓ
            CargaRITiempoEspera.CargarArchivo();                  //CARGÓ
            CargaRIPasivosCortoLagoPlazo.CargarArchivo();         //CARGÓ
            CargaRIPasivosCsdCsi.CargarArchivo();                 //CARGÓ
            CargaRIActivosSuperCash.CargarArchivo();              //CARGÓ
            CargaRIActivosRapicashCCFF.CargarArchivo();           //CARGÓ
            CargaRISeguroVSC.CargarArchivo();                     //CARGÓ
            CargaRISeguroTP.CargarArchivo();                      //CARGÓ
            CargaRICalidadAtencion1erContacto.CargarArchivo();    //CARGÓ
            CargaRICalidadNPSCCFF.CargarArchivo();                //CARGÓ!
            CargaRICalidadAtencion.CargarArchivo();               //CARGÓ!
            CargaRIDerivacionHeavyPlataforma.CargarArchivo();         //CARGÓ
            CargaRIDerivacionCaja.CargarArchivo();                  //CARGÓ
            CargaRIAmpliacionLinea.CargarArchivo();                 //CARGÓ
            CargaRIOperacionSF.CargarArchivo();                      //CARGÓ!
            CargaRIOperacionE.CargarArchivo();                        //CARGÓ!
        }
        #endregion
    }

}
