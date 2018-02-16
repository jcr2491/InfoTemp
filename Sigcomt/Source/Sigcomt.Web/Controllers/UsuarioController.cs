using Newtonsoft.Json;
using Sigcomt.Common;
using Sigcomt.Common.DataTable;
using Sigcomt.Web.ApiService;
using Sigcomt.Web.Core;
using Sigcomt.Web.Models;
using Sigcomt.Web.Utilities;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Sigcomt.Web.Controllers
{
    public class UsuarioController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult Listar(DataTableModel<UsuarioFilterModel, int> dataTableModel)
        {
            try
            {
                FormatDataTable(dataTableModel);
                var jsonResponse = new JsonResponse { Success = false };
                jsonResponse = InvokeHelper.MakeRequest(ConstantesWeb.WS_Usuario_GetAllPaging, 
                    new PaginationParameter<int> {
                        AmountRows = dataTableModel.length,
                        WhereFilter = dataTableModel.whereFilter,
                        Start = dataTableModel.start,
                        OrderBy = dataTableModel.orderBy
                    }, ConstantesWeb.METHODPOST);

                var usuarioPaginationModelList  = (List<UsuarioPaginationModel>)JsonConvert.DeserializeObject(jsonResponse.Data.ToString(), (new List<UsuarioPaginationModel>()).GetType());
                dataTableModel.data = usuarioPaginationModelList;
                if (usuarioPaginationModelList.Count > 0)
                {
                    dataTableModel.recordsTotal = usuarioPaginationModelList[0].Cantidad;
                    dataTableModel.recordsFiltered = dataTableModel.recordsTotal;
                }
            }
            catch (Exception ex)
            {
                LogError(ex);

                ViewBag.MessageError = ex.Message;
                dataTableModel.data = new List<UsuarioPaginationModel>();
            }
            return Json(dataTableModel);
        }

        #region Métodos Privados

        public void FormatDataTable(DataTableModel<UsuarioFilterModel, int> dataTableModel)
        {
            for (int i = 0; i < dataTableModel.order.Count; i++)
            {
                var columnIndex = dataTableModel.order[0].column;
                var columnDir = dataTableModel.order[0].dir.ToUpper();
                var column = dataTableModel.columns[columnIndex].data;
                dataTableModel.orderBy = (" [" + column + "] " + columnDir + " ");
            }

            dataTableModel.whereFilter = "WHERE U.Estado IN (1,2)";

            if (dataTableModel.filter.RolIdSearch > 0)
                dataTableModel.whereFilter += (" AND R.Id = " + dataTableModel.filter.RolIdSearch);

            if (!string.IsNullOrWhiteSpace(dataTableModel.filter.UsernameSearch))
                dataTableModel.whereFilter += (" AND U.Username LIKE '%" + dataTableModel.filter.UsernameSearch + "%'");
        }

        #endregion
    }
}