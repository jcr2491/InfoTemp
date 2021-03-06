CREATE DATABASE BancoFalabellaBI
GO
USE [BancoFalabellaBI]
GO
CREATE SCHEMA Comisiones
GO
/****** Object:  Table [Comisiones].[CabeceraCarga]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[CabeceraCarga](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Calidad]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Calidad](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Cargo]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Cargo](
	[Id] [tinyint] NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Area] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cargo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[CargoComision]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comisiones].[CargoComision](
	[CargoId] [tinyint] NOT NULL,
	[Comision] [decimal](8, 2) NULL CONSTRAINT [DF_CargoComision_Comision]  DEFAULT ((0)),
	[Estado] [bit] NULL CONSTRAINT [DF_CargoComision_Estado]  DEFAULT ((1)),
 CONSTRAINT [PK_CargoComision_1] PRIMARY KEY CLUSTERED 
(
	[CargoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comisiones].[CmrRatificada]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[CmrRatificada](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[NomCorto] [varchar](50) NULL,
	[Ratificada] [int] NULL,
 CONSTRAINT [PK_CmrRatificada] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[DataAutomotriz]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[DataAutomotriz](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[DiasAusencia]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Empleado]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Empleado](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[EquipoConsolidadoMes]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[EquipoConsolidadoMes](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Excel]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Excel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](40) NULL,
	[Descripcion] [varchar](500) NULL,
	[Ruta] [varchar](500) NULL,
 CONSTRAINT [PK_InputExcel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[ExcelHoja]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[ExcelHoja](
	[ExcelId] [int] NOT NULL,
	[TipoArchivo] [varchar](2) NOT NULL,
	[FilaIni] [int] NOT NULL,
	[NombreHoja] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](500) NULL,
 CONSTRAINT [PK_ExcelHoja] PRIMARY KEY CLUSTERED 
(
	[ExcelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[ExcelHojaCampo]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[ExcelHojaCampo](
	[ExcelId] [int] NOT NULL,
	[TipoArchivo] [varchar](2) NOT NULL,
	[NombreCampo] [varchar](50) NOT NULL,
	[NombreCelda] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ExcelHojaCampo] PRIMARY KEY CLUSTERED 
(
	[ExcelId] ASC,
	[TipoArchivo] ASC,
	[NombreCampo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[ExcelHojaTI]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comisiones].[ExcelHojaTI](
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
/****** Object:  Table [Comisiones].[Grupo]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Grupo](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Indicador]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Indicador](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[IndicadorCumplimiento]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[IndicadorCumplimiento](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[IndicadorEncabezado]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[IndicadorEncabezado](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Log]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Log](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](100) NOT NULL,
	[Mensaje] [varchar](4000) NOT NULL,
	[Controlador] [varchar](200) NOT NULL,
	[Accion] [varchar](100) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Objeto] [varchar](4000) NOT NULL,
	[Identificador] [int] NULL,
 CONSTRAINT [PK_Comisiones_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Monitoreo]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Monitoreo](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[MontosTrasladosCTS]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[MontosTrasladosCTS](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[MPonderacion]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[MPonderacion](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[ProducContactenos]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comisiones].[ProducContactenos](
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
/****** Object:  Table [Comisiones].[Productividad]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comisiones].[Productividad](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[SupervisorId] [int] NULL,
	[Supervisor] [nvarchar](250) NOT NULL,
	[GrupoId] [int] NULL,
	[Grupo] [nvarchar](20) NOT NULL,
	[EmpleadoId] [int] NULL,
	[Empleado] [nvarchar](250) NOT NULL,
	[Dias_Asistencia] [int] NOT NULL,
	[TotalProductividad] [int] NOT NULL,
	[Logro] [int] NOT NULL,
 CONSTRAINT [PK_IProductividad] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comisiones].[ProductividadEsp]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[ProductividadEsp](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[ProductividadSuperJefe]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[ProductividadSuperJefe](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Rol]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Rol](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](200) NULL,
	[Estado] [int] NOT NULL,
 CONSTRAINT [PK_Comisiones_Rol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[SLA]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[SLA](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[SLAUAC]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[SLAUAC](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[TotalCuentas2Abono]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[TotalCuentas2Abono](
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Usuario]    Script Date: 05/12/2017 06:32:35 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Usuario](
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
 CONSTRAINT [PK_Comisiones_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [Comisiones].[CabeceraCarga] ON 

INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (1, N'6 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-11-30 17:04:36.937' AS DateTime), CAST(N'2017-11-30 17:04:37.223' AS DateTime), 1)
SET IDENTITY_INSERT [Comisiones].[CabeceraCarga] OFF
INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Area]) VALUES (1, N'Especialista UAC', N'Especialista')
INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Area]) VALUES (2, N'Supervisor', N'Supervisor')
INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Area]) VALUES (3, N'Jefe UAC', N'Jefe')
INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Area]) VALUES (4, N'Apoyo UAC', N'Especialista')
INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Area]) VALUES (5, N'Especialista UAC Noche', N'Especialista')
INSERT [Comisiones].[CargoComision] ([CargoId], [Comision], [Estado]) VALUES (1, CAST(750.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[CargoComision] ([CargoId], [Comision], [Estado]) VALUES (2, CAST(500.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[CargoComision] ([CargoId], [Comision], [Estado]) VALUES (3, CAST(2000.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[CargoComision] ([CargoId], [Comision], [Estado]) VALUES (4, CAST(300.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[CargoComision] ([CargoId], [Comision], [Estado]) VALUES (5, CAST(277.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 1, 1003014000, N'D.N.I', 12896534, N'ABREGU GONZÁLEZ ADELMO CRISTY', CAST(N'2017-10-01 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'TORRES MUÑOZ MARCELO DENISSE', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(42372.00 AS Decimal(18, 2)), CAST(11500.00 AS Decimal(18, 2)), CAST(30872.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 2, 1003014001, N'D.N.I', 12896535, N'ABREU RODRÍGUEZ ADOLFO WALTER', CAST(N'2017-10-02 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'TORRES MUÑOZ MARCELO DENISSE', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(41951.19 AS Decimal(18, 2)), CAST(8390.23 AS Decimal(18, 2)), CAST(33560.95 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 3, 1003014002, N'D.N.I', 12896536, N'ADAMES GÓMEZ ADRIANO TERESA', CAST(N'2017-10-03 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'TORRES MUÑOZ MARCELO DENISSE', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(44903.19 AS Decimal(18, 2)), CAST(8980.63 AS Decimal(18, 2)), CAST(35922.55 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 4, 1003014003, N'D.N.I', 12896537, N'ADARO FERNÁNDEZ AILÍN FERNANDO', CAST(N'2017-10-04 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'TORRES MUÑOZ MARCELO DENISSE', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(34407.19 AS Decimal(18, 2)), CAST(6881.43 AS Decimal(18, 2)), CAST(27525.75 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 5, 1003014004, N'D.N.I', 12896538, N'ADAUTO LÓPEZ ALBERTO SONIA', CAST(N'2017-10-05 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORADOR NAVARRO PABLO HAROLD', N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(50291.09 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), CAST(35291.09 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 6, 1003014005, N'D.N.I', 12896539, N'AGRADA DÍAZ ALEJANDRO ARLETH', CAST(N'2017-10-06 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORADOR NAVARRO PABLO HAROLD', N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(45690.40 AS Decimal(18, 2)), CAST(25000.00 AS Decimal(18, 2)), CAST(20690.40 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 7, 1003014006, N'D.N.I', 12896540, N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', CAST(N'2017-10-07 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORADOR NAVARRO PABLO HAROLD', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(78927.10 AS Decimal(18, 2)), CAST(23500.00 AS Decimal(18, 2)), CAST(55427.09 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 8, 1003014007, N'D.N.I', 12896541, N'ALCABES PÉREZ ALFREDO ANGELA', CAST(N'2017-10-08 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORADOR NAVARRO PABLO HAROLD', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(66066.94 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), CAST(46066.94 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 9, 1003014008, N'D.N.I', 12896542, N'ALMEIDA GARCÍA ALVAREZ JAVIER', CAST(N'2017-10-09 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORADOR NAVARRO PABLO HAROLD', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(36263.69 AS Decimal(18, 2)), CAST(7252.73 AS Decimal(18, 2)), CAST(29010.95 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 10, 1003014009, N'D.N.I', 12896543, N'ALMEYDA SÁNCHEZ ALVARO JOSE', CAST(N'2017-10-10 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(45314.00 AS Decimal(18, 2)), CAST(9063.00 AS Decimal(18, 2)), CAST(36251.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 11, 1003014010, N'D.N.I', 12896544, N'ALVARES ROMERO ANA CRISTINA', CAST(N'2017-10-11 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(56047.00 AS Decimal(18, 2)), CAST(13825.00 AS Decimal(18, 2)), CAST(42222.00 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 12, 1003014011, N'D.N.I', 12896545, N'ALVES SOSA ANDREA NORMA', CAST(N'2017-10-12 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(53406.00 AS Decimal(18, 2)), CAST(18000.00 AS Decimal(18, 2)), CAST(35406.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 13, 1003014012, N'D.N.I', 12896546, N'AMADO ÁLVAREZ ANDRÉS ELSA', CAST(N'2017-10-13 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(52767.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), CAST(32767.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 14, 1003014013, N'D.N.I', 12896547, N'AMARAL TORRES ANGELO KRISTOFER', CAST(N'2017-10-14 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(51142.00 AS Decimal(18, 2)), CAST(10229.00 AS Decimal(18, 2)), CAST(40913.00 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 15, 1003014014, N'D.N.I', 12896548, N'ANGOBALDO RAMÍREZ ARIEL JAMES', CAST(N'2017-10-15 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(77302.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(27302.00 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 16, 1003014015, N'D.N.I', 12896549, N'ANTUNES FLORES ARSENIO HINDRA', CAST(N'2017-10-16 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(43169.00 AS Decimal(18, 2)), CAST(8634.00 AS Decimal(18, 2)), CAST(34535.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 17, 1003014016, N'D.N.I', 12896550, N'BAES ACOSTA ARTURO TELLO', CAST(N'2017-10-17 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOCARMO VILLALBA NICOLAS LUYO', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(44085.32 AS Decimal(18, 2)), CAST(8817.10 AS Decimal(18, 2)), CAST(35268.22 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 18, 1003014017, N'D.N.I', 12896551, N'BARBOZA BENÍTEZ BRAULIO FASABI', CAST(N'2017-10-18 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOCARMO VILLALBA NICOLAS LUYO', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(45517.52 AS Decimal(18, 2)), CAST(22758.77 AS Decimal(18, 2)), CAST(22758.75 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 19, 1003014018, N'D.N.I', 12896552, N'BARDALES MEDINA CARLOS MARIA', CAST(N'2017-10-19 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOCARMO VILLALBA NICOLAS LUYO', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(34726.00 AS Decimal(18, 2)), CAST(7800.00 AS Decimal(18, 2)), CAST(26926.00 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 20, 1003014019, N'D.N.I', 12896553, N'BARROSO SUÁREZ CRISTÓBAL NORIS', CAST(N'2017-10-20 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOCARMO VILLALBA NICOLAS LUYO', N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(80958.50 AS Decimal(18, 2)), CAST(44766.30 AS Decimal(18, 2)), CAST(36192.20 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 21, 1003014020, N'D.N.I', 12896554, N'BATISTA HERRERA DIEGO LUZ', CAST(N'2017-10-21 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'JUNIOR MÉNDEZ VICENTE CANDY', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(51029.00 AS Decimal(18, 2)), CAST(10206.00 AS Decimal(18, 2)), CAST(40823.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 22, 1003014021, N'D.N.I', 12896555, N'BRANCO AGUIRRE EDUARDO KEYKO', CAST(N'2017-10-22 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'JUNIOR MÉNDEZ VICENTE CANDY', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(53584.00 AS Decimal(18, 2)), CAST(10717.00 AS Decimal(18, 2)), CAST(42867.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 23, 1003014022, N'D.N.I', 12896556, N'CALIENES PEREYRA ESTEBAN MELISSA', CAST(N'2017-10-23 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'JUNIOR MÉNDEZ VICENTE CANDY', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(47673.00 AS Decimal(18, 2)), CAST(11000.00 AS Decimal(18, 2)), CAST(36673.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 24, 1003014023, N'D.N.I', 12896557, N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', CAST(N'2017-10-24 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'EVANGELISTA CÓRDOBA PICHI JANETH', N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(46784.45 AS Decimal(18, 2)), CAST(11954.00 AS Decimal(18, 2)), CAST(34830.45 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 25, 1003014024, N'D.N.I', 12896558, N'CASAL GIMÉNEZ FERNANDO MARGOTH', CAST(N'2017-10-25 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'EVANGELISTA CÓRDOBA PICHI JANETH', N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(54706.32 AS Decimal(18, 2)), CAST(21909.00 AS Decimal(18, 2)), CAST(32797.32 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 26, 1003014025, N'D.N.I', 12896559, N'CERNADES MOLINA FORTUNATO AMARELIS', CAST(N'2017-10-26 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'EVANGELISTA CÓRDOBA PICHI JANETH', N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(110166.30 AS Decimal(18, 2)), CAST(68670.00 AS Decimal(18, 2)), CAST(41496.30 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 27, 1003014026, N'D.N.I', 12896560, N'CLIMACO SILVA GERARDO PIERO', CAST(N'2017-10-27 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'EVANGELISTA CÓRDOBA PICHI JANETH', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(92646.89 AS Decimal(18, 2)), CAST(49650.00 AS Decimal(18, 2)), CAST(42996.90 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 28, 1003014027, N'D.N.I', 12896561, N'COELHO CASTRO HECTOR DIANA', CAST(N'2017-10-28 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'EVANGELISTA CÓRDOBA PICHI JANETH', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(47069.69 AS Decimal(18, 2)), CAST(9413.93 AS Decimal(18, 2)), CAST(37655.76 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 29, 1003014028, N'D.N.I', 12896562, N'COIMBRA ROJAS HUENU LILIAN', CAST(N'2017-10-29 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOSANTOS CORONEL PEHUEN JESSENIA', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(77302.80 AS Decimal(18, 2)), CAST(39240.00 AS Decimal(18, 2)), CAST(38062.80 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 30, 1003014029, N'D.N.I', 12896563, N'COSINGA ORTÍZ HUGO DE', CAST(N'2017-10-30 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOSANTOS CORONEL PEHUEN JESSENIA', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(55076.59 AS Decimal(18, 2)), CAST(13769.15 AS Decimal(18, 2)), CAST(41307.44 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 31, 1003014030, N'D.N.I', 12896564, N'COSTA NÚÑEZ IGNACIO PAULA', CAST(N'2017-10-31 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOSANTOS CORONEL PEHUEN JESSENIA', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(56047.80 AS Decimal(18, 2)), CAST(35970.00 AS Decimal(18, 2)), CAST(20077.79 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 32, 1003014031, N'D.N.I', 12896565, N'GONZÁLEZ  LUNA JAVIER CARMEN', CAST(N'2017-10-20 00:00:00.000' AS DateTime), N'CCFF', N'118 CAL Bellavista CF', N'GUTIÉRREZ VÁZQUEZ NEYEN GRECIA', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(55158.43 AS Decimal(18, 2)), CAST(35000.00 AS Decimal(18, 2)), CAST(20158.43 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 33, 1003014032, N'D.N.I', 12896566, N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', CAST(N'2017-10-15 00:00:00.000' AS DateTime), N'CCFF', N'208 SANTA ANITA', N'MENDOZA OJEDA MARCO LUIS', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(56970.00 AS Decimal(18, 2)), CAST(25000.00 AS Decimal(18, 2)), CAST(31970.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 34, 1003014033, N'D.N.I', 12896567, N'PÉREZ CABRERA JORGE SUSANA', CAST(N'2017-10-19 00:00:00.000' AS DateTime), N'CCFF', N'106 MIR Pardo CF SF', N'LEANDRO LUCERO VICTOR ROSA', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(43204.00 AS Decimal(18, 2)), CAST(18904.00 AS Decimal(18, 2)), CAST(24300.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 35, 1003014034, N'D.N.I', 12896568, N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', CAST(N'2017-10-04 00:00:00.000' AS DateTime), N'CCFF', N'107 SJM Atocongo CF', N'MIDEROS OLIVERA ROSA', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(87885.00 AS Decimal(18, 2)), CAST(60885.00 AS Decimal(18, 2)), CAST(27000.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 36, 1003014035, N'D.N.I', 12896569, N'GARCÍA FERREYRA JUAN LINDERIKA', CAST(N'2017-10-04 00:00:00.000' AS DateTime), N'CCFF', N'105 TT LA MARINA', N'DOS ARIAS PEDRO ELISA', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(38431.12 AS Decimal(18, 2)), CAST(13000.00 AS Decimal(18, 2)), CAST(25431.11 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 37, 1003014036, N'D.N.I', 12896570, N'MARTÍNEZ GODOY JULIAN MARINA', CAST(N'2017-10-19 00:00:00.000' AS DateTime), N'CCFF', N'107 SJM Atocongo CF', N'MARKO PAIRAZAWAMAN TORREZ', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(49150.00 AS Decimal(18, 2)), CAST(16000.00 AS Decimal(18, 2)), CAST(33150.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 38, 1003014037, N'D.N.I', 12896571, N'SÁNCHEZ MORALES JULIO JORGE', CAST(N'2017-10-06 00:00:00.000' AS DateTime), N'CCFF', N'304 AQP Cayma CF SF', N'DOMINGUES CARDOZO NULPI YEFERSON', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(21490.00 AS Decimal(18, 2)), CAST(4900.00 AS Decimal(18, 2)), CAST(16590.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 39, 1003014038, N'D.N.I', 12896572, N'LÓPEZ DOMÍNGUEZ LEONARDO JORGE', CAST(N'2017-10-12 00:00:00.000' AS DateTime), N'CCFF', N'311 centro financiero tottus trujillo mall', N'PEDRO ORTIZ SALAS', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(45452.26 AS Decimal(18, 2)), CAST(10363.00 AS Decimal(18, 2)), CAST(35089.26 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 40, 1003014039, N'D.N.I', 12896573, N'DÍAZ MORENO LICHUEN WIDSENIA', CAST(N'2017-10-20 00:00:00.000' AS DateTime), N'CCFF', N'311 centro financiero tottus trujillo mall', N'MIRELES SOTO CARLOS', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(62007.57 AS Decimal(18, 2)), CAST(42000.00 AS Decimal(18, 2)), CAST(20007.57 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 41, 1003014040, N'D.N.I', 12896574, N'ROJAS PERALTA LOLA URSULA', CAST(N'2017-10-12 00:00:00.000' AS DateTime), N'CCFF', N'303 PIU Saga Falabella CF', N'MINAURO DUARTE TREICY', N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(32036.00 AS Decimal(18, 2)), CAST(6410.00 AS Decimal(18, 2)), CAST(25626.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 42, 1003014041, N'D.N.I', 12896575, N'RAMÍREZ VEGA LUCHO MIRIAM', CAST(N'2017-10-27 00:00:00.000' AS DateTime), N'CCFF', N'CCFF CUSCO', N'MORENO VERA NAHUEL NEHUEN ANAVELA', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(35110.19 AS Decimal(18, 2)), CAST(7023.00 AS Decimal(18, 2)), CAST(28087.20 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 43, 1003014042, N'D.N.I', 12896576, N'CASTILLO CARRIZO LUIS KATHERINE', CAST(N'2017-10-06 00:00:00.000' AS DateTime), N'CCFF', N'301 TRU Pizarro CF', N'MEDINA PONCE MIGUEL DAVID', N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(27640.00 AS Decimal(18, 2)), CAST(7640.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [Nombre], [FechaDesembolso], [Canal], [Captacion], [Promotor], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (1, 44, 1003014043, N'D.N.I', 12896577, N'GÓMEZ QUIROGA MAITEN DENISE', CAST(N'2017-10-27 00:00:00.000' AS DateTime), N'CCFF', N'304 AQP Cayma CF SF', N'DOMINGUES CARDOZO NULPI YEFERSON', N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(52204.19 AS Decimal(18, 2)), CAST(10500.00 AS Decimal(18, 2)), CAST(41704.19 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 1, NULL, 2, N'BANCO FALABELLA', N'ABREU RODRÍGUEZ ADOLFO WALTER', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 2, NULL, 2, N'BANCO FALABELLA', N'ADAMES GÓMEZ ADRIANO TERESA', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 3, NULL, 2, N'BANCO FALABELLA', N'ADARO FERNÁNDEZ AILÍN FERNANDO', 2017, 10, 1, N'', CAST(9.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 4, NULL, 2, N'BANCO FALABELLA', N'ADAUTO LÓPEZ ALBERTO SONIA', 2017, 10, 1, N'', CAST(12.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 5, NULL, 2, N'BANCO FALABELLA', N'AGRADA DÍAZ ALEJANDRO ARLETH', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 6, NULL, 2, N'BANCO FALABELLA', N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', 2017, 10, 1, N'', CAST(14.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 7, NULL, 2, N'BANCO FALABELLA', N'ALCABES PÉREZ ALFREDO ANGELA', 2017, 10, 1, N'', CAST(6.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 8, NULL, 2, N'BANCO FALABELLA', N'ALMEIDA GARCÍA ALVAREZ JAVIER', 2017, 10, 1, N'', CAST(7.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 9, NULL, 2, N'BANCO FALABELLA', N'ALMEYDA SÁNCHEZ ALVARO JOSE', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 10, NULL, 2, N'BANCO FALABELLA', N'ALVARES ROMERO ANA CRISTINA', 2017, 10, 1, N'', CAST(31.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 11, NULL, 2, N'BANCO FALABELLA', N'ALVES SOSA ANDREA NORMA', 2017, 10, 1, N'', CAST(3.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 12, NULL, 2, N'BANCO FALABELLA', N'AMADO ÁLVAREZ ANDRÉS ELSA', 2017, 10, 1, N'', CAST(14.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 13, NULL, 2, N'BANCO FALABELLA', N'AMARAL TORRES ANGELO KRISTOFER', 2017, 10, 1, N'', CAST(9.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 14, NULL, 2, N'BANCO FALABELLA', N'ANGOBALDO RAMÍREZ ARIEL JAMES', 2017, 10, 1, N'', CAST(9.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 15, NULL, 2, N'BANCO FALABELLA', N'ANTUNES FLORES ARSENIO HINDRA', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 16, NULL, 2, N'BANCO FALABELLA', N'BAES ACOSTA ARTURO TELLO', 2017, 10, 1, N'', CAST(7.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 17, NULL, 2, N'BANCO FALABELLA', N'BARBOZA BENÍTEZ BRAULIO FASABI', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 18, NULL, 2, N'BANCO FALABELLA', N'BARDALES MEDINA CARLOS MARIA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 19, NULL, 2, N'BANCO FALABELLA', N'BARROSO SUÁREZ CRISTÓBAL NORIS', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 20, NULL, 2, N'BANCO FALABELLA', N'BATISTA HERRERA DIEGO LUZ', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 21, NULL, 2, N'BANCO FALABELLA', N'BRANCO AGUIRRE EDUARDO KEYKO', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 22, NULL, 2, N'BANCO FALABELLA', N'CALIENES PEREYRA ESTEBAN MELISSA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 23, NULL, 2, N'BANCO FALABELLA', N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 24, NULL, 2, N'BANCO FALABELLA', N'CASAL GIMÉNEZ FERNANDO MARGOTH', 2017, 10, 1, N'', CAST(5.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 25, NULL, 2, N'BANCO FALABELLA', N'CERNADES MOLINA FORTUNATO AMARELIS', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 26, NULL, 2, N'BANCO FALABELLA', N'CLIMACO SILVA GERARDO PIERO', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 27, NULL, 2, N'BANCO FALABELLA', N'COELHO CASTRO HECTOR DIANA', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 28, NULL, 2, N'BANCO FALABELLA', N'COIMBRA ROJAS HUENU LILIAN', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 29, NULL, 2, N'BANCO FALABELLA', N'COSINGA ORTÍZ HUGO DE', 2017, 10, 1, N'', CAST(3.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 30, NULL, 2, N'BANCO FALABELLA', N'COSTA NÚÑEZ IGNACIO PAULA', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 31, NULL, 2, N'BANCO FALABELLA', N'GONZÁLEZ  LUNA JAVIER CARMEN', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 32, NULL, 2, N'BANCO FALABELLA', N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', 2017, 10, 1, N'', CAST(5.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 33, NULL, 2, N'BANCO FALABELLA', N'PÉREZ CABRERA JORGE SUSANA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 34, NULL, 2, N'BANCO FALABELLA', N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 35, NULL, 2, N'BANCO FALABELLA', N'GARCÍA FERREYRA JUAN LINDERIKA', 2017, 10, 1, N'', CAST(9.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 36, NULL, 2, N'BANCO FALABELLA', N'MARTÍNEZ GODOY JULIAN MARINA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 37, NULL, 2, N'BANCO FALABELLA', N'SÁNCHEZ MORALES JULIO JORGE', 2017, 10, 1, N'', CAST(7.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 38, NULL, 2, N'BANCO FALABELLA', N'LÓPEZ DOMÍNGUEZ LEONARDO JORGE', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 39, NULL, 2, N'BANCO FALABELLA', N'DÍAZ MORENO LICHUEN WIDSENIA', 2017, 10, 1, N'', CAST(3.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 40, NULL, 2, N'BANCO FALABELLA', N'ROJAS PERALTA LOLA URSULA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 41, NULL, 2, N'BANCO FALABELLA', N'RAMÍREZ VEGA LUCHO MIRIAM', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 42, NULL, 2, N'BANCO FALABELLA', N'CASTILLO CARRIZO LUIS KATHERINE', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 43, NULL, 2, N'BANCO FALABELLA', N'GÓMEZ QUIROGA MAITEN DENISE', 2017, 10, 1, N'', CAST(31.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 44, NULL, 2, N'BANCO FALABELLA', N'ROMERO CASTILLO MANQUE JOEL', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 45, NULL, 2, N'BANCO FALABELLA', N'FERNANDEZ LEDESMA MANUEL HELMUD', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 46, NULL, 2, N'BANCO FALABELLA', N'TORRES MUÑOZ MARCELO DENISSE', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 47, NULL, 2, N'BANCO FALABELLA', N'MENDOZA OJEDA MARCO LUIS', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 48, NULL, 2, N'BANCO FALABELLA', N'MEDINA PONCE MIGUEL DAVID', 2017, 10, 1, N'', CAST(7.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 49, NULL, 2, N'BANCO FALABELLA', N'MORENO VERA NAHUEL NEHUEN ANAVELA', 2017, 10, 1, N'', CAST(5.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 50, NULL, 2, N'BANCO FALABELLA', N'GUTIÉRREZ VÁZQUEZ NEYEN GRECIA', 2017, 10, 1, N'', CAST(26.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 51, NULL, 2, N'BANCO FALABELLA', N'DOCARMO VILLALBA NICOLAS LUYO', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 52, NULL, 2, N'BANCO FALABELLA', N'DOMINGUES CARDOZO NULPI YEFERSON', 2017, 10, 1, N'', CAST(8.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 53, NULL, 2, N'BANCO FALABELLA', N'DORADOR NAVARRO PABLO HAROLD', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 54, NULL, 2, N'BANCO FALABELLA', N'DORREGO RAMOS PATRÍCIO SANTOS', 2017, 10, 1, N'', CAST(4.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 55, NULL, 2, N'BANCO FALABELLA', N'DOS ARIAS PEDRO ELISA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 56, NULL, 2, N'BANCO FALABELLA', N'DOSANTOS CORONEL PEHUEN JESSENIA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 57, NULL, 2, N'BANCO FALABELLA', N'EVANGELISTA CÓRDOBA PICHI JANETH', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 58, NULL, 2, N'BANCO FALABELLA', N'JUNIOR MÉNDEZ VICENTE CANDY', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 59, NULL, 2, N'BANCO FALABELLA', N'LEANDRO LUCERO VICTOR ROSA', 2017, 10, 1, N'', CAST(7.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (2, 60, NULL, 2, N'BANCO FALABELLA', N'LEAO CRUZ XAVIER YACO YOEL', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896534, N'', N'', NULL, N'ABREGU GONZÁLEZ', N'ABREGU GONZÁLEZ ADELMO CRISTY', NULL, N'ABREGU GONZÁLEZ ADELMO CRISTY', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896535, N'', N'', NULL, N'ABREU RODRÍGUEZ', N'ABREU RODRÍGUEZ ADOLFO WALTER', NULL, N'ABREU RODRÍGUEZ ADOLFO WALTER', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896536, N'', N'', NULL, N'ADAMES GÓMEZ ', N'ADAMES GÓMEZ ADRIANO TERESA', NULL, N'ADAMES GÓMEZ ADRIANO TERESA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896537, N'', N'', NULL, N'ADARO FERNÁNDEZ', N'ADARO FERNÁNDEZ AILÍN FERNANDO', NULL, N'ADARO FERNÁNDEZ AILÍN FERNANDO', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896538, N'', N'', NULL, N'ADAUTO LÓPEZ ', N'ADAUTO LÓPEZ ALBERTO SONIA', NULL, N'ADAUTO LÓPEZ ALBERTO SONIA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896539, N'', N'', NULL, N'AGRADA DÍAZ ', N'AGRADA DÍAZ ALEJANDRO ARLETH', NULL, N'AGRADA DÍAZ ALEJANDRO ARLETH', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896540, N'', N'', NULL, N'ALBURQUEQUE ', N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', NULL, N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896541, N'', N'', NULL, N'ALCABES PÉREZ ', N'ALCABES PÉREZ ALFREDO ANGELA', NULL, N'ALCABES PÉREZ ALFREDO ANGELA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896542, N'', N'', NULL, N'ALMEIDA GARCÍA ', N'ALMEIDA GARCÍA ALVAREZ JAVIER', NULL, N'ALMEIDA GARCÍA ALVAREZ JAVIER', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896543, N'', N'', NULL, N'ALMEYDA SÁNCHEZ', N'ALMEYDA SÁNCHEZ ALVARO JOSE', NULL, N'ALMEYDA SÁNCHEZ ALVARO JOSE', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896544, N'', N'', NULL, N'ALVARES ROMERO ', N'ALVARES ROMERO ANA CRISTINA', NULL, N'ALVARES ROMERO ANA CRISTINA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896545, N'', N'', NULL, N'ALVES SOSA ', N'ALVES SOSA ANDREA NORMA', NULL, N'ALVES SOSA ANDREA NORMA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896546, N'', N'', NULL, N'AMADO ÁLVAREZ ', N'AMADO ÁLVAREZ ANDRÉS ELSA', NULL, N'AMADO ÁLVAREZ ANDRÉS ELSA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896547, N'', N'', NULL, N'AMARAL TORRES ', N'AMARAL TORRES ANGELO KRISTOFER', NULL, N'AMARAL TORRES ANGELO KRISTOFER', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896548, N'', N'', NULL, N'ANGOBALDO RAMÍREZ', N'ANGOBALDO RAMÍREZ ARIEL JAMES', NULL, N'ANGOBALDO RAMÍREZ ARIEL JAMES', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896549, N'', N'', NULL, N'ANTUNES FLORES ', N'ANTUNES FLORES ARSENIO HINDRA', NULL, N'ANTUNES FLORES ARSENIO HINDRA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896550, N'', N'', NULL, N'BAES ACOSTA ', N'BAES ACOSTA ARTURO TELLO', NULL, N'BAES ACOSTA ARTURO TELLO', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896551, N'', N'', NULL, N'BARBOZA BENÍTEZ', N'BARBOZA BENÍTEZ BRAULIO FASABI', NULL, N'BARBOZA BENÍTEZ BRAULIO FASABI', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896552, N'', N'', NULL, N'BARDALES MEDINA', N'BARDALES MEDINA CARLOS MARIA', NULL, N'BARDALES MEDINA CARLOS MARIA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896553, N'', N'', NULL, N'BARROSO SUÁREZ ', N'BARROSO SUÁREZ CRISTÓBAL NORIS', NULL, N'BARROSO SUÁREZ CRISTÓBAL NORIS', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896554, N'', N'', NULL, N'BATISTA HERRERA', N'BATISTA HERRERA DIEGO LUZ', NULL, N'BATISTA HERRERA DIEGO LUZ', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896555, N'', N'', NULL, N'BRANCO AGUIRRE ', N'BRANCO AGUIRRE EDUARDO KEYKO', NULL, N'BRANCO AGUIRRE EDUARDO KEYKO', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896556, N'', N'', NULL, N'CALIENES PEREYRA', N'CALIENES PEREYRA ESTEBAN MELISSA', NULL, N'CALIENES PEREYRA ESTEBAN MELISSA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896557, N'', N'', NULL, N'CARDOSO GUTIÉRREZ', N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', NULL, N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896558, N'', N'', NULL, N'CASAL GIMÉNEZ ', N'CASAL GIMÉNEZ FERNANDO MARGOTH', NULL, N'CASAL GIMÉNEZ FERNANDO MARGOTH', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896559, N'', N'', NULL, N'CERNADES MOLINA', N'CERNADES MOLINA FORTUNATO AMARELIS', NULL, N'CERNADES MOLINA FORTUNATO AMARELIS', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896560, N'', N'', NULL, N'CLIMACO SILVA ', N'CLIMACO SILVA GERARDO PIERO', NULL, N'CLIMACO SILVA GERARDO PIERO', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896561, N'', N'', NULL, N'COELHO CASTRO ', N'COELHO CASTRO HECTOR DIANA', NULL, N'COELHO CASTRO HECTOR DIANA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896562, N'', N'', NULL, N'COIMBRA ROJAS ', N'COIMBRA ROJAS HUENU LILIAN', NULL, N'COIMBRA ROJAS HUENU LILIAN', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896563, N'', N'', NULL, N'COSINGA ORTÍZ ', N'COSINGA ORTÍZ HUGO DE', NULL, N'COSINGA ORTÍZ HUGO DE', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896564, N'', N'', NULL, N'COSTA NÚÑEZ ', N'COSTA NÚÑEZ IGNACIO PAULA', NULL, N'COSTA NÚÑEZ IGNACIO PAULA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896565, N'', N'', NULL, N'GONZÁLEZ  LUNA ', N'GONZÁLEZ  LUNA JAVIER CARMEN', NULL, N'GONZÁLEZ  LUNA JAVIER CARMEN', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896566, N'', N'', NULL, N'RODRÍGUEZ JUÁREZ', N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', NULL, N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896567, N'', N'', NULL, N'PÉREZ CABRERA ', N'PÉREZ CABRERA JORGE SUSANA', NULL, N'PÉREZ CABRERA JORGE SUSANA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896568, N'', N'', NULL, N'HERNÁNDEZ RÍOS ', N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', NULL, N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896569, N'', N'', NULL, N'GARCÍA FERREYRA', N'GARCÍA FERREYRA JUAN LINDERIKA', NULL, N'GARCÍA FERREYRA JUAN LINDERIKA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896570, N'', N'', NULL, N'MARTÍNEZ GODOY ', N'MARTÍNEZ GODOY JULIAN MARINA', NULL, N'MARTÍNEZ GODOY JULIAN MARINA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896571, N'', N'', NULL, N'SÁNCHEZ MORALES', N'SÁNCHEZ MORALES JULIO JORGE', NULL, N'SÁNCHEZ MORALES JULIO JORGE', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896572, N'', N'', NULL, N'LÓPEZ DOMÍNGUEZ', N'LÓPEZ DOMÍNGUEZ LEONARDO JORGE', NULL, N'LÓPEZ DOMÍNGUEZ LEONARDO JORGE', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896573, N'', N'', NULL, N'DÍAZ MORENO ', N'DÍAZ MORENO LICHUEN WIDSENIA', NULL, N'DÍAZ MORENO LICHUEN WIDSENIA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896574, N'', N'', NULL, N'ROJAS PERALTA ', N'ROJAS PERALTA LOLA URSULA', NULL, N'ROJAS PERALTA LOLA URSULA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896575, N'', N'', NULL, N'RAMÍREZ VEGA ', N'RAMÍREZ VEGA LUCHO MIRIAM', NULL, N'RAMÍREZ VEGA LUCHO MIRIAM', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896576, N'', N'', NULL, N'CASTILLO CARRIZO', N'CASTILLO CARRIZO LUIS KATHERINE', NULL, N'CASTILLO CARRIZO LUIS KATHERINE', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896577, N'', N'', NULL, N'GÓMEZ QUIROGA ', N'GÓMEZ QUIROGA MAITEN DENISE', NULL, N'GÓMEZ QUIROGA MAITEN DENISE', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896578, N'', N'', NULL, N'ROMERO CASTILLO', N'ROMERO CASTILLO MANQUE JOEL', NULL, N'ROMERO CASTILLO MANQUE JOEL', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896579, N'', N'', NULL, N'FERNANDEZ LEDES', N'FERNANDEZ LEDESMA MANUEL HELMUD', NULL, N'FERNANDEZ LEDESMA MANUEL HELMUD', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896580, N'', N'', NULL, N'TORRES MUÑOZ MA', N'TORRES MUÑOZ MARCELO DENISSE', NULL, N'TORRES MUÑOZ MARCELO DENISSE', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896581, N'', N'', NULL, N'MENDOZA OJEDA M', N'MENDOZA OJEDA MARCO LUIS', NULL, N'MENDOZA OJEDA MARCO LUIS', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896582, N'', N'', NULL, N'MEDINA PONCE MI', N'MEDINA PONCE MIGUEL DAVID', NULL, N'MEDINA PONCE MIGUEL DAVID', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896583, N'', N'', NULL, N'MORENO VERA NAH', N'MORENO VERA NAHUEL NEHUEN ANAVELA', NULL, N'MORENO VERA NAHUEL NEHUEN ANAVELA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896584, N'', N'', NULL, N'GUTIÉRREZ VÁZQU', N'GUTIÉRREZ VÁZQUEZ NEYEN GRECIA', NULL, N'GUTIÉRREZ VÁZQUEZ NEYEN GRECIA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896585, N'', N'', NULL, N'DOCARMO VILLALB', N'DOCARMO VILLALBA NICOLAS LUYO', NULL, N'DOCARMO VILLALBA NICOLAS LUYO', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896586, N'', N'', NULL, N'DOMINGUES CARDO', N'DOMINGUES CARDOZO NULPI YEFERSON', NULL, N'DOMINGUES CARDOZO NULPI YEFERSON', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896587, N'', N'', NULL, N'DORADOR NAVARRO', N'DORADOR NAVARRO PABLO HAROLD', NULL, N'DORADOR NAVARRO PABLO HAROLD', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896588, N'', N'', NULL, N'DORREGO RAMOS P', N'DORREGO RAMOS PATRÍCIO SANTOS', NULL, N'DORREGO RAMOS PATRÍCIO SANTOS', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896589, N'', N'', NULL, N'DOS ARIAS PEDRO', N'DOS ARIAS PEDRO ELISA', NULL, N'DOS ARIAS PEDRO ELISA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896590, N'', N'', NULL, N'DOSANTOS CORONE', N'DOSANTOS CORONEL PEHUEN JESSENIA', NULL, N'DOSANTOS CORONEL PEHUEN JESSENIA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896591, N'', N'', NULL, N'EVANGELISTA CÓR', N'EVANGELISTA CÓRDOBA PICHI JANETH', NULL, N'EVANGELISTA CÓRDOBA PICHI JANETH', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896592, N'', N'', NULL, N'FARIA FIGUEROA ', N'FARIA FIGUEROA RADHIKA FULVIA', NULL, N'FARIA FIGUEROA RADHIKA FULVIA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896593, N'', N'', NULL, N'FAURA CORREA RA', N'FAURA CORREA RAFAEL MARIANELA', NULL, N'FAURA CORREA RAFAEL MARIANELA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896594, N'', N'', NULL, N'FERNANDES CÁCER', N'FERNANDES CÁCERES RAIQUEN KAREN', NULL, N'FERNANDES CÁCERES RAIQUEN KAREN', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896595, N'', N'', NULL, N'FERREIRA VARGAS', N'FERREIRA VARGAS RAUL WILMER', NULL, N'FERREIRA VARGAS RAUL WILMER', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896596, N'', N'', NULL, N'FERREYRA MALDON', N'FERREYRA MALDONADO RICARDO MIRTHA', NULL, N'FERREYRA MALDONADO RICARDO MIRTHA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896597, N'', N'', NULL, N'FINO MANSILLA R', N'FINO MANSILLA ROBERTO LILIA', NULL, N'FINO MANSILLA ROBERTO LILIA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896598, N'', N'', NULL, N'FREITAS FARÍAS ', N'FREITAS FARÍAS RODOLFO MAYRA', NULL, N'FREITAS FARÍAS RODOLFO MAYRA', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896599, N'', N'', NULL, N'GOMES RIVERO RO', N'GOMES RIVERO ROLANDO CESIA', NULL, N'GOMES RIVERO ROLANDO CESIA', NULL, N'#N/A')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896600, N'', N'', NULL, N'GONCALVES PAZ S', N'GONCALVES PAZ SANTIAGO JORGE', NULL, N'GONCALVES PAZ SANTIAGO JORGE', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896601, N'', N'', NULL, N'GUEDES MIRANDA ', N'GUEDES MIRANDA SEBASTIAN ISAURA', NULL, N'GUEDES MIRANDA SEBASTIAN ISAURA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896602, N'', N'', NULL, N'GUIMAREY ROLDÁN', N'GUIMAREY ROLDÁN SERGIO DIANA', NULL, N'GUIMAREY ROLDÁN SERGIO DIANA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896603, N'', N'', NULL, N'JUNIOR MÉNDEZ V', N'JUNIOR MÉNDEZ VICENTE CANDY', NULL, N'JUNIOR MÉNDEZ VICENTE CANDY', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896604, N'', N'', NULL, N'LEANDRO LUCERO ', N'LEANDRO LUCERO VICTOR ROSA', NULL, N'LEANDRO LUCERO VICTOR ROSA', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896605, N'', N'', NULL, N'LEAO CRUZ XAVIE', N'LEAO CRUZ XAVIER YACO YOEL', NULL, N'LEAO CRUZ XAVIER YACO YOEL', NULL, N'4')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896606, N'', N'', NULL, N'LENCASTRE HERNÁ', N'LENCASTRE HERNÁNDEZ YAMAI ANGIE', NULL, N'LENCASTRE HERNÁNDEZ YAMAI ANGIE', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896607, N'', N'', NULL, N'LOBATO AGÜERO Y', N'LOBATO AGÜERO YENIEN WILMER', NULL, N'LOBATO AGÜERO YENIEN WILMER', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896608, N'', N'', NULL, N'LOBO PÁEZ YERIM', N'LOBO PÁEZ YERIMEN KELY', NULL, N'LOBO PÁEZ YERIMEN KELY', NULL, N'1')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896609, N'', N'', NULL, N'LOPES BLANCO KA', N'LOPES BLANCO KATHERINE ', NULL, N'LOPES BLANCO KATHERINE ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896610, N'', N'', NULL, N'LUGO MENDOZA KE', N'LUGO MENDOZA KERLY ', NULL, N'LUGO MENDOZA KERLY ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896611, N'', N'', NULL, N'MAGALLANES BARR', N'MAGALLANES BARRIOS YENNIFER ', NULL, N'MAGALLANES BARRIOS YENNIFER ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896612, N'', N'', NULL, N'MAQUEIRA ESCOBA', N'MAQUEIRA ESCOBAR MARIA ', NULL, N'MAQUEIRA ESCOBAR MARIA ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896613, N'', N'', NULL, N'MARTOS ÁVILA KA', N'MARTOS ÁVILA KAYRO ', NULL, N'MARTOS ÁVILA KAYRO ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896614, N'', N'', NULL, N'MAURO SORIA LOR', N'MAURO SORIA LORENA ', NULL, N'MAURO SORIA LORENA ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896615, N'', N'', NULL, N'MEGO LEIVA NEST', N'MEGO LEIVA NESTOR ', NULL, N'MEGO LEIVA NESTOR ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896616, N'', N'', NULL, N'MELO ACUÑA JOSE', N'MELO ACUÑA JOSE ', NULL, N'MELO ACUÑA JOSE ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896617, N'', N'', NULL, N'MELLO MARTIN MI', N'MELLO MARTIN MILAGROS ', NULL, N'MELLO MARTIN MILAGROS ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896618, N'', N'', NULL, N'MENEJES MAIDANA', N'MENEJES MAIDANA LIZZET ', NULL, N'MENEJES MAIDANA LIZZET ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896619, N'', N'', NULL, N'MERELLO MOYANO ', N'MERELLO MOYANO KATHERINE ', NULL, N'MERELLO MOYANO KATHERINE ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896620, N'', N'', NULL, N'MERES CAMPOS AR', N'MERES CAMPOS ARIAGNA ', NULL, N'MERES CAMPOS ARIAGNA ', NULL, N'5')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896621, N'', N'', NULL, N'MIDEROS OLIVERA', N'MIDEROS OLIVERA ROSA ', NULL, N'MIDEROS OLIVERA ROSA ', NULL, N'2')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896622, N'', N'', NULL, N'MINAURO DUARTE ', N'MINAURO DUARTE TREICY ', NULL, N'MINAURO DUARTE TREICY ', NULL, N'2')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896623, N'', N'', NULL, N'MIRELES SOTO CA', N'MIRELES SOTO CARLOS ', NULL, N'MIRELES SOTO CARLOS ', NULL, N'2')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (12896624, N'', N'', NULL, N'MIRES FRANCO LA', N'MIRES FRANCO LA ', NULL, N'MIRES FRANCO LA ', NULL, N'2')
INSERT [Comisiones].[Empleado] ([EmpleadoID], [Nombres], [Apellidos], [NomCorto], [NomCalidar], [NomData], [NomProducSLA], [NomGesco], [CargoId], [Cargo]) VALUES (50098078, N'', N'', NULL, N'Elka Mendoza', N'Elka Mendoza Reategui', NULL, N'MENDOZA REATEGUI ELKA PAOLA', NULL, N'0')
SET IDENTITY_INSERT [Comisiones].[Excel] ON 

INSERT [Comisiones].[Excel] ([Id], [Nombre], [Descripcion], [Ruta]) VALUES (1, N'MONITOEREO', N'Input Monitoreo por Mes', NULL)
INSERT [Comisiones].[Excel] ([Id], [Nombre], [Descripcion], [Ruta]) VALUES (2, N'PRODUCTIVIDAD', N'Input Productividad por Resolutor por MEs', NULL)
INSERT [Comisiones].[Excel] ([Id], [Nombre], [Descripcion], [Ruta]) VALUES (3, N'PLANTILLA', N'Plantilla Comisiones UAC, cuenta con hojas maestro y los reportes finales', NULL)
INSERT [Comisiones].[Excel] ([Id], [Nombre], [Descripcion], [Ruta]) VALUES (4, N'ASISTENCIA', N'Asistencia de los empleados, para obtener los días laborados', NULL)
SET IDENTITY_INSERT [Comisiones].[Excel] OFF
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (1, 1, 1, N'IM_Ponderacion', NULL, NULL, N'A3', N'AH3', NULL, NULL)
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (2, 1, 1, N'IProductividad', NULL, NULL, N'A7', N'P7', N'H,M,O', NULL)
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (2, 2, 1, N'ISLA_UAC', NULL, NULL, N'A7', N'J7', N'G,I', NULL)
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 1, 1, N'T_Cumplimiento', NULL, N'ProducSLA_Esp', N'A6', N'D6', NULL, N'A6:D16')
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 1, 2, N'T_Cumplimiento', NULL, N'Calidad_Esp', N'A21', N'D21', NULL, N'A21:D29')
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 1, 3, N'T_Cumplimiento', NULL, N'Premios_Esp', N'A34', N'A34', NULL, N'A34:D38')
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 1, 4, N'T_Cumplimiento', NULL, N'ProducSLA_Super', N'G6', N'J6', NULL, N'G6:J16')
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 1, 5, N'T_Cumplimiento', NULL, N'Calidad_Super', N'G21', N'J21', NULL, N'G21:J29')
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 1, 6, N'T_Cumplimiento', NULL, N'Premios_Super', N'G34', N'K34', NULL, N'G34:K38')
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 1, 7, N'T_Cumplimiento', NULL, N'ProducSLA_Jefe', N'M6', N'P6', NULL, N'M6:P16')
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 1, 8, N'T_Cumplimiento', NULL, N'Calidad_Jefe', N'M21', N'P21', NULL, N'M21:P29')
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 2, 1, N'Grupo', NULL, NULL, N'B3', N'C3', NULL, N'B3:C16')
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 3, 1, N'Empleado', NULL, NULL, N'B2', N'G2', NULL, NULL)
INSERT [Comisiones].[ExcelHojaTI] ([ExcelId], [HojaId], [TablaInputId], [TablaInput], [SubTablaInput], [Observaciones], [CeldaInicio], [CeldaFin], [ColumnasOmitidas], [Rangos]) VALUES (3, 4, 1, N'ICargoComision', NULL, NULL, N'H2', N'L2', NULL, NULL)
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (1, N'Alo Banco', NULL, N'Elka Mendoza Reategui')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (2, N'Contáctenos', NULL, N'Elka Mendoza Reategui')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (3, N'G1', NULL, N'MIDEROS OLIVERA ROSA')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (4, N'G2', NULL, N'MIDEROS OLIVERA ROSA')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (5, N'G3', NULL, N'MINAURO DUARTE TREICY')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (6, N'G4', NULL, N'MINAURO DUARTE TREICY')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (7, N'G5', NULL, N'MIRELES SOTO CARLOS')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (8, N'G6', NULL, N'')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (9, N'G7', NULL, N'MIDEROS OLIVERA ROSA')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (10, N'G8', NULL, N'MINAURO DUARTE TREICY')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (11, N'G9', NULL, N'MIRELES SOTO CARLOS')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (12, N'G9-Piloto', NULL, N'MIRELES SOTO CARLOS')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (13, N'Impugnaciones', NULL, N'MIDEROS OLIVERA ROSA')
INSERT [Comisiones].[Grupo] ([GrupoId], [Grupo], [ResposableId], [Responsable]) VALUES (14, N'Masivos', NULL, N'Elka Mendoza Reategui')
INSERT [Comisiones].[Indicador] ([IndicadorId], [Indicador], [Area], [Porcentaje]) VALUES (1, N'Productividad y SLA', N'Especialista', NULL)
INSERT [Comisiones].[Indicador] ([IndicadorId], [Indicador], [Area], [Porcentaje]) VALUES (2, N'Calidad', N'Especialista', NULL)
INSERT [Comisiones].[Indicador] ([IndicadorId], [Indicador], [Area], [Porcentaje]) VALUES (3, N'Premio', N'Especialista', NULL)
INSERT [Comisiones].[Indicador] ([IndicadorId], [Indicador], [Area], [Porcentaje]) VALUES (4, N'Productividad y SLA', N'Supevisor', NULL)
INSERT [Comisiones].[Indicador] ([IndicadorId], [Indicador], [Area], [Porcentaje]) VALUES (5, N'Calidad', N'Supervisor', NULL)
INSERT [Comisiones].[Indicador] ([IndicadorId], [Indicador], [Area], [Porcentaje]) VALUES (6, N'Premio', N'Supervisor', NULL)
INSERT [Comisiones].[Indicador] ([IndicadorId], [Indicador], [Area], [Porcentaje]) VALUES (7, N'Productividad y SLA', N'Jefe', NULL)
INSERT [Comisiones].[Indicador] ([IndicadorId], [Indicador], [Area], [Porcentaje]) VALUES (8, N'Calidad', N'Jefe', NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.79 AS Decimal(8, 2)), N'60% - 79% ', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.84 AS Decimal(8, 2)), N'80% - 84% ', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.89 AS Decimal(8, 2)), N'85% - 89% ', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.93 AS Decimal(8, 2)), N'90% - 93% ', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 6, CAST(0.94 AS Decimal(8, 2)), CAST(0.97 AS Decimal(8, 2)), N'94% - 97% ', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 7, CAST(0.98 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), N'98% - 100% ', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 8, CAST(1.01 AS Decimal(8, 2)), CAST(1.05 AS Decimal(8, 2)), N'101% - 105%', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 9, CAST(1.06 AS Decimal(8, 2)), CAST(1.10 AS Decimal(8, 2)), N'106% - 110%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 10, CAST(1.11 AS Decimal(8, 2)), CAST(1.14 AS Decimal(8, 2)), N'111% - 115%', CAST(1.15 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 11, CAST(1.15 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'Mayor a 115%', CAST(1.20 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'60% - 79% ', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'80% - 84% ', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'85% - 89% ', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'90% - 92% ', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 6, CAST(0.93 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'93% - 94% ', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 7, CAST(0.95 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'95% - 97% ', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 8, CAST(0.98 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'98% - 99% ', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 9, CAST(1.00 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'100%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'3', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.99 AS Decimal(8, 2)), N'Menor a 100%', NULL, CAST(0.00 AS Decimal(8, 2)), N'1.00')
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'3', 2, CAST(1.00 AS Decimal(8, 2)), CAST(1.05 AS Decimal(8, 2)), N'101%-105%', NULL, CAST(50.00 AS Decimal(8, 2)), N'1.00')
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'3', 3, CAST(1.06 AS Decimal(8, 2)), CAST(1.10 AS Decimal(8, 2)), N'106%-110%', NULL, CAST(100.00 AS Decimal(8, 2)), N'1.00')
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'3', 4, CAST(1.11 AS Decimal(8, 2)), CAST(1.15 AS Decimal(8, 2)), N'111%-115%', NULL, CAST(150.00 AS Decimal(8, 2)), N'1.00')
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'3', 5, CAST(1.16 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'Mayor a 115%', NULL, CAST(200.00 AS Decimal(8, 2)), N'1.00')
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.79 AS Decimal(8, 2)), N'60% - 79%', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.84 AS Decimal(8, 2)), N'80% - 84%', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.89 AS Decimal(8, 2)), N'85% - 89%', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.93 AS Decimal(8, 2)), N'90% - 93%', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 6, CAST(0.94 AS Decimal(8, 2)), CAST(0.97 AS Decimal(8, 2)), N'94% - 97%', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 7, CAST(0.98 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), N'98% - 100%', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 8, CAST(1.01 AS Decimal(8, 2)), CAST(1.05 AS Decimal(8, 2)), N'101% - 105%', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 9, CAST(1.06 AS Decimal(8, 2)), CAST(1.10 AS Decimal(8, 2)), N'106% - 110%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 10, CAST(1.11 AS Decimal(8, 2)), CAST(1.14 AS Decimal(8, 2)), N'111% - 115%', CAST(1.15 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 11, CAST(1.15 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'Mayor a 115%', CAST(1.20 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'60% - 79%', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'80% - 84%', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'85% - 89%', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'90% - 92%', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 6, CAST(0.93 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'93% - 94%', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 7, CAST(0.95 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'95% - 97%', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 8, CAST(0.98 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'98% - 99%', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 9, CAST(1.00 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'100%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'6', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.99 AS Decimal(8, 2)), N'Menor a 100%', NULL, CAST(0.00 AS Decimal(8, 2)), N'Producción trimestre')
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'6', 2, CAST(1.00 AS Decimal(8, 2)), CAST(1.05 AS Decimal(8, 2)), N'101%-105%', NULL, CAST(100.00 AS Decimal(8, 2)), N'1° trimestre: Ene – Mar (pago abril)')
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'6', 3, CAST(1.06 AS Decimal(8, 2)), CAST(1.10 AS Decimal(8, 2)), N'106%-110%', NULL, CAST(200.00 AS Decimal(8, 2)), N'2° trimestre: Abr – Jun (pago julio)')
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'6', 4, CAST(1.11 AS Decimal(8, 2)), CAST(1.15 AS Decimal(8, 2)), N'111%-115%', NULL, CAST(300.00 AS Decimal(8, 2)), N'3° trimestre: Jul – Sep (pago octubre)')
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'6', 5, CAST(1.16 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'Mayor a 115%', NULL, CAST(500.00 AS Decimal(8, 2)), N'4° trimestre: Oct – Dic (pago enero)')
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.79 AS Decimal(8, 2)), N'60% - 79%', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.84 AS Decimal(8, 2)), N'80% - 84%', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.89 AS Decimal(8, 2)), N'85% - 89%', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.93 AS Decimal(8, 2)), N'90% - 93%', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 6, CAST(0.94 AS Decimal(8, 2)), CAST(0.97 AS Decimal(8, 2)), N'94% - 97%', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 7, CAST(0.98 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), N'98% - 100%', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 8, CAST(1.01 AS Decimal(8, 2)), CAST(1.05 AS Decimal(8, 2)), N'101% - 105%', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 9, CAST(1.06 AS Decimal(8, 2)), CAST(1.10 AS Decimal(8, 2)), N'106% - 110%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 10, CAST(1.11 AS Decimal(8, 2)), CAST(1.14 AS Decimal(8, 2)), N'111% - 115%', CAST(1.15 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 11, CAST(1.15 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'Mayor a 115%', CAST(1.20 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'60% - 79%', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'80% - 84%', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'85% - 89%', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'90% - 92%', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 6, CAST(0.93 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'93% - 94%', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 7, CAST(0.95 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'95% - 97%', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 8, CAST(0.98 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'98% - 99%', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[IndicadorCumplimiento] ([TablaId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 9, CAST(1.00 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'100%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 1, N'Del 04/09/2017 al 08/09/2017', 9, CAST(N'2017-09-08 00:00:00.000' AS DateTime), 2235478, NULL, N'ABREGU GONZÁLEZ ADELMO CRISTY', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 2, N'Del 04/09/2017 al 08/09/2017', 9, CAST(N'2017-09-08 00:00:00.000' AS DateTime), 2235478, NULL, N'ABREU RODRÍGUEZ ADOLFO WALTER', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 3, N'Del 04/09/2017 al 08/09/2017', 9, CAST(N'2017-09-08 00:00:00.000' AS DateTime), 2235478, NULL, N'ADAMES GÓMEZ ADRIANO TERESA', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 4, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-15 00:00:00.000' AS DateTime), 2235478, NULL, N'ADARO FERNÁNDEZ AILÍN FERNANDO', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 5, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-15 00:00:00.000' AS DateTime), 2235478, NULL, N'ADAUTO LÓPEZ ALBERTO SONIA', N'Problemas en el Envío de Estado de Cuenta', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 6, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-15 00:00:00.000' AS DateTime), 2235478, NULL, N'AGRADA DÍAZ ALEJANDRO ARLETH', N'Extornos', N'N', N'si', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 7, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-15 00:00:00.000' AS DateTime), 2235478, NULL, N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', N'Extornos', N'N', N'si', N'no', N'si', N'no', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'si')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 8, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-21 00:00:00.000' AS DateTime), 2235478, NULL, N'ALCABES PÉREZ ALFREDO ANGELA', N'Consumo No Reconocido', N'N', N'si', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'si', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 9, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-22 00:00:00.000' AS DateTime), 2235478, NULL, N'ALMEIDA GARCÍA ALVAREZ JAVIER', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 10, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-22 00:00:00.000' AS DateTime), 2235478, NULL, N'ALMEYDA SÁNCHEZ ALVARO JOSE', N'Explicación de Cuenta', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 11, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-29 00:00:00.000' AS DateTime), 2235478, NULL, N'ALVARES ROMERO ANA CRISTINA', N'Consumo No Reconocido', N'N', N'si', N'no', N'no', N'no', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 12, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-29 00:00:00.000' AS DateTime), 2235478, NULL, N'ALVES SOSA ANDREA NORMA', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 13, N'Del 04/09/2017 al 08/09/2017', 9, CAST(N'2017-09-04 00:00:00.000' AS DateTime), 2235478, NULL, N'AMADO ÁLVAREZ ANDRÉS ELSA', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 14, N'Del 04/09/2017 al 08/09/2017', 9, CAST(N'2017-09-05 00:00:00.000' AS DateTime), 2235478, NULL, N'AMARAL TORRES ANGELO KRISTOFER', N'Inadecuada o Insuficiente Información', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 15, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-13 00:00:00.000' AS DateTime), 2235478, NULL, N'ANGOBALDO RAMÍREZ ARIEL JAMES', N'Promociones y/u ofertas', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 16, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-13 00:00:00.000' AS DateTime), 2235478, NULL, N'ANTUNES FLORES ARSENIO HINDRA', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 17, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-19 00:00:00.000' AS DateTime), 2235478, NULL, N'BAES ACOSTA ARTURO TELLO', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 18, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-20 00:00:00.000' AS DateTime), 2235478, NULL, N'BARBOZA BENÍTEZ BRAULIO FASABI', N'Consumos no reconocidos', N'N', N'no', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'si', N'si', N'no', N'si', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 19, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-20 00:00:00.000' AS DateTime), 2235478, NULL, N'BARDALES MEDINA CARLOS MARIA', N'Extornos', N'N', N'si', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 20, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-21 00:00:00.000' AS DateTime), 2235478, NULL, N'BARROSO SUÁREZ CRISTÓBAL NORIS', N'Problemas con Pagos', N'N', N'no', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 21, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-22 00:00:00.000' AS DateTime), 2235478, NULL, N'BATISTA HERRERA DIEGO LUZ', N'Inadecuada o Insuficiente Información', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 22, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-25 00:00:00.000' AS DateTime), 2235478, NULL, N'BRANCO AGUIRRE EDUARDO KEYKO', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 23, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-28 00:00:00.000' AS DateTime), 2235478, NULL, N'CALIENES PEREYRA ESTEBAN MELISSA', N'Extornos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 24, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-29 00:00:00.000' AS DateTime), 2235478, NULL, N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 25, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-29 00:00:00.000' AS DateTime), 2235478, NULL, N'CASAL GIMÉNEZ FERNANDO MARGOTH', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EspecialistaId], [Especialista], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (1, 26, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-29 00:00:00.000' AS DateTime), 2235478, NULL, N'CERNADES MOLINA FORTUNATO AMARELIS', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no', N'no', N'no')
SET IDENTITY_INSERT [Comisiones].[Rol] ON 

INSERT [Comisiones].[Rol] ([Id], [Nombre], [Descripcion], [Estado]) VALUES (1, N'Administrador', N'', 1)
INSERT [Comisiones].[Rol] ([Id], [Nombre], [Descripcion], [Estado]) VALUES (2, N'Mantenedor', N'', 1)
INSERT [Comisiones].[Rol] ([Id], [Nombre], [Descripcion], [Estado]) VALUES (3, N'Operador', N'', 1)
SET IDENTITY_INSERT [Comisiones].[Rol] OFF
ALTER TABLE [Comisiones].[ExcelHoja]  WITH CHECK ADD  CONSTRAINT [FK_ExcelHoja_Excel] FOREIGN KEY([ExcelId])
REFERENCES [Comisiones].[Excel] ([Id])
GO
ALTER TABLE [Comisiones].[ExcelHoja] CHECK CONSTRAINT [FK_ExcelHoja_Excel]
GO
ALTER TABLE [Comisiones].[ExcelHojaCampo]  WITH CHECK ADD  CONSTRAINT [FK_ExcelHojaCampo_Excel] FOREIGN KEY([ExcelId])
REFERENCES [Comisiones].[Excel] ([Id])
GO
ALTER TABLE [Comisiones].[ExcelHojaCampo] CHECK CONSTRAINT [FK_ExcelHojaCampo_Excel]
GO
ALTER TABLE [Comisiones].[Productividad]  WITH CHECK ADD  CONSTRAINT [FK_Productividad_CabeceraCarga] FOREIGN KEY([CargaId])
REFERENCES [Comisiones].[CabeceraCarga] ([Id])
GO
ALTER TABLE [Comisiones].[Productividad] CHECK CONSTRAINT [FK_Productividad_CabeceraCarga]
GO
ALTER TABLE [Comisiones].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Rol] FOREIGN KEY([RolId])
REFERENCES [Comisiones].[Rol] ([Id])
GO
ALTER TABLE [Comisiones].[Usuario] CHECK CONSTRAINT [FK_Usuario_Rol]
GO
