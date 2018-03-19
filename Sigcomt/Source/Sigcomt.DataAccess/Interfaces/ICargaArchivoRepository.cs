using Sigcomt.Business.Entity;
using System;
using System.Collections.Generic;
using System.Data;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface ICargaArchivoRepository
    {
        void Add(DataTable dt, string nameTable);
        void AddEmpleadoId(string nombreTabla, string campoComparar, string campoActualizar);
        void AddGrupoId(string nombreTabla);
        void AddSucursalId(string nombreTabla, string campoComparar, string campoActualizar);
        void AddCCFFSucursal(string nombreTabla, string campoComparar, string campoActualizar);
        List<DetalleLogCarga> GetLogCarga(DateTime fecha);
        List<TablaColumna> GetColumnasTabla(string tabla);
        List<Archivo> GetArchivosEstado(DateTime fecha);
    }
}