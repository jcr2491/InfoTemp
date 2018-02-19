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
        List<DetalleErrorCarga> GetUltimaCargaPorArchivo(DateTime fecha);
    }
}