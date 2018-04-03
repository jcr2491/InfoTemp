namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.EjecutivosPromotores
{
    public class CargaEjecutivoPromotor
    {
        public static void CargaArchivos()
        {
            CargaPromotor.CargarArchivo();
            CargaEjecutivo.CargarArchivo();
            CargaCajero.CargarArchivo();
        }
    }
}
