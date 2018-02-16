using AutoMapper;
using Sigcomt.Business.Entity;
using System;

namespace Sigcomt.DTO.AutoMapper
{
    public class DtoToDomainMappingProfile : Profile
    {
        public override string ProfileName
        {
            get { return "DtoToDomainMappingProfile"; }
        }

        protected override void Configure()
        {
            Mapper.CreateMap<UsuarioDTO, Usuario>()
                .ForMember(p => p.UsuarioModificacion, x => x.Condition(p => p.Id != 0))
                .ForMember(p => p.UsuarioModificacion, x => x.MapFrom(p => p.UsuarioRegistro))
                .ForMember(p => p.UsuarioCreacion, x => x.Condition(p => p.Id == 0))
                .ForMember(p => p.UsuarioCreacion, x => x.MapFrom(p => p.UsuarioRegistro));

            Mapper.CreateMap<ItemTablaDTO, ItemTabla>();

        }
    }
}
