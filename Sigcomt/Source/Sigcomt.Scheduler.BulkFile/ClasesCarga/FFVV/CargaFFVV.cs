namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.FFVV
{
    public class CargaFFVV
    {
        #region Métodos Públicos

        public static void CargarArchivos()
        {
            CargaCmrRatificada.CargarArchivo();
            CargaMontosTrasladosCTS.CargarArchivo();
            CargaTotalCuentas2Abono.CargarArchivo();
        }

        #endregion
    }
}