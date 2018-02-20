namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.UAC
{
    public class CargaUAC
    {
        #region Métodos Públicos

        public static void CargarArchivos()
        {
            CargaProductividad.CargarArchivo();
            CargaSlaUac.CargarArchivo();
            CargaMonitoreo.CargarArchivo();
            CargaDiasAusencia.CargarArchivo();
            //CargaProducContactenos.CargarArchivo();
            //CargaSLAContactenos.CargarArchivo();
        }

        #endregion
    }
}