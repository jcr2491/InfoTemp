-- DATOS EXCEL --
DECLARE @OutputTbl TABLE (Id INT)
DECLARE @Id INT

INSERT [Comisiones].[Excel] ([Nombre], [Descripcion], [Ruta])
OUTPUT INSERTED.Id INTO @OutputTbl(Id)
VALUES (N'Productividad.xlsx', N'Reporte de Productividad', N'D:\TEMP\Comisiones\')

SET @Id = (SELECT Id FROM @OutputTbl)
-- DATOS EXCELHOJA --
SET IDENTITY_INSERT [Comisiones].[ExcelHoja] ON

INSERT [Comisiones].[ExcelHoja] ([Id], [ExcelId], [TipoArchivo], [FilaIni], [NombreHoja], [Descripcion]) VALUES (1, @Id, N'1', 3, N'Productividad', NULL)
INSERT [Comisiones].[ExcelHoja] ([Id], [ExcelId], [TipoArchivo], [FilaIni], [NombreHoja], [Descripcion]) VALUES (2, @Id, N'5', 3, N'SLA', NULL)

SET IDENTITY_INSERT [Comisiones].[ExcelHoja] OFF

-- DATOS EXCELHOJACAMPO --
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (1, N'DiasAsistencia', N'F', 1, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (1, N'Empleado', N'B', 2, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (1, N'Grupo', N'A', 2, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (1, N'Logro', N'I', 5, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (1, N'TotalProductividad', N'C', 5, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (1, N'MetaDiaria', N'E', 5, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (1, N'MetaReal', N'J', 5, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (1, N'AppAnd', N'M', 5, NULL, NULL, NULL)

INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (2, N'DentroPlazo', N'E', 1, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (2, N'Empleado', N'C', 1, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (2, N'FueraPlazo', N'D', 1, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (2, N'Grupo', N'B', 2, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (2, N'Supervisor', N'A', 2, NULL, NULL, NULL)
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelHojaId], [NombreCampo], [PosicionColumna], [TipoDato], [PermiteNulo], [ValorDefecto], [ValorIgnorar]) VALUES (2, N'TotalGeneral', N'F', 1, NULL, NULL, NULL)

DELETE FROM @OutputTbl
-- DATOS EXCEL --
INSERT [Comisiones].[Excel] ([Nombre], [Descripcion], [Ruta])
OUTPUT INSERTED.Id INTO @OutputTbl(Id)
VALUES (N'AUT_REPORTE_EMPLEADO.csv', N'Empleados de los Centros Financieros', N'D:\TEMP\Comisiones\')

SET @Id = (SELECT Id FROM @OutputTbl)

-- DATOS EXCELHOJA --
INSERT [Comisiones].[ExcelHoja] ([ExcelId], [TipoArchivo], [FilaIni], [NombreHoja], [Descripcion]) VALUES (@Id, N'29', 1, N'AUT_REPORTE_EMPLEADO', NULL)

-- DATOS EXCELHOJACAMPO --
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'CodigoEmpleado', N'0')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'PrimerNombre', N'7')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'SegundoNombre', N'8')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'ApellidoPaterno', N'12')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'ApellidoMaterno', N'13')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'CargoId', N'1')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'Cargo', N'2')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'SucursalId', N'3')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'Sucursal', N'4')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'ZonaId', N'5')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'Zona', N'6')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'FechaIngreso', N'14')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'FechaCese', N'15')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'Estado', N'16')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'SubEstadoId', N'19')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [PosicionColumna]) VALUES (@Id, N'1', N'SubEstado', N'20')

--DATOS CARGO
SET IDENTITY_INSERT [Comisiones].[Cargo] ON 

GO
INSERT [Comisiones].[Cargo] ([Id], [Nombre]) VALUES (1, N'Apoyo UAC')
GO
INSERT [Comisiones].[Cargo] ([Id], [Nombre]) VALUES (2, N'Especialista UAC')
GO
INSERT [Comisiones].[Cargo] ([Id], [Nombre]) VALUES (3, N'Especialista UAC Noche')
GO
INSERT [Comisiones].[Cargo] ([Id], [Nombre]) VALUES (4, N'Jefe UAC')
GO
INSERT [Comisiones].[Cargo] ([Id], [Nombre]) VALUES (5, N'Supervisor')
GO
SET IDENTITY_INSERT [Comisiones].[Cargo] OFF
GO

--DATOS EMPLEADO
SET IDENTITY_INSERT [Comisiones].[Empleado] ON 

GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (1, N'ADELMO CRISTY', N'ABREGU', N'GONZÁLEZ', N'12896534', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (2, N'ADOLFO WALTER', N'ABREU', N'RODRÍGUEZ', N'12896535', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (3, N'ADRIANO TERESA', N'ADAMES', N'GÓMEZ', N'12896536', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (4, N'AILÍN FERNANDO', N'ADARO', N'FERNÁNDEZ', N'12896537', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (5, N'ALBERTO SONIA', N'ADAUTO', N'LÓPEZ', N'12896538', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (6, N'ALEJANDRO ARLETH', N'AGRADA', N'DÍAZ', N'12896539', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (7, N'ALFONSO MARITZA', N'ALBURQUEQUE', N'MARTÍNEZ', N'12896540', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (8, N'ALFREDO ANGELA', N'ALCABES', N'PÉREZ', N'12896541', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (9, N'ALVAREZ JAVIER', N'ALMEIDA', N'GARCÍA', N'12896542', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (10, N'ALVARO JOSE', N'ALMEYDA', N'SÁNCHEZ', N'12896543', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (11, N'ANA CRISTINA', N'ALVARES', N'ROMERO', N'12896544', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (12, N'ANDREA NORMA', N'ALVES', N'SOSA', N'12896545', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (13, N'ANDRÉS ELSA', N'AMADO', N'ÁLVAREZ', N'12896546', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (14, N'ANGELO KRISTOFER', N'AMARAL', N'TORRES', N'12896547', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (15, N'ARIEL JAMES', N'ANGOBALDO', N'RAMÍREZ', N'12896548', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (16, N'ARSENIO HINDRA', N'ANTUNES', N'FLORES', N'12896549', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (17, N'ARTURO TELLO', N'BAES', N'ACOSTA', N'12896550', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (18, N'BRAULIO FASABI', N'BARBOZA', N'BENÍTEZ', N'12896551', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (19, N'CARLOS MARIA', N'BARDALES', N'MEDINA', N'12896552', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (20, N'CRISTÓBAL NORIS', N'BARROSO', N'SUÁREZ', N'12896553', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (21, N'DIEGO LUZ', N'BATISTA', N'HERRERA', N'12896554', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (22, N'EDUARDO KEYKO', N'BRANCO', N'AGUIRRE', N'12896555', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (23, N'ESTEBAN MELISSA', N'CALIENES', N'PEREYRA', N'12896556', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (24, N'ESTEVAN ALEX', N'CARDOSO', N'GUTIÉRREZ', N'12896557', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (25, N'FERNANDO MARGOTH', N'CASAL', N'GIMÉNEZ', N'12896558', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (26, N'FORTUNATO AMARELIS', N'CERNADES', N'MOLINA', N'12896559', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (27, N'GERARDO PIERO', N'CLIMACO', N'SILVA', N'12896560', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (28, N'HECTOR DIANA', N'COELHO', N'CASTRO', N'12896561', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (29, N'HUENU LILIAN', N'COIMBRA', N'ROJAS', N'12896562', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (30, N'HUGO DE', N'COSINGA', N'ORTÍZ', N'12896563', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (31, N'IGNACIO PAULA', N'COSTA', N'NÚÑEZ', N'12896564', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (32, N'JAVIER CARMEN', N'GONZÁLEZ ', N'LUNA', N'12896565', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (33, N'JOAQUIN JANNINA', N'RODRÍGUEZ', N'JUÁREZ', N'12896566', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (34, N'JORGE SUSANA', N'PÉREZ', N'CABRERA', N'12896567', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (35, N'JOSÉ GLADYZ', N'HERNÁNDEZ', N'RÍOS', N'12896568', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (36, N'JUAN LINDERIKA', N'GARCÍA', N'FERREYRA', N'12896569', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (37, N'JULIAN MARINA', N'MARTÍNEZ', N'GODOY', N'12896570', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (38, N'JULIO JORGE', N'SÁNCHEZ', N'MORALES', N'12896571', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (39, N'LEONARDO JORGE', N'LÓPEZ', N'DOMÍNGUEZ', N'12896572', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (40, N'LICHUEN WIDSENIA', N'DÍAZ', N'MORENO', N'12896573', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (41, N'LOLA URSULA', N'ROJAS', N'PERALTA', N'12896574', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (42, N'LUCHO MIRIAM', N'RAMÍREZ', N'VEGA', N'12896575', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (43, N'LUIS KATHERINE', N'CASTILLO', N'CARRIZO', N'12896576', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (44, N'MAITEN DENISE', N'GÓMEZ', N'QUIROGA', N'12896577', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (45, N'MANQUE JOEL', N'ROMERO', N'CASTILLO', N'12896578', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (46, N'MANUEL HELMUD', N'FERNANDEZ', N'LEDESMA', N'12896579', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (47, N'MARCELO DENISSE', N'TORRES', N'MUÑOZ', N'12896580', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (48, N'MARCO LUIS', N'MENDOZA', N'OJEDA', N'12896581', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (49, N'MIGUEL DAVID', N'MEDINA', N'PONCE', N'12896582', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (50, N'NEYEN GRECIA', N'GUTIÉRREZ', N'VÁZQUEZ', N'12896584', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (51, N'NICOLAS LUYO', N'DOCARMO', N'VILLALBA', N'12896585', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (52, N'NULPI YEFERSON', N'DOMINGUES', N'CARDOZO', N'12896586', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (53, N'PABLO HAROLD', N'DORADOR', N'NAVARRO', N'12896587', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (54, N'PATRÍCIO SANTOS', N'DORREGO', N'RAMOS', N'12896588', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (55, N'PEDRO ELISA', N'DOS', N'ARIAS', N'12896589', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (56, N'PEHUEN JESSENIA', N'DOSANTOS', N'CORONEL', N'12896590', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (57, N'PICHI JANETH', N'EVANGELISTA', N'CÓRDOBA', N'12896591', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (58, N'RADHIKA FULVIA', N'FARIA', N'FIGUEROA', N'12896592', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (59, N'RAFAEL MARIANELA', N'FAURA', N'CORREA', N'12896593', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (60, N'RAIQUEN KAREN', N'FERNANDES', N'CÁCERES', N'12896594', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (61, N'RAUL WILMER', N'FERREIRA', N'VARGAS', N'12896595', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (62, N'RICARDO MIRTHA', N'FERREYRA', N'MALDONADO', N'12896596', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (63, N'ROBERTO LILIA', N'FINO', N'MANSILLA', N'12896597', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (64, N'RODOLFO MAYRA', N'FREITAS', N'FARÍAS', N'12896598', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (65, N'SANTIAGO JORGE', N'GONCALVES', N'PAZ', N'12896600', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (66, N'SEBASTIAN ISAURA', N'GUEDES', N'MIRANDA', N'12896601', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (67, N'SERGIO DIANA', N'GUIMAREY', N'ROLDÁN', N'12896602', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (68, N'VICENTE CANDY', N'JUNIOR', N'MÉNDEZ', N'12896603', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (69, N'VICTOR ROSA', N'LEANDRO', N'LUCERO', N'12896604', 1)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (70, N'YAMAI ANGIE', N'LENCASTRE', N'HERNÁNDEZ', N'12896606', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (71, N'YENIEN WILMER', N'LOBATO', N'AGÜERO', N'12896607', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (72, N'YERIMEN KELY', N'LOBO', N'PÁEZ', N'12896608', 2)
GO
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (73, N'ELKA PAOLA', N'MENDOZA', N'REATEGUI', N'50098078', 4)
GO
SET IDENTITY_INSERT [Comisiones].[Empleado] OFF
GO


/*** DATOS KPI ***/
SET IDENTITY_INSERT [Comisiones].[Kpi] ON 

GO
INSERT [Comisiones].[Kpi] ([Id], [Nombre], [TipoComision], [PesoTotal], [Tipo]) VALUES (1, N'Producción mes individual', 1, 50, 1)
GO
INSERT [Comisiones].[Kpi] ([Id], [Nombre], [TipoComision], [PesoTotal], [Tipo]) VALUES (2, N'Casos resueltos dentro de SLA (Según Tipología)', 1, 50, 1)
GO
SET IDENTITY_INSERT [Comisiones].[Kpi] OFF
GO
SET IDENTITY_INSERT [Comisiones].[IndicadorKpi] ON 

GO
INSERT [Comisiones].[IndicadorKpi] ([Id], [KpiId], [Nombre], [CargoId], [Peso]) VALUES (1, 1, N'CASOS RESUELTOS', 2, 50)
GO
INSERT [Comisiones].[IndicadorKpi] ([Id], [KpiId], [Nombre], [CargoId], [Peso]) VALUES (2, 1, N'CASOS RESUELTOS', 3, 50)
GO
INSERT [Comisiones].[IndicadorKpi] ([Id], [KpiId], [Nombre], [CargoId], [Peso]) VALUES (3, 1, N'CASOS RESUELTOS', 1, 50)
GO
INSERT [Comisiones].[IndicadorKpi] ([Id], [KpiId], [Nombre], [CargoId], [Peso]) VALUES (4, 5, N'SLA POR TIPOLOGÍA', 1, 50)
GO
INSERT [Comisiones].[IndicadorKpi] ([Id], [KpiId], [Nombre], [CargoId], [Peso]) VALUES (5, 5, N'SLA POR TIPOLOGÍA', 2, 50)
GO
INSERT [Comisiones].[IndicadorKpi] ([Id], [KpiId], [Nombre], [CargoId], [Peso]) VALUES (7, 5, N'SLA POR TIPOLOGÍA', 3, 50)
GO
SET IDENTITY_INSERT [Comisiones].[IndicadorKpi] OFF
GO
SET IDENTITY_INSERT [Comisiones].[PuntajeKpi] ON 

GO
INSERT [Comisiones].[PuntajeKpi] ([Id], [KpiId], [CargoId], [CumplimientoIni], [CumplimientoFin], [Puntaje], [Comision]) VALUES (1, 1, 1, NULL, 60, 0, NULL)
GO
INSERT [Comisiones].[PuntajeKpi] ([Id], [KpiId], [CargoId], [CumplimientoIni], [CumplimientoFin], [Puntaje], [Comision]) VALUES (2, 1, 1, 60, 79, 60, NULL)
GO
INSERT [Comisiones].[PuntajeKpi] ([Id], [KpiId], [CargoId], [CumplimientoIni], [CumplimientoFin], [Puntaje], [Comision]) VALUES (3, 1, 1, 80, 84, 70, NULL)
GO
INSERT [Comisiones].[PuntajeKpi] ([Id], [KpiId], [CargoId], [CumplimientoIni], [CumplimientoFin], [Puntaje], [Comision]) VALUES (4, 1, 1, 85, 89, 80, NULL)
GO
SET IDENTITY_INSERT [Comisiones].[PuntajeKpi] OFF
GO
SET IDENTITY_INSERT [Comisiones].[ColumnaKpi] ON 

GO
INSERT [Comisiones].[ColumnaKpi] ([Id], [ExcelHojaCampoMeta], [ExcelHojaCampoResultado], [KpiId]) VALUES (1, 6, 8, 1)
GO
SET IDENTITY_INSERT [Comisiones].[ColumnaKpi] OFF
GO
SET IDENTITY_INSERT [Comisiones].[Bono] ON 

GO
INSERT [Comisiones].[Bono] ([Id], [CargoId], [Monto], [MontoMaximo]) VALUES (1, 1, 300, 396)
GO
SET IDENTITY_INSERT [Comisiones].[Bono] OFF
GO

/*** VISTA COMISION ***/
INSERT [Comisiones].[VistaComision] ([Id], [Nombre], [TipoComision]) VALUES (1, N'ESPECIALISTA', 1)
GO
INSERT [Comisiones].[VistaComision] ([Id], [Nombre], [TipoComision]) VALUES (2, N'SUPERVISOR - JEFE', 1)
GO
INSERT [Comisiones].[VistaComisionCargo] ([VistaComisionId], [CargoId]) VALUES (1, 1)
GO
INSERT [Comisiones].[VistaComisionCargo] ([VistaComisionId], [CargoId]) VALUES (1, 2)
GO
INSERT [Comisiones].[VistaComisionCargo] ([VistaComisionId], [CargoId]) VALUES (1, 3)
GO
INSERT [Comisiones].[VistaComisionCargo] ([VistaComisionId], [CargoId]) VALUES (2, 4)
GO
INSERT [Comisiones].[VistaComisionCargo] ([VistaComisionId], [CargoId]) VALUES (2, 5)
GO