namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Rapicash
{
    public class CargaRapicashTottus
    {
        #region Métodos Públicos
        public static void CargarArchivos()
        {
            CargaPlanillaCajeroTottusRapicash.CargarArchivo();
            CargaResumenTottusRapicash.CargarArchivo();
            CargaDetalleTottusRapicash.CargarArchivo();
        }
        #endregion
    }
}
