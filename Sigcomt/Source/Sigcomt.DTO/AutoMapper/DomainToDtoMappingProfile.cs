using AutoMapper;
using Sigcomt.Business.Entity;
using System;

namespace Sigcomt.DTO.AutoMapper
{
    public class DomainToDtoMappingProfile : Profile
    {
        public override string ProfileName
        {
            get { return "DomainToDtoMappingProfile"; }
        }
        protected override void Configure()
        {
            Mapper.CreateMap<Usuario, UsuarioLoginDTO>()
               .ForMember(d => d.RolNombre, x => x.MapFrom(p => p.Rol.Nombre));

            Mapper.CreateMap<Usuario, UsuarioDTO>()
                .ForMember(d => d.RolNombre, x => x.MapFrom(p => p.Rol.Nombre));

            Mapper.CreateMap<Rol, RolDTO>();

            Mapper.CreateMap<Cargo, CargoDTO>();


        }
    }
}
