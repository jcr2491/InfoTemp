TRUNCATE TABLE [Comisiones].[CabeceraCarga]
TRUNCATE TABLE [Comisiones].[Productividad]
TRUNCATE TABLE [Comisiones].[SLAUAC]
TRUNCATE TABLE [Comisiones].[DiasAusencia]
TRUNCATE TABLE [Comisiones].[Monitoreo]
TRUNCATE TABLE [Comisiones].[Ponderacion]
TRUNCATE TABLE [Comisiones].[ProductividadEsp]
TRUNCATE TABLE [Comisiones].[ProducContactenos]
TRUNCATE TABLE [Comisiones].[SLAContactenos]


USE Comisiones

EXEC [Comisiones].[LlenarPonderacion]
GO
EXEC [Comisiones].[CargarProducContactenos]
GO
EXEC [Comisiones].[CargarSLAContactenos]
GO



/*  */
INSERT INTO [Comisiones].[ProductividadEsp](
[CargaId],
[EmpleadoId],
[GrupoId],
[SuperId],
[CargoId],
[DiasLaborados],
[CRFactor],
[CRMetaTotal],
[CRCasosCerrados],
[CRCumplimiento],
[CRNota1],
[SLATotal],
[SLANroCasos],
[SLACumplimiento],
[SLANota2],
[KPINota1y2],
[KPISumaPesos],
[KPINota],
[KPIPuntaje],
[CALImpug],
[CALPuntaje]
)
SELECT
	P.CargaId,
	P.[EmpleadoId] EmpleadoId,  
	P.[GrupoId], 	
	P.SupervisorId,
	C.Id AS CargoId,
	30 - D.TotDiasNoLabor AS DiasLaborados,
	(SELECT Porcentaje FROM [Comisiones].[IndicadorMedicion] WHERE IndicadorId='CRE') AS CRFactor,	
	P.[MetaDiaria] * (30 - D.TotDiasNoLabor) AS CRMetaTotal,
	P.[Logro] AS CRCasosCerrados,
	CASE WHEN (30 - D.TotDiasNoLabor)= 0 THEN 0 ELSE (P.[Logro]/ (30 - D.TotDiasNoLabor)) END AS CumplimientoCR,
	(CASE WHEN (30 - D.TotDiasNoLabor)= 0 THEN 0 ELSE (P.[Logro]/ (30 - D.TotDiasNoLabor)) END ) * (SELECT [Porcentaje] FROM [Comisiones].[IndicadorMedicion] WHERE [IndicadorId]='CRE') AS CRNota1,
	(SELECT Porcentaje FROM [Comisiones].[IndicadorMedicion] WHERE IndicadorId='SLA') AS SLAFactor,	
	S.[TotalGeneral] AS SLATotal,
	S.[DentroPlazo] AS SLANroCasos,
	(S.[DentroPlazo])/(S.[TotalGeneral]) AS CumplimientoSLA,
	((S.[DentroPlazo])/(S.[TotalGeneral])) * (SELECT [Porcentaje] FROM [Comisiones].[IndicadorMedicion] WHERE [IndicadorId]='SLA') AS SLANota2,
	ROUND((((CASE WHEN (30 - D.TotDiasNoLabor)= 0 THEN 0 ELSE (P.[Logro]/ (30 - D.TotDiasNoLabor)) END ) * (SELECT [Porcentaje] 
													FROM [Comisiones].[IndicadorMedicion] 
													WHERE [IndicadorId]='CRE')) + ((S.[DentroPlazo]/S.[TotalGeneral]) * 
													(SELECT [Porcentaje] 
													FROM [Comisiones].[IndicadorMedicion] 
													WHERE [IndicadorId]='SLA'))),2) 
	AS KPINota1y2,
	(CASE 
	WHEN S.[TotalGeneral] <> 0  
	THEN (SELECT [Porcentaje] FROM [Comisiones].[IndicadorMedicion] WHERE [IndicadorId]='CRE') ELSE 0 END) + 
	(CASE 
	WHEN P.[MetaDiaria] * (30 - D.TotDiasNoLabor) <> 0 
	THEN (SELECT [Porcentaje] FROM [Comisiones].[IndicadorMedicion] WHERE [IndicadorId]='SLA') ELSE 0 END) 
	AS SumaPesosKPI,
	ROUND((ROUND((((CASE WHEN (30 - D.TotDiasNoLabor)= 0 THEN 0 ELSE (P.[Logro]/ (30 - D.TotDiasNoLabor)) END ) * (SELECT [Porcentaje] 
															FROM [Comisiones].[IndicadorMedicion] 
															WHERE [IndicadorId]='CRE')) + 
															((S.[DentroPlazo]/S.[TotalGeneral]) * 
															(SELECT [Porcentaje] 
															FROM [Comisiones].[IndicadorMedicion] 
															WHERE [IndicadorId]='SLA'))),2) /
	(CASE 
	WHEN S.[TotalGeneral] <> 0  
	THEN (SELECT [Porcentaje] FROM [Comisiones].[IndicadorMedicion] WHERE [IndicadorId]='CRE') ELSE 0 END) + 
	(CASE 
	WHEN P.[MetaDiaria] * (30 - D.TotDiasNoLabor) <> 0 
	THEN (SELECT [Porcentaje] FROM [Comisiones].[IndicadorMedicion] WHERE [IndicadorId]='SLA') ELSE 0 END)
	),2) AS NotaKPI,	 
	PO.Nota AS CALImpug,
	(SELECT [Puntaje] FROM [Comisiones].[CumplimientoDetalle] WHERE CumplimientoId=1 AND PO.Nota BETWEEN [Inicio] AND [Fin]) AS Puntaje
FROM [Comisiones].[Productividad] AS P 
INNER JOIN [Comisiones].[Ponderacion] AS PO ON P.EmpleadoId = PO.EmpleadoId
LEFT OUTER JOIN [Comisiones].[Empleado] AS SUP ON P.[SupervisorId] = SUP.[Id]
LEFT JOIN [Comisiones].[Empleado] AS E ON P.[EmpleadoId] = E.Id
LEFT JOIN [Comisiones].[Cargo] AS C ON E.[CargoId] = C.[Id]
LEFT JOIN [Comisiones].[DiasAusencia] AS D ON P.[EmpleadoId] = D.[EmpleadoId]
LEFT JOIN [Comisiones].[SLAUAC] AS S ON E.Id = S.EmpleadoId AND P.GrupoId = S.GrupoId
WHERE P.EmpleadoId is not null

UPDATE PE
SET PE.[CREMetaTotal] = (SELECT SUM([CRMetaTotal]) FROM [Comisiones].[ProductividadEsp] WHERE GrupoId = PE.GrupoId  GROUP BY GrupoId)
FROM [Comisiones].[ProductividadEsp] AS PE --INNER JOIN [Comisiones].[ProductividadEsp] AS P ON PE.[CargaId] = P.CargaId AND PE.EmpleadoId = P.EmpleadoId

UPDATE PE
SET PE.[CRECasosCerrados] = (SELECT SUM([CRECasosCerrados]) FROM [Comisiones].[ProductividadEsp] WHERE GrupoId = PE.GrupoId  GROUP BY GrupoId)
FROM [Comisiones].[ProductividadEsp] AS PE --INNER JOIN [Comisiones].[ProductividadEsp] AS P ON PE.[CargaId] = P.CargaId AND PE.EmpleadoId = P.EmpleadoId


UPDATE [Comisiones].[ProductividadEsp] 
SET [CRECumplimiento] = ROUND(([CRECasosCerrados]/[CREMetaTotal]),2)




