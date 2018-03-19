using Sigcomt.Scheduler.BulkFile.ClasesCarga.Rapicash;
namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Maestro
{
    public class CargaMantenimientoRapicash
    {
        public static void CargaArchivos()
        {
            CargaMaestroSagaTottus.CargarArchivo();
            //CargaMaestroSodimacMaestro.CargarArchivo();
        }
    }
}
