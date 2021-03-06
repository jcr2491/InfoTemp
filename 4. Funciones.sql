/***
	Descripción: Retorna las columnas (resultado , meta) por cada kpi
	Parámetros:  
		- @TipoArchivo, Tipo de archivo (Ej. Productividad => 1)
***/
CREATE FUNCTION Comisiones.GetColumnasKpi 
(
	@TipoArchivo VARCHAR(2)
)
RETURNS VARCHAR(100)
AS  
BEGIN
	DECLARE @Columnas NVARCHAR(100);

	SET @Columnas = 
		STUFF(
			(SELECT
				CONCAT(', ', ck.KpiId),
				', ' + QUOTENAME(ca.NombreCampo),
				', ' + QUOTENAME(cm.NombreCampo)		
			FROM Comisiones.ColumnaKpi ck
				INNER JOIN Comisiones.Kpi k ON k.Id = ck.KpiId
				INNER JOIN Comisiones.ExcelHojaCampo ca ON ca.Id = ck.ExcelHojaCampoResultado
				INNER JOIN Comisiones.ExcelHojaCampo cm ON cm.Id = ck.ExcelHojaCampoMeta
			WHERE k.TipoArchivo = @TipoArchivo
			FOR XML PATH('')),
		1,2,'')

	RETURN @Columnas;
END

/***
	Descripción: Retorna el query que permite seleccionar e insertar en una tabla los valores para las columnas del kpi
	Parámetros: 
		- @TablaSelect, Nombre de la tabla de donde se tomaran los datos
		- @TablaInsert, Nombre de la tabla donde se insertaran los datos
		- @Fecha, Fecha del reporte
		- @TipoArchivo, Tipo de archivo (Ej. Productividad => 1)
		- @ColumnasExtra, Columnas que se desean adicionar de la tabla en consulta (si no se desea nada, se coloca '')
***/
CREATE FUNCTION Comisiones.GetQueryKpi 
(
	@TablaSelect VARCHAR(15),
	@TablaInsert VARCHAR(15),
	@Fecha DATE, @TipoArchivo VARCHAR(2),
	@ColumnasExtra VARCHAR(100)
)
RETURNS VARCHAR(500)
AS
BEGIN
	
	DECLARE @Query NVARCHAR(500)

	SET @Query =
		N'INSERT INTO ' + @TablaInsert + ' (CargaId, Secuencia, KpiId, Meta, Obtenido, ' + @ColumnasExtra + ')
		SELECT 
			t.CargaId,
			t.Secuencia,' +			
			Comisiones.GetColumnasKpi(@TipoArchivo) + CASE WHEN @ColumnasExtra <> '' THEN ', ' ELSE '' END +
			@ColumnasExtra + '
		FROM Comisiones.' + @TablaSelect + ' t
			INNER JOIN Comisiones.CabeceraCarga cc ON cc.Id = t.CargaId
		WHERE cc.EstadoCarga = 1
			AND cc.FechaArchivo = ''' + CAST(@Fecha AS VARCHAR(10)) + '''
			AND cc.TipoArchivo = ''' + @TipoArchivo + ''''

	RETURN @Query;
END