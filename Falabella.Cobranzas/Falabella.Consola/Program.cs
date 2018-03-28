namespace Falabella.Consola
{
    class Program
    {
        static void Main(string[] args)
        {
            CargaSaldosVencidoCyber.CargarArchivo();
            CargaRiad.CargarArchivo();
            CargaTampJ.CargarArchivo();
            CargaPagosVencidos.CargarArchivo();
            CargaCastigoHc.CargarArchivo();
            CargaRefinanciados.CargarArchivo();
            CargaUbigeoTramo45.CargarArchivo();
            CargaEstudioCuentaTramo1.CargarArchivo();
            CargaEstudioDistritoTramo2.CargarArchivo();
            CargaEstudioRangoTramo3.CargarArchivo();
            CargaEstudioCuentaTramo45.CargarArchivo();
            CargaEstudioMetaTramo.CargarArchivo();
            CargaCuentasCastigoMensual.CargarArchivo();
            CargaEstudioRangoTramo1.CargarArchivo();
            CargaEstudioCuentaTramo23.CargarArchivo();
            CargaCuentaHomologada.CargarArchivo();
            CargaPagosHc.CargarArchivo();
            CargaMetaRecuperoCastigo.CargarArchivo();
            CargaEstudioRecuperoCastigo.CargarArchivo();
            CargaEstudioMetaRecupero.CargarArchivo();
            CargaMetaContencion.CargarArchivo();
            CargaMetaRollRatesDiario.CargarArchivo();
            //Solo es para la data historica para el reporte de contención
            //CargaContencionHistorico.CargarArchivo();
        }
    }
}