using Microsoft.Practices.EnterpriseLibrary.Data;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Core.Singleton;
using Sigcomt.Common;
namespace Sigcomt.DataAccess
{
    public class MPonderacionRepository : Singleton<MPonderacionRepository>, IMPonderacionRepository<MPonderacion, int>
    {
        private readonly Database _database = new DatabaseProviderFactory().Create(ConectionStringRepository.ConnectionStringNameSQL);
        public IList<MPonderacion> GetAll(PaginationParameter<int> paginationParameter)
        {
            List<MPonderacion> mponderacion = new List<MPonderacion>();
            //using (var comando = _database.GetStoredProcCommand(string.Format("{0}{1}", ConectionStringRepository.EsquemaName, "CargoGetAllFilter")))
            //{
            //    _database.AddInParameter(comando, "@WhereFilters", DbType.String, paginationParameter.WhereFilter);
            //    using (var lector = _database.ExecuteReader(comando))
            //    {
            //        if (lector != null)
            //        {
            //            while (lector.Read())
            //            {
            //                mponderacion.Add(new MPonderacion
            //                {
            //                    Id = lector.IsDBNull(lector.GetOrdinal("Id")) ? default(int) : lector.GetInt32(lector.GetOrdinal("Id")),
            //                    Nombre = lector.IsDBNull(lector.GetOrdinal("Nombre")) ? default(string) : lector.GetString(lector.GetOrdinal("Nombre")),
            //                    Descripcion = lector.IsDBNull(lector.GetOrdinal("Descripcion")) ? default(string) : lector.GetString(lector.GetOrdinal("Descripcion")),
            //                    Estado = lector.IsDBNull(lector.GetOrdinal("Estado")) ? default(int) : lector.GetInt32(lector.GetOrdinal("Estado"))
            //                });
            //            }
            //        }
            //    }
            //}
            return mponderacion;
        }

        public IList<MPonderacion> GetById(int Id)
        {
            List<MPonderacion> mponderacion = new List<MPonderacion>();
            //using (var comando = _database.GetStoredProcCommand(string.Format("{0}{1}"), ConectionStringRepository.EsquemaName, "CargoGetById"))
            //{
            //    _database.AddInParameter(comando, "@Id", DbType.Int32, Id);
            //    using (var lector = _database.ExecuteReader(comando))
            //    {
            //        if (lector != null)
            //        {
            //            while (lector.Read())
            //            {
            //                mponderacion.Add(new MPonderacion
            //                {
            //                    Id = lector.IsDBNull(lector.GetOrdinal("Id")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("Id")),
            //                    Nombre = lector.IsDBNull(lector.GetOrdinal("Nombre")) ? default(String) : lector.GetString(lector.GetOrdinal("Nombre")),
            //                    Descripcion = lector.IsDBNull(lector.GetOrdinal("Descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("Descripcion")),
            //                    Estado = lector.IsDBNull(lector.GetOrdinal("Estado")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("Estado"))
            //                });
            //            }
            //        }
            //    }
            //}
            return mponderacion;
        }
    }
}