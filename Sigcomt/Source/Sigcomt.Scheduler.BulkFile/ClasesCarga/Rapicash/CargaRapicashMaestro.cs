namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Rapicash
{
    public class CargaRapicashMaestro
    {
        #region Métodos Públicos
        public static void CargarArchivos()
        {
            CargaMetaMaestroRapicash.CargarArchivo();
            CargaGanadoresMaestroRapicash.CargarArchivo();
        }
        #endregion
    }
}
