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

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI
{   
    public class CargaRI
    {
        #region Métodos Públicos

        public static void CargasArchivos()
        {
            CargaRITarjetaAdicional.CargarArchivo();
            CargaRITEPlataforma.CargarArchivo();
            CargaRITECCFF.CargarArchivo();
            CargaRITECajero.CargarArchivo();
            CargaRIPasivosCortoLagoPlazo.CargarArchivo();
            CargaRIPasivosCsdCsi.CargarArchivo();
            CargaRIActivosSuperCash.CargarArchivo();
            CargaRIActivosRapicashCCFF.CargarArchivo();
            CargaRISeguroVSC.CargarArchivo();
            CargaRISeguroTP.CargarArchivo();
            CargaRICalidadAtencion1erContacto.CargarArchivo();
            CargaRICalidadNPSCCFF.CargarArchivo();
            CargaRIDerivacionHeavyPlataforma.CargarArchivo();
            CargaRIDerivacionCaja.CargarArchivo();
            CargaRIAmpliacionLinea.CargarArchivo();
            CargaRIOperacionSF.CargarArchivo();
            CargaRIOperacionE.CargarArchivo();
            CargaRIParticipacionTR.CargaArchivo();
        }

        #endregion
    }
}