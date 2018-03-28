using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Filters;
using Falabella.Entity;
using Falabella.Resources;
using Falabella.Web.Core;

namespace Falabella.Web.Controllers
{
    public class RollRatesDiarioReportController : BaseController
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
                DateTime fecha = Convert.ToDateTime(filter.Fecha);
                DateTime fechaFin = fecha.GetDateLastDayOfMonth();
                string path = Constantes.PathInReportTemplate + string.Format(Constantes.NameInRollRatesDiarioReport, fechaFin.Day);
                var fileBase = new FileStream(Server.MapPath(path), FileMode.Open, FileAccess.Read);
                var excel = new ExcelXlsx(fileBase, 0);
                bool valido = GenerarCuerpoExcel(excel, filter);

                if (valido)
                {
                    GenerarExcel(excel);
                    jsonResponse.Success = true;
                    jsonResponse.Data = WebUtils.AbsoluteWebRoot + Constantes.PathOutReportTemplate.Replace("~/", "") +
                                        Constantes.NameRollRatesDiarioReport;
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
            excel.CopyRange(37, 38, 1, 2, dias);

            //Cambiar el valor de la fecha en los rangos
            excel.ChangeCell(new[] { 41, 47, 53, 59, 65, 71 }, 0, fechaIni);

            int startColumn = 1;

            while (fechaIni <= fechaFin)
            {
                //Poner la letra inicial del dia
                excel.ChangeCell(37, startColumn, fechaIni.GetFirstLetterDay());

                //Poner el número del dia
                excel.ChangeCell(new[] { 38, 44, 50, 56, 62, 68 }, startColumn, fechaIni.Day);

                fechaIni = fechaIni.AddDays(1);
                startColumn++;
            }
        }

        private void GenerarExcel(ExcelXlsx excel)
        {
            using (var file = new FileStream(Server.MapPath(Constantes.PathOutReportTemplate + Constantes.NameRollRatesDiarioReport),
                FileMode.Create, FileAccess.Write))
            {
                excel.WorkBook.Write(file);
            }
            excel.WorkBook.Close();
        }

        private bool GenerarCuerpoExcel(ExcelXlsx excel, ContencionFilter filter)
        {
            var rollRatesList = RollRateBL.GetInstance().GetRollRatesDiario(filter.Fecha);
            if (!rollRatesList.Any()) return false;

            DateTime fecha = Convert.ToDateTime(filter.Fecha);
            DateTime fechaIni = fecha.GetDateFirstDay();
            DateTime fechaFin = fecha.GetDateLastDayOfMonth();

            GenerarCabeceraReport(excel, fechaIni, fechaFin);

            int inicioProyeccion = 0;
            List<RollRatesDiarioReport> tramosAnt = null;

            for (int i = 1; i <= fechaFin.Day; i++)
            {
                var tramos = rollRatesList.Where(p => p.Dia == i).OrderBy(p => p.Tramo).ToList();

                if (tramos.Any(p => p.EsContenido))
                {
                    inicioProyeccion = 0;
                }
                else
                {
                    inicioProyeccion = inicioProyeccion == 0 ? 1 : 2;
                }

                foreach (var tramo in tramos)
                {
                    excel.ChangeCell(39 + 6 * tramo.Tramo, i, tramo.Meta);

                    if (inicioProyeccion == 0)
                    {
                        //if (tramosAnt != null)
                        //{
                        //    var tramoAnt = tramosAnt.First(p => p.Tramo == tramo.Tramo);

                        //    if (tramo.EsContenido)
                        //    {
                        //        tramo.ContenidoAcumulado = tramoAnt.ContenidoAcumulado + tramo.Contenido;
                        //        tramo.PorcentajeContenido = tramo.ContenidoAcumulado / tramoTotal.Total;
                        //    }
                        //    else
                        //    {
                        //        tramo.ContenidoAcumulado = tramoAnt.ContenidoAcumulado;
                        //        tramo.PorcentajeContenido = tramoAnt.PorcentajeContenido;
                        //    }
                        //}
                        //else
                        //{
                        //    tramo.ContenidoAcumulado = tramo.Contenido;
                        //    tramo.PorcentajeContenido = tramo.Contenido / tramoTotal.Total;
                        //}
                        tramo.PorcentajeAumenta = tramo.Total.HasValue && tramo.Total > 0
                            ? (tramo.Aumenta ?? 0) / tramo.Total.Value
                            : 0;
                        excel.ChangeCell(41 + 6 * tramo.Tramo, i, tramo.PorcentajeAumenta);
                    }
                    else
                    {
                        if (tramosAnt != null)
                        {
                            var tramoAnt = tramosAnt.First(p => p.Tramo == tramo.Tramo);

                            if (inicioProyeccion == 1)
                            {
                                excel.ChangeCell(42 + 6 * tramo.Tramo, i - 1, tramoAnt.PorcentajeAumenta);
                            }

                            tramo.PorcentajeAumenta = tramoAnt.PorcentajeAumenta + (tramo.Meta - tramoAnt.Meta);
                            excel.ChangeCell(42 + 6 * tramo.Tramo, i, tramo.PorcentajeAumenta);
                        }
                        else
                        {
                            excel.ChangeCell(42 + 6 * tramo.Tramo, i, tramo.Meta);
                        }
                    }
                }

                tramosAnt = tramos;
            }

            return true;
        }

        #endregion
    }
}