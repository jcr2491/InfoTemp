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
    public class ItemTablaController : BaseController
    {
        [HttpPost]
        public JsonResponse GetAllByTablaId(ItemTablaDTO itemTablaDTO)
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var itemTablaList = ItemTablaBL.GetInstance().GetAllByTablaId(itemTablaDTO.Id);
                var itemTablaDTOList = MapperHelper.Map<IEnumerable<ItemTabla>, IEnumerable<ItemTablaDTO>>(itemTablaList);
                jsonResponse.Data = itemTablaDTOList;
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