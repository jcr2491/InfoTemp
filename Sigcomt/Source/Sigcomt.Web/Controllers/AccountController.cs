using log4net;
using Newtonsoft.Json;
using Sigcomt.Common;
using Sigcomt.Web.ApiService;
using Sigcomt.Web.Core;
using Sigcomt.Web.Models;
using Sigcomt.Web.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Sigcomt.Web.Controllers
{
    public class AccountController: Controller
    {
        private static readonly ILog logger = LogManager.GetLogger(string.Empty);

        [AllowAnonymous]
        public ActionResult Login()
        {
            var modelo = new AccountModel
            {
                Username = "",
                Password = ""
            };
            return View(modelo);
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login(AccountModel accountModel)
        {
            try
            {
                var jsonResponse = new JsonResponse { Success = false };
                accountModel.ValidacionAD = ConfigurationAppSettings.ValidacionAD();
                jsonResponse = InvokeHelper.MakeRequest(ConstantesWeb.WS_Account_Login, accountModel, ConstantesWeb.METHODPOST);

                if (jsonResponse.Success && !jsonResponse.Warning)
                {
                    var usuarioModel = (UsuarioModel)JsonConvert.DeserializeObject(jsonResponse.Data.ToString(), (new UsuarioModel()).GetType());
                    GenerarTickectAutenticacion(usuarioModel);

                    return RedirectToAction(ConstantesWeb.HomeAction, ConstantesWeb.HomeController);
                }
                else if (jsonResponse.Warning)
                {
                    ViewBag.MessageError = jsonResponse.Message;
                }                
            }
            catch (Exception exception)
            {
                logger.Error(string.Format("Mensaje: {0} Trace: {1}", exception.Message, exception.StackTrace));
                ViewBag.MessageError = exception.Message;
            }
            return View(accountModel);
        }

        public ActionResult LogOut()
        {
            LimpiarAutenticacion();

            return RedirectToAction(ConstantesWeb.LoginAction);
        }
        
        [HttpPost]
        public JsonResult VerifySession()
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                HttpSessionStateBase session = HttpContext.Session;
                if (session.Contents[ConstantesWeb.UsuarioSesion] == null)
                {
                    jsonResponse.Title = ConstantesWeb.SesionTerminada;
                    jsonResponse.Warning = true;
                    jsonResponse.Message = ConstantesWeb.SeTerminoLaSession;
                }
            }
            catch (Exception exception)
            {
                logger.Error(string.Format("Mensaje: {0} Trace: {1}", exception.Message, exception.StackTrace));
                jsonResponse.Success = false;
                jsonResponse.Message = ConstantesWeb.IntenteloMasTarde;
            }

            return Json(jsonResponse);
        }

        #region Metodos Privados

        private void GenerarTickectAutenticacion(UsuarioModel usuarioModel)
        {
            usuarioModel.TimeZoneId = ConfigurationAppSettings.TimeZoneId();
            usuarioModel.TimeZoneGMT = ConfigurationAppSettings.TimeZoneGMT();

            AuthenticationHelper.CreateAuthenticationTicket(usuarioModel.Username, usuarioModel.TimeZoneId);

            WebSession.Usuario = usuarioModel;
            WebSession.Formularios = GetFormulario().Where(p=> p.RolId == usuarioModel.RolId);
        }

        private void LimpiarAutenticacion()
        {
            AuthenticationHelper.SignOut();

            WebSession.Usuario = null;
            WebSession.Formularios = new List<FormularioModel>();
        }

        private IList<FormularioModel> GetFormulario()
        {
            return new List<FormularioModel>
            {
                new FormularioModel { Id = 1,  Direccion = "//Home/Index", Orden = 1, RolId = 1, Nombre = "Home"  },
                new FormularioModel { Id = 2,  Direccion = "//Usuario/Index", Orden = 2, RolId = 1, Nombre = "Usuario"  },                                               
                                               
                new FormularioModel { Id = 5,  Direccion = "//Home/Index", Orden = 1, RolId = 3, Nombre = "Home"  }

            };
        }

        #endregion
    }
}