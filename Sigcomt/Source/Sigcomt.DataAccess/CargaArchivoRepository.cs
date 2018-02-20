using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Core.Singleton;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;

namespace Sigcomt.DataAccess
{
    public class CargaArchivoRepository : Singleton<CargaArchivoRepository>, ICargaArchivoRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(ConectionStringRepository.ConnectionStringNameSQL);

        #endregion

        #region Métodos Públicos

        public void Add(DataTable dt, string nameTable)
        {
            using (var conexionBulkCopy = new SqlConnection(_database.ConnectionString))
            {
                conexionBulkCopy.Open();
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(_database.ConnectionString))
                {
                    bulkCopy.BulkCopyTimeout = int.MaxValue;
                    bulkCopy.DestinationTableName = $"{ConectionStringRepository.EsquemaName}.{nameTable}";
                    
                    foreach (var column in dt.Columns)
                    {
                        bulkCopy.ColumnMappings.Add(column.ToString(), column.ToString());
                    }

                    bulkCopy.WriteToServer(dt);
                }
            }
        }

        public void AddEmpleadoId(string nombreTabla, string campoComparar, string campoActualizar)
        {
            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.AgregarEmpleadoId"))
            {
                _database.AddInParameter(comando, "@NombreTabla", DbType.String, nombreTabla);
                _database.AddInParameter(comando, "@CampoComparar", DbType.String, campoComparar);
                _database.AddInParameter(comando, "@CampoActualizar", DbType.String, campoActualizar);

                _database.ExecuteNonQuery(comando);
            }
        }

        public void AddGrupoId(string nombreTabla)
        {
            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.AgregarGrupoId"))
            {
                _database.AddInParameter(comando, "@NombreTabla", DbType.String, nombreTabla);

                _database.ExecuteNonQuery(comando);
            }
        }

        public void AddSucursalId(string nombreTabla, string campoComparar, string campoActualizar)
        {
            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.AgregaSucursalId"))
            {
                _database.AddInParameter(comando, "@NombreTabla", DbType.String, nombreTabla);
                _database.AddInParameter(comando, "@CampoComparar", DbType.String, campoComparar);
                _database.AddInParameter(comando, "@CampoActualizar", DbType.String, campoActualizar);

                _database.ExecuteNonQuery(comando);
            }
        }

        public void AddCCFFSucursal(string nombreTabla, string campoComparar, string campoActualizar)
        {
            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.AgregaCCFFSucursal"))
            {
                _database.AddInParameter(comando, "@NombreTabla", DbType.String, nombreTabla);
                _database.AddInParameter(comando, "@CampoComparar", DbType.String, campoComparar);
                _database.AddInParameter(comando, "@CampoActualizar", DbType.String, campoActualizar);

                _database.ExecuteNonQuery(comando);
            }
        }

        public List<DetalleErrorCarga> GetUltimaCargaPorArchivo(DateTime fecha)
        {
            var list = new List<DetalleErrorCarga>();

            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.GetErrorCarga"))
            {
                _database.AddInParameter(comando, "@FechaError", DbType.DateTime, "2018-02-19 12:03:35.627");

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(new DetalleErrorCarga
                        {
                            TipoArchivo = lector.GetString(lector.GetOrdinal("TipoArchivo")),
                           //FechaError = lector.GetDateTime(lector.GetOrdinal("FechaError")),
                            DetalleError = lector.GetString(lector.GetOrdinal("DetalleError")),
                            NumFila = lector.GetInt32(lector.GetOrdinal("NumFila")),
                            PosicionColumna = lector.GetString(lector.GetOrdinal("PosicionColumna")),
                            TipoError = lector.GetString(lector.GetOrdinal("TipoError")),
                            IdTipoArchivo= lector.GetString(lector.GetOrdinal("IdTipoArchivo")),
                            TipoComision = lector.GetString(lector.GetOrdinal("TipoComision")),
                            IdTipoComision = lector.GetInt32(lector.GetOrdinal("IdTipoComisiones")),
                        });
                    }
                }
            }

            return list;
        }

        #endregion
    }
}