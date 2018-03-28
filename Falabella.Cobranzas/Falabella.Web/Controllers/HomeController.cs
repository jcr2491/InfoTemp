using System;
using System.Linq;
using System.Web.Mvc;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Enums;
using Falabella.Dto;
using Falabella.Web.Core;

namespace Falabella.Web.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetUltimaCargaPorArchivo()
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var list = CabeceraCargaBL.GetInstance().GetUltimaCargaPorArchivo().Select(p => new CargaCabeceraDto
                {
                    Id = p.Id,
                    TipoArchivo = p.TipoArchivo,
                    DescripcionTipoArchivo = Enum.GetName(typeof(TipoArchivo), Convert.ToInt32(p.TipoArchivo)),
                    FechaArchivo = p.FechaArchivo.GetDateToString(),
                    FechaCargaIni = p.FechaCargaIni.GetDateTimeToString(),
                    TiempoCarga = p.FechaCargaIni.SubtractDate(p.FechaCargaFin),
                    EstadoCarga = p.EstadoCarga,
                    DescripcionEstadoCarga = Enum.GetName(typeof(EstadoCarga), p.EstadoCarga)
                }).ToList();

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
        public JsonResult GetHistorialCargaPorArchivo(string tipoArchivo)
        {
            var jsonResponse = new JsonResponse { Success = false };

            try
            {
                var list = CabeceraCargaBL.GetInstance().GetHistorialCargaPorArchivo(tipoArchivo).Select(p => new CargaCabeceraDto
                {
                    Id = p.Id,
                    TipoArchivo = p.TipoArchivo,
                    DescripcionTipoArchivo = Enum.GetName(typeof(TipoArchivo), Convert.ToInt32(p.TipoArchivo)),
                    FechaArchivo = p.FechaArchivo.GetDateToString(),
                    FechaCargaIni = p.FechaCargaIni.GetDateTimeToString(),
                    TiempoCarga = p.FechaCargaIni.SubtractDate(p.FechaCargaFin),
                    EstadoCarga = p.EstadoCarga,
                    DescripcionEstadoCarga = Enum.GetName(typeof(EstadoCarga), p.EstadoCarga)
                }).ToList();

                jsonResponse.Data = list;
                jsonResponse.Success = true;
            }
            catch (Exception ex)
            {
                LogError(ex);
            }

            return Json(jsonResponse, JsonRequestBehavior.AllowGet);
        }
    }
}