using Newtonsoft.Json;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.DTO;
using Sigcomt.DTO.AutoMapper;
using Sigcomt.WebApi.Core;
using System;
using System.Collections.Generic;
using System.Web.Http;

namespace Sigcomt.WebApi.Controllers
{
    public class UsuarioController : BaseController
    {
        [HttpPost]
        public JsonResponse Add(UsuarioDTO usuarioDTO)
        {
            var jsonResponse = new JsonResponse { Success = true };            
            try
            {
                int resultado = 0;
                var usuario = MapperHelper.Map<UsuarioDTO, Usuario>(usuarioDTO);

                if (!UsuarioBL.GetInstance().Exists(usuario))
                {
                    resultado = UsuarioBL.GetInstance().Add(usuario);

                    if (resultado > 0)
                    {
                        jsonResponse.Title = Title.TitleRegistro;
                        jsonResponse.Message = Mensajes.RegistroSatisfactorio;
                    }
                    else
                    {
                        jsonResponse.Title = Title.TitleAlerta;
                        jsonResponse.Warning = true;
                        jsonResponse.Message = Mensajes.RegistroFallido;
                    }
                }
                else
                {
                    jsonResponse.Title = Title.TitleAlerta;
                    jsonResponse.Warning = true;
                    jsonResponse.Message = Mensajes.YaExisteRegistro;
                }

                LogBL.GetInstance().Add(new Log
                {
                    Accion = Mensajes.Add,
                    Controlador = Mensajes.UsuarioController,
                    Identificador = resultado,
                    Mensaje = jsonResponse.Message,
                    Usuario = usuarioDTO.UsuarioRegistro,
                    //Objeto = JsonConvert.SerializeObject(usuarioDTO)
                });
            }
           catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Success = false;
                jsonResponse.Title = Title.TitleAlerta;
                jsonResponse.Message = Mensajes.IntenteloMasTarde;

                LogBL.GetInstance().Add(new Log
                {
                    Accion = Mensajes.Add,
                    Controlador = Mensajes.UsuarioController,
                    Identificador = 0,
                    Mensaje = ex.Message,
                    Usuario = usuarioDTO.UsuarioRegistro,
                    //Objeto = JsonConvert.SerializeObject(usuarioDTO)
                });
            }

            return jsonResponse;
        }

        [HttpPost]
        public JsonResponse Delete(UsuarioDTO usuarioDTO)
        {
            var jsonResponse = new JsonResponse { Success = true };
            try
            {
                var usuario = MapperHelper.Map<UsuarioDTO, Usuario>(usuarioDTO);
                int resultado = UsuarioBL.GetInstance().Delete(usuario);

                if (resultado > 0)
                {
                    jsonResponse.Title = Title.TitleEliminar;
                    jsonResponse.Message = Mensajes.EliminacionSatisfactoria;
                }
                else
                {
                    jsonResponse.Title = Title.TitleAlerta;
                    jsonResponse.Warning = true;
                    jsonResponse.Message = Mensajes.EliminacionFallida;
                }

                LogBL.GetInstance().Add(new Log
                {
                    Accion = Mensajes.Delete,
                    Controlador = Mensajes.UsuarioController,
                    Identificador = resultado,
                    Mensaje = jsonResponse.Message,
                    Usuario = usuarioDTO.UsuarioRegistro,
                    //Objeto = JsonConvert.SerializeObject(usuarioDTO)
                });
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Success = false;
                jsonResponse.Title = Title.TitleAlerta;
                jsonResponse.Message = Mensajes.IntenteloMasTarde;

                LogBL.GetInstance().Add(new Log
                {
                    Accion = Mensajes.Delete,
                    Controlador = Mensajes.UsuarioController,
                    Identificador = 0,
                    Mensaje = ex.Message,
                    Usuario = usuarioDTO.UsuarioRegistro,
                    //Objeto = JsonConvert.SerializeObject(usuarioDTO)
                });
            }

            return jsonResponse;
        }

        [HttpPost]
        public JsonResponse GetAllPaging(PaginationParameter<int> paginationParameters)
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var usuarioList = UsuarioBL.GetInstance().GetAllPaging(paginationParameters);
                var usuarioDTOList = MapperHelper.Map<IEnumerable<Usuario>, IEnumerable<UsuarioDTO>>(usuarioList);
                jsonResponse.Data = usuarioDTOList;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Success = false;
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return jsonResponse;
        }

        [HttpPost]
        public JsonResponse GetById(UsuarioDTO usuarioDTO)
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var usuario = MapperHelper.Map<UsuarioDTO, Usuario>(usuarioDTO);
                var usuarioResult = UsuarioBL.GetInstance().GetById(usuario);
                if (usuarioResult != null)
                {
                    usuarioDTO = MapperHelper.Map<Usuario, UsuarioDTO>(usuarioResult);
                    jsonResponse.Data = usuarioDTO;
                }
                else
                {
                    jsonResponse.Warning = true;
                    jsonResponse.Message = Mensajes.UsuarioNoExiste;
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

        [HttpPost]
        public JsonResponse GetByUsername(LoginDTO loginDTO)
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var usuario = UsuarioBL.GetInstance().GetByUsername(loginDTO.Username);
                if (usuario != null)
                {
                    var usuarioLoginDTO = MapperHelper.Map<Usuario, UsuarioLoginDTO>(usuario);
                    jsonResponse.Data = usuarioLoginDTO;
                }
                else
                {
                    jsonResponse.Warning = true;
                    jsonResponse.Message = Mensajes.UsuarioNoExiste;
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

        [HttpPost]
        public JsonResponse Update(UsuarioDTO usuarioDTO)
        {
            var jsonResponse = new JsonResponse { Success = true };
            try
            {
                var usuario = MapperHelper.Map<UsuarioDTO, Usuario>(usuarioDTO);
                int resultado = UsuarioBL.GetInstance().Update(usuario);

                if (resultado > 0)
                {
                    jsonResponse.Title = Title.TitleActualizar;
                    jsonResponse.Message = Mensajes.ActualizacionSatisfactoria;
                }
                if (resultado==0)
                {
                    jsonResponse.Title = Title.TitleAlerta;
                    jsonResponse.Warning = true;
                    jsonResponse.Message = Mensajes.ActualizacionFallida;
                }
                if (resultado==-2)
                {
                    jsonResponse.Title = Title.TitleAlerta;
                    jsonResponse.Warning = true;
                    jsonResponse.Message = Mensajes.YaExisteRegistro;
                }

                LogBL.GetInstance().Add(new Log
                {
                    Accion = Mensajes.Update,
                    Controlador = Mensajes.UsuarioController,
                    Identificador = resultado,
                    Mensaje = jsonResponse.Message,
                    Usuario = usuarioDTO.UsuarioRegistro,
                    //Objeto = JsonConvert.SerializeObject(usuarioDTO)
                });
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Success = false;
                jsonResponse.Title = Title.TitleAlerta;
                jsonResponse.Message = Mensajes.IntenteloMasTarde;

                LogBL.GetInstance().Add(new Log
                {
                    Accion = Mensajes.Update,
                    Controlador = Mensajes.UsuarioController,
                    Identificador = 0,
                    Mensaje = ex.Message,
                    Usuario = usuarioDTO.UsuarioRegistro,
                    //Objeto = JsonConvert.SerializeObject(usuarioDTO)
                });
            }

            return jsonResponse;
        }
    }
}