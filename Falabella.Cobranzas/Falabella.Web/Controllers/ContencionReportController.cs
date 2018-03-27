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
    public class ContencionReportController : BaseController
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
                string path = Constantes.PathInReportTemplate + string.Format(Constantes.NameInContencionReport, fechaFin.Day);
                var fileBase = new FileStream(Server.MapPath(path), FileMode.Open, FileAccess.Read);
                var excel = new ExcelXlsx(fileBase, 0);
                bool valido = GenerarCuerpoExcel(excel, filter);

                if (valido)
                {
                    GenerarExcel(excel);
                    jsonResponse.Success = true;
                    jsonResponse.Data = WebUtils.AbsoluteWebRoot + Constantes.PathOutReportTemplate.Replace("~/", "") +
                                        Constantes.NameContencionReport;
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
            excel.CopyRange(47, 38, 1, 2, dias);

            //Cambiar el valor de la fecha en los rangos
            excel.ChangeCell(new[] {51, 57, 63, 69, 75, 81}, 0, fechaIni);

            int startColumn = 1;

            while (fechaIni <= fechaFin)
            {
                //Poner la letra inicial del dia
                excel.ChangeCell(47, startColumn, fechaIni.GetFirstLetterDay());

                //Poner el número del dia
                excel.ChangeCell(new[] {48, 54, 60, 66, 72, 78}, startColumn, fechaIni.Day);

                fechaIni = fechaIni.AddDays(1);
                startColumn++;
            }
        }

        private void GenerarExcel(ExcelXlsx excel)
        {
            using (var file = new FileStream(Server.MapPath(Constantes.PathOutReportTemplate + Constantes.NameContencionReport),
                    FileMode.Create, FileAccess.Write))
            {
                excel.WorkBook.Write(file);
            }
            excel.WorkBook.Close();
        }

        private bool GenerarCuerpoExcel(ExcelXlsx excel, ContencionFilter filter)
        {
            var contencionList = ContencionBL.GetInstance().GetContencion(filter);
            if (!contencionList.Any()) return false;

            DateTime fecha = Convert.ToDateTime(filter.Fecha);
            DateTime fechaIni = fecha.GetDateFirstDay();
            DateTime fechaFin = fecha.GetDateLastDayOfMonth();

            GenerarCabeceraReport(excel, fechaIni, fechaFin);

            var groupList = contencionList.GroupBy(p => p.Tramo).Select(p => new
            {
                Rango = p.Key,
                Contenido = p.Sum(q => q.Contenido),
                NoContenido = p.Max(q => q.NoContenido),
                Total = p.Sum(q => q.Contenido) + p.Max(q => q.NoContenido)
            }).ToList();

            foreach (var item in groupList)
            {
                int rowNum = item.Rango + 3;
                excel.ChangeCell(rowNum, 2, item.Total);
                excel.ChangeCell(rowNum, 3, item.Contenido);
                excel.ChangeCell(rowNum, 4, item.NoContenido);
                excel.ChangeCell(rowNum, 5, item.Contenido / item.Total);
            }

            int inicioProyeccion = 0;
            List<ContencionReport> tramosAnt = null;

            for (int i = 1; i <= fechaFin.Day; i++)
            {
                var tramos = contencionList.Where(p => p.Dia == i).OrderBy(p => p.Tramo).ToList();

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
                    excel.ChangeCell(49 + 6 * (tramo.Tramo - 1), i, tramo.Meta);
                    var tramoTotal = groupList.First(p => p.Rango == tramo.Tramo);

                    if (inicioProyeccion == 0)
                    {
                        if (tramosAnt != null)
                        {
                            var tramoAnt = tramosAnt.First(p => p.Tramo == tramo.Tramo);

                            if (tramo.EsContenido)
                            {
                                tramo.ContenidoAcumulado = tramoAnt.ContenidoAcumulado + tramo.Contenido;
                                tramo.PorcentajeContenido = tramo.ContenidoAcumulado / tramoTotal.Total;
                            }
                            else
                            {
                                tramo.ContenidoAcumulado = tramoAnt.ContenidoAcumulado;
                                tramo.PorcentajeContenido = tramoAnt.PorcentajeContenido;
                            }
                        }
                        else
                        {
                            tramo.ContenidoAcumulado = tramo.Contenido;
                            tramo.PorcentajeContenido = tramo.Contenido / tramoTotal.Total;
                        }
                        excel.ChangeCell(51 + 6 * (tramo.Tramo - 1), i, tramo.PorcentajeContenido);
                    }
                    else
                    {
                        if (tramosAnt != null)
                        {
                            var tramoAnt = tramosAnt.First(p => p.Tramo == tramo.Tramo);

                            if (inicioProyeccion == 1)
                            {
                                excel.ChangeCell(52 + (6 * (tramo.Tramo - 1)), i - 1, tramoAnt.PorcentajeContenido);
                            }

                            tramo.PorcentajeContenido = tramoAnt.PorcentajeContenido + (tramo.Meta - tramoAnt.Meta);
                            excel.ChangeCell(52 + (6 * (tramo.Tramo - 1)), i, tramo.PorcentajeContenido);
                        }
                        else
                        {
                            excel.ChangeCell(52 + 6 * (tramo.Tramo - 1), i, tramo.Meta);
                        }
                    }
                }

                tramosAnt = tramos;
            }

            if (tramosAnt != null)
            {
                foreach (var tramo in tramosAnt)
                {
                    int rowNum = tramo.Tramo + 3;
                    excel.ChangeCell(rowNum, 6, tramo.PorcentajeContenido);
                }
            }

            return true;
        }

        #endregion
    }
}