using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Core.Singleton;
using Falabella.Data.Core;
using Falabella.Data.Interfaces;
using Falabella.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Falabella.Data
{
    public class CabeceraCargaRepository : Singleton<CabeceraCargaRepository>, ICabeceraCargaRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(Connection.ConnectionStrinName);

        #endregion

        #region Métodos Públicos

        public CabeceraCarga GetCabeceraCargaProcesado(string tipoArchivo, DateTime fecha)
        {
            CabeceraCarga cabecera = null;

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetCabeceraCargaProcesado"))
            {
                _database.AddInParameter(comando, "@TipoArchivo", DbType.String, tipoArchivo);
                _database.AddInParameter(comando, "@FechaArchivo", DbType.DateTime, fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector.Read())
                    {
                        cabecera = new CabeceraCarga
                        {
                            Id = lector.GetInt32(lector.GetOrdinal("Id")),
                            TipoArchivo = lector.GetString(lector.GetOrdinal("TipoArchivo")),
                            FechaArchivo = lector.GetDateTime(lector.GetOrdinal("FechaArchivo")),
                            FechaCargaIni = lector.GetDateTime(lector.GetOrdinal("FechaCargaIni")),
                            FechaCargaFin =
                                lector.IsDBNull(lector.GetOrdinal("FechaCargaFin"))
                                    ? (DateTime?)null
                                    : lector.GetDateTime(lector.GetOrdinal("FechaCargaFin")),
                            EstadoCarga = lector.GetInt32(lector.GetOrdinal("EstadoCarga"))
                        };
                    }
                }
            }

            return cabecera;
        }

        public List<CabeceraCarga> GetUltimaCargaPorArchivo()
        {
            var list = new List<CabeceraCarga>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetUltimaCargaPorArchivo"))
            {
                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(new CabeceraCarga
                        {
                            Id = lector.GetInt32(lector.GetOrdinal("Id")),
                            TipoArchivo = lector.GetString(lector.GetOrdinal("TipoArchivo")),
                            FechaArchivo = lector.GetDateTime(lector.GetOrdinal("FechaArchivo")),
                            FechaCargaIni = lector.GetDateTime(lector.GetOrdinal("FechaCargaIni")),
                            FechaCargaFin =
                                lector.IsDBNull(lector.GetOrdinal("FechaCargaFin"))
                                    ? (DateTime?) null
                                    : lector.GetDateTime(lector.GetOrdinal("FechaCargaFin")),
                            EstadoCarga = lector.GetInt32(lector.GetOrdinal("EstadoCarga"))
                        });
                    }
                }
            }

            return list;
        }

        public List<CabeceraCarga> GetHistorialCargaPorArchivo(string tipoArchivo)
        {
            var list = new List<CabeceraCarga>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetHistorialCargaPorArchivo"))
            {
                _database.AddInParameter(comando, "@TipoArchivo", DbType.String, tipoArchivo);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(new CabeceraCarga
                        {
                            Id = lector.GetInt32(lector.GetOrdinal("Id")),
                            TipoArchivo = lector.GetString(lector.GetOrdinal("TipoArchivo")),
                            FechaArchivo = lector.GetDateTime(lector.GetOrdinal("FechaArchivo")),
                            FechaCargaIni = lector.GetDateTime(lector.GetOrdinal("FechaCargaIni")),
                            FechaCargaFin =
                                lector.IsDBNull(lector.GetOrdinal("FechaCargaFin"))
                                    ? (DateTime?)null
                                    : lector.GetDateTime(lector.GetOrdinal("FechaCargaFin")),
                            EstadoCarga = lector.GetInt32(lector.GetOrdinal("EstadoCarga"))
                        });
                    }
                }
            }

            return list;
        }

        public int Add(CabeceraCarga cabecera)
        {
            int id;

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.AddCabeceraCarga"))
            {
                _database.AddInParameter(comando, "@TipoArchivo", DbType.String, cabecera.TipoArchivo);
                _database.AddInParameter(comando, "@FechaCargaIni", DbType.DateTime, cabecera.FechaCargaIni);
                _database.AddInParameter(comando, "@FechaArchivo", DbType.DateTime, cabecera.FechaArchivo);
                _database.AddInParameter(comando, "@EstadoCarga", DbType.Boolean, cabecera.EstadoCarga);

                id = Convert.ToInt32(_database.ExecuteScalar(comando));
            }

            return id;
        }

        public bool Update(CabeceraCarga cabecera)
        {
            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.UpdateCabeceraCarga"))
            {
                _database.AddInParameter(comando, "@Id", DbType.Int32, cabecera.Id);
                _database.AddInParameter(comando, "@FechaCargaFin", DbType.DateTime, cabecera.FechaCargaFin);
                _database.AddInParameter(comando, "@EstadoCarga", DbType.Int32, cabecera.EstadoCarga);

                _database.ExecuteNonQuery(comando);
            }

            return true;
        }

        public void Add(DataTable dt, string nameTable)
        {
            using (var conexionBulkCopy = new SqlConnection(_database.ConnectionString))
            {
                conexionBulkCopy.Open();
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(_database.ConnectionString))
                {
                    bulkCopy.BulkCopyTimeout = int.MaxValue;
                    bulkCopy.DestinationTableName = $"{Connection.EsquemaName}.{nameTable}";

                    #region Datatable bullcopy

                    foreach (var column in dt.Columns)
                    {
                        bulkCopy.ColumnMappings.Add(column.ToString(), column.ToString());
                    }

                    #endregion

                    bulkCopy.WriteToServer(dt);
                }
            }
        }

        #endregion
    }
}