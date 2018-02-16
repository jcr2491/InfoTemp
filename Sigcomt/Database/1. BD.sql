
USE [BancoFalabellaBI]
GO
--ELIMINAR SP
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[GetHistorialCargaPorArchivo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[GetHistorialCargaPorArchivo]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[GetCabeceraCargaProcesado]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[GetCabeceraCargaProcesado]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[AddCabeceraCarga]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[AddCabeceraCarga]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[LogInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[LogInsert]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[RolGetAllActives]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[RolGetAllActives]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[UsuarioUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[UsuarioUpdate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[UsuarioDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[UsuarioDelete]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[UsuarioInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[UsuarioInsert]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[UsuarioGetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[UsuarioGetById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[UsuarioGetAllFilter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[UsuarioGetAllFilter]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[CargoGetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[CargoGetById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[CargoGetAllFilter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[CargoGetAllFilter]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[RolGetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[RolGetById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[RolGetAllFilter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[RolGetAllFilter]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[UsuarioGetByUsername]') AND type in (N'P', N'PC'))
DROP PROCEDURE [ReporteComisiones].[UsuarioGetByUsername]
GO
--ELIMINAR TABLAS
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Usuario]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Usuario]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Rol]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Rol]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Log]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Log]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[LogError]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[LogError]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[CabeceraCarga]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[CabeceraCarga]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Calidad]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Calidad]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Cargo]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Cargo]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[CargoComision]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[CargoComision]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[CmrRatificada]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[CmrRatificada]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[DiasAutomotriz]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[DiasAutomotriz]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Dias_Ausencia]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[DiasAusencia]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Empleado]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Empleado]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Equipo_ConsolidadoMes]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[EquipoConsolidadoMes]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Excel]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Excel]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[ExcelHoja]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[ExcelHoja]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[ExcelHojaTI]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[ExcelHojaTI]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[ExcelHojaTICampo]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[ExcelHojaTICampo]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Grupo]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Grupo]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Indicador]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Indicador]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[IndicadorCumplimiento]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[IndicadorEncabezado]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[IndicadorCumplimiento]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[IndicadorCumplimiento]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Monitoreo]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Monitoreo]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[MontosTrasladosCTS]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[MontosTrasladosCTS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[MPonderacion]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[MPonderacion]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[ProducContactenos]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[ProducContactenos]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[Productividad]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[Productividad]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[ProductividadEsp]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[ProductividadEsp]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[ProductividadSuperJefe]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[ProductividadSuperJefe]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[SLA]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[SLA]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[SLAUAC]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[SLAUAC]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ReporteComisiones].[TotalCuentas2Abono]') AND type in (N'U'))
DROP TABLE [ReporteComisiones].[TotalCuentas2Abono]
GO

IF  EXISTS (SELECT * FROM sys.schemas WHERE name = N'ReporteComisiones')
DROP SCHEMA [ReporteComisiones]
GO
--CREAR ESQUEMA
CREATE SCHEMA ReporteComisiones
GO

--CREAR TABLAS
CREATE TABLE [ReporteComisiones].[Log](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](100) NOT NULL,
	[Mensaje] [varchar](4000) NOT NULL,
	[Controlador] [varchar](200) NOT NULL,
	[Accion] [varchar](100) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Objeto] [varchar](4000) NOT NULL,
	[Identificador] [int] NULL,
 CONSTRAINT [PK_ReporteComisiones_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [ReporteComisiones].[LogError](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ErrorNumber] [int] NOT NULL,
	[ErrorSeverity] [int] NOT NULL,
	[ErrorState] [int] NOT NULL,
	[ErrorProcedure] [varchar](100) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[ErrorMessage] [varchar](4000) NOT NULL,
	[ErrorLine] [int] NULL,
 CONSTRAINT [PK_ReporteComisiones_LogError] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [ReporteComisiones].[Usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](100) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Apellido] [varchar](100) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[CargoId] [int] NOT NULL,
	[RolId] [int] NOT NULL,
	[Estado] [int] NOT NULL,
	[UsuarioCreacion] [varchar](100) NOT NULL,
	[UsuarioModificacion] [varchar](100) NULL,
	[FechaHoraCreacion] [datetime] NOT NULL,
	[FechaHoraModificacion] [datetime] NULL,
 CONSTRAINT [PK_ReporteComisiones_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [ReporteComisiones].[CabeceraCarga](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TipoArchivo] [char](2) NOT NULL,
	[FechaArchivo] [datetime] NOT NULL,
	[FechaCargaIni] [datetime] NOT NULL,
	[FechaCargaFin] [datetime] NULL,
	[EstadoCarga] [int] NOT NULL,
 CONSTRAINT [pk_cabeceracarga] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[Calidad](
	[CargaId] [int] NOT NULL,
	[Id] [int] NOT NULL,
	[Semana] [varchar](50) NULL,
	[FechaMuestra] [datetime] NULL,
	[Incidente] [int] NULL,
	[EspecialistaId] [int] NULL,
	[Proceso] [varchar](250) NULL,
	[TipoMonitoreo] [varchar](5) NULL,
	[CR1] [int] NULL,
	[CR2] [int] NULL,
	[CR3] [int] NULL,
	[CR4] [int] NULL,
	[CR5] [int] NULL,
	[CR6] [int] NULL,
	[CR7] [int] NULL,
	[CR_SUMA] [int] NULL,
	[CS1] [int] NULL,
	[CS2] [int] NULL,
	[CS_SUMA] [nchar](10) NULL,
	[CP1] [int] NULL,
	[CP_SUMA] [int] NULL,
	[OR1] [int] NULL,
	[OR2] [int] NULL,
	[OR_SUMA] [int] NULL,
	[VR1] [int] NULL,
	[VR2] [int] NULL,
	[VR3] [int] NULL,
	[VR4] [int] NULL,
	[VR_SUMA] [int] NULL,
	[MR1] [int] NULL,
	[MR2] [int] NULL,
	[MR3] [int] NULL,
	[MR_SUMA] [int] NULL,
	[Nota] [decimal](8, 2) NULL,
	[Cumple_Estand] [varchar](50) NULL,
 CONSTRAINT [PK_Calidad] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[Cargo](
	[Id] [tinyint] NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Area] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cargo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


GO

CREATE TABLE [ReporteComisiones].[Rol](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](200) NULL,
	[Estado] [int] NOT NULL,
 CONSTRAINT [PK_ReporteComisiones_Rol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [ReporteComisiones].[CargoComision](
	[CargoId] [tinyint] NOT NULL,
	[Comision] [decimal](8, 2) NULL CONSTRAINT [DF_CargoComision_Comision]  DEFAULT ((0)),
	[Estado] [bit] NULL CONSTRAINT [DF_CargoComision_Estado]  DEFAULT ((1)),
 CONSTRAINT [PK_CargoComision_1] PRIMARY KEY CLUSTERED 
(
	[CargoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[CmrRatificada](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[Nomcorto] [varchar](50) NULL,
	[Ratificada] [int] NULL,
 CONSTRAINT [PK_CmrRatificada] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[DataAutomotriz](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[NroPrestamo] [int] NULL,
	[TipoDoc] [varchar](50) NULL,
	[Documento] [int] NULL,
	[Nombre] [nvarchar](250) NULL,
	[FechaDesembolso] [datetime] NULL,
	[Canal] [varchar](50) NULL,
	[Captacion] [varchar](50) NULL,
	[Promotor] [nvarchar](50) NULL,
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

CREATE TABLE [ReporteComisiones].[DiasAusencia](
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

GO

CREATE TABLE [ReporteComisiones].[Empleado](
	[EmpleadoID] [int] NOT NULL,
	[Nombres] [varchar](100) NULL,
	[Apellidos] [varchar](100) NULL,
	[NomCorto] [varchar](50) NULL,
	[NomCalidar] [varchar](250) NULL,
	[NomData] [varchar](250) NULL,
	[NomProducSLA] [varchar](250) NULL,
	[NomGesco] [varchar](250) NULL,
	[CargoId] [tinyint] NULL,
	[Cargo] [varchar](250) NULL,
 CONSTRAINT [PK_Empleado_1] PRIMARY KEY CLUSTERED 
(
	[EmpleadoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[EquipoConsolidadoMes](
	[CargaId] [int] NOT NULL,
	[GrupoId] [varchar](3) NOT NULL,
	[SumaMetaTotal] [int] NULL,
	[SumaCasosCerrados] [int] NULL,
	[Logro] [decimal](5, 2) NULL,
 CONSTRAINT [PK_EquipoEsp_Consolidado] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[GrupoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[Excel](
	[ExcelId] [int] IDENTITY(1,1) NOT NULL,
	[NomExcel] [varchar](250) NULL,
	[Descripcion] [varchar](500) NULL,
	[Ruta] [varchar](500) NULL,
 CONSTRAINT [PK_InputExcel] PRIMARY KEY CLUSTERED 
(
	[ExcelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[ExcelHoja](
	[ExcelId] [int] NOT NULL,
	[HojaId] [int] NOT NULL,
	[Hoja] [nvarchar](100) NULL,
	[Descripcion] [nvarchar](500) NULL,
 CONSTRAINT [PK_InputExcel_Hoja] PRIMARY KEY CLUSTERED 
(
	[ExcelId] ASC,
	[HojaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[ExcelHojaTI](
	[ExcelId] [int] NOT NULL,
	[HojaId] [int] NOT NULL,
	[TablaInputId] [int] NOT NULL,
	[TablaInput] [nvarchar](100) NULL,
	[SubTablaInput] [nvarchar](100) NULL,
	[Observaciones] [nvarchar](500) NULL,
	[CeldaInicio] [nvarchar](100) NULL,
	[CeldaFin] [nvarchar](100) NULL,
	[ColumnasOmitidas] [nvarchar](100) NULL,
	[Rangos] [nvarchar](150) NULL,
 CONSTRAINT [PK_IExcel_HojaTablaInput] PRIMARY KEY CLUSTERED 
(
	[ExcelId] ASC,
	[HojaId] ASC,
	[TablaInputId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[ExcelHojaTICampo](
	[ExcelId] [int] NOT NULL,
	[HojaId] [int] NOT NULL,
	[TablaInputId] [int] NOT NULL,
	[Colum] [varchar](50) NOT NULL,
	[ColExcel] [nvarchar](100) NULL,
	[ColDestino] [nvarchar](100) NULL,
 CONSTRAINT [PK_IExcel_HojaTI_Campo_1] PRIMARY KEY CLUSTERED 
(
	[ExcelId] ASC,
	[HojaId] ASC,
	[TablaInputId] ASC,
	[Colum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[Grupo](
	[GrupoId] [int] NOT NULL,
	[Grupo] [varchar](50) NULL,
	[ResposableId] [int] NULL,
	[Responsable] [varchar](100) NULL,
 CONSTRAINT [PK_Grupo] PRIMARY KEY CLUSTERED 
(
	[GrupoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[Indicador](
	[IndicadorId] [int] NOT NULL,
	[Indicador] [nvarchar](250) NULL,
	[Area] [varchar](50) NULL,
	[Porcentaje] [decimal](5, 2) NULL,
 CONSTRAINT [PK_Indicadores] PRIMARY KEY CLUSTERED 
(
	[IndicadorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[IndicadorEncabezado](
	[IndicadorId] [int] NOT NULL,
	[EncabezadoId] [int] NOT NULL,
	[Encabezado] [varchar](100) NULL,
	[Factor] [decimal](5, 2) NULL,
	[Formula] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Ind_Encabezado] PRIMARY KEY CLUSTERED 
(
	[IndicadorId] ASC,
	[EncabezadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[IndicadorCumplimiento](
	[TablaId] [varchar](50) NOT NULL,
	[Secuencia] [tinyint] NOT NULL,
	[Inicio] [decimal](8, 2) NULL,
	[Fin] [decimal](8, 2) NULL,
	[Cumplimiento] [varchar](50) NULL,
	[Puntaje] [decimal](8, 2) NULL,
	[Premio] [decimal](8, 2) NULL,
	[GestionIndivGrupal] [varchar](50) NULL,
 CONSTRAINT [PK_TCumplimiento] PRIMARY KEY CLUSTERED 
(
	[TablaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[Monitoreo](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[Semana] [varchar](50) NULL,
	[Mes] [tinyint] NULL,
	[FechaMuestra] [datetime] NULL,
	[Incidente] [int] NULL,
	[EspecialistaId] [int] NULL,
	[Especialista] [varchar](250) NULL,
	[Proceso] [varchar](50) NULL,
	[TipoMonitoreo] [varchar](5) NULL,
	[CR1] [varchar](5) NULL,
	[CR2] [varchar](5) NULL,
	[CR3] [varchar](5) NULL,
	[CR4] [varchar](5) NULL,
	[CR5] [varchar](5) NULL,
	[CR6] [varchar](5) NULL,
	[CR7] [varchar](5) NULL,
	[CS1] [varchar](5) NULL,
	[CS2] [varchar](5) NULL,
	[CP1] [varchar](5) NULL,
	[OR1] [varchar](5) NULL,
	[OR2] [varchar](5) NULL,
	[VR1] [varchar](5) NULL,
	[VR2] [varchar](5) NULL,
	[VR3] [varchar](5) NULL,
	[VR4] [varchar](5) NULL,
	[MR1] [varchar](5) NULL,
	[MR2] [varchar](5) NULL,
	[MR3] [varchar](5) NULL,
 CONSTRAINT [PK_Monitoreo] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[MontosTrasladosCTS](
	[CargaId] [int] NOT NULL,
	[Secuecnia] [int] NOT NULL,
	[NomCorto] [varchar](50) NULL,
	[NroAperturas] [int] NULL,
	[NroTransferencias] [int] NULL,
	[MontoTotal] [decimal](18, 2) NULL,
 CONSTRAINT [PK_MontosTransladosCTS] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuecnia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[MPonderacion](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[Semana] [varchar](50) NULL,
	[Mes] [tinyint] NULL,
	[FechaMuestra] [datetime] NULL,
	[Incidente] [int] NULL,
	[EspecialistaId] [int] NULL,
	[NomEspecialista] [varchar](250) NULL,
	[Proceso] [varchar](50) NULL,
	[TipoMonitoreo] [varchar](5) NULL,
	[CR1] [decimal](8, 2) NULL,
	[CR2] [decimal](8, 2) NULL,
	[CR3] [decimal](8, 2) NULL,
	[CR4] [decimal](8, 2) NULL,
	[CR5] [decimal](8, 2) NULL,
	[CR6] [decimal](8, 2) NULL,
	[CR7] [decimal](8, 2) NULL,
	[CR_SUMA] [decimal](8, 2) NULL,
	[CS1] [decimal](8, 2) NULL,
	[CS2] [decimal](8, 2) NULL,
	[CS_SUMA] [decimal](8, 2) NULL,
	[CP1] [decimal](8, 2) NULL,
	[CP_SUMA] [decimal](8, 2) NULL,
	[OR1] [decimal](8, 2) NULL,
	[OR2] [decimal](8, 2) NULL,
	[OR_SUMA] [decimal](8, 2) NULL,
	[VR1] [decimal](8, 2) NULL,
	[VR2] [decimal](8, 2) NULL,
	[VR3] [decimal](8, 2) NULL,
	[VR4] [decimal](8, 2) NULL,
	[VR_SUMA] [decimal](8, 2) NULL,
	[MR1] [decimal](8, 2) NULL,
	[MR2] [decimal](8, 2) NULL,
	[MR3] [decimal](8, 2) NULL,
	[MR_SUMA] [decimal](8, 2) NULL,
	[Nota] [decimal](8, 2) NULL,
	[Cumple_Estand] [varchar](50) NULL,
 CONSTRAINT [PK_IM_Ponderacion] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[ProducContactenos](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[EmpleadoId] [int] NULL,
	[Empleado] [nvarchar](250) NOT NULL,
	[TotalAtendido] [int] NULL,
	[DiasLaborados] [int] NULL,
	[MetaDiaria] [int] NULL,
	[MesaMes] [int] NULL,
	[Productividad] [decimal](5, 2) NULL,
 CONSTRAINT [PK_IProduc_Contactenos] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[Productividad](
	[CargaId] [int] NOT NULL,
	[Id] [int] NOT NULL,
	[SupervisorId] [int] NULL,
	[Supervisor] [nvarchar](250) NULL,
	[EquipoEsp] [varchar](5) NULL,
	[Usuario] [nvarchar](250) NULL,
	[TotalProd] [int] NULL,
	[DiasConCierres] [int] NULL,
	[Meta_Diaria] [int] NULL,
	[Dias_Asistencia] [int] NULL,
	[Logro_Redond] [int] NULL,
	[Logro] [decimal](5, 2) NULL,
	[MetaReal] [int] NULL,
	[MetaAjust] [int] NULL,
	[AppAnd] [float] NULL,
	[LogroAjustado] [decimal](5, 2) NULL,
 CONSTRAINT [PK_IProductividad] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[ProductividadEsp](
	[CargaId] [int] NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[GrupoId] [varchar](3) NULL,
	[SuperId] [int] NULL,
	[CargoId] [tinyint] NULL,
	[DiasLaborados] [int] NULL,
	[CR_Factor] [decimal](5, 2) NULL,
	[CR_MetaTotal] [decimal](5, 2) NULL,
	[CR_CasosCerrados] [int] NULL,
	[CR_Cumplimiento] [decimal](5, 2) NULL,
	[CR_Nota1] [decimal](5, 2) NULL,
	[SLA_Factor] [decimal](5, 2) NULL,
	[SLA_Total] [int] NULL,
	[SLA_NroCasos] [int] NULL,
	[SLA_Cumplimiento] [decimal](5, 2) NULL,
	[SLA_Nota2] [decimal](5, 2) NULL,
	[KPI_Nota1y2] [decimal](5, 2) NULL,
	[KPI_SumaPesos] [decimal](5, 2) NULL,
	[KPI_Nota] [decimal](5, 2) NULL,
	[KPI_Puntaje] [decimal](5, 2) NULL,
	[CAL_Impug] [decimal](5, 2) NULL,
	[CAL_Puntaje] [decimal](5, 2) NULL,
	[CRE_MetaTotal] [int] NULL,
	[CRE_CasosCerrados] [int] NULL,
	[CRE_Cumplimiento] [decimal](5, 2) NULL,
	[Comision_A] [decimal](8, 2) NULL,
	[Premio_B] [decimal](8, 2) NULL,
	[Total_ComisPremio] [decimal](8, 2) NULL,
 CONSTRAINT [PK_Productividad_Esp] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[EmpleadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[ProductividadSuperJefe](
	[CargaId] [int] NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[CargoId] [varchar](3) NULL,
	[DiasLaborados] [tinyint] NULL,
	[CRE_Factor] [decimal](5, 2) NULL,
	[CRE_MetaTotal] [int] NULL,
	[CRE_CasosCerrados] [int] NULL,
	[CRE_Cumplimiento] [decimal](5, 2) NULL,
	[CRE_Nota1] [decimal](5, 2) NULL,
	[SLAE_Factor] [nchar](10) NULL,
	[SLAE_Total] [int] NULL,
	[SLAE_NroCasos] [int] NULL,
	[SLAE_Cumplimiento] [decimal](5, 2) NULL,
	[SLAE_Nota2] [decimal](5, 2) NULL,
	[KPI_Nota1y2] [decimal](5, 2) NULL,
	[KPI_SumaPesos] [decimal](5, 2) NULL,
	[KPI_Nota] [decimal](5, 2) NULL,
	[KPI_Puntaje] [decimal](5, 2) NULL,
	[CAL_Impug] [decimal](5, 2) NULL,
	[CAL_Cumplimiento] [decimal](5, 2) NULL,
	[Comision_A] [decimal](8, 2) NULL,
	[Premio_B] [decimal](8, 2) NULL,
	[Total_AyB] [decimal](8, 2) NULL,
 CONSTRAINT [PK_Productividad_Super_Jefe] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[EmpleadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[SLA](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[SupervisorId] [int] NULL,
	[Supervisor] [varchar](250) NULL,
	[GrupoId] [varchar](5) NULL,
	[GrupoEsp] [varchar](50) NULL,
	[EmpeladoId] [int] NULL,
	[Empleado] [varchar](250) NULL,
	[FueraPlazo] [decimal](8, 2) NULL,
	[DentroPlazo] [decimal](8, 2) NULL,
	[TotalGeneral] [decimal](8, 2) NULL,
	[SLAConAjuste] [decimal](8, 2) NULL,
	[SLASinAjuste] [decimal](8, 2) NULL,
 CONSTRAINT [PK_IProductividadSLA] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[SLAUAC](
	[CargaId] [int] NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[DentroPlazo] [tinyint] NULL,
	[FueraPlazo] [tinyint] NULL,
	[TotalGeneral] [int] NULL,
	[SLA] [varchar](50) NULL,
 CONSTRAINT [PK_ISLA_UAC] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[EmpleadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [ReporteComisiones].[TotalCuentas2Abono](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[NomCorto] [varchar](50) NULL,
	[CS] [int] NULL,
	[CSyCTS] [int] NULL,
	[CSyCMR] [int] NULL,
	[CSyCTSyCMR] [int] NULL,
	[Total2Abono] [int] NULL,
 CONSTRAINT [PK_TotalCuentas2Abono] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [ReporteComisiones].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Rol] FOREIGN KEY([RolId])
REFERENCES [ReporteComisiones].[Rol] ([Id])
GO

ALTER TABLE [ReporteComisiones].[Usuario] CHECK CONSTRAINT [FK_Usuario_Rol]
GO


-------------------------------CREACION DE SP-------------------------------

-- =====================================================
-- Author:  MC
-- Create date: 02/11/2016
-- Description: Listar Usuario por username
-- Test: exec [ReporteComisiones].[UsuarioGetByUsername] @Username = ''
-- =====================================================
CREATE PROCEDURE [ReporteComisiones].[UsuarioGetByUsername]
@Username VARCHAR(100)
AS
BEGIN
SET NOCOUNT ON;
	SELECT 
	U.Id,
	U.Username,
	U.CargoId,
	U.RolId,
	U.Estado,
	R.Nombre AS RolNombre
	FROM
	[ReporteComisiones].Usuario U 
	inner join[ReporteComisiones].Rol R on U.RolId= R.Id 
	WHERE
	U.Username = @Username
	AND U.Estado = 1

END
GO

-- =============================================      
-- Author:  MC      
-- Create date: 02/11/2016     
-- Description: Insertar log
-- Test : [ReporteComisiones].[LogInsert] '','','','','',0
-- =============================================  

CREATE PROCEDURE [ReporteComisiones].[LogInsert]
@Usuario VARCHAR(100),
@Mensaje VARCHAR(4000),
@Controlador VARCHAR(200),
@Accion VARCHAR(100),
@Objeto VARCHAR(4000),
@Identificador BIGINT,
@Response INT OUT
AS
BEGIN
BEGIN TRAN 
BEGIN TRY

INSERT INTO ReporteComisiones.Log(Usuario,Mensaje,Controlador,Accion,FechaRegistro,Objeto,Identificador)
values(@Usuario,@Mensaje,@Controlador,@Accion,GETDATE(),@Objeto,@Identificador)
COMMIT TRAN
SET @Response=(SELECT @@IDENTITY)
select @Response
END TRY 
BEGIN CATCH
ROLLBACK TRAN
  SET @Response = 0;
		INSERT INTO [ReporteComisiones].[LogError]([ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [FechaRegistro], [ErrorMessage], [ErrorLine])
		SELECT ISNULL(ERROR_NUMBER(),0) AS ErrorNumber
		,ISNULL(ERROR_SEVERITY(),0) AS ErrorSeverity
		,ISNULL(ERROR_STATE(),0) AS ErrorState
		,ISNULL(ERROR_PROCEDURE(),0) AS ErrorProcedure
		,GETDATE()		
		,ISNULL(ERROR_MESSAGE(),0) AS ErrorMessage
		,ISNULL(ERROR_LINE(),0) AS ErrorLine;
END CATCH
END
GO

-- =====================================================
-- Author:  MC
-- Create date: 02/11/2016
-- Description: Listar Cargo
-- Test: EXEC [ReporteComisiones].[CargoGetAllFilter] @WhereFilters = ''
-- =====================================================
CREATE PROCEDURE [ReporteComisiones].[CargoGetAllFilter]
@WhereFilters VARCHAR(MAX) = ''
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @SentenciaSQL nvarchar(MAX)
	SET @SentenciaSQL =  '

	;WITH Consulta AS (
	SELECT
		Id
		,Nombre
		,Descripcion
		,Estado
	FROM ReporteComisiones.Cargo ' + 
	@WhereFilters + 
	') SELECT *
	FROM Consulta '	
	PRINT (@SentenciaSQL);
    EXECUTE sp_executesql  @stmt = @SentenciaSQL

END
GO

-- =====================================================
-- Author:  MC
-- Create date: 02/11/2016
-- Description: Listar Rol
-- Test: EXEC [ReporteComisiones].[RolGetAllFilter] @WhereFilters = ''
-- =====================================================
CREATE PROCEDURE [ReporteComisiones].[RolGetAllFilter]
@WhereFilters VARCHAR(MAX) = ''
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @SentenciaSQL nvarchar(MAX)
	SET @SentenciaSQL =  '

	;WITH Consulta AS (
	SELECT
		Id
		,Nombre
		,Descripcion
		,Estado
	FROM ReporteComisiones.Rol ' + 
	@WhereFilters + 
	') SELECT *
	FROM Consulta '	
	PRINT (@SentenciaSQL);
    EXECUTE sp_executesql  @stmt = @SentenciaSQL

END
GO

-- =============================================      
-- Author:  MC      
-- Create date: 02/11/2016     
-- Description: Obtener Rol por Id
-- Test : [ReporteComisiones].[RolGetById] 1
-- =============================================  
CREATE PROCEDURE [ReporteComisiones].[RolGetById]
@Id INT
AS
BEGIN

	SET NOCOUNT ON;
	SELECT 
	Id,
	Nombre,
	Descripcion,
	Estado
	FROM [ReporteComisiones].[Rol]
	WHERE Id = @Id;	
END
GO

-- =====================================================
-- Author:  MC
-- Create date: 02/11/2016
-- Description: Listar Usuario
-- Test: EXEC [ReporteComisiones].[UsuarioGetAllFilter] @WhereFilters = '', @OrderBy = '', @Rows = 10
-- =====================================================
CREATE PROCEDURE [ReporteComisiones].[UsuarioGetAllFilter]
@WhereFilters VARCHAR(MAX) = '',
@OrderBy VARCHAR (100) = '', 
@Start INT = 0,
@Rows INT = 0
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @SentenciaSQL nvarchar(MAX)
	SET @SentenciaSQL =  '

	;WITH Consulta AS (
	SELECT
		U.Id
		,U.Username
		,U.Nombre
		,U.Apellido
		,U.Correo
		,R.Id RolId
		,R.Nombre RolNombre
		,U.Estado
	FROM ReporteComisiones.Usuario U
	INNER JOIN ReporteComisiones.Rol R ON U.RolId = R.Id ' + 
	@WhereFilters + 
	') SELECT *
	FROM Consulta
	CROSS JOIN (SELECT Count(*) AS Cantidad FROM Consulta) AS CC
	ORDER BY ' +
	CASE WHEN ISNULL(@OrderBy,'') != '' THEN (@OrderBy) 
	ELSE ' ID ASC ' END
	    + ' ' +
	' OFFSET ' + CONVERT(VARCHAR, (@Start)) + 
	' ROWS FETCH NEXT ' + CONVERT(VARCHAR, @Rows) + ' ROWS ONLY'
	PRINT (@SentenciaSQL);
    EXECUTE sp_executesql  @stmt = @SentenciaSQL

END
GO

-- =============================================      
-- Author:  MC      
-- Create date: 02/11/2016     
-- Description: Obtener Usuario por Id
-- Test : [ReporteComisiones].[UsuarioGetById] 1
-- =============================================  
CREATE PROCEDURE [ReporteComisiones].[UsuarioGetById]
@Id INT
AS
BEGIN

	SET NOCOUNT ON;
	SELECT 
	Id,
	Username,
	Nombre,
	Apellido,
	Correo,
	CargoId,
	RolId,
	Estado
	FROM [ReporteComisiones].[Usuario]
	WHERE Id = @Id;	
END
GO

-- =============================================      
-- Author:  MC      
-- Create date: 02/11/2016     
-- Description: Insertar Usuario
-- Test : [ReporteComisiones].[UsuarioInsert] 'gruiz','Geo','Ruiz','gruiz@sigcomt.com',1,1,1,'ADMIN',0
-- =============================================  
create PROCEDURE [ReporteComisiones].[UsuarioInsert]
@Username VARCHAR(100),
@Nombre VARCHAR(100),
@Apellido VARCHAR(100),
@Correo VARCHAR(100),
@CargoId INT,
@RolId INT,
@Estado INT,
@UsuarioCreacion VARCHAR(100),
@Response int out
AS
BEGIN
BEGIN TRAN 
BEGIN TRY
	SET NOCOUNT ON;
	INSERT INTO [ReporteComisiones].[Usuario](Username, Nombre, Apellido, Correo, CargoId,RolId, Estado, UsuarioCreacion, UsuarioModificacion, FechaHoraCreacion, FechaHoraModificacion)
    VALUES(@Username, @Nombre, @Apellido, @Correo,@CargoId, @RolId, @Estado, @UsuarioCreacion, NULL, GETDATE(), NULL);
	--	SELECT @@IDENTITY as Id;
	COMMIT TRAN

	 SET @Response = (SELECT @@IDENTITY);	
	 SELECT @Response
END TRY
BEGIN CATCH 
ROLLBACK TRAN
		SET @Response = 0;

		INSERT INTO [ReporteComisiones].[LogError]([ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [FechaRegistro], [ErrorMessage], [ErrorLine])
		SELECT ISNULL(ERROR_NUMBER(),0) AS ErrorNumber
		,ISNULL(ERROR_SEVERITY(),0) AS ErrorSeverity
		,ISNULL(ERROR_STATE(),0) AS ErrorState
		,ISNULL(ERROR_PROCEDURE(),0) AS ErrorProcedure
		,GETDATE()		
		,ISNULL(ERROR_MESSAGE(),0) AS ErrorMessage
		,ISNULL(ERROR_LINE(),0) AS ErrorLine;
END CATCH
END
GO

-- =============================================      
-- Author:  MC      
-- Create date: 02/11/2016     
-- Description: Eliminar Usuario
-- Test : [ReporteComisiones].[UsuarioDelete] 1
-- =============================================  
CREATE PROCEDURE [ReporteComisiones].[UsuarioDelete]
@Id INT,
@Response INT OUT
AS
BEGIN
  BEGIN TRAN
  BEGIN TRY


	SET NOCOUNT ON;
	DECLARE @FILASAFECTADA INT = 0;
	IF EXISTS (SELECT Id FROM [ReporteComisiones].[Usuario] WHERE Id = @Id)
	BEGIN
		UPDATE [ReporteComisiones].[Usuario] 
		SET Estado = 0
		WHERE Id = @Id;
	
		SET @FILASAFECTADA = @Id;
	END
	COMMIT TRAN
	SELECT @FILASAFECTADA AS Id;
	set @Response=@FILASAFECTADA
	END TRY
BEGIN CATCH
	ROLLBACK TRAN
	SET @Response=0
	INSERT INTO [ReporteComisiones].[LogError]([ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [FechaRegistro], [ErrorMessage], [ErrorLine])
		SELECT ISNULL(ERROR_NUMBER(),0) AS ErrorNumber
		,ISNULL(ERROR_SEVERITY(),0) AS ErrorSeverity
		,ISNULL(ERROR_STATE(),0) AS ErrorState
		,ISNULL(ERROR_PROCEDURE(),0) AS ErrorProcedure
		,GETDATE()		
		,ISNULL(ERROR_MESSAGE(),0) AS ErrorMessage
		,ISNULL(ERROR_LINE(),0) AS ErrorLine;
	END CATCH
END
GO

-- =============================================      
-- Author:  MC      
-- Create date: 02/11/2016     
-- Description: Actualizar Usuario
-- Test : [ReporteComisiones].[UsuarioUpdate] 'mcastillo','Mijail','Castillo','mcastillo@sigcomt.com',1,1, 1,'ADMIN',3
-- =============================================  
CREATE PROCEDURE [ReporteComisiones].[UsuarioUpdate]
@Username VARCHAR(100),
@Nombre VARCHAR(100),
@Apellido VARCHAR(100),
@Correo VARCHAR(100),
@CargoId INT,
@RolId INT,
@Estado INT,
@UsuarioModificacion VARCHAR(100),
@Id INT,
@Response int out
AS
BEGIN
BEGIN TRAN 
BEGIN TRY
	SET NOCOUNT ON;
	DECLARE @FILASAFECTADA INT = 0;
	DECLARE @EXITS INT=(SELECT COUNT(*) FROM [ReporteComisiones].Usuario WHERE Estado=1 AND Username=@Username AND Id!= @Id)

	IF EXISTS (SELECT Id FROM [ReporteComisiones].[Usuario] WHERE Id = @Id)
	BEGIN
	    IF @EXITS=0
		BEGIN
				UPDATE [ReporteComisiones].[Usuario] 
				SET Username = @Username,
				Nombre = @Nombre,
				Apellido = @Apellido,
				Correo = @Correo,
				CargoId =  @CargoId,
				RolId =  @RolId,
				Estado = @Estado,
				UsuarioModificacion = @UsuarioModificacion,
				FechaHoraModificacion = GETDATE()
				WHERE Id = @Id;
				SET @FILASAFECTADA = @Id;
				set @Response=@FILASAFECTADA
		END
		ELSE 
		BEGIN
		       SET @Response=-2
		END
		
	END
	COMMIT TRAN;
	SELECT @Response

	END TRY	
BEGIN CATCH
ROLLBACK TRAN
	SET @Response = 0;
		INSERT INTO [ReporteComisiones].[LogError]([ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [FechaRegistro], [ErrorMessage], [ErrorLine])
		SELECT ISNULL(ERROR_NUMBER(),0) AS ErrorNumber
		,ISNULL(ERROR_SEVERITY(),0) AS ErrorSeverity
		,ISNULL(ERROR_STATE(),0) AS ErrorState
		,ISNULL(ERROR_PROCEDURE(),0) AS ErrorProcedure
		,GETDATE()		
		,ISNULL(ERROR_MESSAGE(),0) AS ErrorMessage
		,ISNULL(ERROR_LINE(),0) AS ErrorLine;
END CATCH

END
GO

-- =============================================      
-- Author:  MC      
-- Create date: 20/02/2017     
-- Description: Obtener Roles activos
-- Test : [ReporteComisiones].[RolGetAllActives]
-- =============================================  
CREATE PROCEDURE [ReporteComisiones].[RolGetAllActives]
AS
BEGIN

	SET NOCOUNT ON;
	SELECT 
	Id,
	Nombre
	FROM [ReporteComisiones].[Rol]
	WHERE Estado = 1;	
END
GO
-- =============================================      
-- Author:  PZ      
-- Create date: 21/11/2017     
-- Description: Agrega un registro a la tabla CabeceraCarga
-- =============================================  
CREATE PROCEDURE [ReporteComisiones].[AddCabeceraCarga]
	@TipoArchivo CHAR(2),
	@FechaArchivo DATETIME,
	@FechaCargaIni DATETIME,
	@EstadoCarga INT
AS    
BEGIN
	DECLARE @OutputTbl TABLE (Id INT)

	INSERT INTO ReporteComisiones.CabeceraCarga (TipoArchivo, FechaArchivo, FechaCargaIni, EstadoCarga)
	OUTPUT INSERTED.Id INTO @OutputTbl(Id)
	VALUES(@TipoArchivo, @FechaArchivo, @FechaCargaIni, @EstadoCarga);

	SELECT Id FROM @OutputTbl;
END
GO
-- =============================================      
-- Author:  PZ      
-- Create date: 21/11/2017     
-- Description: Obtiene el historial de las cargas por tipo de archivo
-- =============================================  
CREATE PROCEDURE [ReporteComisiones].[GetHistorialCargaPorArchivo]
	@TipoArchivo CHAR(2)
AS    
BEGIN
	SELECT TOP 60
		Id,
		TipoArchivo,
		FechaArchivo,
		FechaCargaIni,
		FechaCargaFin,
		EstadoCarga
	FROM
	(
		SELECT 
			Id,
			TipoArchivo,
			FechaArchivo,
			FechaCargaIni,
			FechaCargaFin,
			EstadoCarga,
			ROW_NUMBER() OVER (PARTITION BY FechaArchivo ORDER BY FechaArchivo DESC, FechaCargaIni DESC) RowNumber
		FROM [ReporteComisiones].[CabeceraCarga]
		WHERE TipoArchivo = @TipoArchivo	
	) temp
	WHERE RowNumber = 1
	ORDER BY FechaArchivo DESC
END
GO
-- =============================================      
-- Author:  PZ      
-- Create date: 21/11/2017     
-- Description: Obtiene la carga por TipoArchivo y la FechaArchivo
-- =============================================  
CREATE PROCEDURE [ReporteComisiones].[GetCabeceraCargaProcesado]
	@TipoArchivo CHAR(2),
	@FechaArchivo DATETIME
AS    
BEGIN
	SELECT TOP 1
		Id,
		TipoArchivo,
		FechaArchivo,
		FechaCargaIni,
		FechaCargaFin,
		EstadoCarga
	FROM ReporteComisiones.CabeceraCarga	
	WHERE TipoArchivo = @TipoArchivo 
		AND FechaArchivo = @FechaArchivo
		AND EstadoCarga = 1
END