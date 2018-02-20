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
		eh.Id ExcelHojaId,
		eh.TipoArchivo,
		eh.FilaIni,
		eh.NombreHoja,
		ehc.Id ExcelHojaCampoId,
		ehc.NombreCampo,
		ehc.PosicionColumna,
		ehc.TipoDato,
		ISNULL(ehc.PermiteNulo, 1) PermiteNulo,
		ehc.ValorDefecto,
		ehc.ValorIgnorar
	FROM Comisiones.Excel e
	INNER JOIN Comisiones.ExcelHoja eh ON eh.ExcelId = e.Id
	INNER JOIN Comisiones.ExcelHojaCampo ehc ON ehc.ExcelHojaId = eh.Id
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

---=====================REPORTE FINAL SAGA RAPICASH==============================
/***
	Descripción: Reporte final de SAGA RAPICASH
	Parámetros:  SIN PARAMETROS
***/

CREATE PROC [Comisiones].[ReporteFinalSagaRapicash]
AS
BEGIN
IF  object_id('#DetalleSFRapicash')>0
				BEGIN
					DROP TABLE #DetalleSFRapicash
				END

 ELSE
				BEGIN
				 SELECT
							dsf.CargaId,
							dsf.Secuencia,
							dsf.SucursalId,
							dsf.Sucursal,
							dsf.CodCajero,
							dsf.Cajero,
							dsf.Total,
							(CASE WHEN dsf.Total >= 5000 or dsf.Total >= 2500 THEN 'EMP'
								  WHEN dsf.Total<=2500  THEN 'PRT'
 								 END) PLLA,
							(CASE WHEN dsf.CodCajero>=1000000 THEN 'ID' ELSE 'NO ID' END) AS IDCAJERO,
							(CASE WHEN 
									 (CASE WHEN dsf.Total >= 5000 or dsf.Total >= 2500 THEN 'EMP'END)='EMP' THEN 5000
								  WHEN
									 (CASE WHEN dsf.Total<=2500 THEN 'PRT' END)='PRT' THEN 	2500  
								  END) AS CUMPLEINDIVIDUAL,

							(CASE WHEN 
									 (CASE WHEN dsf.Total<=2500 THEN 'PRT' END)='PRT' AND dsf.Total>=2500 THEN 'OK'
								  WHEN 
									  (CASE WHEN dsf.Total >= 5000 or dsf.Total >= 2500 THEN 'EMP' END)='EMP' AND dsf.Total>=5000 THEN 'OK'
								  ELSE 'NO'
								  END) ASCUMPLIOCONDIC,

							(dsf.Total*100) /(convert(int, ((CASE WHEN 
									 (CASE WHEN dsf.Total >= 5000 or dsf.Total >= 2500 THEN 'EMP'END)='EMP' THEN 5000
								  WHEN
									 (CASE WHEN dsf.Total<=2500 THEN 'PRT' END)='PRT' THEN 	2500  
								  END)))) AS LOGROIND,

							  CONVERT(DECIMAL(9,2), (CASE WHEN 
								(CASE WHEN 
									 (CASE WHEN dsf.Total<=2500 THEN 'PRT' END)='PRT' AND dsf.Total>=2500 THEN 'OK'
								  WHEN 
									  (CASE WHEN dsf.Total >= 5000 or dsf.Total >= 2500 THEN 'EMP' END)='EMP' AND dsf.Total>=5000 THEN 'OK'
								  ELSE 'NO'
								  END)='OK' THEN dsf.Total*0.2/100
								  ELSE dsf.Total*0.0
							END)) AS LIMITEAPROX,
							REPLACE(CONVERT(DECIMAL(9,2), (CASE WHEN 
								(CASE WHEN 
									 (CASE WHEN dsf.Total<=2500 THEN 'PRT' END)='PRT' AND dsf.Total>=2500 THEN 'OK'
								  WHEN 
									  (CASE WHEN dsf.Total >= 5000 or dsf.Total >= 2500 THEN 'EMP' END)='EMP' AND dsf.Total>=5000 THEN 'OK'
								  ELSE 'NO'
								  END)='OK' THEN dsf.Total*0.2/100
								  ELSE dsf.Total*0.0
							END)),0.00,'-') AS MONTOAPROXFECHA into  #DetalleSFRapicash
							FROM Comisiones.DetalleSagaRapicash dsf
							--where  dsf.Sucursal='SF HUANCAYO' --AND dsf.Total >= 5000 or dsf.Total >= 2500


							--truncate table #DetalleSFRapicash
							--select*From #DetalleSFRapicash
							--==============================REPORTE FINAL DE SAGA FALABELLA RAPICASH==========================

							SELECT 
							RSF.CargaId,
							RSF.Secuencia,
							RSF.SucursalId,
							RSF.Sucursal,
							RSF.Meta,
							RSF.VentaReal,
							(RSF.Cumplimiento*100) as Cumplimiento,
							SUM(CONVERT(DEC(9,2),REPLACE(DSF.MONTOAPROXFECHA,'-',0))) AS PremioCajero,
							ROUND(CONVERT(DEC(9,2),(CASE WHEN (RSF.Cumplimiento*100)>=100 THEN (RSF.VentaReal/100)*0.05 else 0.00 END)),4,1) AS ComisionParaSupervisor,
							CONVERT(DEC(9,1),(1 * ROUND(CONVERT(DEC(9,2),(CASE WHEN (RSF.Cumplimiento*100)>=100 THEN (RSF.VentaReal/100)*0.05 else 0.00 END)),4,1))) AS PremioTotalSupervisor,
							ROUND(CONVERT(DEC(9,2),(CASE WHEN (RSF.Cumplimiento*100)>=100 THEN (RSF.VentaReal/100)*0.07 else 0.00 END)),4,1) AS ComisionParaGerente,
							CONVERT(int,(0 + CONVERT(DEC(9,2),(1 * ROUND(CONVERT(DEC(9,2),(CASE WHEN (RSF.Cumplimiento*100)>=100 THEN (RSF.VentaReal/100)*0.05 else 0 END)),4,1))+
							CONVERT(DEC(9,2),ROUND(CONVERT(DEC(9,2),(CASE WHEN (RSF.Cumplimiento*100)>=100 THEN (RSF.VentaReal/100)*0.07 else 0 END)),4,1))))) AS TotalPremios,

							CONVERT(DEC(9,1),
							CONVERT(DEC(9,1),(0 + CONVERT(DEC(9,2),(1 * ROUND(CONVERT(DEC(9,2),(CASE WHEN (RSF.Cumplimiento*100)>=100 THEN (RSF.VentaReal/100)*0.05 else 0 END)),4,1))+
							CONVERT(DEC(9,2),ROUND(CONVERT(DEC(9,2),(CASE WHEN (RSF.Cumplimiento*100)>=100 THEN (RSF.VentaReal/100)*0.07 else 0 END)),4,1)))))*1.08
							) AS TotalPremiosMasCostoTransf,

							CONVERT(DEC(9,1),CONVERT(DEC(9,1),
							CONVERT(DEC(9,1),(0 + CONVERT(DEC(9,2),(1 * ROUND(CONVERT(DEC(9,2),(CASE WHEN (RSF.Cumplimiento*100)>=100 THEN (RSF.VentaReal/100)*0.05 else 0 END)),4,1))+
							CONVERT(DEC(9,2),ROUND(CONVERT(DEC(9,2),(CASE WHEN (RSF.Cumplimiento*100)>=100 THEN (RSF.VentaReal/100)*0.07 else 0 END)),4,1)))))*1.08
							)*1.18) AS TotalPremiosFinal

							FROM Comisiones.ResumenSagaRapicash RSF
							LEFT JOIN #DetalleSFRapicash DSF
							ON RSF.Sucursal=DSF.Sucursal
							group by 
							RSF.CargaId,
							RSF.Secuencia,
							RSF.SucursalId,
							RSF.Sucursal,
							RSF.Meta,
							RSF.VentaReal,
							RSF.Cumplimiento,
							DSF.MONTOAPROXFECHA
							
				END
END
GO

--==============================REPORTE FINAL TOTTUS RAPICASH===================================
/***
	Descripción: Reporte final de TOTTUS RAPICASH
	Parámetros:  SIN PARAMETROS
***/
CREATE PROC [Comisiones].[ReporteFinalTottusRapicash]
AS
BEGIN
IF  OBJECT_ID('#PLANILLATottus')>0 AND OBJECT_ID('#DetalleTottusRapicash')>0
				BEGIN
					DROP TABLE #PLANILLATottus
					DROP TABLE #DetalleTottusRapicash

				END
ELSE
       BEGIN
					SELECT
						dTt.CargaId,
						dTt.Secuencia,
						dTt.Sucursal,
						dTt.CodCajero,
						dTt.Cajero,
						dTt.Total,
						(CASE WHEN dTt.Total >= 5000 or dTt.Total >= 2500 THEN 'EMP'
							  WHEN dTt.Total<=2500  THEN 'PRT'
 							 END) PLLA,
						(CASE WHEN dTt.CodCajero>=1000000 THEN 'ID' ELSE 'NO ID' END) AS IDCAJERO,
						(CASE WHEN 
								 (CASE WHEN dTt.Total >= 5000 or dTt.Total >= 2500 THEN 'EMP'END)='EMP' THEN 5000
							  WHEN
								 (CASE WHEN dTt.Total<=2500 THEN 'PRT' END)='PRT' THEN 	2500  
							  END) AS CUMPLEINDIVIDUAL,

						(CASE WHEN 
								 (CASE WHEN dTt.Total<=2500 THEN 'PRT' END)='PRT' AND dTt.Total>=2500 THEN 'OK'
							  WHEN 
								  (CASE WHEN dTt.Total >= 5000 or dTt.Total >= 2500 THEN 'EMP' END)='EMP' AND dTt.Total>=5000 THEN 'OK'
							  ELSE 'NO'
							  END) ASCUMPLIOCONDIC,

						 CONVERT(INT, (dTt.Total*100) /(convert(int, ((CASE WHEN 
								 (CASE WHEN dTt.Total >= 5000 or dTt.Total >= 2500 THEN 'EMP'END)='EMP' THEN 5000
							  WHEN
								 (CASE WHEN dTt.Total<=2500 THEN 'PRT' END)='PRT' THEN 	2500  
							  END))))) AS LOGROIND,

						  CONVERT(DECIMAL(9,2), (CASE WHEN 
							(CASE WHEN 
								 (CASE WHEN dTt.Total<=2500 THEN 'PRT' END)='PRT' AND dTt.Total>=2500 THEN 'OK'
							  WHEN 
								  (CASE WHEN dTt.Total >= 5000 or dTt.Total >= 2500 THEN 'EMP' END)='EMP' AND dTt.Total>=5000 THEN 'OK'
							  ELSE 'NO'
							  END)='OK' THEN dTt.Total*0.2/100
							  ELSE dTt.Total*0.0
						END)) AS LIMITEAPROX,

						REPLACE(CONVERT(DECIMAL(9,2), (CASE WHEN 
							(CASE WHEN 
								 (CASE WHEN dTt.Total<=2500 THEN 'PRT' END)='PRT' AND dTt.Total>=2500 THEN 'OK'
							  WHEN 
								  (CASE WHEN dTt.Total >= 5000 or dTt.Total >= 2500 THEN 'EMP' END)='EMP' AND dTt.Total>=5000 THEN 'OK'
							  ELSE 'NO'
							  END)='OK' THEN dTt.Total*0.2/100
							  ELSE dTt.Total*0.0
						END)),0.00,'-') AS MONTOAPROXFECHA into  #DetalleTottusRapicash
						FROM Comisiones.DetalleTottusRapicash dTt
						--WHERE Sucursal='ATOCONGO'

						--SELECT*FROM #DetalleTottusRapicash

						--==========================Crear tabla temporal para sacar la cantidad de cargo================
						select Tienda,count(*) as cantSupervisorJefe INTO #PLANILLATottus
						 From Comisiones.PlanillaTottusRapicash
						where   Puesto IN('SUPERVISOR' ,'JEFE') 
						group by Tienda

						--select*From #PLANILLATottus
						----==========================================================================================

						--==========================REPORTE FINAL DE TOTTUS RAPICASH==================================

						SELECT
						RTR.Sucursal,
						RTR.Meta,
						RTR.VentaReal,
						RTR.Cumplimiento*100 as Cumplimiento,
						SUM(CONVERT(DEC(9,2),REPLACE(DTR.MONTOAPROXFECHA,'-',0))) AS PremioCajero,
						PTR.cantSupervisorJefe,
						CONVERT(DEC(9,2) ,(CASE WHEN (Cumplimiento*100)>=100 THEN RTR.VentaReal*0.65 ELSE 0 END)) AS CumisionJefeSupervisor,
						CONVERT(INT,(PTR.cantSupervisorJefe * convert(DEC(9,2) ,(CASE WHEN (Cumplimiento*100)>=100 THEN RTR.VentaReal*0.65 ELSE 0 END)))) AS PremioTotalSupervisorJefe,
						CONVERT(DEC(9,2) ,(CASE WHEN (Cumplimiento*100)>=100 THEN RTR.VentaReal*0.95 ELSE 0 END)) AS CumisionGerente,
						CONVERT(INT,
						CONVERT(INT,(PTR.cantSupervisorJefe * convert(DEC(9,2) ,(CASE WHEN (Cumplimiento*100)>=100 THEN RTR.VentaReal*0.65 ELSE 0 END)))) +
						SUM(CONVERT(DEC(9,2),REPLACE(DTR.MONTOAPROXFECHA,'-',0))) +
						CONVERT(DEC(9,2) ,(CASE WHEN (Cumplimiento*100)>=100 THEN RTR.VentaReal*0.95 ELSE 0 END))
						)AS TotalPremio,
						CONVERT(INT,
						CONVERT(INT,
						CONVERT(INT,(PTR.cantSupervisorJefe * convert(DEC(9,2) ,(CASE WHEN (Cumplimiento*100)>=100 THEN RTR.VentaReal*0.65 ELSE 0 END)))) +
						SUM(CONVERT(DEC(9,2),REPLACE(DTR.MONTOAPROXFECHA,'-',0))) +
						CONVERT(DEC(9,2) ,(CASE WHEN (Cumplimiento*100)>=100 THEN RTR.VentaReal*0.95 ELSE 0 END))
						)*1.45415*1.08*1.08
						)AS PremiosCCSSIGVCostoTransferencia

						FROM Comisiones.ResumenTottusRapicash RTR
						INNER JOIN #DetalleTottusRapicash DTR
						ON RTR.Sucursal=DTR.Sucursal
						INNER JOIN #PLANILLATottus PTR 
						ON RTR.Sucursal= PTR.Tienda
						--WHERE RTR.Sucursal='ATOCONGO'
						GROUP BY 
						RTR.Sucursal,
						RTR.Meta,
						RTR.VentaReal,
						RTR.Cumplimiento,
						PTR.cantSupervisorJefe
	   END

END
GO

--==============================REPORTE FINAL SODIMAC RAPICASH===================================
/***
	Descripción: Reporte final de SODIMAC RAPICASH
	Parámetros:  SIN PARAMETROS
***/
CREATE PROC [Comisiones].[ReporteFinalSodimacRapicash]
AS
BEGIN
IF object_id('#DETALLESODIMACRAPICASH')>0
				BEGIN
					DROP TABLE #DETALLESODIMACRAPICASH
				END
ELSE
          BEGIN
		  
			--==================================REPORTE DE DETALLE DE SODIMAC RAPICASH================================
							  SELECT
									DSR.CargaId,
									DSR.Secuencia,
									DSR.Sucursal,
									DSR.CodCajero,
									DSR.Cajero,
									DSR.Total,
									(CASE WHEN DSR.CodCajero>=1000000 THEN 'ID' ELSE 'NO ID' END) AS IdCajero,
									(CASE WHEN DSR.Total >=2400  THEN 'OK' ELSE 'NO' END) Cumplimiento,
									(CASE WHEN 
											 (CASE WHEN DSR.Total >=2400  THEN 'OK' ELSE 'NO' END)='OK' THEN 2500
											 ELSE 0
										   END) AS CumplimientoMontoMinimo,

									CONVERT(DEC(9,1),(DSR.Total /(CASE WHEN 
											 (CASE WHEN DSR.Total >=2400  THEN 'OK' ELSE 'NO' END)='OK' THEN 2500
											 ELSE 0
										  END))*100) AS CumplimientoMetaIndividual,

									 Comisiones.FN_LimiteMaxAComision(CONVERT(DEC(9,1),(DSR.Total /(CASE WHEN  --//1  Codigo Cajero
											 (CASE WHEN DSR.Total >=2400  THEN 'OK' ELSE 'NO' END)='OK' THEN 2500
											 ELSE 0
										  END))*100),1) AS LimiteMaxAComision ,
							  
									CONVERT(DEC(9,2) ,Comisiones.FN_LimiteMaxAComision(CONVERT(DEC(9,1),(DSR.Total /(CASE WHEN  --// 1 Codigo Cajero
											 (CASE WHEN DSR.Total >=2400  THEN 'OK' ELSE 'NO' END)='OK' THEN 2500
											 ELSE 0
										  END))*100),1)) AS MontoComisionFecha INTO #DETALLESODIMACRAPICASH

									FROM Comisiones.DetalleSodimacRapicash DSR

			--============================REPORTE FINAL DE SODIMAC RAPICASH============================================

			--select*from  #DETALLESODIMACRAPICASH

			SELECT 
			DSR.Sucursal,
			RSR.Meta,
			RSR.VentaReal,

			(RSR.Cumplimiento*100) AS Cumplimiento,
			COUNT(DSR.Cajero) AS CantidadCajero,
			SUM(DSR.MontoComisionFecha)as PremioTotalCajero,

			0 AS CantidadCoordinador,
			Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),275) AS TopeCoordinador, --//275 Coordinador Cajero 
			CONVERT(DEC(9,1),(0* Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),275))) AS PremioTotalCoordinadores,

			0 AS CantidadSupervisor,
			Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),242) AS TopeSupervisor, --//242 Coordinador Supervisor 
			CONVERT(DEC(9,1),(0*Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),242))) AS PremioTotalSupervisor,

			0 AS CantidadJefe,
			Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),276) AS TopeJefe, --//276 Coordinador Jefe de Carga 
			CONVERT(DEC(9,1),(0*Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),276))) AS PremioTotalJefe,

			(
			SUM(DSR.MontoComisionFecha)  +
			CONVERT(DEC(9,1),(2* Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),275))) +
			CONVERT(DEC(9,1),(3*Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),242))) +
			CONVERT(DEC(9,1),(1*Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),276)))
			) AS TotalPremios,

			CONVERT(DEC(9,1),(
			SUM(DSR.MontoComisionFecha)  +
			CONVERT(DEC(9,1),(2*Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),275))) +
			CONVERT(DEC(9,1),(3*Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),242))) +
			CONVERT(DEC(9,1),(1*Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),276)))
			)*1.08) AS TotalPremiosCostoTransferencia,

			CONVERT(DEC(9,1),CONVERT(DEC(9,1),(
			SUM(DSR.MontoComisionFecha)  +
			CONVERT(DEC(9,1),(2*Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),275))) +
			CONVERT(DEC(9,1),(3*Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),242))) +
			CONVERT(DEC(9,1),(1*Comisiones.FN_LimiteMaxAComision((RSR.Cumplimiento*100),276)))
			)*1.08)*1.18) AS TotalPremiosFinalIGV


			fROM Comisiones.ResumenSodimacRapicash RSR
			INNER JOIN #DETALLESODIMACRAPICASH DSR
			ON LTRIM(RTRIM(SUBSTRING(UPPER(RSR.Sucursal),8, LEN(RSR.Sucursal))))=UPPER(DSR.Sucursal)
			GROUP BY
			DSR.Sucursal,
			RSR.Meta,
			RSR.VentaReal,
			RSR.Cumplimiento
		  END
END
GO


--==============================REPORTE FINAL MAESTRO RAPICASH===================================
/***
	Descripción: Reporte final de MAESTRO RAPICASH
	Parámetros:  SIN PARAMETROS
***/
CREATE PROC Comisiones.ReporteFinalMaestroRapicash
AS
BEGIN 
 IF OBJECT_ID('#RESUMENMAESTRORAPICASH')>0
   BEGIN
   DROP TABLE #RESUMENMAESTRORAPICASH;
   TRUNCATE TABLE #RESUMENMAESTRORAPICASH;
   END 
   ELSE
   BEGIN
--===========================================EXTRAER EL PRIMIO TOTAL DEL CAJERO Y EL TOPE DE CAJERO POR SUCURSAL

					SELECT Sucursal,
					 SUM(MontoBono) as PremioTotalCajero,
					 COUNT(Sucursal) TopeCajero into #RESUMENMAESTRORAPICASH
					 FROM Comisiones.ResumenMaestroRapicash 
					  GROUP BY Sucursal


					--==============================REPORTE FINAL DE MAESTRO RAPICASH==========================


					SELECT 
					DMR.Sucursal,
					CONVERT(DEC(9,3),(MTR.MetaMes/100)) AS Meta,
					SUM(Monto) AS VentaReal,
					convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100) AS Cumplimiento,
					 ISNULL(SUM(RMR.PremioTotalCajero),0) as PremioTotalCajero,
					 COUNT(RMR.TopeCajero) TopeCajero ,
					 0 AS CantidadCoordinador,
					 Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),275) AS TopeCoordinador, --//275 Coordinador Cajero 
					CONVERT(DEC(9,1),(0* Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),275))) AS PremioTotalCoordinadores,


					0 AS CantidadSupervisor,
					Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),242) AS TopeSupervisor, --//242 Coordinador Supervisor 
					CONVERT(DEC(9,1),(0*Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),242))) AS PremioTotalSupervisor,

					0 AS CantidadJefe,
					Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),276) AS TopeJefe, --//276 Coordinador Jefe de Carga 
					CONVERT(DEC(9,1),(0*Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),276))) AS PremioTotalJefe,


					(
					ISNULL(SUM(RMR.PremioTotalCajero),0) +
					CONVERT(DEC(9,1),(0* Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),275))) +
					CONVERT(DEC(9,1),(0*Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),242))) +
					CONVERT(DEC(9,1),(0*Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),276)))
					) AS TotalPremios,

					CONVERT(DEC(9,1),(
					ISNULL(SUM(RMR.PremioTotalCajero),0) +
					CONVERT(DEC(9,1),(0* Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),275))) +
					CONVERT(DEC(9,1),(0*Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),242))) +
					CONVERT(DEC(9,1),(0*Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),276)))
					)*1.08) AS TotalPremiosCostoTransferencia,


					CONVERT(DEC(9,1),CONVERT(DEC(9,1),(
					ISNULL(SUM(RMR.PremioTotalCajero),0) +
					CONVERT(DEC(9,1),(0* Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),275))) +
					CONVERT(DEC(9,1),(0*Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),242))) +
					CONVERT(DEC(9,1),(0*Comisiones.FN_LimiteMaxAComision((convert(DEC(9,2),((MTR.MetaMes/100)/SUM(DMR.Monto))*100)*100),276)))
					)*1.08)*1.18) AS TotalPremiosFinalIGV

					FROM Comisiones.DetalleMaestroRapicash DMR
					INNER JOIN Comisiones.HomologacionSucursal HS
					ON DMR.Sucursal= HS. SucursalConCodigo
					INNER JOIN Comisiones.MetaTiendaRapicash MTR
					ON MTR.Sucursal=HS.Sucursal
					LEFT JOIN #RESUMENMAESTRORAPICASH RMR
					ON DMR.Sucursal=RMR.Sucursal
					GROUP BY 
					DMR.Sucursal,
					MTR.MetaMes
   END
END


GO


--==============================REPORTE FINAL MAESTRO RAPICASH===================================
/***
	Descripción: Reporte final de Automotriz
	Parámetros:  SIN PARAMETROS
***/
CREATE PROC Comisiones.ReporteFinalAutomotriz
AS
BEGIN
				SELECT 
				--DA.PromotorId,
				ECCFF.Sucursal,
				DA.Promotor,
				COUNT(Promotor) AS CuentaPromotor,
				(SELECT COUNT(*) FROM Comisiones.DataAutomotriz WHERE Intermediacion='SI' AND Promotor=DA.Promotor)  AS CuentaIntermediacion,
				SUM(DA.Monto) AS SumaMonto,
				(SELECT COUNT(TipoSeguro) FROM Comisiones.DataAutomotriz WHERE TipoSeguro='Seguro Incluido' AND Promotor=DA.Promotor)  AS SeguroIncluido,
				(SELECT COUNT(TipoSeguro)FROM Comisiones.DataAutomotriz WHERE TipoSeguro='Endosado Externo' AND Promotor=DA.Promotor)  AS EndosadiExterno,
				COUNT(DA.TipoSeguro) AS TotalGeneral,
				(CASE WHEN ECCFF.Sucursal!='Lima' THEN 300.000
					 ELSE 400.000 END ) AS Meta,

				 CONVERT(DEC(9,2),(SUM(DA.Monto/(CASE WHEN ECCFF.Sucursal!='Lima' THEN 300.000
					 ELSE 400.000 END )))/100) AS Logro,
				0 AS ResultadoCCFF ,

				(CASE WHEN ECCFF.Sucursal='TRU Trujillo CF M' OR
						  ECCFF.Sucursal='Chiclayo' OR
						  ECCFF.Sucursal='Arequipa' THEN 2500
						  ELSE ''
						  END )AS MetaCCFF,
				(
				CASE WHEN ECCFF.Sucursal='TRU Trujillo CF M' AND
						  ECCFF.Sucursal='Chiclayo' AND
						  ECCFF.Sucursal='Arequipa'
				  THEN CONVERT(DEC(9,2),((1+SUM(DA.Monto))/(1+1))/100)
				  else  CONVERT(DEC(9,2),(SUM(DA.Monto/(CASE WHEN ECCFF.Sucursal!='Lima' THEN 300.000
					 ELSE 400.000 END )))/100) END 
				) AS Ponderado,
				( CASE WHEN ECCFF.Sucursal!='Lima' THEN
												   (SELECT DISTINCT ConSeguro FROM Comisiones.CumplimientoAsesor 
												   WHERE CumplimientoId=9 AND PCumplimiento=0)*(SELECT COUNT(TipoSeguro)FROM Comisiones.DataAutomotriz WHERE TipoSeguro='Endosado Externo' AND Promotor=DA.Promotor)
												   else 0
				   END                      
				) AS Incluido,

				( CASE WHEN ECCFF.Sucursal!='Lima' THEN
												   (SELECT DISTINCT SinSeguro FROM Comisiones.CumplimientoAsesor 
												   WHERE CumplimientoId=9 AND PCumplimiento=0)*(SELECT COUNT(TipoSeguro) FROM Comisiones.DataAutomotriz WHERE TipoSeguro='Seguro Incluido' AND Promotor=DA.Promotor)
												   else 0
				   END                      
				) AS Endosado,


				( CASE WHEN ECCFF.Sucursal!='Lima' THEN
												   (SELECT DISTINCT SinSeguro FROM Comisiones.CumplimientoAsesor 
												   WHERE CumplimientoId=9 AND PCumplimiento=0)*(SELECT COUNT(*) FROM Comisiones.DataAutomotriz WHERE Intermediacion='SI' AND Promotor=DA.Promotor)
												   else 
												   (SELECT DISTINCT SinSeguro FROM Comisiones.CumplimientoAsesor 
												   WHERE CumplimientoId=10 AND PCumplimiento=0)*(SELECT COUNT(*) FROM Comisiones.DataAutomotriz WHERE Intermediacion='SI' AND Promotor=DA.Promotor)
				   END                      
				) AS Intermediacion,

				(
						( CASE WHEN ECCFF.Sucursal!='Lima' THEN
														   (SELECT DISTINCT ConSeguro FROM Comisiones.CumplimientoAsesor 
														   WHERE CumplimientoId=9 AND PCumplimiento=0)*(SELECT COUNT(TipoSeguro)FROM Comisiones.DataAutomotriz WHERE TipoSeguro='Endosado Externo' AND Promotor=DA.Promotor)
														   else 0
						   END                      
						)+
						( CASE WHEN ECCFF.Sucursal!='Lima' THEN
												   (SELECT DISTINCT SinSeguro FROM Comisiones.CumplimientoAsesor 
												   WHERE CumplimientoId=9 AND PCumplimiento=0)*(SELECT COUNT(TipoSeguro) FROM Comisiones.DataAutomotriz WHERE TipoSeguro='Seguro Incluido' AND Promotor=DA.Promotor)
												   else 0
						  END                      
						)+
						( CASE WHEN ECCFF.Sucursal!='Lima' THEN
												   (SELECT DISTINCT SinSeguro FROM Comisiones.CumplimientoAsesor 
												   WHERE CumplimientoId=9 AND PCumplimiento=0)*(SELECT COUNT(*) FROM Comisiones.DataAutomotriz WHERE Intermediacion='SI' AND Promotor=DA.Promotor)
												   else 
												   (SELECT DISTINCT SinSeguro FROM Comisiones.CumplimientoAsesor 
												   WHERE CumplimientoId=10 AND PCumplimiento=0)*(SELECT COUNT(*) FROM Comisiones.DataAutomotriz WHERE Intermediacion='SI' AND Promotor=DA.Promotor)
						 END                      
						)

				)AS Monto

				FROM Comisiones.DataAutomotriz DA
				INNER JOIN Comisiones.EmpleadoCCFF ECCFF
				ON DA.Promotor= ECCFF.ApellidoPaterno+' '+ECCFF.ApellidoMaterno+' '+ECCFF.PrimerNombre+' '+ECCFF.SegundoNombre
				GROUP BY
				ECCFF.Sucursal,
				DA.Promotor

END
GO




/***
	Descripción: Genera el reporte final de UAC
	Parámetros:  
		- @Fecha, fecha que se desea generar el reporte (Enero => 2018-01-01)
***/
CREATE PROCEDURE [Comisiones].[ReporteFinalUAC]
	@Fecha DATETIME
AS    
BEGIN
	DECLARE @Query NVARCHAR(MAX);

	CREATE TABLE #Temp(
		CargaId int NOT NULL,
		Secuencia int NOT NULL,
		KpiId int NOT NULL,
		EmpleadoId int NULL,
		Meta decimal(5,2),
		Obtenido decimal(5,2)
	)

	--PRODUCTIVIDAD
	SET @Query = Comisiones.GetQueryKpi('Productividad', '#Temp', @Fecha, '1', 'EmpleadoId')
	EXEC sp_executesql @Query

	--SLA
	SET @Query = Comisiones.GetQueryKpi('SlaUac', '#Temp', @Fecha, '5', 'EmpleadoId')
	EXEC sp_executesql @Query

	--SELECT
	
	--FROM #Temp t
	--LEFT JOIN Comisiones.Productividad p ON p.CargaId = t.CargaId AND p.Secuencia = t.Secuencia
	--LEFT JOIN Comisiones.SlaUac s ON s.CargaId = t.CargaId AND s.Secuencia = t.Secuencia

	SELECT
		e.Codigo,
		CONCAT(e.Nombres, ' ', e.ApellidoPaterno, ' ', e.ApellidoMaterno) Nombre,
		c.Nombre Cargo,
		(t.Obtenido/t.Meta)*k.PesoTotal Cumplimiento,
		K.Id
	FROM Comisiones.Productividad p
		INNER JOIN #Temp t ON t.CargaId = p.CargaId AND t.Secuencia = p.Secuencia
		INNER JOIN Comisiones.Empleado e ON e.Id = p.EmpleadoId
		INNER JOIN Comisiones.Kpi k ON k.Id = t.KpiId
		LEFT JOIN Comisiones.Cargo c ON c.Id = e.CargoId
	
	DROP TABLE #Temp
END
GO

/***
	Descripción: Genera el reporte final de FFVV
	Parámetros:  
		- @Fecha, fecha que se desea generar el reporte (Enero => 2018-01-01)
***/
CREATE PROCEDURE [Comisiones].[ReporteFinalFFVV]
	@Fecha DATETIME
AS    
BEGIN
	select 'vacío'
END
GO

CREATE PROCEDURE [Comisiones].[GetErrorCarga] 
	@FechaError DATETIME
AS    
BEGIN
	SELECT
		FechaError,
		TipoError,
		NumFila,
		PosicionColumna,
		DetalleError,
		Isnull(it.Nombre,'') TipoArchivo,
		cc.TipoArchivo IdTipoArchivo,
		Isnull(it2.Descripcion,'') TipoComision,
	    tc.TipoComision AS IdTipoComisiones
	FROM Comisiones.ErrorCarga ec
	LEFT JOIN Comisiones.CabeceraCarga cc ON cc.Id = ec.CargaId
	LEFT JOIN Comisiones.ItemTabla it ON it.TablaId = 2 AND it.Valor = cc.TipoArchivo
	LEFT JOIN Comisiones.TipoComision tc  ON cc.TipoArchivo= tc.TipoArchivo
	LEFT JOIN Comisiones.ItemTabla it2 ON it2.TablaId=1 AND it2.Valor= tc.TipoComision
	WHERE FechaError = @FechaError
END


GO
