using System;
using System.Collections.Generic;
using System.Data;
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
    public class CarteraCastigadaController : BaseController
    {
        #region Métodos Públicos

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetEstudios(string fecha)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var list = EstudioBL.GetInstance().GetEstudios(fecha);

                jsonResponse.Data = list;
                jsonResponse.Success = true;
            }
            catch (Exception ex)
            {
                LogError(ex);
            }

            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GenerarReporteExcel(CarteraCastigadaFilter filter)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                DateTime fechaIni = Convert.ToDateTime(filter.FechaIni);

                var fileBase =
                    new FileStream(Server.MapPath(Constantes.PathInReportTemplate + Constantes.NameCarteraCastigadaReport),
                        FileMode.Open, FileAccess.Read);
                var excel = new ExcelXlsx(fileBase, 0);

                if (filter.EstudioMetaList == null)
                {
                    jsonResponse.Message = Reporte.SeleccioneEstudio;
                    return Json(jsonResponse, JsonRequestBehavior.AllowGet);
                }

                AgregarMetas(filter);

                var carteraList = ReportBL.GetInstance().GetCarteraCastigada(filter);

                CargarCarterasProvincia(excel, fechaIni, carteraList);
                CargarCarterasLima(excel, fechaIni, carteraList);
                CargarRecuperoCastigo(excel, filter);

                using (var file = new FileStream(Server.MapPath(Constantes.PathOutReportTemplate + Constantes.NameCarteraCastigadaReport),
                    FileMode.Create, FileAccess.Write))
                {
                    excel.WorkBook.Write(file);
                }

                excel.WorkBook.Close();
                jsonResponse.Success = true;
                jsonResponse.Data = WebUtils.AbsoluteWebRoot + Constantes.PathOutReportTemplate.Replace("~/", "") +
                                    Constantes.NameCarteraCastigadaReport;
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

        private void AgregarMetas(CarteraCastigadaFilter filter)
        {
            DataTable dt = Utils.CrearCabeceraDataTable<Entity.EstudioMeta>();
            var split = filter.FechaIni.Split('/');
            string fecha = $"01/{split[1]}/{split[2]}";

            foreach (var item in filter.EstudioMetaList)
            {
                DataRow dr = dt.NewRow();
                dr["Fecha"] = fecha;
                dr["Codigo"] = item.CodEstudio;
                dr["Meta"] = item.Meta;

                dt.Rows.Add(dr);
            }

            EstudioBL.GetInstance().DeleteEstudioMeta(fecha);
            CabeceraCargaBL.GetInstance().Add(dt, "EstudioMeta");
        }

        private void CargarCarterasProvincia(ExcelXlsx excel, DateTime fechaIni, IEnumerable<CarteraCastigadaReport> carteraList)
        {
            var carteraProvincias =
                carteraList.Where(p => p.RegionId != CrossCutting.Enums.RegionEstudio.Lima.GetNumberValue())
                    .OrderBy(p => p.RegionId)
                    .ThenByDescending(p => p.Meta / p.Capital)
                    .ToList();

            int rowNumber = 5;
            int orden = 0;
            int regionAnterior = 0;

            string title = excel.GetStringCellValue(1, 1);
            excel.ChangeCell(1, 1, string.Format(title, fechaIni.Day, fechaIni.GetNameMonth(), fechaIni.Year));

            foreach (var item in carteraProvincias)
            {
                if (regionAnterior != 0 && regionAnterior != item.RegionId)
                {
                    excel.CopyRow(rowNumber, rowNumber + 1);
                    excel.Sheet.CreateRow(rowNumber);
                    orden = 0;
                    rowNumber++;
                }

                orden++;
                regionAnterior = item.RegionId;

                excel.CopyRow(rowNumber, rowNumber + 1);
                excel.ChangeCell(rowNumber, 1, orden);
                excel.ChangeCell(rowNumber, 2, item.CodigoEstudio);
                excel.ChangeCell(rowNumber, 3, item.RegionNombre);
                excel.ChangeCell(rowNumber, 4, item.Capital);
                excel.ChangeCell(rowNumber, 5, item.Meta);
                excel.ChangeCell(rowNumber, 6, item.Recupero);
                excel.ChangeCell(rowNumber, 7, item.Meta / item.Capital);
                excel.ChangeCell(rowNumber, 8, item.Recupero / item.Capital);

                rowNumber++;
            }
        }

        private void CargarCarterasLima(ExcelXlsx excel, DateTime fechaIni, IEnumerable<CarteraCastigadaReport> carteraList)
        {
            var carteraProvincias =
                carteraList.Where(p => p.RegionId == CrossCutting.Enums.RegionEstudio.Lima.GetNumberValue())
                    .OrderBy(p => p.Grupo)
                    .ThenByDescending(p => p.Meta / p.Capital)
                    .ToList();

            int rowNumber = 5;
            int rowNameGroup = 2;
            int orden = 0;
            int grupoAnterior = 0;
            excel.ChangeSheet(1);

            string title = excel.GetStringCellValue(1, 1);
            excel.ChangeCell(1, 1, string.Format(title, fechaIni.Day, fechaIni.GetNameMonth(), fechaIni.Year));

            foreach (var item in carteraProvincias)
            {
                item.Grupo = item.Grupo ?? -1;
                if (grupoAnterior != 0 && grupoAnterior != item.Grupo)
                {
                    excel.CopyRow(rowNumber, rowNumber + 1);
                    excel.Sheet.CreateRow(rowNumber);

                    orden = 0;
                    rowNameGroup = rowNumber;
                    rowNumber++;
                }

                if (rowNameGroup != 0 && item.Grupo != -1)
                {
                    excel.AddCell(rowNameGroup, 1, $"GRUPO {item.Grupo}");
                }

                orden++;
                rowNameGroup = 0;
                grupoAnterior = item.Grupo.Value;

                excel.CopyRow(rowNumber, rowNumber + 1);
                excel.ChangeCell(rowNumber, 1, orden);
                excel.ChangeCell(rowNumber, 2, item.CodigoEstudio);
                excel.ChangeCell(rowNumber, 3, item.RegionNombre);
                excel.ChangeCell(rowNumber, 4, item.Capital);
                excel.ChangeCell(rowNumber, 5, item.Meta);
                excel.ChangeCell(rowNumber, 6, item.Recupero);
                excel.ChangeCell(rowNumber, 7, item.Meta / item.Capital);
                excel.ChangeCell(rowNumber, 8, item.Recupero / item.Capital);

                rowNumber++;
            }
        }

        private void CargarRecuperoCastigo(ExcelXlsx excel, CarteraCastigadaFilter filter)
        {
            var recuperoList = ReportBL.GetInstance().GetRecuperoCastigo(filter);
            if (recuperoList == null) return;

            DateTime fecha = Convert.ToDateTime(filter.FechaIni);
            DateTime fechaIniMes = fecha.GetDateFirstDay();
            DateTime fechaFinMes = fecha.GetDateLastDayOfMonth();

            int dias = DateTime.DaysInMonth(fechaIniMes.Year, fechaIniMes.Month);

            excel.ChangeSheet(2);

            //Agregar celdas en los rangos (tamaño => número de dias)
            excel.CopyRange(1, 5, 1, 2, dias - 1);
            CargarCabeceraRecuperoCastigo(fecha, excel, recuperoList);

            int startColumn = 1;
            bool esProyeccion = true;
            double acumuladoTotal = 0;
            double metaAnterior = 0;
            filter.FactorCrecimiento = filter.FactorCrecimiento / 100;

            while (fechaIniMes <= fechaFinMes)
            {
                //Poner el número del dia
                excel.ChangeCell(1, startColumn, fechaIniMes.Day);

                var recuperos = recuperoList.Where(p => p.Dia == fechaIniMes.Day).ToList();

                if (!recuperos.Any()) break;

                double meta = recuperoList.First(p => p.Dia == fechaIniMes.Day).Meta;
                excel.ChangeCell(2, startColumn, meta);

                if (recuperos.Any(p => p.Acumulado.HasValue))
                {
                    acumuladoTotal += recuperos.Sum(p => p.Acumulado ?? 0);
                    
                    excel.ChangeCell(4, startColumn, acumuladoTotal);
                }
                else
                {
                    if (esProyeccion && fechaIniMes != fecha.GetDateFirstDay())
                    {
                        excel.ChangeCell(5, startColumn - 1, acumuladoTotal);
                    }
                    acumuladoTotal = acumuladoTotal + (meta - metaAnterior) * filter.FactorCrecimiento;
                    excel.ChangeCell(5, startColumn, acumuladoTotal);

                    esProyeccion = false;
                }

                metaAnterior = meta;
                fechaIniMes = fechaIniMes.AddDays(1);
                startColumn++;
            }
        }

        private void CargarCabeceraRecuperoCastigo(DateTime fecha, ExcelXlsx excel, List<RecuperoCastigoReport> list)
        {
            int anioMin = list.Min(p => p.Anio);
            int anioMax = list.Max(p => p.Anio);
            int row = 11;
            int dia = fecha.Day;
            double monto, sumReal = 0, sumMeta = 0;

            for (int i = anioMin; i <= anioMax; i++)
            {
                double real = list.Where(p => p.Anio == i).Sum(p => p.Acumulado ?? 0);
                var recupero = list.FirstOrDefault(p => p.Anio == i && p.Dia == dia);

                if (i != anioMin)
                {
                    excel.CopyRow(11, row);
                }

                double meta = recupero?.MetaAnio ?? 0;
                monto = real - meta;
                sumReal += real;
                sumMeta += meta;

                excel.ChangeCell(row, 0, i);
                excel.ChangeCell(row, 2, real);
                excel.ChangeCell(row, 3, meta);
                excel.ChangeCell(row, 4, monto);
                excel.ChangeCell(row, 5, monto / meta);
                excel.ChangeCell(row, 6, meta);
                excel.ChangeCell(row, 7, monto);
                excel.ChangeCell(row, 8, monto / meta);

                row++;
            }

            monto = sumReal - sumMeta;
            excel.ChangeCell(row, 2, sumReal);
            excel.ChangeCell(row, 3, sumMeta);
            excel.ChangeCell(row, 4, monto);
            excel.ChangeCell(row, 5, monto / sumMeta);
            excel.ChangeCell(row, 6, sumMeta);
            excel.ChangeCell(row, 7, monto);
            excel.ChangeCell(row, 8, monto / sumMeta);
        }

        #endregion
    }
}