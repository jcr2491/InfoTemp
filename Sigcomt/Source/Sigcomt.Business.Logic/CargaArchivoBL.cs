using System;
using System.Collections.Generic;
using System.Data;
using Core.Singleton;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.DataAccess;

namespace Sigcomt.Business.Logic
{
    public class CargaArchivoBL : Singleton<CargaArchivoBL>, ICargaArchivoBL
    {
        public void Add(DataTable dt, string nameTable)
        {
            CargaArchivoRepository.GetInstance().Add(dt, nameTable);
        }

        public void AddEmpleadoId(string nombreTabla, string campoComparar, string campoActualizar)
        {
            CargaArchivoRepository.GetInstance().AddEmpleadoId(nombreTabla, campoComparar, campoActualizar);
        }

        public void AddGrupoId(string nombreTabla)
        {
            CargaArchivoRepository.GetInstance().AddGrupoId(nombreTabla);
        }

        public void AddSucursalId(string nombreTabla, string campoComparar, string campoActualizar)
        {
            CargaArchivoRepository.GetInstance().AddSucursalId(nombreTabla, campoComparar, campoActualizar);
        }

        public void AddCCFFSucursal(string nombreTabla, string campoComparar, string campoActualizar)
        {
            CargaArchivoRepository.GetInstance().AddCCFFSucursal(nombreTabla, campoComparar, campoActualizar);
        }

        public List<DetalleLogCarga> GetLogCarga(DateTime fecha)
        {
            return CargaArchivoRepository.GetInstance().GetLogCarga(fecha);
        }

        public List<TablaColumna> GetColumnasTabla(string tabla)
        {
            return CargaArchivoRepository.GetInstance().GetColumnasTabla(tabla);
        }

        public List<Archivo> GetArchivosEstado(DateTime fecha)
        {
            return CargaArchivoRepository.GetInstance().GetArchivosEstado(fecha);
        }
    }
}