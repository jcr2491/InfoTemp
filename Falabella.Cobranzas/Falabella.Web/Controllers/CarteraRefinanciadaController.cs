using System;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Filters;
using Falabella.Resources;
using Falabella.Web.Core;

namespace Falabella.Web.Controllers
{
    public class CarteraRefinanciadaController : BaseController
    {
        #region Métodos Públicos

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GenerarReporteExcel(CarteraRefinanciadaFilter filter)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var fileBase =
                    new FileStream(Server.MapPath(Constantes.PathInReportTemplate + Constantes.NameCarteraRefinanciadaReport),
                        FileMode.Open, FileAccess.Read);
                var excel = new ExcelXlsx(fileBase, 0);

                bool valido = GenerarCuerpoExcel(excel, filter);

                if (valido)
                {
                    GenerarExcel(excel);
                    jsonResponse.Success = true;
                    jsonResponse.Data = WebUtils.AbsoluteWebRoot + Constantes.PathOutReportTemplate.Replace("~/", "") +
                                        Constantes.NameCarteraRefinanciadaReport;
                }
                else
                {
                    jsonResponse.Success = false;
                    jsonResponse.Message = General.NoDatos;
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = Reporte.GenerarReporteError;
            }

            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Métodos Privados

        private void GenerarCabeceraReport(ExcelXlsx excel, DateTime fechaIni, DateTime fechaFin)
        {
            int dias = fechaFin.Subtract(fechaIni).Days;

            //Agregar celdas en los rangos (tamaño => número de dias)
            excel.CopyRange(3, 6, 1, 2, dias);

            //Cambiar el valor de la fecha en los rangos
            excel.ChangeCell(4, 0, string.Format("META_{0}", fechaIni.GetNameMonth()));
        }

        private bool GenerarCuerpoExcel(ExcelXlsx excel, CarteraRefinanciadaFilter filter)
        {
            DateTime fechaReport = Convert.ToDateTime(filter.FechaFin);
            DateTime fechaIniMesTemp = fechaReport.GetDateFirstDay();
            DateTime fechaIniMes = fechaReport.GetDateFirstDay();
            DateTime fechaFinMes = fechaReport.GetDateLastDayOfMonth();
            string title = excel.GetStringCellValue(1, 1);
            excel.ChangeCell(1, 1, string.Format(title, fechaReport.Day, fechaReport.GetNameMonth(), fechaReport.Year));

            var carteraList = ReportBL.GetInstance().GetCarteraRefinanciada(filter);
            if (!carteraList.Any(p => p.FechaOperacion >= fechaIniMesTemp)) return false;

            var meta = MetaRefinanciadoBL.GetInstance().GetMetaRefinanciadoPorMes(filter.FechaFin);
            if (meta == null) return false;

            GenerarCabeceraReport(excel, fechaIniMesTemp, fechaFinMes);

            int cellNumber = 1;
            double capitalPromAnterior = 0;
            //const double factorCumplimiento = 1.1;
            double saldoCapital = 0;
            double metaDia = 0;
            Random rnd = new Random();
            double factorCrecimiento = meta.IntervaloSeleccionado ??
                                       rnd.NextDouble() * (meta.IntervaloSuperior - meta.IntervaloInferior) +
                                       meta.IntervaloInferior;
            carteraList = carteraList.OrderByDescending(p => p.FechaOperacion).ToList();

            foreach (var item in carteraList)
            {
                item.SaldoCapital = carteraList
                    .Where(p => p.FechaOperacion >= item.FechaOperacion.GetDateFirstDay() &&
                                p.FechaOperacion <= item.FechaOperacion).Sum(p => p.SaldoCapital);
            }

            var metas =
                carteraList.GroupBy(p => p.FechaOperacion.Month)
                    .Select(p => new { Mes = p.Key, Meta = p.Max(q => q.SaldoCapital) });

            var carteraDomingo = carteraList.Where(p => p.FechaOperacion < fechaIniMes &&
                                                        p.FechaOperacion.DayOfWeek == DayOfWeek.Sunday);
            double sumTemp = 0;
            int cont = 0;
            foreach (var domingo in carteraDomingo)
            {
                var sabado = carteraList.FirstOrDefault(p => p.FechaOperacion == domingo.FechaOperacion.AddDays(-1));
                if (sabado != null)
                {
                    sumTemp += (domingo.SaldoCapital / sabado.SaldoCapital);
                    cont++;
                }
            }

            var porcentajeDomingo = sumTemp / cont;

            while (fechaIniMesTemp <= fechaFinMes)
            {
                //Agregar los dias del mes
                excel.ChangeCell(3, cellNumber, fechaIniMesTemp.Day);

                var carteraActual = carteraList.FirstOrDefault(p => p.FechaOperacion == fechaIniMesTemp);
                var carteraMesAnteriorList =
                    carteraList.Where(p => p.FechaOperacion != fechaIniMesTemp &&
                                           p.FechaOperacion.Day == fechaIniMesTemp.Day).ToList();
                                           //((p.FechaOperacion.DayOfWeek != DayOfWeek.Sunday &&
                                           //  p.FechaOperacion.Day == fechaIniMesTemp.Day) ||
                                           // (p.FechaOperacion.AddDays(-1).DayOfWeek == DayOfWeek.Sunday &&
                                           //  p.FechaOperacion.Day == fechaIniMesTemp.AddDays(1).Day))).ToList();
                double capitalPromActual = 0;

                if (carteraMesAnteriorList.Any())
                {
                    if (fechaIniMesTemp.DayOfWeek == DayOfWeek.Sunday)
                    {
                        var saldo = metaDia * porcentajeDomingo;
                        excel.ChangeCell(4, cellNumber, saldo);
                        excel.ChangeCell(5, cellNumber, saldo / meta.Meta);
                    }
                    else
                    {
                        if (fechaIniMesTemp == fechaFinMes)
                        {
                            excel.ChangeCell(4, cellNumber, meta.Meta);
                        }
                        else
                        {
                            var cumplimientoProm = carteraMesAnteriorList.Average(
                                p => p.SaldoCapital / metas.First(q => q.Mes == p.FechaOperacion.Month).Meta);

                            //double cumplimiento = cumplimientoProm * factorCumplimiento;
                            metaDia = meta.Meta * cumplimientoProm;
                            excel.ChangeCell(4, cellNumber, metaDia);
                            excel.ChangeCell(5, cellNumber, cumplimientoProm);
                        }
                    }

                    capitalPromActual = carteraMesAnteriorList.Average(p => p.SaldoCapital);

                    if (carteraActual != null)
                    {
                        saldoCapital = carteraActual.SaldoCapital;
                        excel.ChangeCell(new[] {7, 8}, cellNumber, carteraActual.SaldoCapital);
                    }
                    else
                    {
                        if (fechaIniMesTemp.DayOfWeek == DayOfWeek.Sunday)
                        {
                            saldoCapital = saldoCapital + porcentajeDomingo;
                        }
                        else
                        {
                            saldoCapital = saldoCapital + ((capitalPromActual - capitalPromAnterior) * factorCrecimiento);
                        }
                       
                        excel.ChangeCell(8, cellNumber, saldoCapital);
                    }
                }

                capitalPromAnterior = capitalPromActual;
                fechaIniMesTemp = fechaIniMesTemp.AddDays(1);
                cellNumber++;
            }

            MetaRefinanciadoBL.GetInstance().UpdateFactorCrecimiento(filter.FechaFin, factorCrecimiento);

            return true;
        }

        private void GenerarExcel(ExcelXlsx excel)
        {
            using (var file = new FileStream(Server.MapPath(Constantes.PathOutReportTemplate + Constantes.NameCarteraRefinanciadaReport),
                        FileMode.Create, FileAccess.Write))
            {
                excel.WorkBook.Write(file);
            }

            excel.WorkBook.Close();
        }

        #endregion
    }
}