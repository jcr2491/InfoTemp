using System;
using System.Collections.Generic;
using System.Data;
using Core.Singleton;
using Falabella.Business.Interfaces;
using Falabella.Data;
using Falabella.Entity;

namespace Falabella.Business
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

        public void Add(DataTable dt, string nameTable)
        {
            CabeceraCargaRepository.GetInstance().Add(dt, nameTable);
        }
    }
}