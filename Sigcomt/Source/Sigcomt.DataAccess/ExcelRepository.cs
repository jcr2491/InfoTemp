using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Core.Singleton;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;

namespace Sigcomt.DataAccess
{
    public class ExcelRepository : Singleton<ExcelRepository>, IExcelRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(ConectionStringRepository.ConnectionStringNameSQL);

        #endregion

        #region Métodos Públicos

        public List<Excel> GetExcel()
        {
            var list = new List<Excel>();

            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.GetExcel"))
            {
                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    { 
                        int id = lector.GetInt32(lector.GetOrdinal("Id"));
                        string tipoArchivo = lector.GetString(lector.GetOrdinal("TipoArchivo"));
                        Excel excel = list.FirstOrDefault(p => p.Id == id);

                        if (excel == null)
                        {
                            excel = new Excel
                            {
                                Id = id,
                                Nombre = lector.GetString(lector.GetOrdinal("NombreExcel")),
                                Ruta = lector.GetString(lector.GetOrdinal("Ruta")),
                                HojasList = new List<ExcelHoja>()
                            };
                            list.Add(excel);
                        }

                        ExcelHoja excelHoja = excel.HojasList.FirstOrDefault(p => p.TipoArchivo == tipoArchivo);

                        if (excelHoja == null)
                        {
                            excelHoja = new ExcelHoja
                            {
                                Id = lector.GetInt32(lector.GetOrdinal("ExcelHojaId")),
                                ExcelId = id,
                                NombreHoja = lector.GetString(lector.GetOrdinal("NombreHoja")),
                                TipoArchivo = tipoArchivo,
                                FilaIni = lector.GetInt32(lector.GetOrdinal("FilaIni")),
                                CampoList = new List<ExcelHojaCampo>()
                            };
                            excel.HojasList.Add(excelHoja);
                        }

                        excelHoja.CampoList.Add(new ExcelHojaCampo
                        {
                            Id = lector.GetInt32(lector.GetOrdinal("ExcelHojaCampoId")),
                            ExcelHojaId = excelHoja.Id,
                            NombreCampo = lector.GetString(lector.GetOrdinal("NombreCampo")),
                            PosicionColumna = lector.GetString(lector.GetOrdinal("PosicionColumna")),
                            TipoDato = lector.GetString(lector.GetOrdinal("TipoDato")),
                            PermiteNulo = lector.GetBoolean(lector.GetOrdinal("PermiteNulo")),
                            ValorDefecto = lector.GetString(lector.GetOrdinal("ValorDefecto")),
                            ValorIgnorar = lector.GetString(lector.GetOrdinal("ValorDefecto"))
                        });
                    }
                }
            }

            return list;
        }

        public List<CabeceraCarga> GetHistorialCargaPorArchivo(string tipoArchivo)
        {
            var list = new List<CabeceraCarga>();

            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.GetHistorialCargaPorArchivo"))
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

            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.AddCabeceraCarga"))
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
            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.UpdateCabeceraCarga"))
            {
                _database.AddInParameter(comando, "@Id", DbType.Int32, cabecera.Id);
                _database.AddInParameter(comando, "@FechaCargaFin", DbType.DateTime, cabecera.FechaCargaFin);
                _database.AddInParameter(comando, "@EstadoCarga", DbType.Int32, cabecera.EstadoCarga);

                _database.ExecuteNonQuery(comando);
            }

            return true;
        }

        #endregion
    }
}