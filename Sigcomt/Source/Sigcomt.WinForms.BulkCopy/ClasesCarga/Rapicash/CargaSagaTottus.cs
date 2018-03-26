namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.Rapicash
{
    public class CargaSagaTottus
    {
        public static void CargasArchivos()
        {
            if (CargaMaestroSagaTottus.CargarArchivo())
            {
                CargaRapicashSaga.CargarArchivos();
                CargaRapicashTottus.CargarArchivos();
            }
        }
    }
}
