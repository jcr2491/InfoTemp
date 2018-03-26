using Sigcomt.WinForms.BulkCopy.ClasesCarga.Maestro;

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
        }

        #endregion
    }
}