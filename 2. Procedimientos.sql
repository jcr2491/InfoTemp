CREATE PROCEDURE [Comisiones].[AddCabeceraCarga]
	@TipoArchivo CHAR(2),
	@FechaArchivo DATETIME,
	@FechaCargaIni DATETIME,
	@EstadoCarga INT,
	@FechaModificacionArchivo DATETIME
AS    
BEGIN
	DECLARE @OutputTbl TABLE (Id INT)

	INSERT INTO Comisiones.CabeceraCarga (TipoArchivo, FechaArchivo, FechaModificacionArchivo, FechaCargaIni, EstadoCarga)
	OUTPUT INSERTED.Id INTO @OutputTbl(Id)
	VALUES(@TipoArchivo, @FechaArchivo, @FechaModificacionArchivo, @FechaCargaIni, @EstadoCarga);

	SELECT Id FROM @OutputTbl;
END
GO


CREATE PROCEDURE [Comisiones].[GetCabeceraCargaProcesado]
	@TipoArchivo CHAR(2),
	@FechaArchivo DATETIME
AS    
BEGIN
	SELECT TOP 1
		Id,
		TipoArchivo,
		FechaArchivo,
		FechaModificacionArchivo,
		FechaCargaIni,
		FechaCargaFin,
		EstadoCarga		
	FROM Comisiones.CabeceraCarga	
	WHERE TipoArchivo = @TipoArchivo 
		AND FechaArchivo = @FechaArchivo
		AND EstadoCarga = 1
END
GO

CREATE PROCEDURE [Comisiones].[UpdateCabeceraCarga]
	@Id INT,
	@FechaCargaFin DATETIME,
	@EstadoCarga INT
AS    
BEGIN
	DECLARE @FechaArchivo DATETIME
	DECLARE @TipoArchivo VARCHAR(2)

	--Actualizamos solo si el estado es Procesado = 1
	IF(@EstadoCarga = 1)
	BEGIN
		SELECT @FechaArchivo = FechaArchivo, @TipoArchivo = TipoArchivo 
		FROM Comisiones.CabeceraCarga 
		WHERE Id = @Id

		--Actualizamos el estado a Regularizado = 3 para los registros anteriores
		UPDATE Comisiones.CabeceraCarga SET EstadoCarga = 3
		WHERE FechaArchivo = @FechaArchivo
			AND TipoArchivo = @TipoArchivo
			AND EstadoCarga = 1
	END
	
	--Actualizamos el estado de la carga actual
	UPDATE Comisiones.CabeceraCarga
	SET EstadoCarga = @EstadoCarga, FechaCargaFin = @FechaCargaFin
	WHERE Id = @Id
END
GO

CREATE PROCEDURE [Comisiones].[GetExcel]
AS
BEGIN
	SELECT
		e.Id,
		e.Nombre NombreExcel,
		e.Ruta,
		eh.TipoArchivo,
		eh.FilaIni,
		eh.NombreHoja,
		ehc.NombreCampo,
		ehc.PosicionColumna
	FROM Comisiones.Excel e
	INNER JOIN Comisiones.ExcelHoja eh ON eh.ExcelId = e.Id
	INNER JOIN Comisiones.ExcelHojaCampo ehc ON ehc.ExcelId = e.Id and eh.TipoArchivo = ehc.TipoArchivo
END
GO

/***
	Descripción: Agrega "Id" del empleado a la tabla pasada por parametro
	Parámetros:  - @NombreTabla, nombre de la tabla actualizar
				 - @CampoComparar, nombre del campo a comparar con el nombre del empleado
				 - @CampoActualizar, nombre del campo actualizar
***/
CREATE PROCEDURE [Comisiones].[AgregarEmpleadoId]
	@NombreTabla VARCHAR(20),
	@CampoComparar VARCHAR(20),
	@CampoActualizar VARCHAR(20)
AS
BEGIN
	DECLARE @query NVARCHAR(300);

	SET @query =
		N'UPDATE t
		SET t.' + @CampoActualizar + ' = e.Id
		FROM Comisiones.' + @NombreTabla + ' t
			LEFT JOIN Comisiones.Homologacion h ON h.Nombre = t.' + @CampoComparar + '
			LEFT JOIN Comisiones.Empleado e ON e.Codigo = h.Codigo
		WHERE t.' + @CampoActualizar + ' IS NULL'

	EXEC (@query);
END
GO

/***
	Descripción: Agrega "Id" del grupo a la tabla pasada por parametro
	Parámetros:  - @NombreTabla, nombre de la tabla actualizar
***/
CREATE PROCEDURE [Comisiones].[AgregarGrupoId]
	@NombreTabla VARCHAR(20)
AS
BEGIN
	DECLARE @query NVARCHAR(300);

	SET @query =
		N'UPDATE t
		SET GrupoId = g.Id
		FROM Comisiones.' + @NombreTabla + ' t
			LEFT JOIN Comisiones.Grupo g ON g.Nombre = t.Grupo
		WHERE t.GrupoId IS NULL'

	EXEC (@query);
END
GO