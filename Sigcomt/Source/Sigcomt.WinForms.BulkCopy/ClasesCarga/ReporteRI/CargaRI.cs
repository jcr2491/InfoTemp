using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.BParticipación;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.CTarjetas;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.DTiemposdeEspera;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.EPasivos;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.FActivos;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.HSeguros;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.ICalidadAtencion;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.JDerivacióndeCanalesElectrónicos;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.LAmpliacionesdeLínea;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.MOperaciones;

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI
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