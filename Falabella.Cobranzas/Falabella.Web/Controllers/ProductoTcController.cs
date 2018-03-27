using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.Dto;
using Falabella.Dto.AutoMapper;
using Falabella.Entity;
using Falabella.Resources;
using Falabella.Web.Core;

namespace Falabella.Web.Controllers
{
    public class ProductoTcController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult Listar()
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var list = ProductoTcBL.GetInstance().GetProductos();

                jsonResponse.Data = MapperHelper.Map<List<ProductoTc>, List<ProductoTcDto>>(list);
                jsonResponse.Success = true;
            }
            catch (Exception ex)
            {
                LogError(ex);
            }

            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Agregar(int codigo)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                ProductoTcBL.GetInstance().Add(codigo);
                
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
        public JsonResult Eliminar(int id)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                ProductoTcBL.GetInstance().Delete(id);
                jsonResponse.Success = true;
                jsonResponse.Message = General.DatosEliminados;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Message = General.ErrorEliminar;
            }

            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }
    }
}