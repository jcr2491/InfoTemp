namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.Rapicash
{
     public class CargaSodimacMaestro
    {
        public static void CargarArchivos()
        {
            if (CargaMaestroSodimacMaestro.CargarArchivo())
            {
                CargaRapicashSodimac.CargarArchivos();
                CargaRapicashMaestro.CargarArchivos();
            }
        }
    }
}
