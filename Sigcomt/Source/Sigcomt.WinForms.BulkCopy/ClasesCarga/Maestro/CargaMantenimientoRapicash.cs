using Sigcomt.WinForms.BulkCopy.ClasesCarga.Rapicash;

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.Maestro
{
    public class CargaMantenimientoRapicash
    {
        public static void CargaArchivos()
        {
            CargaMaestroSagaTottus.CargarArchivo();
            CargaMaestroSodimacMaestro.CargarArchivo();
        }
    }
}
