using Newtonsoft.Json;
using Sigcomt.ActiveDirectory;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.DTO;
using Sigcomt.DTO.AutoMapper;
using Sigcomt.WebApi.Core;
using System;
using System.Web.Http;
namespace Sigcomt.WebApi.Controllers
{
    public class AccountController: BaseController
    {
        [HttpPost]
        public JsonResponse Login(LoginDTO loginDTO)
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                if (loginDTO.ValidacionAD)
                {
                    UsuarioAD usuarioAD = new UsuarioAD();
                    if (usuarioAD.AutenticarEnDominio(loginDTO.Username, loginDTO.Password))
                    {
                        var usuario = UsuarioBL.GetInstance().GetByUsername(loginDTO.Username);
                        if (usuario != null)
                        {
                            var usuarioLoginDTO = MapperHelper.Map<Usuario, UsuarioLoginDTO>(usuario);
                            jsonResponse.Data = usuarioLoginDTO;

                            LogBL.GetInstance().Add(new Log
                            {
                                Accion = Mensajes.Login,
                                Controlador = Mensajes.AccountController,
                                Identificador = usuarioLoginDTO.Id,
                                Mensaje = Mensajes.AccesoAlSistema,
                                Usuario = usuarioLoginDTO.Username,
                                Objeto = JsonConvert.SerializeObject(usuarioLoginDTO)
                            });
                        }
                        else
                        {
                            jsonResponse.Warning = true;
                            jsonResponse.Message = Mensajes.UsuarioNoExiste;
                        }
                    }else
                    {
                        jsonResponse.Warning = true;
                        jsonResponse.Message = Mensajes.CredencialesDominioIncorrectas;
                    }
                }
                else
                {
                    var usuario = UsuarioBL.GetInstance().GetByUsername(loginDTO.Username);
                    if (usuario != null)
                    {
                        var usuarioLoginDTO = MapperHelper.Map<Usuario, UsuarioLoginDTO>(usuario);
                        jsonResponse.Data = usuarioLoginDTO;

                        LogBL.GetInstance().Add(new Log
                        {
                            Accion = Mensajes.Login,
                            Controlador = Mensajes.AccountController,
                            Identificador = usuarioLoginDTO.Id,
                            Mensaje = Mensajes.AccesoAlSistema,
                            Usuario = usuarioLoginDTO.Username,
                            Objeto = JsonConvert.SerializeObject(usuarioLoginDTO)
                        });
                    }
                    else
                    {
                        jsonResponse.Warning = true;
                        jsonResponse.Message = Mensajes.UsuarioNoExiste;
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Success = false;
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return jsonResponse;
        }
    }
}