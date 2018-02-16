using System;
using System.Collections.Generic;
using Core.Singleton;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.DataAccess;

namespace Sigcomt.Business.Logic
{
    public class CabeceraCargaBL : Singleton<CabeceraCargaBL>, ICabeceraCargaBL
    {
        public CabeceraCarga GetCabeceraCargaProcesado(string tipoArchivo, DateTime fecha)
        {
            return CabeceraCargaRepository.GetInstance().GetCabeceraCargaProcesado(tipoArchivo, fecha);
        }

        public List<CabeceraCarga> GetUltimaCargaPorArchivo()
        {
            return CabeceraCargaRepository.GetInstance().GetUltimaCargaPorArchivo();
        }

        public List<CabeceraCarga> GetHistorialCargaPorArchivo(string tipoArchivo)
        {
            return CabeceraCargaRepository.GetInstance().GetHistorialCargaPorArchivo(tipoArchivo);
        }

        public int Add(CabeceraCarga cabecera)
        {
            return CabeceraCargaRepository.GetInstance().Add(cabecera);
        }

        public bool Update(CabeceraCarga cabecera)
        {
            return CabeceraCargaRepository.GetInstance().Update(cabecera);
        }
    }
}