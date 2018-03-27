using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Enums;
using Falabella.Dto;
using Falabella.Dto.AutoMapper;
using Falabella.Entity;
using Falabella.Resources;
using Falabella.Web.Core;
using Microsoft.Ajax.Utilities;

namespace Falabella.Web.Controllers
{
    public class ContencionCierreReportController : BaseController
    {
        #region Métodos Públicos

        public ActionResult Index()
        {
            var rangos = ContencionBL.GetInstance().GetRangoContencionCierre(DateTime.Today.GetDateToString());
            var model = new ContencionCierreDto
            {
                Fecha = DateTime.Today.ToString("MM/yyyy"),
                Rangos = MapperHelper.Map<List<RangoContencionCierre>, List<RangoContencionCierreDto>>(rangos)
            };

            return View(model);
        }

        [HttpPost]
        public JsonResult GenerarReporteExcel(ContencionCierreDto filter)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var fileBase =
                    new FileStream(Server.MapPath(Constantes.PathInReportTemplate + Constantes.NameContencionCierreReport),
                        FileMode.Open, FileAccess.Read);
                var excel = new ExcelXlsx(fileBase, 0);
                bool valido = GenerarCuerpoExcel(excel, filter);

                if (valido)
                {
                    GenerarExcel(excel);
                    jsonResponse.Success = true;
                    jsonResponse.Data = WebUtils.AbsoluteWebRoot + Constantes.PathOutReportTemplate.Replace("~/", "") +
                                        Constantes.NameContencionCierreReport;
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

        [HttpPost]
        public JsonResult GuardarRangos(ContencionCierreDto filter)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                AgregarRangos(filter);

                jsonResponse.Success = true;
                jsonResponse.Message = General.DatosGuardados;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = General.IntenteNuevamente;
            }

            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GuardarHistorico(ContencionCierreDto filter)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                ContencionBL.GetInstance().AddHistoricoContencionCierre(filter.Fecha);

                jsonResponse.Success = true;
                jsonResponse.Message = General.DatosGuardados;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = General.IntenteNuevamente;
            }

            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Métodos Privados

        private void AgregarRangos(ContencionCierreDto filter)
        {
            DataTable dt = Utils.CrearCabeceraDataTable<RangoContencionCierre>();
            var split = filter.Fecha.Split('/');
            string fecha = $"01/{split[1]}/{split[2]}";

            foreach (var item in filter.Rangos)
            {
                DataRow dr = dt.NewRow();
                dr["Fecha"] = fecha;
                dr["Rango"] = item.Rango;
                dr["DiaMoraMin"] = item.DiaMoraMin;
                dr["DiaMoraMax"] = Utils.GetValueColumn(item.DiaMoraMax);
                dr["PaisId"] = item.PaisId;

                dt.Rows.Add(dr);
            }

            ContencionBL.GetInstance().DeleteRangos(fecha);
            CabeceraCargaBL.GetInstance().Add(dt, "RangoContencionCierre");
        }

        private bool GenerarCuerpoExcel(ExcelXlsx excel, ContencionCierreDto filter)
        {
            if (filter.SoloHistorico)
            {
                GenerarHojaHistorico(excel, filter);
                excel.WorkBook.RemoveSheetAt(1);
                excel.WorkBook.RemoveSheetAt(0);
            }
            else
            {
                var contencionList = ContencionBL.GetInstance().GetContencionCierre(filter.Fecha);
                if (!contencionList.Any()) return false;

                GenerarHojaAnalisis(excel, filter, contencionList);
                GenerarHojaDetalle(excel, contencionList);

                if (filter.IncluirHistorico)
                {
                    bool existe = ContencionBL.GetInstance().ExisteHistoricoContencionCierre(filter.Fecha);
                    if (!existe)
                    {
                        ContencionBL.GetInstance().AddHistoricoContencionCierre(filter.Fecha);
                    }
                    GenerarHojaHistorico(excel, filter);
                }
                else
                {
                    excel.WorkBook.RemoveSheetAt(3);
                    excel.WorkBook.RemoveSheetAt(2);
                }
            }

            return true;
        }

        private void GenerarHojaAnalisis(ExcelXlsx excel, ContencionCierreDto filter, List<ContencionCierreReport> contencionList)
        {
            DateTime fecha = Convert.ToDateTime(filter.Fecha);
            string mesAño = $"{fecha.GetFirstLetterMonth()}{fecha:yy}";

            excel.ChangeCell(1, 1, string.Format(excel.GetStringCellValue(1, 1), mesAño));
            excel.ChangeCell(1, 2, string.Format(excel.GetStringCellValue(1, 2), mesAño));
            excel.ChangeCell(1, 9, string.Format(excel.GetStringCellValue(1, 9), mesAño));
            excel.ChangeCell(1, 10, string.Format(excel.GetStringCellValue(1, 10), mesAño));

            int rowIni = 5;
            int numRow = contencionList.Max(p => p.Rango);
            int rowTotal = rowIni + numRow;
            contencionList = contencionList.OrderBy(p => p.Rango).ToList();

            excel.CopyRowRange(rowIni, numRow, rowIni + 1, false);
            excel.ChangeCell(rowTotal, new Dictionary<int, string> { { 1, "Total" }, { 9, "Total" } });

            foreach (var item in contencionList)
            {
                var row = 4 + item.Rango;
                int col = item.PaisId == Pais.Peru.GetNumberValue() ? 1 : 9;

                if (item.Rango != 1)
                {
                    excel.ChangeCell(row, col,
                        item.DiaMoraMax.HasValue ? $"{item.DiaMoraMin}-{item.DiaMoraMax}" : $"=>{item.DiaMoraMin}");
                }

                excel.ChangeCell(row, col + 1, item.SumNoContenido);
                excel.ChangeCell(row, col + 2, item.SumContenido);
                excel.ChangeCell(row, col + 3, item.SumTotal);
                excel.ChangeCell(row, col + 4, item.NumNoContenido);
                excel.ChangeCell(row, col + 5, item.NumContenido);
                excel.ChangeCell(row, col + 6, item.NumNoContenido + item.NumContenido);

                excel.ChangeCell(rowTotal, col + 1, excel.GetDoubleCellValue(rowTotal, col + 1) + item.SumNoContenido);
                excel.ChangeCell(rowTotal, col + 2, excel.GetDoubleCellValue(rowTotal, col + 2) + item.SumContenido);
                excel.ChangeCell(rowTotal, col + 3, excel.GetDoubleCellValue(rowTotal, col + 3) + item.SumTotal);
                excel.ChangeCell(rowTotal, col + 4, excel.GetIntCellValue(rowTotal, col + 4) + item.NumNoContenido);
                excel.ChangeCell(rowTotal, col + 5, excel.GetIntCellValue(rowTotal, col + 5) + item.NumContenido);
                excel.ChangeCell(rowTotal, col + 6, excel.GetIntCellValue(rowTotal, col + 6) + item.NumNoContenido + item.NumContenido);
            }
        }

        private void GenerarHojaDetalle(ExcelXlsx excel, List<ContencionCierreReport> contencionList)
        {
            contencionList = contencionList.Where(p => p.DiaMoraMax.HasValue).OrderBy(p => p.Rango).ToList();

            int rowIni = 3;
            int rowFin = rowIni;
            int numRow = contencionList.Max(p => p.Rango);
            excel.ChangeSheet(1);

            for (int i = 1; i < numRow; i++)
            {
                rowFin += 5;
                excel.CopyRowRange2(rowIni, rowIni + 4, rowFin, false);
            }

            rowFin += 4;
            excel.ChangeCell(rowFin, new Dictionary<int, string> {{1, "TOTAL"}, {9, "TOTAL"}});

            foreach (var item in contencionList)
            {
                var row = 3 + (item.Rango - 1) * 5;
                int col = item.PaisId == Pais.Peru.GetNumberValue() ? 1 : 9;

                if (item.Rango != 1)
                {
                    excel.ChangeCell(row, col, $"{item.DiaMoraMin}-{item.DiaMoraMax}");
                }
                double numtotal = item.NumContenido + item.NumNoContenido;
                double sumTotal = item.SumTotal;

                excel.ChangeCell(new[] {row, row + 1, row + 2, row + 3}, col + 1, numtotal);
                excel.ChangeCell(new[] {row, row + 1, row + 2, row + 3}, col + 2, sumTotal);
                excel.ChangeCell(row, col + 3, item.NumContenido);
                excel.ChangeCell(row, col + 4, item.NumContenido / numtotal);
                excel.ChangeCell(row, col + 5, item.SumContenido);
                excel.ChangeCell(row, col + 6, item.SumContenido / sumTotal);

                row++;
                excel.ChangeCell(row, col + 3, item.NumPagoCuotaAtrasada);
                excel.ChangeCell(row, col + 4, item.NumPagoCuotaAtrasada / numtotal);
                excel.ChangeCell(row, col + 5, item.SumPagoCuotaAtrasada);
                excel.ChangeCell(row, col + 6, item.SumPagoCuotaAtrasada / sumTotal);

                row++;
                excel.ChangeCell(row, col + 3, item.NumPagoTotal);
                excel.ChangeCell(row, col + 4, item.NumPagoTotal / numtotal);
                excel.ChangeCell(row, col + 5, item.SumPagoTotal);
                excel.ChangeCell(row, col + 6, item.SumPagoTotal / sumTotal);

                row++;
                excel.ChangeCell(row, col + 3, item.NumRenegociada);
                excel.ChangeCell(row, col + 4, item.NumRenegociada / numtotal);
                excel.ChangeCell(row, col + 5, item.SumRenegociada);
                excel.ChangeCell(row, col + 6, item.SumRenegociada / sumTotal);

                //Total
                excel.ChangeCell(rowFin, col + 1, excel.GetIntCellValue(rowFin, col + 1) + numtotal);
                excel.ChangeCell(rowFin, col + 2, excel.GetDoubleCellValue(rowFin, col + 2) + sumTotal);
                excel.ChangeCell(rowFin, col + 3, excel.GetIntCellValue(rowFin, col + 3) + item.NumContenido);
                excel.ChangeCell(rowFin, col + 4,
                    excel.GetIntCellValue(rowFin, col + 3) / (excel.GetIntCellValue(rowFin, col + 1) * 1.00));
                excel.ChangeCell(rowFin, col + 5, excel.GetDoubleCellValue(rowFin, col + 5) + item.SumContenido);
                excel.ChangeCell(rowFin, col + 6, excel.GetDoubleCellValue(rowFin, col + 5) / excel.GetDoubleCellValue(rowFin, col + 2));
            }
        }

        private void GenerarHojaHistorico(ExcelXlsx excel, ContencionCierreDto filter)
        {
            var historicoList = ContencionBL.GetInstance().GetHistoricoContencionCierre(filter.Fecha);
            if (!historicoList.Any()) return;

            // Perú
            var newList = historicoList.Where(p => p.PaisId == Pais.Peru.GetNumberValue()).OrderBy(p => p.Fecha)
                .ThenBy(p => p.Rango).ToList();
            GenerarHojaHistoricoPais(excel, newList, 2);

            // Chile
            newList = historicoList.Where(p => p.PaisId == Pais.Chile.GetNumberValue()).OrderBy(p => p.Fecha)
                .ThenBy(p => p.Rango).ToList();
            GenerarHojaHistoricoPais(excel, newList, 3);
        }

        private void GenerarHojaHistoricoPais(ExcelXlsx excel, List<HistoricoContencionCierre> historicoList, int hojaPais)
        {
            int rowIni = 3;
            int rowFin = rowIni;
            int numRow = 6;

            int meses = historicoList.DistinctBy(p => p.Fecha).Count() - 1;
            excel.ChangeSheet(hojaPais);
            excel.CopyCell(2, 2, 3, 2 + meses);
            excel.CopyRange(rowIni, 5, 2, 3, meses);

            for (int i = 1; i < numRow; i++)
            {
                rowFin += 5;
                excel.CopyRowRange2(rowIni, rowIni + 4, rowFin, false);
            }

            rowFin += 5;
            excel.CopyCell(rowFin, 2, 3, 2 + meses);

            int colBase = 2;
            int col = 1;
            DateTime fechaAnterior = DateTime.MinValue;

            foreach (var item in historicoList)
            {
                var row = 3 + (item.Rango - 2) * 5;

                if (item.Fecha != fechaAnterior)
                {
                    col++;
                    excel.ChangeCell(2, col, item.Fecha);
                }

                if (col == colBase)
                {
                    excel.ChangeCell(row, 1, $"{item.DiaMoraMin} - {item.DiaMoraMax}");
                }

                excel.ChangeCell(row, col, item.CapitalContenido / item.CapitalTotal);
                excel.ChangeCell(row + 1, col, item.CapitalPagoCuotaAtrasada / item.CapitalTotal);
                excel.ChangeCell(row + 2, col, item.CapitalPagoTotal / item.CapitalTotal);
                excel.ChangeCell(row + 3, col, item.CapitalRenegociada / item.CapitalTotal);

                fechaAnterior = item.Fecha;
            }

            var groupList = historicoList.GroupBy(p => p.Fecha).Select(p => new
            {
                Fecha = p.Key,
                Total = p.Sum(q => q.CapitalContenido) / p.Sum(q => q.CapitalTotal)
            }).OrderBy(p => p.Fecha);

            col = 2;
            foreach (var item in groupList)
            {
                excel.ChangeCell(rowFin, col, item.Total);
                col++;
            }
        }

        private void GenerarExcel(ExcelXlsx excel)
        {
            using (var file = new FileStream(Server.MapPath(Constantes.PathOutReportTemplate + Constantes.NameContencionCierreReport),
                FileMode.Create, FileAccess.Write))
            {
                excel.WorkBook.Write(file);
            }
            excel.WorkBook.Close();
        }

        #endregion
    }
}