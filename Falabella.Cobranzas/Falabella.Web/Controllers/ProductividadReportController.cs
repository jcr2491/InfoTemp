using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using Falabella.Business;
using Falabella.CrossCutting;
using Enums = Falabella.CrossCutting.Enums;
using Falabella.CrossCutting.Filters;
using Falabella.Entity;
using Falabella.Resources;
using Falabella.Web.Core;

namespace Falabella.Web.Controllers
{
    public class ProductividadReportController : BaseController
    {
        #region Métodos Públicos

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GenerarReporteExcel(ProductividadFilter filter)
        {
            var jsonResponse = new JsonResponse {Success = false};

            try
            {
                var fileBase =
                    new FileStream(Server.MapPath(Constantes.PathInReportTemplate + Constantes.NameProductividadTramoMoraReport),
                        FileMode.Open, FileAccess.Read);
                var excel = new ExcelXlsx(fileBase, filter.Tramos.First() - 1);
                var response = GenerarCuerpoExcel(excel, filter);

                EliminarHojas(excel, filter, (List<int>) response.Data);

                if (response.Success)
                {
                    GenerarExcel(excel);
                    jsonResponse.Success = true;
                    jsonResponse.Data = WebUtils.AbsoluteWebRoot + Constantes.PathOutReportTemplate.Replace("~/", "") +
                                    Constantes.NameProductividadTramoMoraReport;
                }

                jsonResponse.Message = response.Message;
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

        #region Tramo 1

        private bool GenerarCuerpoExcelTramo1(ExcelXlsx excel, ProductividadFilter filter)
        {
            var tramoList = ReportBL.GetInstance().GetProductividadTramo1(filter);
            if (!tramoList.Any()) return false;

            var tramoTempList = tramoList.Where(p => p.Rango != null).ToList();
            var estudios = tramoTempList.GroupBy(p => p.EstudioPrimario).Select(p => p.Key).OrderBy(p => p).ToList();

            excel.ChangeSheet(0);

            DateTime fecha = Convert.ToDateTime(filter.Fecha);
            int firstRowGrid2 = CrearEstructuraTramo1(excel, estudios, fecha, tramoTempList.GroupBy(p => p.Rango).Count());
            int rowNumber = firstRowGrid2;
            double total = 0;
            double contenido = 0;
            int rangoActual = 0;
            var rangos = tramoTempList.OrderBy(p => p.Rango).ThenBy(p => p.EstudioPrimario);

            foreach (var rango in rangos)
            {
                if (rangoActual != 0 && rangoActual != rango.Rango)
                {
                    rowNumber++;
                    firstRowGrid2 = rowNumber;
                    total = 0;
                    contenido = 0;
                }
                //rango.Total = rango.Contenido + rango.NoContenido;
                total += rango.Total;
                contenido += rango.Contenido;

                excel.ChangeCell(rowNumber, 3, rango.Total);
                excel.ChangeCell(rowNumber, 4, rango.Contenido);
                excel.ChangeCell(rowNumber, 5, rango.Contenido / rango.Total);
                excel.ChangeCell(firstRowGrid2, 6, contenido / total);
                excel.ChangeCell(firstRowGrid2, 7, rango.MetaDiaria);
                excel.ChangeCell(firstRowGrid2, 8, rango.MetaCierre);

                rangoActual = rango.Rango ?? 0;
                rowNumber++;
            }

            int lastRow1 = 4;

            var rangoEstudios = tramoTempList.GroupBy(p => p.EstudioPrimario).OrderBy(p => p.Key);
            var meta = tramoList.FirstOrDefault(p => p.Rango == null);
            total = 0;
            contenido = 0;

            foreach (var rango in rangoEstudios)
            {
                double totalParcial = rango.Sum(p => p.Total);
                double contenidoParcial = rango.Sum(p => p.Contenido);
                total += totalParcial;
                contenido += contenidoParcial;

                excel.ChangeCell(lastRow1, 3, totalParcial);
                excel.ChangeCell(lastRow1, 4, contenidoParcial);
                excel.ChangeCell(lastRow1, 5, contenidoParcial / totalParcial);
                excel.ChangeCell(4, 6, contenido / total);
                if (meta != null)
                {
                    excel.ChangeCell(4, 7, meta.MetaDiaria);
                    excel.ChangeCell(4, 8, meta.MetaCierre);
                }
                lastRow1++;
            }

            return true;
        }

        private int CrearEstructuraTramo1(ExcelXlsx excel, List<string> estudios, DateTime fecha, int rangos)
        {
            int lastRow1 = 4;
            int firstRow2 = 9;
            int lastRow2 = 9;
            int numEstudios = estudios.Count;

            for (int i = 0; i < numEstudios; i++)
            {
                lastRow1 = 4 + i;
                firstRow2 = 9 + i;
                lastRow2 = firstRow2 + i;

                if (i != 0)
                {
                    excel.CopyRow(4, lastRow1, false);
                    excel.CopyRow(firstRow2, lastRow2, false);
                }
                excel.ChangeCell(lastRow1, 2, estudios[i]);
                excel.ChangeCell(lastRow2, 2, estudios[i]);
                excel.ChangeCell(lastRow2, 1, $"Ven. 05/{fecha.Month:00}");
            }
            excel.AddMergedRegion(4, lastRow1, new[] { 1, 6, 7, 8 });
            excel.AddMergedRegion(firstRow2, lastRow2, new[] { 1, 6, 7, 8 });

            lastRow2++;

            for (int i = 1; i < rangos; i++)
            {
                lastRow2++;
                excel.CopyRowRange2(firstRow2, firstRow2 + numEstudios - 1, lastRow2, false);
                excel.ChangeCell(lastRow2, 1, $"Ven. {(i + 1) * 5:00}/{fecha.Month:00}");
                excel.AddMergedRegion(lastRow2, lastRow2 + numEstudios - 1, new[] { 1, 6, 7, 8 });

                lastRow2 += numEstudios;
            }

            return firstRow2;
        }

        #endregion

        #region Tramo 2

        private bool GenerarCuerpoExcelTramo2(ExcelXlsx excel, ProductividadFilter filter)
        {
            var tramoList = ReportBL.GetInstance().GetProductividadTramo2(filter);
            if (!tramoList.Any()) return false;

            excel.ChangeSheet(1);

            int numRow = 3;
            var departamentosLima = new List<int>
            {
                Enums.Departamento.Lima.GetNumberValue(),
                Enums.Departamento.Callao.GetNumberValue()
            };

            for (int i = 0; i < 2; i++)
            {
                int baseRow;
                string nombreEstudio = string.Empty;
                int firstRow = baseRow = numRow = numRow + (i != 0 ? 7 : 0);
                double sumTotal = 0;
                double sumContenido = 0;
                double sumProductos = 0;
                double meta;
                double porcentajeCont;

                var estudios = i == 0
                    ? tramoList.Where(p => departamentosLima.Contains(p.DepartamentoId)).GroupBy(p => p.Estudio)
                    : tramoList.Where(p => !departamentosLima.Contains(p.DepartamentoId)).GroupBy(p => p.Estudio);

                foreach (var estudio in estudios)
                {
                    double sumSubTotal = 0;
                    double sumSubContenido = 0;
                    double sumSubProductos = 0;

                    if (firstRow > baseRow)
                    {
                        excel.CopyRow(numRow, numRow, false);
                        excel.ChangeCell(numRow, 1, $"TOTAL {nombreEstudio}");
                        excel.AddMergedRegion(numRow, numRow, 1, 2);
                        numRow++;
                        firstRow = numRow;
                        excel.CopyRow(baseRow, numRow, false);
                    }

                    excel.ChangeCell(numRow, 1, estudio.Key);
                    var ditritos = estudio.Select(p => p);

                    foreach (var distrito in ditritos)
                    {
                        if (numRow > firstRow)
                        {
                            excel.CopyRow(baseRow, numRow, false);
                        }

                        porcentajeCont = distrito.Contenido / distrito.Total;
                        excel.ChangeCell(numRow, 2, distrito.Distrito);
                        excel.ChangeCell(numRow, 3, distrito.Total);
                        excel.ChangeCell(numRow, 4, distrito.Contenido);
                        excel.ChangeCell(numRow, 5, porcentajeCont);
                        excel.ChangeCell(numRow, 6, distrito.Meta);
                        excel.ChangeCell(numRow, 7, porcentajeCont / distrito.Meta);

                        sumSubTotal += distrito.Total;
                        sumSubContenido += distrito.Contenido;
                        sumSubProductos += distrito.Total * distrito.Meta;

                        numRow++;
                    }

                    porcentajeCont = sumSubContenido / sumSubTotal;
                    meta = sumSubProductos / sumSubTotal;

                    excel.ChangeCell(numRow, 3, sumSubTotal);
                    excel.ChangeCell(numRow, 4, sumSubContenido);
                    excel.ChangeCell(numRow, 5, porcentajeCont);
                    excel.ChangeCell(numRow, 6, meta);
                    excel.ChangeCell(numRow, 7, porcentajeCont / meta);
                    excel.AddMergedRegion(firstRow, numRow - 1, 1, 1);

                    sumTotal += sumSubTotal;
                    sumContenido += sumSubContenido;
                    sumProductos += sumSubTotal * meta;

                    firstRow = numRow;
                    nombreEstudio = estudio.Key;
                }

                porcentajeCont = sumContenido / sumTotal;
                meta = sumProductos / sumTotal;

                excel.ChangeCell(numRow, 1, $"TOTAL {nombreEstudio}");
                excel.ChangeCell(numRow + 1, 3, sumTotal);
                excel.ChangeCell(numRow + 1, 4, sumContenido);
                excel.ChangeCell(numRow + 1, 5, porcentajeCont);
                excel.ChangeCell(numRow + 1, 6, meta);
                excel.ChangeCell(numRow + 1, 7, porcentajeCont / meta);
            }

            return true;
        }

        #endregion

        #region Tramo 3

        private bool GenerarCuerpoExcelTramo3(ExcelXlsx excel, ProductividadFilter filter)
        {
            var tramoList = ReportBL.GetInstance().GetProductividadTramo3(filter);
            if (!tramoList.Any()) return false;

            excel.ChangeSheet(2);

            int numRow = 3;
            var departamentosLima = new List<int>
            {
                Enums.Departamento.Lima.GetNumberValue(),
                Enums.Departamento.Callao.GetNumberValue()
            };

            for (int i = 0; i < 2; i++)
            {
                int baseRow;
                string nombreEstudio = string.Empty;
                int firstRow = baseRow = numRow = numRow + (i != 0 ? 7 : 0);
                double sumTotal = 0;
                double sumContenido = 0;
                double sumProductos = 0;
                double meta;
                double porcentajeCont;

                var estudios = i == 0
                    ? tramoList.Where(p => departamentosLima.Contains(p.DepartamentoId)).GroupBy(p => p.Estudio)
                    : tramoList.Where(p => !departamentosLima.Contains(p.DepartamentoId)).GroupBy(p => p.Estudio);

                foreach (var estudio in estudios)
                {
                    double sumSubTotal = 0;
                    double sumSubContenido = 0;
                    double sumSubProductos = 0;

                    if (firstRow > baseRow)
                    {
                        excel.CopyRow(numRow, numRow, false);
                        excel.ChangeCell(numRow, 1, $"TOTAL {nombreEstudio}");
                        excel.AddMergedRegion(numRow, numRow, 1, 2);
                        numRow++;
                        firstRow = numRow;
                        excel.CopyRow(baseRow, numRow, false);
                    }

                    excel.ChangeCell(numRow, 1, estudio.Key);
                    var rangos = estudio.Select(p => p).OrderBy(p => p.Rango);

                    foreach (var rango in rangos)
                    {
                        if (numRow > firstRow)
                        {
                            excel.CopyRow(baseRow, numRow, false);
                        }

                        porcentajeCont = rango.Contenido / rango.Total;
                        excel.ChangeCell(numRow, 2, rango.Rango);
                        excel.ChangeCell(numRow, 3, rango.Total);
                        excel.ChangeCell(numRow, 4, rango.Contenido);
                        excel.ChangeCell(numRow, 5, porcentajeCont);
                        excel.ChangeCell(numRow, 6, rango.Meta);
                        excel.ChangeCell(numRow, 7, porcentajeCont / rango.Meta);

                        sumSubTotal += rango.Total;
                        sumSubContenido += rango.Contenido;
                        sumSubProductos += rango.Total * rango.Meta;

                        numRow++;
                    }

                    porcentajeCont = sumSubContenido / sumSubTotal;
                    meta = sumSubProductos / sumSubTotal;

                    excel.ChangeCell(numRow, 3, sumSubTotal);
                    excel.ChangeCell(numRow, 4, sumSubContenido);
                    excel.ChangeCell(numRow, 5, porcentajeCont);
                    excel.ChangeCell(numRow, 6, meta);
                    excel.ChangeCell(numRow, 7, porcentajeCont / meta);
                    excel.AddMergedRegion(firstRow, numRow - 1, 1, 1);

                    sumTotal += sumSubTotal;
                    sumContenido += sumSubContenido;
                    sumProductos += sumSubTotal * meta;

                    firstRow = numRow;
                    nombreEstudio = estudio.Key;
                }

                porcentajeCont = sumContenido / sumTotal;
                meta = sumProductos / sumTotal;

                excel.ChangeCell(numRow, 1, $"TOTAL {nombreEstudio}");
                excel.ChangeCell(numRow + 1, 3, sumTotal);
                excel.ChangeCell(numRow + 1, 4, sumContenido);
                excel.ChangeCell(numRow + 1, 5, porcentajeCont);
                excel.ChangeCell(numRow + 1, 6, meta);
                excel.ChangeCell(numRow + 1, 7, porcentajeCont / meta);
            }

            return true;
        }

        #endregion

        #region Tramo 4

        private bool GenerarCuerpoExcelTramo4(ExcelXlsx excel, ProductividadFilter filter)
        {
            var tramoList = ReportBL.GetInstance().GetProductividadTramo4(filter);
            if (!tramoList.Any()) return false;

            excel.ChangeSheet(3);

            int numRow = 3;

            for (int i = 0; i < 4; i++)
            {
                int baseRow;
                string nombreEstudio = string.Empty;
                int firstRow = baseRow = numRow = numRow + (i != 0 ? 7 : 0);
                double sumTotal = 0;
                double sumContenido = 0;
                double sumProductos = 0;
                double meta;
                double porcentajeCont;

                var zonas = GetGrupoTramo4(i, tramoList);

                foreach (var zona in zonas)
                {
                    double sumSubTotal = 0;
                    double sumSubContenido = 0;
                    double sumSubProductos = 0;

                    if (firstRow > baseRow)
                    {
                        excel.CopyRow(numRow, numRow, false);
                        excel.ChangeCell(numRow, 1, $"TOTAL {nombreEstudio}");
                        excel.AddMergedRegion(numRow, numRow, 1, 2);
                        numRow++;
                        firstRow = numRow;
                        excel.CopyRow(baseRow, numRow, false);
                    }

                    excel.ChangeCell(numRow, 1, zona.Key);
                    var estudios = zona.Select(p => p).OrderBy(p => p.Estudio);

                    foreach (var estudio in estudios)
                    {
                        if (numRow > firstRow)
                        {
                            excel.CopyRow(baseRow, numRow, false);
                        }

                        porcentajeCont = estudio.Contenido / estudio.Total;
                        excel.ChangeCell(numRow, 2, estudio.Estudio);
                        excel.ChangeCell(numRow, 3, estudio.Total);
                        excel.ChangeCell(numRow, 4, estudio.Contenido);
                        excel.ChangeCell(numRow, 5, porcentajeCont);
                        excel.ChangeCell(numRow, 6, estudio.Meta);
                        excel.ChangeCell(numRow, 7, porcentajeCont / estudio.Meta);

                        sumSubTotal += estudio.Total;
                        sumSubContenido += estudio.Contenido;
                        sumSubProductos += estudio.Total * estudio.Meta;

                        numRow++;
                    }

                    porcentajeCont = sumSubContenido / sumSubTotal;
                    meta = sumSubProductos / sumSubTotal;

                    excel.ChangeCell(numRow, 3, sumSubTotal);
                    excel.ChangeCell(numRow, 4, sumSubContenido);
                    excel.ChangeCell(numRow, 5, porcentajeCont);
                    excel.ChangeCell(numRow, 6, meta);
                    excel.ChangeCell(numRow, 7, porcentajeCont / meta);
                    excel.AddMergedRegion(firstRow, numRow - 1, 1, 1);

                    sumTotal += sumSubTotal;
                    sumContenido += sumSubContenido;
                    sumProductos += sumSubTotal * meta;

                    firstRow = numRow;
                    nombreEstudio = zona.Key;
                }

                porcentajeCont = sumContenido / sumTotal;
                meta = sumProductos / sumTotal;

                excel.ChangeCell(numRow, 1, $"TOTAL {nombreEstudio}");
                excel.ChangeCell(numRow + 1, 3, sumTotal);
                excel.ChangeCell(numRow + 1, 4, sumContenido);
                excel.ChangeCell(numRow + 1, 5, porcentajeCont);
                excel.ChangeCell(numRow + 1, 6, meta);
                excel.ChangeCell(numRow + 1, 7, porcentajeCont / meta);
            }

            return true;
        }

        private List<IGrouping<string, ProductividadTramo4Report>> GetGrupoTramo4(int grupo, List<ProductividadTramo4Report> tramoList)
        {
            IEnumerable<IGrouping<string, ProductividadTramo4Report>> list;

            switch (grupo)
            {
                case 0:
                    list = tramoList
                        .FindAll(p => p.ZonaId == Enums.Zona.LimaCallao.GetNumberValue() && p.Grupo == 1 && p.EsCore)
                        .GroupBy(p => p.TipoZona);
                    break;
                case 1:
                    list = tramoList
                        .FindAll(p => p.ZonaId == Enums.Zona.LimaCallao.GetNumberValue() && p.Grupo == 2 && p.EsCore)
                        .GroupBy(p => p.TipoZona);
                    break;
                case 2:
                    list = tramoList.FindAll(p => p.ZonaId == Enums.Zona.Provincia.GetNumberValue() && p.EsCore)
                        .GroupBy(p => p.Departamento);
                    break;
                default:
                    list = tramoList.FindAll(p => !p.EsCore).GroupBy(p => p.Departamento);
                    break;
            }

            return list.OrderBy(p => p.Key).ToList();
        }

        #endregion

        #region Tramo 5

        private bool GenerarCuerpoExcelTramo5(ExcelXlsx excel, ProductividadFilter filter)
        {
            var tramoList = ReportBL.GetInstance().GetProductividadTramo5(filter);
            if (!tramoList.Any()) return false;

            excel.ChangeSheet(4);

            int numRow = 3;

            for (int i = 0; i < 4; i++)
            {
                int baseRow;
                string nombreEstudio = string.Empty;
                int firstRow = baseRow = numRow = numRow + (i != 0 ? 7 : 0);
                double sumTotal = 0;
                double sumContenido = 0;
                double sumProductos = 0;
                double meta;
                double porcentajeCont;

                var zonas = GetGrupoTramo5(i, tramoList);

                foreach (var zona in zonas)
                {
                    double sumSubTotal = 0;
                    double sumSubContenido = 0;
                    double sumSubProductos = 0;

                    if (firstRow > baseRow)
                    {
                        excel.CopyRow(numRow, numRow, false);
                        excel.ChangeCell(numRow, 1, $"TOTAL {nombreEstudio}");
                        excel.AddMergedRegion(numRow, numRow, 1, 2);
                        numRow++;
                        firstRow = numRow;
                        excel.CopyRow(baseRow, numRow, false);
                    }

                    excel.ChangeCell(numRow, 1, zona.Key);
                    var estudios = zona.Select(p => p).OrderBy(p => p.Estudio);

                    foreach (var estudio in estudios)
                    {
                        if (numRow > firstRow)
                        {
                            excel.CopyRow(baseRow, numRow, false);
                        }

                        porcentajeCont = estudio.Contenido / estudio.Total;
                        excel.ChangeCell(numRow, 2, estudio.Estudio);
                        excel.ChangeCell(numRow, 3, estudio.Total);
                        excel.ChangeCell(numRow, 4, estudio.Contenido);
                        excel.ChangeCell(numRow, 5, porcentajeCont);
                        excel.ChangeCell(numRow, 6, estudio.Meta);
                        excel.ChangeCell(numRow, 7, porcentajeCont / estudio.Meta);

                        sumSubTotal += estudio.Total;
                        sumSubContenido += estudio.Contenido;
                        sumSubProductos += estudio.Total * estudio.Meta;

                        numRow++;
                    }

                    porcentajeCont = sumSubContenido / sumSubTotal;
                    meta = sumSubProductos / sumSubTotal;

                    excel.ChangeCell(numRow, 3, sumSubTotal);
                    excel.ChangeCell(numRow, 4, sumSubContenido);
                    excel.ChangeCell(numRow, 5, porcentajeCont);
                    excel.ChangeCell(numRow, 6, meta);
                    excel.ChangeCell(numRow, 7, porcentajeCont / meta);
                    excel.AddMergedRegion(firstRow, numRow - 1, 1, 1);

                    sumTotal += sumSubTotal;
                    sumContenido += sumSubContenido;
                    sumProductos += sumSubTotal * meta;

                    firstRow = numRow;
                    nombreEstudio = zona.Key;
                }

                porcentajeCont = sumContenido / sumTotal;
                meta = sumProductos / sumTotal;

                excel.ChangeCell(numRow, 1, $"TOTAL {nombreEstudio}");
                excel.ChangeCell(numRow + 1, 3, sumTotal);
                excel.ChangeCell(numRow + 1, 4, sumContenido);
                excel.ChangeCell(numRow + 1, 5, porcentajeCont);
                excel.ChangeCell(numRow + 1, 6, meta);
                excel.ChangeCell(numRow + 1, 7, porcentajeCont / meta);
            }

            return true;
        }

        private List<IGrouping<string, ProductividadTramo5Report>> GetGrupoTramo5(int grupo, List<ProductividadTramo5Report> tramoList)
        {
            IEnumerable<IGrouping<string, ProductividadTramo5Report>> list;

            switch (grupo)
            {
                case 0:
                    list = tramoList
                        .FindAll(p => p.ZonaId == Enums.Zona.LimaCallao.GetNumberValue() && p.Grupo == 1 && p.EsCore)
                        .GroupBy(p => p.TipoZona);
                    break;
                case 1:
                    list = tramoList
                        .FindAll(p => p.ZonaId == Enums.Zona.LimaCallao.GetNumberValue() && p.Grupo == 2 && p.EsCore)
                        .GroupBy(p => p.TipoZona);
                    break;
                case 2:
                    list = tramoList.FindAll(p => p.ZonaId == Enums.Zona.Provincia.GetNumberValue() && p.EsCore)
                        .GroupBy(p => p.Departamento);
                    break;
                default:
                    list = tramoList.FindAll(p => !p.EsCore).GroupBy(p => p.Departamento);
                    break;
            }

            return list.OrderBy(p => p.Key).ToList();
        }

        #endregion

        private void EliminarHojas(ExcelXlsx excel, ProductividadFilter filter, List<int> tramoList)
        {
            for (int i = 4; i >= 0; i--)
            {
                if (filter.Tramos.All(p => p != i + 1) || tramoList.Exists(p => p == i + 1))
                {
                    excel.WorkBook.RemoveSheetAt(i);
                }
            }
        }

        private void GenerarExcel(ExcelXlsx excel)
        {
            using (
                var file =
                    new FileStream(
                        Server.MapPath(Constantes.PathOutReportTemplate + Constantes.NameProductividadTramoMoraReport),
                        FileMode.Create, FileAccess.Write))
            {
                excel.WorkBook.Write(file);
            }
            excel.WorkBook.Close();
        }

        private JsonResponse GenerarCuerpoExcel(ExcelXlsx excel, ProductividadFilter filter)
        {
            bool esValido;
            List<int> tramosEliminar = new List<int>();
            var response = new JsonResponse {Success = false, Message = string.Empty};

            if (filter.Tramos.Any(p => p == 1))
            {
                esValido = GenerarCuerpoExcelTramo1(excel, filter);
                response.Success = response.Success || esValido;

                if (!esValido)
                {
                    response.Message += "<br/>" + Reporte.Tramo1;
                    tramosEliminar.Add(1);
                }
            }
            if (filter.Tramos.Any(p => p == 2))
            {
                esValido = GenerarCuerpoExcelTramo2(excel, filter);
                response.Success = response.Success || esValido;

                if (!esValido)
                {
                    response.Message += "<br/>" + Reporte.Tramo2;
                    tramosEliminar.Add(2);
                }
            }
            if (filter.Tramos.Any(p => p == 3))
            {
                esValido = GenerarCuerpoExcelTramo3(excel, filter);
                response.Success = response.Success || esValido;

                if (!esValido)
                {
                    response.Message += "<br/>" + Reporte.Tramo3;
                    tramosEliminar.Add(3);
                }
            }
            if (filter.Tramos.Any(p => p == 4))
            {
                esValido = GenerarCuerpoExcelTramo4(excel, filter);
                response.Success = response.Success || esValido;

                if (!esValido)
                {
                    response.Message += "<br/>" + Reporte.Tramo4;
                    tramosEliminar.Add(4);
                }
            }
            if (filter.Tramos.Any(p => p == 5))
            {
                esValido = GenerarCuerpoExcelTramo5(excel, filter);
                response.Success = response.Success || esValido;

                if (!esValido)
                {
                    response.Message += "<br/>" + Reporte.Tramo5;
                    tramosEliminar.Add(5);
                }
            }

            if (tramosEliminar.Any()) response.Message = Reporte.NoExistenDatos + ":" + response.Message;
            response.Data = tramosEliminar;

            return response;
        }

        #endregion
    }
}