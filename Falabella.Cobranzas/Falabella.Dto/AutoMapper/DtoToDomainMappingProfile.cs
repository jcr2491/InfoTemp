using AutoMapper;
using Falabella.Entity;

namespace Falabella.Dto.AutoMapper
{
    public class DtoToDomainMappingProfile : Profile
    {
        public DtoToDomainMappingProfile()
        {
            CreateMap<LogInDto, Usuario>();
            CreateMap<HistoricoContencionCierreDto, HistoricoContencionCierre>();
        }
    }
}