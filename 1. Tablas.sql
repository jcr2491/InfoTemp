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
	[ExcelId] [int] NOT NULL,
	[TipoArchivo] varchar(2) NOT NULL,
	[FilaIni] [int] NOT NULL,
	[NombreHoja] [nvarchar](40) NOT NULL,
	[Descripcion] [nvarchar](500) NULL,
 CONSTRAINT [PK_ExcelHoja] PRIMARY KEY CLUSTERED 
(
	[ExcelId] ASC,
	[TipoArchivo] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[ExcelHoja]  WITH CHECK ADD  CONSTRAINT [FK_ExcelHoja_Excel] FOREIGN KEY([ExcelId])
REFERENCES [Comisiones].[Excel] ([Id])
GO

ALTER TABLE [Comisiones].[ExcelHoja] CHECK CONSTRAINT [FK_ExcelHoja_Excel]
GO

CREATE TABLE [Comisiones].[ExcelHojaCampo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExcelId] [int] NOT NULL,
	[TipoArchivo] varchar(2) NOT NULL,
	[NombreCampo] [varchar](50) NOT NULL,
	[PosicionColumna] [nvarchar](4) NOT NULL,
 CONSTRAINT [PK_ExcelHojaCampo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [Comisiones].[ExcelHojaCampo]  WITH CHECK ADD  CONSTRAINT [FK_ExcelHojaCampo_Excel] FOREIGN KEY([ExcelId])
REFERENCES [Comisiones].[Excel] ([Id])
GO

ALTER TABLE [Comisiones].[ExcelHojaCampo] CHECK CONSTRAINT [FK_ExcelHojaCampo_Excel]
GO

CREATE TABLE [Comisiones].[Productividad](
	CargaId int NOT NULL,
	Secuencia int NOT NULL,
	SupervisorId int NULL,
	Supervisor nvarchar(250) NOT NULL,
	GrupoId int NULL,
	Grupo nvarchar(20) NOT NULL,
	EmpleadoId int NULL,
	Empleado nvarchar(250) NOT NULL,
	DiasAsistencia int NOT NULL,
	TotalProductividad int NOT NULL,
	Logro int NOT NULL,
	MetaDiaria decimal(8,2) NULL,
	MetaReal decimal(8,2) NULL,
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

ALTER TABLE [Comisiones].[Productividad]  WITH CHECK ADD  CONSTRAINT [FK_Productividad_Supervisor] FOREIGN KEY([SupervisorId])
REFERENCES [Comisiones].[Empleado] ([Id])
GO
ALTER TABLE [Comisiones].[Productividad] CHECK CONSTRAINT [FK_Productividad_Supervisor]
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
	DentroPlazo int NULL,
	FueraPlazo int NULL,
	TotalGeneral int NULL,
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
	[CampoMeta] [int] NULL,
	[CampoAcumulado] [int] NOT NULL,
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