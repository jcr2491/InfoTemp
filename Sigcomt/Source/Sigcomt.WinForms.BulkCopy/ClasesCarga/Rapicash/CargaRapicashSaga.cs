namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.Rapicash
{
    public class CargaRapicashSaga
    {
        #region Métodos Públicos
        public static void CargarArchivos()
        {
            CargaResumenSFRapicash.CargarArchivo();
            CargaDetalleSFRapicash.CargarArchivo();
        }
        #endregion
    }
}
