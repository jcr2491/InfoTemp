using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Reflection;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.Entity;
using log4net;

namespace Falabella.Consola
{
    public class CargaContencionHistorico
    {
        private static readonly ILog Logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region Métodos Públicos

        public static void CargarArchivo()
        {
            Logger.Info("Se inició la carga del archivo ContencionHistorico");
            Console.WriteLine("Se inició la carga del archivo ContencionHistorico");

            string ruta = ConfigurationManager.AppSettings["RutaContencionHistorico"];
            int rowNum = 1;

            try
            {
                var fileBase = new FileStream(ruta + "ContencionHistorico.xlsx", FileMode.Open, FileAccess.Read);
                var excel = new ExcelXlsx(fileBase, 0);
                DateTime? fecha = excel.GetDateCellValue(rowNum, 0);
                DataTable dt = Utils.CrearCabeceraDataTable<ContencionHistorico>();

                while (fecha != null)
                {
                    int cellNum = 1;
                    int rowNum2 = rowNum + 2;
                    var rowDia = excel.Sheet.GetRow(rowNum2);
                    int dia = excel.GetIntCellValue(rowDia, cellNum);
                    int lastDayMonth = DateTime.DaysInMonth(fecha.Value.Year, fecha.Value.Month);

                    while (dia > 0 && dia <= lastDayMonth)
                    {
                        for (int i = 1; i <= 6; i++)
                        {
                            DataRow dr = dt.NewRow();
                            dr["Porcentaje"] = excel.GetDoubleCellValue(rowNum2 + i, cellNum);
                            dr["Rango"] = i;
                            dr["Fecha"] = string.Format("{0}/{1}/{2}", fecha.Value.Year, fecha.Value.Month, dia);

                            dt.Rows.Add(dr);
                        }

                        cellNum++;
                        dia = excel.GetIntCellValue(rowDia, cellNum);
                    }

                    rowNum += 13;
                    fecha = excel.GetDateCellValue(rowNum, 0);
                }

                fileBase.Close();
                CabeceraCargaBL.GetInstance().Add(dt, "ContencionHistorico");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                Logger.Error("Error: " + ex.Message);
            }

            Logger.Info("Se terminó la carga del archivo ContencionHistorico");
            Console.WriteLine("Se terminó la carga del archivo ContencionHistorico");
        }

        #endregion
    }
}