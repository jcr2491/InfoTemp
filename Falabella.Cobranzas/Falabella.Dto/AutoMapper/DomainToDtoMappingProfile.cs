using AutoMapper;
using Falabella.Entity;

namespace Falabella.Dto.AutoMapper
{
    public class DomainToDtoMappingProfile : Profile
    {
        public DomainToDtoMappingProfile()
        {
            CreateMap<Usuario, UsuarioDto>()
                .ForMember(p => p.NombreCompleto, q => q.MapFrom(x => x.Nombres + " " + x.Apellidos));
            CreateMap<RangoContencionCierre, RangoContencionCierreDto>();
            CreateMap<ProductoTc, ProductoTcDto>()
                .ForMember(p => p.FechaRegistro, q => q.MapFrom(x => x.FechaRegistro.ToString("dd/MM/yyy hh:mm")));
            CreateMap<HistoricoContencionCierre, HistoricoContencionCierreDto>()
                .ForMember(p => p.Fecha, q => q.MapFrom(x => x.Fecha.ToString("dd/MM/yyy")));
        }
    }
}