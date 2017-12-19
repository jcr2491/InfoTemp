

IF OBJECT_ID('tempdb..#CumplimientoAsistente') IS NOT NULL
BEGIN
	DROP TABLE #CumplimientoAsistente
END


DECLARE @fecha DATETIME = CONVERT(DATETIME,'01/12/2017',103)

SELECT 
	ME.EmpleadoId, ME.Meta,
	(SELECT COUNT(DA.NroPrestamo) FROM [Comisiones].[DataAutomotriz] DA WHERE DA.AsistenteId = ME.EmpleadoId) AS NroCreditos,
	ROUND(((SELECT COUNT(DA.NroPrestamo) FROM [Comisiones].[DataAutomotriz] DA WHERE DA.AsistenteId = ME.EmpleadoId)/ME.Meta),2)*100 AS Cumplimiento
	INTO #CumplimientoAsistente
FROM [Comisiones].[MetaEmpleado] AS ME
WHERE ME.Fecha = @fecha

--SELECT * FROM #CumplimientoAsistente

SELECT DA.*, CA.Cumplimiento FROM [Comisiones].[DataAutomotriz] AS DA INNER JOIN #CumplimientoAsistente AS CA ON DA.AsistenteId = CA.EmpleadoId






