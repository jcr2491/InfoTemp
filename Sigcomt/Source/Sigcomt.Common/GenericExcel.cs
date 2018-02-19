using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.SS.Util;
using NPOI.XSSF.UserModel;

namespace Sigcomt.Common
{
    public class GenericExcel
    {
        private readonly IWorkbook _workBook;
        private ISheet _sheet;

        public ISheet Sheet => _sheet;

        public IWorkbook WorkBook => _workBook;

        public GenericExcel(FileStream s, string nombreHoja)
        {
            if (s.Name.EndsWith(".xlsx"))
            {
                _workBook = new XSSFWorkbook(s);
            }
            else
            {
                _workBook = new HSSFWorkbook(s);
            }

            _sheet = _workBook.GetSheet(nombreHoja);
        }

        public GenericExcel(FileStream s, int indexHoja)
        {
            if (s.Name.EndsWith(".xlsx"))
            {
                _workBook = new XSSFWorkbook(s);
            }
            else
            {
                _workBook = new HSSFWorkbook(s);
            }

            _sheet = _workBook.GetSheetAt(indexHoja);
        }

        public GenericExcel(string nombreHoja)
        {
            _workBook = new XSSFWorkbook();
            _sheet = _workBook.CreateSheet(nombreHoja);
        }

        #region Métodos Públicos

        public void ChangeSheet(int indexHoja)
        {
            _sheet = _workBook.GetSheetAt(indexHoja);
        }

        public void NewRow(int rowNumber, Dictionary<int, int> cells)
        {
            IRow row = _sheet.CreateRow(rowNumber);
            foreach (var cell in cells)
            {
                row.CreateCell(cell.Key).SetCellValue(cell.Value);
            }
        }

        public void NewRowCellFormula(int rowNumber, int colNumber, string formula)
        {
            IRow row = _sheet.CreateRow(rowNumber);
            row.CreateCell(colNumber).SetCellFormula(formula);
        }

        public void AddCell(int rowNumber, int cellNumber, int cellValue)
        {
            _sheet.GetRow(rowNumber).CreateCell(cellNumber).SetCellValue(cellValue);
        }

        public void AddCell(int rowNumber, int cellNumber, string cellValue)
        {
            _sheet.GetRow(rowNumber).CreateCell(cellNumber).SetCellValue(cellValue);
        }

        public DateTime? GetDateCellValue(int rowNumber, int cellNumber)
        {
            IRow row = _sheet.GetRow(rowNumber);
            ICell cell = row?.GetCell(cellNumber);
            var date = cell?.DateCellValue;

            return DateTime.MinValue != date ? date : null;
        }

        public int GetIntCellValue(int rowNumber, int cellNumber)
        {
            IRow row = _sheet.GetRow(rowNumber);
            ICell cell = row?.GetCell(cellNumber);

            return Convert.ToInt32(cell?.NumericCellValue);
        }

        public int GetIntCellValue(IRow row, int cellNumber)
        {
            ICell cell = row?.GetCell(cellNumber);
            return Convert.ToInt32(cell?.NumericCellValue);
        }

        public string GetStringCellValue(IRow row, int cellNumber)
        {
            ICell cell = row?.GetCell(cellNumber);
            return cell?.StringCellValue;
        }

        public double GetDoubleCellValue(IRow row, int cellNumber)
        {
            ICell cell = row?.GetCell(cellNumber);
            return cell?.NumericCellValue ?? 0;
        }

        public DateTime? GetDateCellValue(IRow row, int cellNumber)
        {
            ICell cell = row?.GetCell(cellNumber);
            return cell?.DateCellValue;
        }        

        public double GetDoubleCellValue(int rowNumber, int cellNumber)
        {
            IRow row = _sheet.GetRow(rowNumber);
            ICell cell = row?.GetCell(cellNumber);

            return cell?.NumericCellValue ?? 0;
        }

        public string GetStringCellValue(int rowNumber, int cellNumber)
        {
            IRow row = _sheet.GetRow(rowNumber);
            ICell cell = row?.GetCell(cellNumber);

            return cell?.StringCellValue;
        }

        public string GetCellToString(IRow row, int cellNumber)
        {
            ICell cell = row?.GetCell(cellNumber);
            string valor = string.Empty;

            switch (cell.CellType)
            {
                case CellType.Numeric:
                    valor = DateUtil.IsCellDateFormatted(cell)
                        ? cell.DateCellValue.ToString("dd/MM/yyyy")
                        : cell.NumericCellValue.ToString();
                    break;
                case CellType.Formula:
                    switch (cell.CachedFormulaResultType)
                    {
                        case CellType.Numeric:
                            valor = DateUtil.IsCellDateFormatted(cell)
                                ? cell.DateCellValue.ToString()
                                : cell.NumericCellValue.ToString();
                            break;
                        case CellType.Error:
                            valor = cell.ErrorCellValue.ToString();
                            break;
                        case CellType.String:
                            valor = cell.StringCellValue.Trim();
                            break;
                        case CellType.Boolean:
                            valor = cell.BooleanCellValue.ToString();
                            break;
                        default:
                            valor = GetCellToString(cell);
                            break;
                    }
                    break;
                case CellType.Error:
                    valor = cell.ErrorCellValue.ToString();
                    break;
                default:
                    valor = GetCellToString(cell);
                    break;
            }

            return valor;
        }

        public string GetCellToString(ICell cell)
        {
            return cell?.ToString().Trim() ?? string.Empty;
        }

        public void ChangeCell(int rowNumber, Dictionary<int, string> cells)
        {
            IRow row = _sheet.GetRow(rowNumber);
            foreach (var cell in cells)
            {
                row.GetCell(cell.Key).SetCellValue(cell.Value);
            }
        }

        public void ChangeCell(int rowNumber, Dictionary<int, int> cells)
        {
            IRow row = _sheet.GetRow(rowNumber);
            foreach (var cell in cells)
            {
                row.GetCell(cell.Key).SetCellValue(cell.Value);
            }
        }

        public void ChangeCell(int rowNumber, Dictionary<int, int> cells, IConditionalFormattingRule[] cfRules)
        {
            IRow row = _sheet.GetRow(rowNumber);
            foreach (var cell in cells)
            {
                row.GetCell(cell.Key).SetCellValue(cell.Value);

                ISheetConditionalFormatting sheetCf = _sheet.SheetConditionalFormatting;
                CellRangeAddress[] regions =
                {
                    new CellRangeAddress(rowNumber, rowNumber, cell.Key, cell.Key)
                };

                sheetCf.AddConditionalFormatting(regions, cfRules);
            }
        }

        public void ChangeCell(int rowNumber, int cellNumber, string cellValue)
        {
            _sheet.GetRow(rowNumber).GetCell(cellNumber).SetCellValue(cellValue);
        }

        public void ChangeCell(int rowNumber, int cellNumber, DateTime cellValue)
        {
            _sheet.GetRow(rowNumber).GetCell(cellNumber).SetCellValue(cellValue);
        }

        public void ChangeCell(int[] rowNumbers, int cellNumber, DateTime cellValue)
        {
            foreach (var rowNumber in rowNumbers)
            {
                _sheet.GetRow(rowNumber).GetCell(cellNumber).SetCellValue(cellValue);
            }
        }

        public void ChangeCell(int[] rowNumbers, int cellNumber, int cellValue)
        {
            foreach (var rowNumber in rowNumbers)
            {
                _sheet.GetRow(rowNumber).GetCell(cellNumber).SetCellValue(cellValue);
            }
        }

        public void ChangeCell(int[] rowNumbers, int cellNumber, double cellValue)
        {
            foreach (var rowNumber in rowNumbers)
            {
                _sheet.GetRow(rowNumber).GetCell(cellNumber).SetCellValue(cellValue);
            }
        }

        public void ChangeCell(int rowNumber, int cellNumber, string cellValue, ICellStyle style)
        {
            var cell = _sheet.GetRow(rowNumber).GetCell(cellNumber);
            cell.CellStyle = style;
            cell.SetCellValue(cellValue);
        }

        public void ChangeCell(int rowNumber, int cellNumber, int cellValue, ICellStyle style)
        {
            var cell = _sheet.GetRow(rowNumber).GetCell(cellNumber);
            cell.CellStyle = style;
            cell.SetCellValue(cellValue);
        }

        public void ChangeCell(int rowNumber, int cellNumber, int cellValue)
        {
            _sheet.GetRow(rowNumber).GetCell(cellNumber).SetCellValue(cellValue);
        }

        public void ChangeCell(int rowNumber, int cellNumber, double cellValue)
        {
            _sheet.GetRow(rowNumber).GetCell(cellNumber).SetCellValue(cellValue);
        }

        public void ChangeCellFormula(int rowNumber, int cellNumber, string formula)
        {
            _sheet.GetRow(rowNumber).GetCell(cellNumber).SetCellFormula(formula);
        }

        public void AddConditionalFormatting(int firstRow, int lastRow, int firstCol, int lastCol, IConditionalFormattingRule[] cfRules)
        {
            ISheetConditionalFormatting sheetCf = _sheet.SheetConditionalFormatting;
            CellRangeAddress[] regions =
            {
                new CellRangeAddress(firstRow, lastRow, firstCol, lastCol)
            };

            sheetCf.AddConditionalFormatting(regions, cfRules);
        }

        public void CopyRange(int firstRowNum, int rowSize, int firstSourceCellNum, int firstDestinationCellNum, int cellSize)
        {
            int lastRowNum = firstRowNum + rowSize;

            for (int i = firstRowNum; i < lastRowNum; i++)
            {
                var sourceRow = _sheet.GetRow(i);
                var sourceCell = sourceRow.GetCell(firstSourceCellNum);
                if (sourceCell == null) continue;

                for (int j = 0; j < cellSize; j++)
                {
                    var newCell = sourceRow.CreateCell(firstDestinationCellNum + j);

                    CopyCell(sourceCell, newCell);
                }
            }
        }

        public void CopyRowRange(int sourceRowNum, int rowSize, int firstDestinationRowNum, bool mergeRegions)
        {
            for (int i = 0; i < rowSize; i++)
            {
                CopyRow(sourceRowNum, firstDestinationRowNum + i, mergeRegions);
            }
        }

        public void CopyRowRange2(int firstSourceRowNum, int lastSourceRowNum, int firstDestinationRowNum, bool mergeRegions)
        {
            for (int i = firstSourceRowNum; i <= lastSourceRowNum; i++)
            {
                CopyRow(i, firstDestinationRowNum, mergeRegions);
                firstDestinationRowNum++;
            }
        }

        /// <summary>
        /// Permite insertar una fila nueva basada en una fila inicial hacia una posición destino
        /// </summary>
        /// <param name="sourceRowNum">Fila origen</param>
        /// <param name="destinationRowNum">Fila Destino</param>
        /// <param name="mergeRegions"></param>
        public void CopyRow(int sourceRowNum, int destinationRowNum, bool mergeRegions = true)
        {
            // Get the source / new row
            IRow newRow = _sheet.GetRow(destinationRowNum);
            IRow sourceRow = _sheet.GetRow(sourceRowNum);

            // If the row exist in destination, push down all rows by 1 else create a new row
            if (newRow != null)
            {
                _sheet.ShiftRows(destinationRowNum, _sheet.LastRowNum, 1);
            }

            newRow = _sheet.CreateRow(destinationRowNum);


            // Loop through source columns to add to new row
            for (int i = 0; i < sourceRow.LastCellNum; i++)
            {
                // Grab a copy of the old/new cell
                ICell oldCell = sourceRow.GetCell(i);
                ICell newCell = newRow.CreateCell(i);

                // If the old cell is null jump to next cell
                if (oldCell == null)
                {
                    continue;
                }

                CopyCell(oldCell, newCell);
            }

            if (!mergeRegions) return;
            int numMergeRegions = _sheet.NumMergedRegions;
            // If there are are any merged regions in the source row, copy to new row
            for (int i = 0; i < numMergeRegions; i++)
            {
                CellRangeAddress cellRangeAddress = _sheet.GetMergedRegion(i);
                if (cellRangeAddress != null && cellRangeAddress.FirstRow == sourceRow.RowNum)
                {
                    var newCellRangeAddress = new CellRangeAddress(newRow.RowNum,
                        (newRow.RowNum +
                         (cellRangeAddress.LastRow - cellRangeAddress.FirstRow
                         )),
                        cellRangeAddress.FirstColumn,
                        cellRangeAddress.LastColumn);
                    _sheet.AddMergedRegion(newCellRangeAddress);
                }
            }
        }

        public List<int> AddMergedRegion(int firstRow, int lastRow, int[] colNumbers)
        {
            var list =
                colNumbers.Select(colNum => new CellRangeAddress(firstRow, lastRow, colNum, colNum))
                    .Select(newCellRangeAddress => _sheet.AddMergedRegion(newCellRangeAddress) - 1)
                    .ToList();

            return list;
        }

        public int AddMergedRegion(int firstRow, int lastRow, int firstCol, int lastCol)
        {
            var newCellRangeAddress = new CellRangeAddress(firstRow, lastRow, firstCol, lastCol);
            return _sheet.AddMergedRegion(newCellRangeAddress) - 1;
        }

        public void RemoveMergedRegion(List<int> list)
        {
            var listOrder = list.OrderByDescending(p => p).ToList();
            foreach (var index in listOrder)
            {
                _sheet.RemoveMergedRegion(index);
            }
        }

        public void CopyCell(int rowNumber, int sourceCellNum, int destinationCellNum)
        {
            IRow sourceRow = _sheet.GetRow(rowNumber);
            ICell sourceCell = sourceRow.GetCell(sourceCellNum);
            ICell newCell = sourceRow.CreateCell(destinationCellNum);

            CopyCell(sourceCell, newCell);
        }

        public void CopyCell(int rowNumber, int sourceCellNum, int destinationFirstCellNum, int destinationLastCellNum)
        {
            IRow sourceRow = _sheet.GetRow(rowNumber);
            ICell sourceCell = sourceRow.GetCell(sourceCellNum);

            for (int i = destinationFirstCellNum; i <= destinationLastCellNum; i++)
            {
                ICell newCell = sourceRow.CreateCell(i);
                CopyCell(sourceCell, newCell);
            }
        }

        public void RemoveRow(int rowNumber)
        {
            IRow removingRow = _sheet.GetRow(rowNumber);
            if (removingRow != null)
            {
                _sheet.RemoveRow(removingRow);
            }
        }

        public void RemoveCell(int rowNumber, int cellNumber)
        {
            IRow row = _sheet.GetRow(rowNumber);

            ICell removingCell = row?.GetCell(cellNumber);

            if (removingCell != null)
                row.RemoveCell(removingCell);
        }

        public void RemoveCells(int rowNumber, int firstCellNumber, int lastCellNumber)
        {
            IRow row = _sheet.GetRow(rowNumber);

            if (row != null)
            {
                for (int i = firstCellNumber; i <= lastCellNumber; i++)
                {
                    ICell removingCell = row.GetCell(i);

                    if (removingCell != null)
                        row.RemoveCell(removingCell);
                }
            }
        }

        public CellReference[] GetCells(string name)
        {
            var iName = _workBook.GetName(name);
            var area = new AreaReference(iName.RefersToFormula);

            return area.GetAllReferencedCells();
        }

        #endregion

        #region Métodos Privados

        private void CopyCell(ICell sourceCell, ICell destinationCell)
        {
            destinationCell.CellStyle = sourceCell.CellStyle;

            // If there is a cell comment, copy
            if (sourceCell.CellComment != null)
            {
                destinationCell.CellComment = sourceCell.CellComment;
            }

            // If there is a cell hyperlink, copy
            if (sourceCell.Hyperlink != null)
            {
                destinationCell.Hyperlink = sourceCell.Hyperlink;
            }

            // Set the cell data type
            destinationCell.SetCellType(sourceCell.CellType);

            // Set the cell data value
            switch (sourceCell.CellType)
            {
                case CellType.Blank:
                    destinationCell.SetCellValue(sourceCell.StringCellValue);
                    break;
                case CellType.Boolean:
                    destinationCell.SetCellValue(sourceCell.BooleanCellValue);
                    break;
                case CellType.Error:
                    destinationCell.SetCellErrorValue(sourceCell.ErrorCellValue);
                    break;
                case CellType.Formula:
                    destinationCell.SetCellFormula(sourceCell.CellFormula);
                    break;
                case CellType.Numeric:
                    destinationCell.SetCellValue(sourceCell.NumericCellValue);
                    break;
                case CellType.String:
                    destinationCell.SetCellValue(sourceCell.RichStringCellValue);
                    break;
            }
        }

        #endregion
    }
}