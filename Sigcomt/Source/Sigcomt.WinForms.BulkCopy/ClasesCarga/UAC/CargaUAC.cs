using Sigcomt.Common;
using Sigcomt.Common.Enums;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.Maestro;
using Sigcomt.WinForms.BulkCopy.Core;

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.UAC
{
    public class CargaUAC
    {
        #region Métodos Públicos

        public static void CargarArchivos()
        {
            if (CargaGestionIndivudalKPIUAC.CargarArchivo() && CargaUACGrupoSupervisor.CargarArchivo() && 
                CargaPuntajeKPI.CargarArchivo() && CargaCargoComision.CargarArchivo())
            {
                CargaProductividad.CargarArchivo();
                CargaSlaUac.CargarArchivo();
                CargaUACMonitoreo.CargarArchivo();
                CargaDiasAusencia.CargarArchivo();
            }

            UtilsLocal.GenerarReporte("ReporteUAC", TipoComision.UAC.GetNumberValue());
        }

        #endregion
    }
}