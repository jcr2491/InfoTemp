CREATE DATABASE [Comisiones]
GO

USE [Comisiones]
GO

CREATE SCHEMA [Comisiones]
GO

CREATE TABLE [Comisiones].[CabeceraCarga](
	[Id] int IDENTITY(1,1) NOT NULL,
	[TipoArchivo] varchar(2) NOT NULL,
	[FechaArchivo] datetime NOT NULL,
	[FechaModificacionArchivo] datetime NOT NULL,
	[FechaCargaIni] datetime NOT NULL,
	[FechaCargaFin] datetime NULL,	
	[EstadoCarga] int NOT NULL,	
 CONSTRAINT [PK_CabeceraCarga] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

CREATE TABLE [Comisiones].[Excel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](40) NOT NULL,
	[Descripcion] [varchar](500) NULL,
	[Ruta] [varchar](500) NOT NULL,
 CONSTRAINT [PK_Excel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

CREATE TABLE [Comisiones].[ExcelHoja](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExcelId] [int] NOT NULL,
	[TipoArchivo] varchar(2) NOT NULL,
	[FilaIni] [int] NOT NULL,
	[NombreHoja] [nvarchar](40) NOT NULL,
	[Descripcion] [nvarchar](500) NULL,
 CONSTRAINT [PK_ExcelHoja] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[ExcelHoja]  WITH CHECK ADD  CONSTRAINT [FK_ExcelHoja_Excel] FOREIGN KEY([ExcelId])
REFERENCES [Comisiones].[Excel] ([Id])
GO

ALTER TABLE [Comisiones].[ExcelHoja] CHECK CONSTRAINT [FK_ExcelHoja_Excel]
GO

/***
	Descripcion: Permite configurar los campos del archivo
	Campos:
		TipoDato     => Identifica que tipo de valor tendra el campo (TipoDato => 1, Letras => 2, etc)
		PermiteNulos => Permite saber si el campo puede tener valores nulos
		ValorDefecto => Permite asignar un valor por defecto cuando se permita valores nulos
		ValorIgnorar => Representa valores que se ignorar cuando se hacen la validacion (Ej. el valor de la columna es entero, 
						pero puede tener valores tipo texto como "Sin asignar", entoces esto debe ser correcto y dejarlo pasar como valor valida),
						si hay mas de un valor se puede se puede concatener con "|"
***/
CREATE TABLE [Comisiones].[ExcelHojaCampo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExcelHojaId] [int] NOT NULL,	
	[NombreCampo] [varchar](50) NOT NULL,
	[PosicionColumna] [nvarchar](4) NOT NULL,
	[TipoDato] [varchar](2) NULL,
	[PermiteNulo] bit NULL,
	[ValorDefecto] varchar(3) NULL,
	[ValorIgnorar] varchar(30) NULL,
 CONSTRAINT [PK_ExcelHojaCampo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]

GO

ALTER TABLE [Comisiones].[ExcelHojaCampo]  WITH CHECK ADD  CONSTRAINT [FK_ExcelHojaCampo_ExcelHoja] FOREIGN KEY([ExcelHojaId])
REFERENCES [Comisiones].[ExcelHoja] ([Id])
GO
ALTER TABLE [Comisiones].[ExcelHojaCampo] CHECK CONSTRAINT [FK_ExcelHojaCampo_ExcelHoja]
GO

CREATE TABLE [Comisiones].[Productividad](
	CargaId int NOT NULL,
	Secuencia int NOT NULL,
	GrupoId int NULL,
	Grupo nvarchar(20) NOT NULL,
	EmpleadoId int NULL,
	Empleado nvarchar(250) NOT NULL,
	DiasAsistencia int NULL,
	TotalProductividad decimal(8,2) NULL,
	Logro decimal(8,2) NULL,
	MetaDiaria decimal(8,2) NULL,
	MetaReal decimal(8,2) NULL,
	AppAnd decimal(8,2) NULL,
 CONSTRAINT [PK_Productividad] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[Productividad]  WITH CHECK ADD  CONSTRAINT [FK_Productividad_CabeceraCarga] FOREIGN KEY([CargaId])
REFERENCES [Comisiones].[CabeceraCarga] ([Id])
GO
ALTER TABLE [Comisiones].[Productividad] CHECK CONSTRAINT [FK_Productividad_CabeceraCarga]
GO

ALTER TABLE [Comisiones].[Productividad]  WITH CHECK ADD  CONSTRAINT [FK_Productividad_Empleado] FOREIGN KEY([EmpleadoId])
REFERENCES [Comisiones].[Empleado] ([Id])
GO
ALTER TABLE [Comisiones].[Productividad] CHECK CONSTRAINT [FK_Productividad_Empleado]
GO

ALTER TABLE [Comisiones].[Productividad]  WITH CHECK ADD  CONSTRAINT [FK_Productividad_Grupo] FOREIGN KEY([GrupoId])
REFERENCES [Comisiones].[Grupo] ([Id])
GO
ALTER TABLE [Comisiones].[Productividad] CHECK CONSTRAINT [FK_Productividad_Grupo]
GO

CREATE TABLE [Comisiones].[SlaUac](
	CargaId int NOT NULL,
	Secuencia int NOT NULL,
	SupervisorId int NULL,
	Supervisor nvarchar(250) NOT NULL,
	GrupoId int NULL,
	Grupo nvarchar(20) NOT NULL,
	EmpleadoId int NULL,
	Empleado nvarchar(250) NOT NULL,
	DentroPlazo decimal(8,2) NULL,
	FueraPlazo decimal(8,2) NULL,
	TotalGeneral decimal(8,2) NULL,
 CONSTRAINT [PK_SlaUac] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[SlaUac]  WITH CHECK ADD  CONSTRAINT [FK_SlaUac_CabeceraCarga] FOREIGN KEY([CargaId])
REFERENCES [Comisiones].[CabeceraCarga] ([Id])
GO
ALTER TABLE [Comisiones].[SlaUac] CHECK CONSTRAINT [FK_SlaUac_CabeceraCarga]
GO

ALTER TABLE [Comisiones].[SlaUac]  WITH CHECK ADD  CONSTRAINT [FK_SlaUac_Empleado] FOREIGN KEY([EmpleadoId])
REFERENCES [Comisiones].[Empleado] ([Id])
GO
ALTER TABLE [Comisiones].[SlaUac] CHECK CONSTRAINT [FK_SlaUac_Empleado]
GO

ALTER TABLE [Comisiones].[SlaUac]  WITH CHECK ADD  CONSTRAINT [FK_SlaUac_Supervisor] FOREIGN KEY([SupervisorId])
REFERENCES [Comisiones].[Empleado] ([Id])
GO
ALTER TABLE [Comisiones].[SlaUac] CHECK CONSTRAINT [FK_SlaUac_Supervisor]
GO

ALTER TABLE [Comisiones].[SlaUac]  WITH CHECK ADD  CONSTRAINT [FK_SlaUac_Grupo] FOREIGN KEY([GrupoId])
REFERENCES [Comisiones].[Grupo] ([Id])
GO
ALTER TABLE [Comisiones].[SlaUac] CHECK CONSTRAINT [FK_SlaUac_Grupo]
GO

CREATE TABLE [Comisiones].[Empleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [varchar](50) NOT NULL,
	[ApellidoPaterno] [varchar](50) NOT NULL,
	[ApellidoMaterno] [varchar](50) NOT NULL,
	[Codigo] [varchar](8) NOT NULL,
	[CargoId] [int] NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_Cargo] FOREIGN KEY([CargoId])
REFERENCES [Comisiones].[Cargo] ([Id])
GO
ALTER TABLE [Comisiones].[Empleado] CHECK CONSTRAINT [FK_Empleado_Cargo]
GO

CREATE TABLE [Comisiones].[Cargo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[TipoComision] int NOT NULL,
 CONSTRAINT [PK_Cargo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

CREATE TABLE [Comisiones].[Grupo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ResponsableId] [int] NULL,
 CONSTRAINT [PK_Grupo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[Grupo]  WITH CHECK ADD  CONSTRAINT [FK_Grupo_Empleado] FOREIGN KEY([ResponsableId])
REFERENCES [Comisiones].[Empleado] ([Id])
GO
ALTER TABLE [Comisiones].[Grupo] CHECK CONSTRAINT [FK_Grupo_Empleado]
GO

CREATE TABLE [Comisiones].[Homologacion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Codigo] [varchar](8) NOT NULL,
 CONSTRAINT [PK_Homologacion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

CREATE TABLE [Comisiones].[Kpi](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[TipoComision] int NOT NULL,
	[TipoArchivo] varchar(2) NOT NULL,
	[PesoTotal] decimal(5,2) NULL,
	[TipoKpi] INT NULL, --Individual/Grupal
 CONSTRAINT [PK_Kpi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

CREATE TABLE [Comisiones].[IndicadorKpi](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[KpiId] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,	
	[CargoId] [int] NOT NULL,
	[Peso] decimal(5,2) NULL,
 CONSTRAINT [PK_IndicadorKpi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[IndicadorKpi]  WITH CHECK ADD  CONSTRAINT [FK_IndicadorKpi_Kpi] FOREIGN KEY([KpiId])
REFERENCES [Comisiones].[Kpi] ([Id])
GO
ALTER TABLE [Comisiones].[IndicadorKpi] CHECK CONSTRAINT [FK_IndicadorKpi_Kpi]
GO

ALTER TABLE [Comisiones].[IndicadorKpi]  WITH CHECK ADD  CONSTRAINT [FK_IndicadorKpi_Cargo] FOREIGN KEY([CargoId])
REFERENCES [Comisiones].[Cargo] ([Id])
GO
ALTER TABLE [Comisiones].[IndicadorKpi] CHECK CONSTRAINT [FK_IndicadorKpi_Cargo]
GO

CREATE TABLE [Comisiones].[PuntajeKpi](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[KpiId] [int] NOT NULL,
	[CargoId] [int] NOT NULL,
	[CumplimientoIni] decimal (5,2) NULL,	
	[CumplimientoFin] decimal (5,2) NULL,
	[Puntaje] decimal(5,2) NULL,
	[Comision] decimal(5,2) NULL,
 CONSTRAINT [PK_PuntajeKpi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[PuntajeKpi]  WITH CHECK ADD  CONSTRAINT [FK_PuntajeKpi_Kpi] FOREIGN KEY([KpiId])
REFERENCES [Comisiones].[Kpi] ([Id])
GO
ALTER TABLE [Comisiones].[PuntajeKpi] CHECK CONSTRAINT [FK_PuntajeKpi_Kpi]
GO

ALTER TABLE [Comisiones].[PuntajeKpi]  WITH CHECK ADD  CONSTRAINT [FK_PuntajeKpi_Cargo] FOREIGN KEY([CargoId])
REFERENCES [Comisiones].[Cargo] ([Id])
GO
ALTER TABLE [Comisiones].[PuntajeKpi] CHECK CONSTRAINT [FK_PuntajeKpi_Cargo]
GO

CREATE TABLE [Comisiones].[Bono](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CargoId] [int] NOT NULL,
	[Monto] decimal(8,2) NOT NULL,
	[MontoMaximo] decimal(8,2) NULL,
 CONSTRAINT [PK_Bono] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[Bono]  WITH CHECK ADD  CONSTRAINT [FK_Bono_Cargo] FOREIGN KEY([CargoId])
REFERENCES [Comisiones].[Cargo] ([Id])
GO
ALTER TABLE [Comisiones].[Bono] CHECK CONSTRAINT [FK_Bono_Cargo]
GO

CREATE TABLE [Comisiones].[ColumnaKpi](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[KpiId] [int] NOT NULL,
	[ExcelHojaCampoMeta] [int] NULL,
	[ExcelHojaCampoResultado] [int] NOT NULL,
 CONSTRAINT [PK_ColumnaKpi] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[ColumnaKpi]  WITH CHECK ADD  CONSTRAINT [FK_ColumnaKpi_ExcelHojaCampo] FOREIGN KEY([CampoMeta])
REFERENCES [Comisiones].[ExcelHojaCampo] ([Id])
GO
ALTER TABLE [Comisiones].[ColumnaKpi] CHECK CONSTRAINT [FK_ColumnaKpi_ExcelHojaCampo]
GO

ALTER TABLE [Comisiones].[ColumnaKpi]  WITH CHECK ADD  CONSTRAINT [FK_ColumnaKpi_ExcelHojaCampo] FOREIGN KEY([CampoAcumulado])
REFERENCES [Comisiones].[ExcelHojaCampo] ([Id])
GO
ALTER TABLE [Comisiones].[ColumnaKpi] CHECK CONSTRAINT [FK_ColumnaKpi_ExcelHojaCampo]
GO

ALTER TABLE [Comisiones].[ColumnaKpi]  WITH CHECK ADD  CONSTRAINT [FK_ColumnaKpi_Kpi] FOREIGN KEY([KpiId])
REFERENCES [Comisiones].[Kpi] ([Id])
GO
ALTER TABLE [Comisiones].[ColumnaKpi] CHECK CONSTRAINT [FK_ColumnaKpi_Kpi]
GO

--CREATE TABLE [Comisiones].[Indicador](
--	[Id] [int] IDENTITY(1,1) NOT NULL,
--	[Nombre] [varchar](50) NOT NULL,
--	[TipoComision] int NOT NULL,
--	[CargoId] [int] NOT NULL,
--	[RangoIni] decimal(5,2) NULL,
--	[RangoFin] decimal(5,2) NULL,
--	[Monto] decimal(10,2) NULL,
-- CONSTRAINT [PK_Indicador] PRIMARY KEY CLUSTERED 
--(
--	[Id] ASC
--)) ON [PRIMARY]
--GO

create table Comisiones.CCFF
(
Id int primary key,
CCFF nvarchar(100) null,
Formato char(3)  null,
GerenteOJefeCCFF nvarchar(100)  null,
Cargo nvarchar(100)  null,
Caja bit null,
Direccion nvarchar(max)  null,
Departamento  nvarchar(100)  null,
Provincia nvarchar(100)  null,
Distrito nvarchar(100)  null
)
go

CREATE TABLE [Comisiones].[Parametros](
	[Id] [int] NOT NULL,
	[TipoComision] [int] NOT NULL,
	[Codigo] [nvarchar](50) NOT NULL,
	[FechaVigencia] [datetime] NOT NULL,
	[Estado] [bit] NOT NULL,
	[Descripcion] [nvarchar](200) NULL,
	[ValorNumerico] [int] NULL,
	[ValorTexto] [nvarchar](250) NULL,
	[ValorDecimal] [decimal](18, 3) NULL,
	[ValorBoleano] [bit] NULL,
	[ValorFecha] [datetime] NULL,
 CONSTRAINT [PK_Parametros] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

CREATE TABLE [Comisiones].[Tabla] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Nombre]      NVARCHAR (40)  NULL,
    [Descripcion] NVARCHAR (250) NULL,
    [Estado]      INT            NOT NULL,
    CONSTRAINT [PK_Comisiones.Tabla] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [Comisiones].[ItemTabla] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Nombre]      NVARCHAR (200) NULL,
    [Descripcion] NVARCHAR (500) NULL,
    [Valor]       INT            NOT NULL,
    [TablaId]     INT            NOT NULL,
    [Estado]      INT            NOT NULL,
    CONSTRAINT [PK_Comisiones.ItemTabla] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Comisiones.ItemTabla_Comisiones.Tabla_TablaId] FOREIGN KEY ([TablaId]) REFERENCES [Comisiones].[Tabla] ([Id]) ON DELETE CASCADE
);

GO
CREATE NONCLUSTERED INDEX [IX_TablaId] ON [Comisiones].[ItemTabla]([TablaId] ASC);

/***
	Descripción: Tabla para agrupar los cargos para una determinada seccion de calculo del reporte
***/
CREATE TABLE [Comisiones].[VistaComision](
	[Id] [int] NOT NULL,
	[Nombre] NVARCHAR (50) NOT NULL,
	[TipoComision] int NOT NULL,
 CONSTRAINT [PK_VistaComision] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

/***
	Descripción: Tabla relacion entre el cargo y la vista
***/
CREATE TABLE [Comisiones].[VistaComisionCargo](
	[VistaComisionId] [int] NOT NULL,
	[CargoId] [int] NOT NULL,
 CONSTRAINT [PK_VistaComisionCargo] PRIMARY KEY CLUSTERED 
(
	[VistaComisionId] ASC,
	[CargoId]
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[VistaComisionCargo]  WITH CHECK ADD  CONSTRAINT [FK_VistaComisionCargo_Cargo] FOREIGN KEY([CargoId])
REFERENCES [Comisiones].[Cargo] ([Id])
GO
ALTER TABLE [Comisiones].[VistaComisionCargo] CHECK CONSTRAINT [FK_VistaComisionCargo_Cargo]
GO

ALTER TABLE [Comisiones].[VistaComisionCargo]  WITH CHECK ADD  CONSTRAINT [FK_VistaComisionCargo_VistaComision] FOREIGN KEY([VistaComisionId])
REFERENCES [Comisiones].[VistaComision] ([Id])
GO
ALTER TABLE [Comisiones].[VistaComisionCargo] CHECK CONSTRAINT [FK_VistaComisionCargo_VistaComision]
GO

/*
Reporte: Automotriz
Descripción: Tabla input base para el reporte Automotriz
Campos:
	_
Observaciones:
*/

CREATE TABLE [Comisiones].[DataAutomotriz](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[NroPrestamo] [int] NULL,
	[TipoDoc] [varchar](50) NULL,
	[Documento] [int] NULL,
	[EmpleadoId] [int] NULL,
	[Empleado] [nvarchar](250) NULL,
	[FechaDesembolso] [datetime] NULL,
	[Canal] [varchar](50) NULL,
	[Captacion] [varchar](50) NULL,
	[PromotorId] [int] NULL,
	[Promotor] [nvarchar](50) NULL,
	[AsistenteId] [int] NULL,
	[Asistente] [varchar](50) NULL,
	[TipoSeguro] [varchar](50) NULL,
	[Moneda] [nvarchar](10) NULL,
	[Precio] [decimal](18, 2) NULL,
	[CuotaInicial] [decimal](18, 2) NULL,
	[Monto] [decimal](18, 2) NULL,
	[Intermediacion] [varchar](10) NULL,
 CONSTRAINT [PK_DataAutomotriz] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO  

/*
Reporte: Rapicash
Descripción: Tabla input base para el reporte Rapicash
Campos:
	_
Observaciones:
*/

CREATE TABLE [Comisiones].[DetalleMaestroRapicash](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[SucursalId] [int] NULL,
	[Sucursal] [nvarchar](100) NULL,
	[Anio] [int] NULL,
	[Mes] [int] NULL,
	[DiaCompraoRetiro] [int] NULL,
	[DiaProceso] [int] NULL,
	[Cargo] [nvarchar](50) NULL,
	[NombreEmpleado] [nvarchar](100) NULL,
	[CodEmpleado] [nvarchar](50) NULL,
	[Transaccion] [nvarchar](50) NULL,
	[Tipo] [nvarchar](50) NULL,
	[Monto] [int] NULL,
	[POS] [int] NULL,
 CONSTRAINT [PK_DetalleMaestroRapicash] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*
Reporte: Rapicash
Descripción: Tabla input base para el reporte Rapicash
Campos:
	_
Observaciones:
*/

CREATE TABLE [Comisiones].[DetalleSagaRapicash](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[SucursalId] [int] NULL,
	[Sucursal] [nvarchar](50) NULL,
	[CodCajero] [int] NULL,
	[Cajero] [nvarchar](50) NULL,
	[Total] [int] NULL,
 CONSTRAINT [PK_DetalleSagaRapicash] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO --LISTO

CREATE TABLE [Comisiones].[DetalleSodimacRapicash](
	[CargaId] [int] NULL,
	[Secuencia] [int] NULL,
	[Sucursal] [nvarchar](100) NULL,
	[CodCajero] [nvarchar](50) NULL,
	[Cajero] [nvarchar](100) NULL,
	[Total] [decimal](9, 2) NULL
) ON [PRIMARY]

GO  --LISTO 

CREATE TABLE [Comisiones].[DetalleTottusRapicash](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[Sucursal] [nvarchar](100) NULL,
	[CodCajero] [nvarchar](50) NULL,
	[Cajero] [nvarchar](100) NULL,
	[Total] [decimal](9, 2) NULL,
 CONSTRAINT [PK_DetalleTottusRapicash] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO  --LISTO

/*
Reporte: Input Base
Descripción: Tabla input base previo a la carga de reportes
Campos:
	_
Observaciones:
*/

CREATE TABLE [Comisiones].[DiasAusencia](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[EmpleadoId] [int] NULL,
	[EmpresaId] [tinyint] NULL,
	[Empresa] [varchar](250) NULL,
	[Empleado] [nvarchar](250) NULL,
	[Anio] [int] NULL,
	[Mes] [tinyint] NULL,
	[Correlativo] [int] NULL,
	[FechaProc] [nvarchar](50) NULL,
	[TotDiasNoLabor] [decimal](5, 2) NULL,
 CONSTRAINT [PK_Dias_Ausencia] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO  --LISTO

/*
Reporte: Input Base Empleado CCF desde un .csv
Descripción: Tabla input base previo a la carga de reportes
Campos:
	_
Observaciones:
*/

CREATE TABLE [Comisiones].[EmpleadoCCFF](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[CodigoEmpleado] [varchar](10) NOT NULL,
	[PrimerNombre] [nvarchar](50) NOT NULL,
	[SegundoNombre] [nvarchar](50) NULL,
	[ApellidoPaterno] [nvarchar](50) NOT NULL,
	[ApellidoMaterno] [nvarchar](50) NOT NULL,
	[CargoId] [varchar](5) NULL,
	[Cargo] [nvarchar](50) NULL,
	[SucursalId] [nvarchar](5) NULL,
	[Sucursal] [nvarchar](100) NULL,
	[ZonaId] [tinyint] NULL,
	[Zona] [varchar](20) NULL,
	[FechaIngreso] [datetime] NULL,
	[FechaCese] [datetime] NULL,
	[Estado] [varchar](20) NULL,
	[SubEstadoId] [tinyint] NULL,
	[SubEstado] [varchar](50) NULL,
 CONSTRAINT [PK_BaseCargaEmpleadoCCFF] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO  --LISTO

/*
Reporte: UAC
Descripción: Tabla que agrupa a los especialistas a un cierto grupo a cargo de un supervisor
Campos:
	_ResponsableId: Debe ir el EmpleadoId
Observaciones:
*/

CREATE TABLE [Comisiones].[Grupo](
	[CargaId] INT NOT NULL,
	[Secuencia] INT NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ResponsableId] [int] NULL,
 CONSTRAINT [PK_Grupo] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO --LISTO

CREATE TABLE [Comisiones].[ErrorCarga](
	[FechaError] datetime NOT NULL,
	[Secuencia] int NOT NULL,
	[TipoError] char(1) NOT NULL,
	[CargaId] [int] NULL,
	[NumFila] [int] NULL,
	[PosicionColumna] [nvarchar](4) NULL,
	[ExcelHojaCampoId] [int] NULL,	
	[DetalleError] [varchar](500) NULL,
 CONSTRAINT [PK_ErrorCarga] PRIMARY KEY CLUSTERED 
(
	[FechaError] ASC,
	[Secuencia] ASC
)) ON [PRIMARY]

GO


CREATE TABLE [Comisiones].[TipoComision](
	[TipoComision] [int] NOT NULL,
	[TipoArchivo] [int] NOT NULL
) ON [PRIMARY]

GO

