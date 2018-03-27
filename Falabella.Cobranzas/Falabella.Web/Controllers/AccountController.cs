using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Mvc;
using Falabella.Business;
using Falabella.CrossCutting.ActiveDirectory;
using Falabella.Dto;
using Falabella.Dto.AutoMapper;
using Falabella.Entity;
using Falabella.Web.Core;
using Falabella.Web.Helpers;

namespace Falabella.Web.Controllers
{
    public class AccountController : BaseController
    {
        #region Métodos Públicos

        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LogInDto model, string returnUrl)
        {
            try
            {
                string validarAd = ConfigurationManager.AppSettings["ValidarAD"] ?? "0";
                bool existe = validarAd != "1" || ActiveDirectory.ExistsUserInDirectory(model.UserName, model.Password);

                if (existe)
                {
                    var usuario = UsuarioBL.GetInstance().GetByUsername(model.UserName);

                    if (usuario == null)
                    {
                        ViewBag.MessageError = Resources.Usuario.UsuarioNoRegistrado;
                    }
                    else
                    {
                        var usuarioDto = MapperHelper.Map<Usuario, UsuarioDto>(usuario);
                        GenerarTickectAutenticacion(usuarioDto);

                        return RedirectToAction("Index", "Home");
                    }
                }
                else
                {
                    ViewBag.MessageError = Resources.Usuario.CredencialesDominioIncorrectas;
                }

            }
            catch (Exception ex)
            {
                LogError(ex);
                ViewBag.MessageError = Resources.General.IntenteNuevamente;
            }
            return View(model);
        }

        public ActionResult LogOut()
        {
            LimpiarAutenticacion();

            return RedirectToAction("Login");
        }

        #endregion

        #region Métodos Privados

        private void GenerarTickectAutenticacion(UsuarioDto usuario)
        {
            AuthenticationHelper.CreateAuthenticationTicket(usuario.Username);
            WebSession.Usuario = usuario;
            //WebSession.Formularios = _formularioAppService.GetByUsuario(usuario.Id);
        }

        private void LimpiarAutenticacion()
        {
            AuthenticationHelper.SignOut();

            WebSession.Usuario = null;
            WebSession.Formularios = new List<FormularioDto>();
        }

        #endregion
    }
}