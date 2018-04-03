using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Core.Singleton;
using Dapper;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;

namespace Sigcomt.DataAccess
{
    public class CabeceraCargaRepository : Singleton<CabeceraCargaRepository>, ICabeceraCargaRepository
    {
        #region Attributos

        private readonly IDbConnection _database = new SqlConnection(ConectionStringRepository.ConnectionStringSql);

        #endregion

        #region Métodos Públicos

        public CabeceraCarga GetCabeceraCargaProcesado(string tipoArchivo, DateTime fecha)
        {
            var cabecera = _database.Query<CabeceraCarga>(
                $"{ConectionStringRepository.EsquemaName}.GetCabeceraCargaProcesado",
                new
                {
                    TipoArchivo = tipoArchivo,
                    FechaArchivo = fecha
                }, commandType: CommandType.StoredProcedure).SingleOrDefault();

            return cabecera;
        }

        public List<CabeceraCarga> GetUltimaCargaPorArchivo()
        {
            var list = _database.Query<CabeceraCarga>(
                $"{ConectionStringRepository.EsquemaName}.GetUltimaCargaPorArchivo",
                commandType: CommandType.StoredProcedure).ToList();

            return list;
        }

        public List<CabeceraCarga> GetHistorialCargaPorArchivo(string tipoArchivo)
        {
            var list = _database.Query<CabeceraCarga>(
                $"{ConectionStringRepository.EsquemaName}.GetHistorialCargaPorArchivo",
                new {TipoArchivo = tipoArchivo}, commandType: CommandType.StoredProcedure).ToList();

            return list;
        }

        public int Add(CabeceraCarga cabecera)
        {
            int id = _database.Query<int>($"{ConectionStringRepository.EsquemaName}.AddCabeceraCarga",
                new
                {
                    cabecera.TipoArchivo,
                    cabecera.FechaCargaIni,
                    cabecera.FechaArchivo,
                    cabecera.EstadoCarga,
                    cabecera.FechaModificacionArchivo
                },
                commandType: CommandType.StoredProcedure).SingleOrDefault();

            return id;
        }

        public bool Update(CabeceraCarga cabecera)
        {
            _database.Query($"{ConectionStringRepository.EsquemaName}.UpdateCabeceraCarga",
                new
                {
                    cabecera.Id,
                    cabecera.FechaCargaFin,
                    cabecera.EstadoCarga
                },
                commandType: CommandType.StoredProcedure);

            return true;
        }

        #endregion
    }
}