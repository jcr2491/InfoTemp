namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.MatenimientoIndicador
{
    public class CargaMantenimientoIndicador
    {
        public static void CargarArchivos()
        {
            CargaKPIIndicador.CargarArchivo();
            CargaIndicador.CargarArchivo();
            CargaHomologacionIndicador.CargarArchivo();
            CargaPesoKPI.CargarArchivo();
            CargaTarifarioIndicador.CargarArchivo();
            CargaEscalaFormatoCCFF.CargarArchivo();
            CargaPotenciarKPI.CargarArchivo();
        } 

    }
}
