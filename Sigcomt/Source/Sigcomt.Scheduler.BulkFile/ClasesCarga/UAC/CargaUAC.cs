using Sigcomt.Scheduler.BulkFile.ClasesCarga.Maestro;
namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.UAC
{
    public class CargaUAC
    {
        #region Métodos Públicos

        public static void CargarArchivos()
        {
            CargaProductividad.CargarArchivo();
            CargaSlaUac.CargarArchivo();
            CargaUACMonitoreo.CargarArchivo();
            CargaDiasAusencia.CargarArchivo();     
            CargaUACGrupoSupervisor.CargarArchivo();
        }

        #endregion
    }
}