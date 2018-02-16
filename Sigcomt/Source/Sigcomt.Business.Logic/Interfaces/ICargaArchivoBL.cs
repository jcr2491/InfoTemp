using System.Data;

namespace Sigcomt.Business.Logic.Interfaces
{
    public interface ICargaArchivoBL
    {
        void Add(DataTable dt, string nameTable);
        void AddEmpleadoId(string nombreTabla, string campoComparar, string campoActualizar);
        void AddGrupoId(string nombreTabla);
    }
}