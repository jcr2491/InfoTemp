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
    public class RollRatesReportController : BaseController
    {
        #region Métodos Públicos

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GenerarReporteExcel(ContencionFilter filter)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                DateTime fechaIni = Convert.ToDateTime(filter.Fecha);

                var fileBase =
                    new FileStream(Server.MapPath(Constantes.PathInReportTemplate + Constantes.NameRollRatesReport),
                        FileMode.Open, FileAccess.Read);
                var excel = new ExcelXlsx(fileBase, 0);
                excel.WorkBook.SetSheetName(0, $"Cierre {fechaIni.GetFirstLetterMonth()}{fechaIni:yy}");
               
                //Cambiar el nombre de la columna del mes
                excel.ChangeCell(2, 3, fechaIni);

                var rollRatesList = RollRateBL.GetInstance().GetRollRates(filter);
                var totalList = rollRatesList.GroupBy(p => p.RangoIni).Select(p => new
                {
                    Rango = p.Key,
                    Total = p.Sum(q => q.CapitalIni)
                }).ToList();

                for (int i = 0; i <= 5; i++)
                {
                    var total = totalList.FirstOrDefault(p => p.Rango == i);
                    if (total != null)
                    {
                        int rowIni = 3 + (i*3);
                        //Retrocede
                        double capital = rollRatesList.Where(p => p.RangoIni == i && p.RangoFin < i).Sum(p => p.CapitalIni);
                        excel.ChangeCell(rowIni, 3, capital / total.Total);

                        //Mantiene
                        capital = rollRatesList.FirstOrDefault(p => p.RangoIni == i && p.RangoFin == i) ?.CapitalIni ?? 0;
                        excel.ChangeCell(rowIni + 1, 3, capital / total.Total);

                        //Aumenta
                        capital = rollRatesList.FirstOrDefault(p => p.RangoIni == i && p.RangoFin == i + 1)?.CapitalIni ?? 0;
                        excel.ChangeCell(rowIni + 2, 3, capital / total.Total);
                    }
                }

                using (var file = new FileStream(Server.MapPath(Constantes.PathOutReportTemplate + Constantes.NameRollRatesReport),
                    FileMode.Create, FileAccess.Write))
                {
                    excel.WorkBook.Write(file);
                }

                jsonResponse.Success = true;
                jsonResponse.Data = WebUtils.AbsoluteWebRoot + Constantes.PathOutReportTemplate.Replace("~/", "") +
                                    Constantes.NameRollRatesReport;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = Reporte.GenerarReporteError;
            }

            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }

        #endregion
    }
}