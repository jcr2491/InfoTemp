USE [master]
GO
/****** Object:  Database [Comisiones]    Script Date: 14/12/2017 06:16:33 p.m. ******/
CREATE DATABASE [Comisiones]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Comisiones', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Comisiones.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Comisiones_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Comisiones_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Comisiones] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Comisiones].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Comisiones] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Comisiones] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Comisiones] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Comisiones] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Comisiones] SET ARITHABORT OFF 
GO
ALTER DATABASE [Comisiones] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Comisiones] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Comisiones] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Comisiones] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Comisiones] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Comisiones] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Comisiones] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Comisiones] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Comisiones] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Comisiones] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Comisiones] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Comisiones] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Comisiones] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Comisiones] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Comisiones] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Comisiones] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Comisiones] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Comisiones] SET RECOVERY FULL 
GO
ALTER DATABASE [Comisiones] SET  MULTI_USER 
GO
ALTER DATABASE [Comisiones] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Comisiones] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Comisiones] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Comisiones] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Comisiones] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Comisiones', N'ON'
GO
USE [Comisiones]
GO
/****** Object:  Schema [Comisiones]    Script Date: 14/12/2017 06:16:33 p.m. ******/
CREATE SCHEMA [Comisiones]
GO
/****** Object:  Table [Comisiones].[CabeceraCarga]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[CabeceraCarga](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TipoArchivo] [varchar](2) NOT NULL,
	[FechaArchivo] [datetime] NOT NULL,
	[FechaCargaIni] [datetime] NOT NULL,
	[FechaCargaFin] [datetime] NULL,
	[EstadoCarga] [int] NOT NULL,
 CONSTRAINT [PK_CabeceraCarga] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Cargo]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Cargo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [nvarchar](250) NULL,
 CONSTRAINT [PK_Cargo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[CmrRatificada]    Script Date: 14/12/2017 06:16:33 p.m. ******/
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
/****** Object:  Table [Comisiones].[Cumplimiento]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Cumplimiento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Area] [varchar](50) NULL,
 CONSTRAINT [PK_Cumplimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[CumplimientoComision]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comisiones].[CumplimientoComision](
	[Fecha] [datetime] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[CargoId] [int] NULL,
	[Cumplimiento] [decimal](8, 2) NULL,
	[ComisionUnit] [decimal](8, 2) NULL,
 CONSTRAINT [PK_CumplimientoComision] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comisiones].[CumplimientoDetalle]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[CumplimientoDetalle](
	[CumplimientoId] [varchar](50) NOT NULL,
	[Secuencia] [tinyint] NOT NULL,
	[Inicio] [decimal](8, 2) NULL,
	[Fin] [decimal](8, 2) NULL,
	[Cumplimiento] [varchar](50) NULL,
	[Puntaje] [decimal](8, 2) NULL,
	[Premio] [decimal](8, 2) NULL,
	[GestionIndivGrupal] [varchar](50) NULL,
 CONSTRAINT [PK_TCumplimiento] PRIMARY KEY CLUSTERED 
(
	[CumplimientoId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[DataAutomotriz]    Script Date: 14/12/2017 06:16:33 p.m. ******/
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
	[EmpleadoId] [int] NULL,
	[Empleado] [nvarchar](250) NULL,
	[FechaDesembolso] [datetime] NULL,
	[Canal] [varchar](50) NULL,
	[Captacion] [varchar](50) NULL,
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[DiasAusencia]    Script Date: 14/12/2017 06:16:33 p.m. ******/
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
/****** Object:  Table [Comisiones].[Empleado]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[Excel]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Excel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](40) NOT NULL,
	[Descripcion] [varchar](500) NULL,
	[Ruta] [varchar](500) NOT NULL,
 CONSTRAINT [PK_Excel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[ExcelHoja]    Script Date: 14/12/2017 06:16:33 p.m. ******/
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
	[NombreHoja] [nvarchar](40) NOT NULL,
	[Descripcion] [nvarchar](500) NULL,
 CONSTRAINT [PK_ExcelHoja] PRIMARY KEY CLUSTERED 
(
	[ExcelId] ASC,
	[TipoArchivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[ExcelHojaCampo]    Script Date: 14/12/2017 06:16:33 p.m. ******/
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
	[NombreCelda] [nvarchar](100) NOT NULL,
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
/****** Object:  Table [Comisiones].[Grupo]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Grupo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ResponsableId] [int] NULL,
 CONSTRAINT [PK_Grupo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[GrupoResponsable]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comisiones].[GrupoResponsable](
	[GrupoId] [int] NOT NULL,
	[ResponsableId] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_GrupoResponsable] PRIMARY KEY CLUSTERED 
(
	[GrupoId] ASC,
	[ResponsableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comisiones].[Homologacion]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[Homologacion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Codigo] [varchar](8) NOT NULL,
 CONSTRAINT [PK_Homologacion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[IndicadorMedicion]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[IndicadorMedicion](
	[IndicadorId] [varchar](3) NOT NULL,
	[Indicador] [varchar](50) NOT NULL,
	[Porcentaje] [decimal](8, 2) NULL,
 CONSTRAINT [PK_IndicadorMedicion] PRIMARY KEY CLUSTERED 
(
	[IndicadorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[IndicadorMedicionNota]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[IndicadorMedicionNota](
	[IndicadorId] [varchar](3) NOT NULL,
	[CampoId] [varchar](5) NOT NULL,
	[Pregunta] [varchar](500) NULL,
	[Nota] [decimal](8, 2) NOT NULL,
 CONSTRAINT [PK_IndicadorMedicionNota] PRIMARY KEY CLUSTERED 
(
	[IndicadorId] ASC,
	[CampoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[MetaEmpleado]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comisiones].[MetaEmpleado](
	[Fecha] [datetime] NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[TipoComision] [tinyint] NULL,
	[Meta] [decimal](18, 2) NULL,
 CONSTRAINT [PK_MetaEmpleado] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC,
	[EmpleadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comisiones].[Monitoreo]    Script Date: 14/12/2017 06:16:33 p.m. ******/
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
	[EmpleadoId] [int] NULL,
	[Empleado] [varchar](250) NULL,
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
/****** Object:  Table [Comisiones].[Ponderacion]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comisiones].[Ponderacion](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[EmpleadoId] [int] NULL,
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
	[Cumple_Estand] [bit] NULL,
 CONSTRAINT [PK_IM_Ponderacion] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comisiones].[ProducContactenos]    Script Date: 14/12/2017 06:16:33 p.m. ******/
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
	[MetaMes] [int] NULL,
	[Productividad] [decimal](5, 2) NULL,
 CONSTRAINT [PK_IProduc_Contactenos] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comisiones].[Productividad]    Script Date: 14/12/2017 06:16:33 p.m. ******/
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
	[DiasAsistencia] [int] NOT NULL,
	[MetaDiaria] [int] NULL,
	[TotalProductividad] [int] NOT NULL,
	[Logro] [int] NOT NULL,
 CONSTRAINT [PK_Productividad] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comisiones].[ProductividadEsp]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comisiones].[ProductividadEsp](
	[CargaId] [int] NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[GrupoId] [varchar](3) NOT NULL,
	[SuperId] [int] NULL,
	[CargoId] [tinyint] NULL,
	[DiasLaborados] [int] NULL,
	[CRFactor] [decimal](5, 2) NULL,
	[CRMetaTotal] [decimal](5, 2) NULL,
	[CRCasosCerrados] [int] NULL,
	[CRCumplimiento] [decimal](5, 2) NULL,
	[CRNota1] [decimal](5, 2) NULL,
	[SLAFactor] [decimal](5, 2) NULL,
	[SLATotal] [int] NULL,
	[SLANroCasos] [int] NULL,
	[SLACumplimiento] [decimal](5, 2) NULL,
	[SLANota2] [decimal](5, 2) NULL,
	[KPINota1y2] [decimal](5, 2) NULL,
	[KPISumaPesos] [decimal](5, 2) NULL,
	[KPINota] [decimal](5, 2) NULL,
	[KPIPuntaje] [decimal](5, 2) NULL,
	[CALImpug] [decimal](5, 2) NULL,
	[CALPuntaje] [decimal](5, 2) NULL,
	[CREMetaTotal] [int] NULL,
	[CRECasosCerrados] [int] NULL,
	[CRECumplimiento] [decimal](5, 2) NULL,
	[ComisionA] [decimal](8, 2) NULL,
	[PremioB] [decimal](8, 2) NULL,
	[TotalComisPremio] [decimal](8, 2) NULL,
 CONSTRAINT [PK_Productividad_Esp] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[EmpleadoId] ASC,
	[GrupoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comisiones].[ProductividadSuperJefe]    Script Date: 14/12/2017 06:16:33 p.m. ******/
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
/****** Object:  Table [Comisiones].[SLAContactenos]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comisiones].[SLAContactenos](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[EmpleadoId] [int] NULL,
	[Empleado] [nvarchar](250) NOT NULL,
	[DentroPlazo] [int] NULL,
	[FueraPlazo] [int] NULL,
	[TotalGeneral] [int] NULL,
	[SLA] [decimal](8, 2) NULL,
 CONSTRAINT [PK_SLAContactenos] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comisiones].[SLAUAC]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comisiones].[SLAUAC](
	[CargaId] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[SupervisorId] [int] NULL,
	[Supervisor] [nvarchar](250) NOT NULL,
	[GrupoId] [int] NULL,
	[Grupo] [nvarchar](20) NOT NULL,
	[EmpleadoId] [int] NULL,
	[Empleado] [nvarchar](250) NOT NULL,
	[DentroPlazo] [int] NULL,
	[FueraPlazo] [int] NULL,
	[TotalGeneral] [int] NULL,
 CONSTRAINT [PK_SLAUAC_1] PRIMARY KEY CLUSTERED 
(
	[CargaId] ASC,
	[Secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [Comisiones].[CabeceraCarga] ON 

INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (1, N'1 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 10:08:38.913' AS DateTime), CAST(N'2017-12-14 10:08:39.587' AS DateTime), 1)
INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (2, N'5 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 10:08:39.617' AS DateTime), CAST(N'2017-12-14 10:08:39.680' AS DateTime), 1)
INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (3, N'2 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 10:08:39.740' AS DateTime), CAST(N'2017-12-14 10:08:39.913' AS DateTime), 1)
INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (4, N'3 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 10:08:39.930' AS DateTime), CAST(N'2017-12-14 10:08:39.960' AS DateTime), 1)
INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (5, N'4 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 10:08:39.977' AS DateTime), CAST(N'2017-12-14 10:08:40.037' AS DateTime), 1)
INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (6, N'10', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 10:08:40.053' AS DateTime), CAST(N'2017-12-14 10:08:40.117' AS DateTime), 1)
INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (13, N'6 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 14:39:30.510' AS DateTime), NULL, 0)
INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (14, N'6 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 14:40:05.500' AS DateTime), NULL, 0)
INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (15, N'6 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 14:41:39.543' AS DateTime), NULL, 0)
INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (16, N'6 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 14:41:48.860' AS DateTime), NULL, 0)
INSERT [Comisiones].[CabeceraCarga] ([Id], [TipoArchivo], [FechaArchivo], [FechaCargaIni], [FechaCargaFin], [EstadoCarga]) VALUES (17, N'6 ', CAST(N'2017-11-01 00:00:00.000' AS DateTime), CAST(N'2017-12-14 14:42:13.403' AS DateTime), CAST(N'2017-12-14 14:42:30.153' AS DateTime), 1)
SET IDENTITY_INSERT [Comisiones].[CabeceraCarga] OFF
SET IDENTITY_INSERT [Comisiones].[Cargo] ON 

INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Descripcion]) VALUES (1, N'Apoyo UAC', NULL)
INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Descripcion]) VALUES (2, N'Especialista UAC', NULL)
INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Descripcion]) VALUES (3, N'Especialista UAC Noche', NULL)
INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Descripcion]) VALUES (4, N'Jefe UAC', NULL)
INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Descripcion]) VALUES (5, N'Supervisor', NULL)
INSERT [Comisiones].[Cargo] ([Id], [Nombre], [Descripcion]) VALUES (6, N'Asistente', NULL)
SET IDENTITY_INSERT [Comisiones].[Cargo] OFF
SET IDENTITY_INSERT [Comisiones].[Cumplimiento] ON 

INSERT [Comisiones].[Cumplimiento] ([Id], [Nombre], [Area]) VALUES (1, N'ProducSLA_Esp', N'Especialista')
INSERT [Comisiones].[Cumplimiento] ([Id], [Nombre], [Area]) VALUES (2, N'Calidad_Esp', N'Especialista')
INSERT [Comisiones].[Cumplimiento] ([Id], [Nombre], [Area]) VALUES (3, N'Premios_Esp', N'Especialista')
INSERT [Comisiones].[Cumplimiento] ([Id], [Nombre], [Area]) VALUES (4, N'ProducSLA_Super', N'Supervisor')
INSERT [Comisiones].[Cumplimiento] ([Id], [Nombre], [Area]) VALUES (5, N'Calidad_Super', N'Supervisor')
INSERT [Comisiones].[Cumplimiento] ([Id], [Nombre], [Area]) VALUES (6, N'Premios_Super', N'Supervisor')
INSERT [Comisiones].[Cumplimiento] ([Id], [Nombre], [Area]) VALUES (7, N'ProducSLA_Jefe', N'Jefe')
INSERT [Comisiones].[Cumplimiento] ([Id], [Nombre], [Area]) VALUES (8, N'Calidad_Jefe', N'Jefe')
SET IDENTITY_INSERT [Comisiones].[Cumplimiento] OFF
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.79 AS Decimal(8, 2)), N'60% - 79% ', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.84 AS Decimal(8, 2)), N'80% - 84% ', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.89 AS Decimal(8, 2)), N'85% - 89% ', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.93 AS Decimal(8, 2)), N'90% - 93% ', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 6, CAST(0.94 AS Decimal(8, 2)), CAST(0.97 AS Decimal(8, 2)), N'94% - 97% ', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 7, CAST(0.98 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), N'98% - 100% ', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 8, CAST(1.01 AS Decimal(8, 2)), CAST(1.05 AS Decimal(8, 2)), N'101% - 105%', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 9, CAST(1.06 AS Decimal(8, 2)), CAST(1.10 AS Decimal(8, 2)), N'106% - 110%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 10, CAST(1.11 AS Decimal(8, 2)), CAST(1.14 AS Decimal(8, 2)), N'111% - 115%', CAST(1.15 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'1', 11, CAST(1.15 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'Mayor a 115%', CAST(1.20 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'60% - 79% ', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'80% - 84% ', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'85% - 89% ', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'90% - 92% ', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 6, CAST(0.93 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'93% - 94% ', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 7, CAST(0.95 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'95% - 97% ', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 8, CAST(0.98 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'98% - 99% ', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'2', 9, CAST(1.00 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'100%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'3', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.99 AS Decimal(8, 2)), N'Menor a 100%', NULL, CAST(0.00 AS Decimal(8, 2)), N'1.00')
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'3', 2, CAST(1.00 AS Decimal(8, 2)), CAST(1.05 AS Decimal(8, 2)), N'101%-105%', NULL, CAST(50.00 AS Decimal(8, 2)), N'1.00')
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'3', 3, CAST(1.06 AS Decimal(8, 2)), CAST(1.10 AS Decimal(8, 2)), N'106%-110%', NULL, CAST(100.00 AS Decimal(8, 2)), N'1.00')
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'3', 4, CAST(1.11 AS Decimal(8, 2)), CAST(1.15 AS Decimal(8, 2)), N'111%-115%', NULL, CAST(150.00 AS Decimal(8, 2)), N'1.00')
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'3', 5, CAST(1.16 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'Mayor a 115%', NULL, CAST(200.00 AS Decimal(8, 2)), N'1.00')
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.79 AS Decimal(8, 2)), N'60% - 79%', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.84 AS Decimal(8, 2)), N'80% - 84%', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.89 AS Decimal(8, 2)), N'85% - 89%', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.93 AS Decimal(8, 2)), N'90% - 93%', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 6, CAST(0.94 AS Decimal(8, 2)), CAST(0.97 AS Decimal(8, 2)), N'94% - 97%', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 7, CAST(0.98 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), N'98% - 100%', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 8, CAST(1.01 AS Decimal(8, 2)), CAST(1.05 AS Decimal(8, 2)), N'101% - 105%', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 9, CAST(1.06 AS Decimal(8, 2)), CAST(1.10 AS Decimal(8, 2)), N'106% - 110%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 10, CAST(1.11 AS Decimal(8, 2)), CAST(1.14 AS Decimal(8, 2)), N'111% - 115%', CAST(1.15 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'4', 11, CAST(1.15 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'Mayor a 115%', CAST(1.20 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'60% - 79%', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'80% - 84%', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'85% - 89%', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'90% - 92%', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 6, CAST(0.93 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'93% - 94%', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 7, CAST(0.95 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'95% - 97%', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 8, CAST(0.98 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'98% - 99%', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'5', 9, CAST(1.00 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'100%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'6', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.99 AS Decimal(8, 2)), N'Menor a 100%', NULL, CAST(0.00 AS Decimal(8, 2)), N'Producción trimestre')
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'6', 2, CAST(1.00 AS Decimal(8, 2)), CAST(1.05 AS Decimal(8, 2)), N'101%-105%', NULL, CAST(100.00 AS Decimal(8, 2)), N'1° trimestre: Ene – Mar (pago abril)')
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'6', 3, CAST(1.06 AS Decimal(8, 2)), CAST(1.10 AS Decimal(8, 2)), N'106%-110%', NULL, CAST(200.00 AS Decimal(8, 2)), N'2° trimestre: Abr – Jun (pago julio)')
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'6', 4, CAST(1.11 AS Decimal(8, 2)), CAST(1.15 AS Decimal(8, 2)), N'111%-115%', NULL, CAST(300.00 AS Decimal(8, 2)), N'3° trimestre: Jul – Sep (pago octubre)')
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'6', 5, CAST(1.16 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'Mayor a 115%', NULL, CAST(500.00 AS Decimal(8, 2)), N'4° trimestre: Oct – Dic (pago enero)')
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.79 AS Decimal(8, 2)), N'60% - 79%', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.84 AS Decimal(8, 2)), N'80% - 84%', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.89 AS Decimal(8, 2)), N'85% - 89%', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.93 AS Decimal(8, 2)), N'90% - 93%', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 6, CAST(0.94 AS Decimal(8, 2)), CAST(0.97 AS Decimal(8, 2)), N'94% - 97%', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 7, CAST(0.98 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), N'98% - 100%', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 8, CAST(1.01 AS Decimal(8, 2)), CAST(1.05 AS Decimal(8, 2)), N'101% - 105%', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 9, CAST(1.06 AS Decimal(8, 2)), CAST(1.10 AS Decimal(8, 2)), N'106% - 110%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 10, CAST(1.11 AS Decimal(8, 2)), CAST(1.14 AS Decimal(8, 2)), N'111% - 115%', CAST(1.15 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'7', 11, CAST(1.15 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'Mayor a 115%', CAST(1.20 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 1, CAST(-99.99 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'Menor a 60%', CAST(0.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 2, CAST(0.60 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'60% - 79%', CAST(0.60 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 3, CAST(0.80 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'80% - 84%', CAST(0.70 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 4, CAST(0.85 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'85% - 89%', CAST(0.80 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 5, CAST(0.90 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'90% - 92%', CAST(0.90 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 6, CAST(0.93 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'93% - 94%', CAST(0.95 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 7, CAST(0.95 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'95% - 97%', CAST(1.00 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 8, CAST(0.98 AS Decimal(8, 2)), CAST(0.59 AS Decimal(8, 2)), N'98% - 99%', CAST(1.05 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[CumplimientoDetalle] ([CumplimientoId], [Secuencia], [Inicio], [Fin], [Cumplimiento], [Puntaje], [Premio], [GestionIndivGrupal]) VALUES (N'8', 9, CAST(1.00 AS Decimal(8, 2)), CAST(99.99 AS Decimal(8, 2)), N'100%', CAST(1.10 AS Decimal(8, 2)), NULL, NULL)
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 1, 1003014000, N'D.N.I', 12896534, 1, N'ABREGU GONZÁLEZ ADELMO CRISTY', CAST(N'2017-10-01 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'TORRES MUÑOZ MARCELO DENISSE', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(42372.00 AS Decimal(18, 2)), CAST(11500.00 AS Decimal(18, 2)), CAST(30872.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 2, 1003014001, N'D.N.I', 12896535, 2, N'ABREU RODRÍGUEZ ADOLFO WALTER', CAST(N'2017-10-02 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'TORRES MUÑOZ MARCELO DENISSE', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(41951.19 AS Decimal(18, 2)), CAST(8390.23 AS Decimal(18, 2)), CAST(33560.95 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 3, 1003014002, N'D.N.I', 12896536, 3, N'ADAMES GÓMEZ ADRIANO TERESA', CAST(N'2017-10-03 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'TORRES MUÑOZ MARCELO DENISSE', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(44903.19 AS Decimal(18, 2)), CAST(8980.63 AS Decimal(18, 2)), CAST(35922.55 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 4, 1003014003, N'D.N.I', 12896537, 4, N'ADARO FERNÁNDEZ AILÍN FERNANDO', CAST(N'2017-10-04 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'TORRES MUÑOZ MARCELO DENISSE', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(34407.19 AS Decimal(18, 2)), CAST(6881.43 AS Decimal(18, 2)), CAST(27525.75 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 5, 1003014004, N'D.N.I', 12896538, 5, N'ADAUTO LÓPEZ ALBERTO SONIA', CAST(N'2017-10-05 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORADOR NAVARRO PABLO HAROLD', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(50291.09 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), CAST(35291.09 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 6, 1003014005, N'D.N.I', 12896539, 6, N'AGRADA DÍAZ ALEJANDRO ARLETH', CAST(N'2017-10-06 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORADOR NAVARRO PABLO HAROLD', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(45690.40 AS Decimal(18, 2)), CAST(25000.00 AS Decimal(18, 2)), CAST(20690.40 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 7, 1003014006, N'D.N.I', 12896540, 7, N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', CAST(N'2017-10-07 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORADOR NAVARRO PABLO HAROLD', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(78927.10 AS Decimal(18, 2)), CAST(23500.00 AS Decimal(18, 2)), CAST(55427.09 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 8, 1003014007, N'D.N.I', 12896541, 8, N'ALCABES PÉREZ ALFREDO ANGELA', CAST(N'2017-10-08 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORADOR NAVARRO PABLO HAROLD', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(66066.94 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), CAST(46066.94 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 9, 1003014008, N'D.N.I', 12896542, 9, N'ALMEIDA GARCÍA ALVAREZ JAVIER', CAST(N'2017-10-09 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORADOR NAVARRO PABLO HAROLD', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(36263.69 AS Decimal(18, 2)), CAST(7252.73 AS Decimal(18, 2)), CAST(29010.95 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 10, 1003014009, N'D.N.I', 12896543, 10, N'ALMEYDA SÁNCHEZ ALVARO JOSE', CAST(N'2017-10-10 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(45314.00 AS Decimal(18, 2)), CAST(9063.00 AS Decimal(18, 2)), CAST(36251.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 11, 1003014010, N'D.N.I', 12896544, 11, N'ALVARES ROMERO ANA CRISTINA', CAST(N'2017-10-11 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(56047.00 AS Decimal(18, 2)), CAST(13825.00 AS Decimal(18, 2)), CAST(42222.00 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 12, 1003014011, N'D.N.I', 12896545, 12, N'ALVES SOSA ANDREA NORMA', CAST(N'2017-10-12 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(53406.00 AS Decimal(18, 2)), CAST(18000.00 AS Decimal(18, 2)), CAST(35406.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 13, 1003014012, N'D.N.I', 12896546, 13, N'AMADO ÁLVAREZ ANDRÉS ELSA', CAST(N'2017-10-13 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(52767.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), CAST(32767.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 14, 1003014013, N'D.N.I', 12896547, 14, N'AMARAL TORRES ANGELO KRISTOFER', CAST(N'2017-10-14 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(51142.00 AS Decimal(18, 2)), CAST(10229.00 AS Decimal(18, 2)), CAST(40913.00 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 15, 1003014014, N'D.N.I', 12896548, 15, N'ANGOBALDO RAMÍREZ ARIEL JAMES', CAST(N'2017-10-15 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(77302.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(27302.00 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 16, 1003014015, N'D.N.I', 12896549, 16, N'ANTUNES FLORES ARSENIO HINDRA', CAST(N'2017-10-16 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DORREGO RAMOS PATRÍCIO SANTOS', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(43169.00 AS Decimal(18, 2)), CAST(8634.00 AS Decimal(18, 2)), CAST(34535.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 17, 1003014016, N'D.N.I', 12896550, 17, N'BAES ACOSTA ARTURO TELLO', CAST(N'2017-10-17 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOCARMO VILLALBA NICOLAS LUYO', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(44085.32 AS Decimal(18, 2)), CAST(8817.10 AS Decimal(18, 2)), CAST(35268.22 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 18, 1003014017, N'D.N.I', 12896551, 18, N'BARBOZA BENÍTEZ BRAULIO FASABI', CAST(N'2017-10-18 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOCARMO VILLALBA NICOLAS LUYO', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(45517.52 AS Decimal(18, 2)), CAST(22758.77 AS Decimal(18, 2)), CAST(22758.75 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 19, 1003014018, N'D.N.I', 12896552, 19, N'BARDALES MEDINA CARLOS MARIA', CAST(N'2017-10-19 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOCARMO VILLALBA NICOLAS LUYO', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(34726.00 AS Decimal(18, 2)), CAST(7800.00 AS Decimal(18, 2)), CAST(26926.00 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 20, 1003014019, N'D.N.I', 12896553, 20, N'BARROSO SUÁREZ CRISTÓBAL NORIS', CAST(N'2017-10-20 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOCARMO VILLALBA NICOLAS LUYO', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(80958.50 AS Decimal(18, 2)), CAST(44766.30 AS Decimal(18, 2)), CAST(36192.20 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 21, 1003014020, N'D.N.I', 12896554, 21, N'BATISTA HERRERA DIEGO LUZ', CAST(N'2017-10-21 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'JUNIOR MÉNDEZ VICENTE CANDY', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(51029.00 AS Decimal(18, 2)), CAST(10206.00 AS Decimal(18, 2)), CAST(40823.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 22, 1003014021, N'D.N.I', 12896555, 22, N'BRANCO AGUIRRE EDUARDO KEYKO', CAST(N'2017-10-22 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'JUNIOR MÉNDEZ VICENTE CANDY', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(53584.00 AS Decimal(18, 2)), CAST(10717.00 AS Decimal(18, 2)), CAST(42867.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 23, 1003014022, N'D.N.I', 12896556, 23, N'CALIENES PEREYRA ESTEBAN MELISSA', CAST(N'2017-10-23 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'JUNIOR MÉNDEZ VICENTE CANDY', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(47673.00 AS Decimal(18, 2)), CAST(11000.00 AS Decimal(18, 2)), CAST(36673.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 24, 1003014023, N'D.N.I', 12896557, 24, N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', CAST(N'2017-10-24 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'EVANGELISTA CÓRDOBA PICHI JANETH', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(46784.45 AS Decimal(18, 2)), CAST(11954.00 AS Decimal(18, 2)), CAST(34830.45 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 25, 1003014024, N'D.N.I', 12896558, 25, N'CASAL GIMÉNEZ FERNANDO MARGOTH', CAST(N'2017-10-25 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'EVANGELISTA CÓRDOBA PICHI JANETH', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(54706.32 AS Decimal(18, 2)), CAST(21909.00 AS Decimal(18, 2)), CAST(32797.32 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 26, 1003014025, N'D.N.I', 12896559, 26, N'CERNADES MOLINA FORTUNATO AMARELIS', CAST(N'2017-10-26 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'EVANGELISTA CÓRDOBA PICHI JANETH', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(110166.30 AS Decimal(18, 2)), CAST(68670.00 AS Decimal(18, 2)), CAST(41496.30 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 27, 1003014026, N'D.N.I', 12896560, 27, N'CLIMACO SILVA GERARDO PIERO', CAST(N'2017-10-27 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'EVANGELISTA CÓRDOBA PICHI JANETH', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(92646.89 AS Decimal(18, 2)), CAST(49650.00 AS Decimal(18, 2)), CAST(42996.90 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 28, 1003014027, N'D.N.I', 12896561, 28, N'COELHO CASTRO HECTOR DIANA', CAST(N'2017-10-28 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'EVANGELISTA CÓRDOBA PICHI JANETH', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(47069.69 AS Decimal(18, 2)), CAST(9413.93 AS Decimal(18, 2)), CAST(37655.76 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 29, 1003014028, N'D.N.I', 12896562, 29, N'COIMBRA ROJAS HUENU LILIAN', CAST(N'2017-10-29 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOSANTOS CORONEL PEHUEN JESSENIA', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(77302.80 AS Decimal(18, 2)), CAST(39240.00 AS Decimal(18, 2)), CAST(38062.80 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 30, 1003014029, N'D.N.I', 12896563, 30, N'COSINGA ORTÍZ HUGO DE', CAST(N'2017-10-30 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOSANTOS CORONEL PEHUEN JESSENIA', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(55076.59 AS Decimal(18, 2)), CAST(13769.15 AS Decimal(18, 2)), CAST(41307.44 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 31, 1003014030, N'D.N.I', 12896564, 31, N'COSTA NÚÑEZ IGNACIO PAULA', CAST(N'2017-10-31 00:00:00.000' AS DateTime), N'Asesor Vehicular', N'Asesor Vehicular', N'DOSANTOS CORONEL PEHUEN JESSENIA', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Endosado Externo', N'Soles', CAST(56047.80 AS Decimal(18, 2)), CAST(35970.00 AS Decimal(18, 2)), CAST(20077.79 AS Decimal(18, 2)), N'SI')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 32, 1003014031, N'D.N.I', 12896565, 32, N'GONZÁLEZ  LUNA JAVIER CARMEN', CAST(N'2017-10-20 00:00:00.000' AS DateTime), N'CCFF', N'118 CAL Bellavista CF', N'GUTIÉRREZ VÁZQUEZ NEYEN GRECIA', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(55158.43 AS Decimal(18, 2)), CAST(35000.00 AS Decimal(18, 2)), CAST(20158.43 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 33, 1003014032, N'D.N.I', 12896566, 33, N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', CAST(N'2017-10-15 00:00:00.000' AS DateTime), N'CCFF', N'208 SANTA ANITA', N'MENDOZA OJEDA MARCO LUIS', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(56970.00 AS Decimal(18, 2)), CAST(25000.00 AS Decimal(18, 2)), CAST(31970.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 34, 1003014033, N'D.N.I', 12896567, 34, N'PÉREZ CABRERA JORGE SUSANA', CAST(N'2017-10-19 00:00:00.000' AS DateTime), N'CCFF', N'106 MIR Pardo CF SF', N'LEANDRO LUCERO VICTOR ROSA', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(43204.00 AS Decimal(18, 2)), CAST(18904.00 AS Decimal(18, 2)), CAST(24300.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 35, 1003014034, N'D.N.I', 12896568, 35, N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', CAST(N'2017-10-04 00:00:00.000' AS DateTime), N'CCFF', N'107 SJM Atocongo CF', N'MIDEROS OLIVERA ROSA', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(87885.00 AS Decimal(18, 2)), CAST(60885.00 AS Decimal(18, 2)), CAST(27000.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 36, 1003014035, N'D.N.I', 12896569, 36, N'GARCÍA FERREYRA JUAN LINDERIKA', CAST(N'2017-10-04 00:00:00.000' AS DateTime), N'CCFF', N'105 TT LA MARINA', N'DOS ARIAS PEDRO ELISA', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(38431.12 AS Decimal(18, 2)), CAST(13000.00 AS Decimal(18, 2)), CAST(25431.11 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 37, 1003014036, N'D.N.I', 12896570, 37, N'MARTÍNEZ GODOY JULIAN MARINA', CAST(N'2017-10-19 00:00:00.000' AS DateTime), N'CCFF', N'107 SJM Atocongo CF', N'MARKO PAIRAZAWAMAN TORREZ', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(49150.00 AS Decimal(18, 2)), CAST(16000.00 AS Decimal(18, 2)), CAST(33150.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 38, 1003014037, N'D.N.I', 12896571, 38, N'SÁNCHEZ MORALES JULIO JORGE', CAST(N'2017-10-06 00:00:00.000' AS DateTime), N'CCFF', N'304 AQP Cayma CF SF', N'DOMINGUES CARDOZO NULPI YEFERSON', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(21490.00 AS Decimal(18, 2)), CAST(4900.00 AS Decimal(18, 2)), CAST(16590.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 39, 1003014038, N'D.N.I', 12896572, 39, N'LÓPEZ DOMÍNGUEZ LEONARDO JORGE', CAST(N'2017-10-12 00:00:00.000' AS DateTime), N'CCFF', N'311 centro financiero tottus trujillo mall', N'PEDRO ORTIZ SALAS', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(45452.26 AS Decimal(18, 2)), CAST(10363.00 AS Decimal(18, 2)), CAST(35089.26 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 40, 1003014039, N'D.N.I', 12896573, 40, N'DÍAZ MORENO LICHUEN WIDSENIA', CAST(N'2017-10-20 00:00:00.000' AS DateTime), N'CCFF', N'311 centro financiero tottus trujillo mall', N'MIRELES SOTO CARLOS', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(62007.57 AS Decimal(18, 2)), CAST(42000.00 AS Decimal(18, 2)), CAST(20007.57 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 41, 1003014040, N'D.N.I', 12896574, 41, N'ROJAS PERALTA LOLA URSULA', CAST(N'2017-10-12 00:00:00.000' AS DateTime), N'CCFF', N'303 PIU Saga Falabella CF', N'MINAURO DUARTE TREICY', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Seguro Incluido', N'Soles', CAST(32036.00 AS Decimal(18, 2)), CAST(6410.00 AS Decimal(18, 2)), CAST(25626.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 42, 1003014041, N'D.N.I', 12896575, 42, N'RAMÍREZ VEGA LUCHO MIRIAM', CAST(N'2017-10-27 00:00:00.000' AS DateTime), N'CCFF', N'CCFF CUSCO', N'MORENO VERA NAHUEL NEHUEN ANAVELA', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(35110.19 AS Decimal(18, 2)), CAST(7023.00 AS Decimal(18, 2)), CAST(28087.20 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 43, 1003014042, N'D.N.I', 12896576, 43, N'CASTILLO CARRIZO LUIS KATHERINE', CAST(N'2017-10-06 00:00:00.000' AS DateTime), N'CCFF', N'301 TRU Pizarro CF', N'MEDINA PONCE MIGUEL DAVID', 82, N'ROMERO CASTILLO MANQUE JOEL', N'Endosado Externo', N'Soles', CAST(27640.00 AS Decimal(18, 2)), CAST(7640.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DataAutomotriz] ([CargaId], [Secuencia], [NroPrestamo], [TipoDoc], [Documento], [EmpleadoId], [Empleado], [FechaDesembolso], [Canal], [Captacion], [Promotor], [AsistenteId], [Asistente], [TipoSeguro], [Moneda], [Precio], [CuotaInicial], [Monto], [Intermediacion]) VALUES (17, 44, 1003014043, N'D.N.I', 12896577, 44, N'GÓMEZ QUIROGA MAITEN DENISE', CAST(N'2017-10-27 00:00:00.000' AS DateTime), N'CCFF', N'304 AQP Cayma CF SF', N'DOMINGUES CARDOZO NULPI YEFERSON', 83, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'Seguro Incluido', N'Soles', CAST(52204.19 AS Decimal(18, 2)), CAST(10500.00 AS Decimal(18, 2)), CAST(41704.19 AS Decimal(18, 2)), N'')
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 1, 1, 2, N'BANCO FALABELLA', N'ABREGU GONZÁLEZ ADELMO CRISTY', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 2, 2, 2, N'BANCO FALABELLA', N'ABREU RODRÍGUEZ ADOLFO WALTER', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 3, 3, 2, N'BANCO FALABELLA', N'ADAMES GÓMEZ ADRIANO TERESA', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 4, 4, 2, N'BANCO FALABELLA', N'ADARO FERNÁNDEZ AILÍN FERNANDO', 2017, 10, 1, N'', CAST(9.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 5, 5, 2, N'BANCO FALABELLA', N'ADAUTO LÓPEZ ALBERTO SONIA', 2017, 10, 1, N'', CAST(12.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 6, 6, 2, N'BANCO FALABELLA', N'AGRADA DÍAZ ALEJANDRO ARLETH', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 7, 7, 2, N'BANCO FALABELLA', N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', 2017, 10, 1, N'', CAST(14.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 8, 8, 2, N'BANCO FALABELLA', N'ALCABES PÉREZ ALFREDO ANGELA', 2017, 10, 1, N'', CAST(6.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 9, 9, 2, N'BANCO FALABELLA', N'ALMEIDA GARCÍA ALVAREZ JAVIER', 2017, 10, 1, N'', CAST(7.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 10, 10, 2, N'BANCO FALABELLA', N'ALMEYDA SÁNCHEZ ALVARO JOSE', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 11, 11, 2, N'BANCO FALABELLA', N'ALVARES ROMERO ANA CRISTINA', 2017, 10, 1, N'', CAST(31.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 12, 12, 2, N'BANCO FALABELLA', N'ALVES SOSA ANDREA NORMA', 2017, 10, 1, N'', CAST(3.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 13, 13, 2, N'BANCO FALABELLA', N'AMADO ÁLVAREZ ANDRÉS ELSA', 2017, 10, 1, N'', CAST(14.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 14, 14, 2, N'BANCO FALABELLA', N'AMARAL TORRES ANGELO KRISTOFER', 2017, 10, 1, N'', CAST(9.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 15, 15, 2, N'BANCO FALABELLA', N'ANGOBALDO RAMÍREZ ARIEL JAMES', 2017, 10, 1, N'', CAST(9.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 16, 16, 2, N'BANCO FALABELLA', N'ANTUNES FLORES ARSENIO HINDRA', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 17, 17, 2, N'BANCO FALABELLA', N'BAES ACOSTA ARTURO TELLO', 2017, 10, 1, N'', CAST(7.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 18, 18, 2, N'BANCO FALABELLA', N'BARBOZA BENÍTEZ BRAULIO FASABI', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 19, 19, 2, N'BANCO FALABELLA', N'BARDALES MEDINA CARLOS MARIA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 20, 20, 2, N'BANCO FALABELLA', N'BARROSO SUÁREZ CRISTÓBAL NORIS', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 21, 21, 2, N'BANCO FALABELLA', N'BATISTA HERRERA DIEGO LUZ', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 22, 22, 2, N'BANCO FALABELLA', N'BRANCO AGUIRRE EDUARDO KEYKO', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 23, 23, 2, N'BANCO FALABELLA', N'CALIENES PEREYRA ESTEBAN MELISSA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 24, 24, 2, N'BANCO FALABELLA', N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 25, 25, 2, N'BANCO FALABELLA', N'CASAL GIMÉNEZ FERNANDO MARGOTH', 2017, 10, 1, N'', CAST(5.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 26, 26, 2, N'BANCO FALABELLA', N'CERNADES MOLINA FORTUNATO AMARELIS', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 27, 27, 2, N'BANCO FALABELLA', N'CLIMACO SILVA GERARDO PIERO', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 28, 28, 2, N'BANCO FALABELLA', N'COELHO CASTRO HECTOR DIANA', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 29, 29, 2, N'BANCO FALABELLA', N'COIMBRA ROJAS HUENU LILIAN', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 30, 30, 2, N'BANCO FALABELLA', N'COSINGA ORTÍZ HUGO DE', 2017, 10, 1, N'', CAST(3.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 31, 31, 2, N'BANCO FALABELLA', N'COSTA NÚÑEZ IGNACIO PAULA', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 32, 32, 2, N'BANCO FALABELLA', N'GONZÁLEZ  LUNA JAVIER CARMEN', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 33, 33, 2, N'BANCO FALABELLA', N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', 2017, 10, 1, N'', CAST(5.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 34, 34, 2, N'BANCO FALABELLA', N'PÉREZ CABRERA JORGE SUSANA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 35, 35, 2, N'BANCO FALABELLA', N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 36, 36, 2, N'BANCO FALABELLA', N'GARCÍA FERREYRA JUAN LINDERIKA', 2017, 10, 1, N'', CAST(9.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 37, 37, 2, N'BANCO FALABELLA', N'MARTÍNEZ GODOY JULIAN MARINA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 38, 38, 2, N'BANCO FALABELLA', N'SÁNCHEZ MORALES JULIO JORGE', 2017, 10, 1, N'', CAST(7.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 39, 39, 2, N'BANCO FALABELLA', N'LÓPEZ DOMÍNGUEZ LEONARDO JORGE', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 40, 40, 2, N'BANCO FALABELLA', N'DÍAZ MORENO LICHUEN WIDSENIA', 2017, 10, 1, N'', CAST(3.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 41, 41, 2, N'BANCO FALABELLA', N'ROJAS PERALTA LOLA URSULA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 42, 42, 2, N'BANCO FALABELLA', N'RAMÍREZ VEGA LUCHO MIRIAM', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 43, 43, 2, N'BANCO FALABELLA', N'CASTILLO CARRIZO LUIS KATHERINE', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 44, 44, 2, N'BANCO FALABELLA', N'GÓMEZ QUIROGA MAITEN DENISE', 2017, 10, 1, N'', CAST(31.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 45, 45, 2, N'BANCO FALABELLA', N'ROMERO CASTILLO MANQUE JOEL', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 46, 46, 2, N'BANCO FALABELLA', N'FERNANDEZ LEDESMA MANUEL HELMUD', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 47, 47, 2, N'BANCO FALABELLA', N'TORRES MUÑOZ MARCELO DENISSE', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 48, 48, 2, N'BANCO FALABELLA', N'MENDOZA OJEDA MARCO LUIS', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 49, 49, 2, N'BANCO FALABELLA', N'MEDINA PONCE MIGUEL DAVID', 2017, 10, 1, N'', CAST(7.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 50, NULL, 2, N'BANCO FALABELLA', N'MORENO VERA NAHUEL NEHUEN ANAVELA', 2017, 10, 1, N'', CAST(5.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 51, 50, 2, N'BANCO FALABELLA', N'GUTIÉRREZ VÁZQUEZ NEYEN GRECIA', 2017, 10, 1, N'', CAST(26.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 52, 51, 2, N'BANCO FALABELLA', N'DOCARMO VILLALBA NICOLAS LUYO', 2017, 10, 1, N'', CAST(1.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 53, 52, 2, N'BANCO FALABELLA', N'DOMINGUES CARDOZO NULPI YEFERSON', 2017, 10, 1, N'', CAST(8.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 54, 53, 2, N'BANCO FALABELLA', N'DORADOR NAVARRO PABLO HAROLD', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 55, 54, 2, N'BANCO FALABELLA', N'DORREGO RAMOS PATRÍCIO SANTOS', 2017, 10, 1, N'', CAST(4.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 56, 55, 2, N'BANCO FALABELLA', N'DOS ARIAS PEDRO ELISA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 57, 56, 2, N'BANCO FALABELLA', N'DOSANTOS CORONEL PEHUEN JESSENIA', 2017, 10, 1, N'', CAST(15.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 58, 57, 2, N'BANCO FALABELLA', N'EVANGELISTA CÓRDOBA PICHI JANETH', 2017, 10, 1, N'', CAST(30.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 59, 68, 2, N'BANCO FALABELLA', N'JUNIOR MÉNDEZ VICENTE CANDY', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 60, 69, 2, N'BANCO FALABELLA', N'LEANDRO LUCERO VICTOR ROSA', 2017, 10, 1, N'', CAST(7.00 AS Decimal(5, 2)))
INSERT [Comisiones].[DiasAusencia] ([CargaId], [Secuencia], [EmpleadoId], [EmpresaId], [Empresa], [Empleado], [Anio], [Mes], [Correlativo], [FechaProc], [TotDiasNoLabor]) VALUES (4, 61, NULL, 2, N'BANCO FALABELLA', N'LEAO CRUZ XAVIER YACO YOEL', 2017, 10, 1, N'', CAST(2.00 AS Decimal(5, 2)))
SET IDENTITY_INSERT [Comisiones].[Empleado] ON 

INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (1, N'ADELMO CRISTY', N'ABREGU', N'GONZÁLEZ', N'12896534', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (2, N'ADOLFO WALTER', N'ABREU', N'RODRÍGUEZ', N'12896535', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (3, N'ADRIANO TERESA', N'ADAMES', N'GÓMEZ', N'12896536', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (4, N'AILÍN FERNANDO', N'ADARO', N'FERNÁNDEZ', N'12896537', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (5, N'ALBERTO SONIA', N'ADAUTO', N'LÓPEZ', N'12896538', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (6, N'ALEJANDRO ARLETH', N'AGRADA', N'DÍAZ', N'12896539', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (7, N'ALFONSO MARITZA', N'ALBURQUEQUE', N'MARTÍNEZ', N'12896540', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (8, N'ALFREDO ANGELA', N'ALCABES', N'PÉREZ', N'12896541', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (9, N'ALVAREZ JAVIER', N'ALMEIDA', N'GARCÍA', N'12896542', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (10, N'ALVARO JOSE', N'ALMEYDA', N'SÁNCHEZ', N'12896543', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (11, N'ANA CRISTINA', N'ALVARES', N'ROMERO', N'12896544', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (12, N'ANDREA NORMA', N'ALVES', N'SOSA', N'12896545', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (13, N'ANDRÉS ELSA', N'AMADO', N'ÁLVAREZ', N'12896546', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (14, N'ANGELO KRISTOFER', N'AMARAL', N'TORRES', N'12896547', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (15, N'ARIEL JAMES', N'ANGOBALDO', N'RAMÍREZ', N'12896548', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (16, N'ARSENIO HINDRA', N'ANTUNES', N'FLORES', N'12896549', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (17, N'ARTURO TELLO', N'BAES', N'ACOSTA', N'12896550', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (18, N'BRAULIO FASABI', N'BARBOZA', N'BENÍTEZ', N'12896551', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (19, N'CARLOS MARIA', N'BARDALES', N'MEDINA', N'12896552', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (20, N'CRISTÓBAL NORIS', N'BARROSO', N'SUÁREZ', N'12896553', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (21, N'DIEGO LUZ', N'BATISTA', N'HERRERA', N'12896554', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (22, N'EDUARDO KEYKO', N'BRANCO', N'AGUIRRE', N'12896555', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (23, N'ESTEBAN MELISSA', N'CALIENES', N'PEREYRA', N'12896556', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (24, N'ESTEVAN ALEX', N'CARDOSO', N'GUTIÉRREZ', N'12896557', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (25, N'FERNANDO MARGOTH', N'CASAL', N'GIMÉNEZ', N'12896558', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (26, N'FORTUNATO AMARELIS', N'CERNADES', N'MOLINA', N'12896559', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (27, N'GERARDO PIERO', N'CLIMACO', N'SILVA', N'12896560', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (28, N'HECTOR DIANA', N'COELHO', N'CASTRO', N'12896561', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (29, N'HUENU LILIAN', N'COIMBRA', N'ROJAS', N'12896562', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (30, N'HUGO DE', N'COSINGA', N'ORTÍZ', N'12896563', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (31, N'IGNACIO PAULA', N'COSTA', N'NÚÑEZ', N'12896564', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (32, N'JAVIER CARMEN', N'GONZÁLEZ ', N'LUNA', N'12896565', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (33, N'JOAQUIN JANNINA', N'RODRÍGUEZ', N'JUÁREZ', N'12896566', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (34, N'JORGE SUSANA', N'PÉREZ', N'CABRERA', N'12896567', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (35, N'JOSÉ GLADYZ', N'HERNÁNDEZ', N'RÍOS', N'12896568', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (36, N'JUAN LINDERIKA', N'GARCÍA', N'FERREYRA', N'12896569', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (37, N'JULIAN MARINA', N'MARTÍNEZ', N'GODOY', N'12896570', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (38, N'JULIO JORGE', N'SÁNCHEZ', N'MORALES', N'12896571', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (39, N'LEONARDO JORGE', N'LÓPEZ', N'DOMÍNGUEZ', N'12896572', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (40, N'LICHUEN WIDSENIA', N'DÍAZ', N'MORENO', N'12896573', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (41, N'LOLA URSULA', N'ROJAS', N'PERALTA', N'12896574', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (42, N'LUCHO MIRIAM', N'RAMÍREZ', N'VEGA', N'12896575', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (43, N'LUIS KATHERINE', N'CASTILLO', N'CARRIZO', N'12896576', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (44, N'MAITEN DENISE', N'GÓMEZ', N'QUIROGA', N'12896577', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (45, N'MANQUE JOEL', N'ROMERO', N'CASTILLO', N'12896578', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (46, N'MANUEL HELMUD', N'FERNANDEZ', N'LEDESMA', N'12896579', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (47, N'MARCELO DENISSE', N'TORRES', N'MUÑOZ', N'12896580', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (48, N'MARCO LUIS', N'MENDOZA', N'OJEDA', N'12896581', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (49, N'MIGUEL DAVID', N'MEDINA', N'PONCE', N'12896582', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (50, N'NEYEN GRECIA', N'GUTIÉRREZ', N'VÁZQUEZ', N'12896584', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (51, N'NICOLAS LUYO', N'DOCARMO', N'VILLALBA', N'12896585', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (52, N'NULPI YEFERSON', N'DOMINGUES', N'CARDOZO', N'12896586', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (53, N'PABLO HAROLD', N'DORADOR', N'NAVARRO', N'12896587', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (54, N'PATRÍCIO SANTOS', N'DORREGO', N'RAMOS', N'12896588', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (55, N'PEDRO ELISA', N'DOS', N'ARIAS', N'12896589', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (56, N'PEHUEN JESSENIA', N'DOSANTOS', N'CORONEL', N'12896590', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (57, N'PICHI JANETH', N'EVANGELISTA', N'CÓRDOBA', N'12896591', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (58, N'RADHIKA FULVIA', N'FARIA', N'FIGUEROA', N'12896592', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (59, N'RAFAEL MARIANELA', N'FAURA', N'CORREA', N'12896593', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (60, N'RAIQUEN KAREN', N'FERNANDES', N'CÁCERES', N'12896594', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (61, N'RAUL WILMER', N'FERREIRA', N'VARGAS', N'12896595', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (62, N'RICARDO MIRTHA', N'FERREYRA', N'MALDONADO', N'12896596', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (63, N'ROBERTO LILIA', N'FINO', N'MANSILLA', N'12896597', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (64, N'RODOLFO MAYRA', N'FREITAS', N'FARÍAS', N'12896598', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (65, N'SANTIAGO JORGE', N'GONCALVES', N'PAZ', N'12896600', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (66, N'SEBASTIAN ISAURA', N'GUEDES', N'MIRANDA', N'12896601', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (67, N'SERGIO DIANA', N'GUIMAREY', N'ROLDÁN', N'12896602', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (68, N'VICENTE CANDY', N'JUNIOR', N'MÉNDEZ', N'12896603', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (69, N'VICTOR ROSA', N'LEANDRO', N'LUCERO', N'12896604', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (70, N'YAMAI ANGIE', N'LENCASTRE', N'HERNÁNDEZ', N'12896606', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (71, N'YENIEN WILMER', N'LOBATO', N'AGÜERO', N'12896607', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (72, N'YERIMEN KELY', N'LOBO', N'PÁEZ', N'12896608', 2)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (73, N'ELKA PAOLA', N'MENDOZA', N'REATEGUI', N'50098078', 4)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (75, N'PEDRO ELISA', N'DOS', N'ARIAS', N'0', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (76, N'PEHUEN JESSENIA', N'DOSANTOS', N'CORONEL', N'0', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (77, N'PICHI JANETH', N'EVANGELISTA', N'CORDOBA', N'0', 1)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (78, N'ROSA', N'MIDEROS', N'OLIVERA', N'0', 5)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (79, N'TREICY', N'MINAURO', N'DUARTE', N'0', 5)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (80, N'CARLOS', N'MIRELES', N'SOTO', N'0', 5)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (81, N'LA', N'MIRES', N'FRANCO', N'0', 5)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (82, N'MANQUE JOEL', N'ROMERO', N'CASTILLO', N'8975541', 6)
INSERT [Comisiones].[Empleado] ([Id], [Nombres], [ApellidoPaterno], [ApellidoMaterno], [Codigo], [CargoId]) VALUES (83, N'MANUEL HELMUD', N'FERNANDEZ', N'LEDESMA', N'8975550', 6)
SET IDENTITY_INSERT [Comisiones].[Empleado] OFF
SET IDENTITY_INSERT [Comisiones].[Excel] ON 

INSERT [Comisiones].[Excel] ([Id], [Nombre], [Descripcion], [Ruta]) VALUES (1, N'Productividad.xlsx', N'Reporte de Productividad', N'D:\TEMP\Comisiones\')
INSERT [Comisiones].[Excel] ([Id], [Nombre], [Descripcion], [Ruta]) VALUES (2, N'Monitoreo.xlsx', N'Reporte de Monitoreo Input', N'D:\TEMP\Comisiones\')
INSERT [Comisiones].[Excel] ([Id], [Nombre], [Descripcion], [Ruta]) VALUES (3, N'DiasAusencia.xlsx', N'Reporte Dias Ausencia', N'D:\TEMP\Comisiones\')
INSERT [Comisiones].[Excel] ([Id], [Nombre], [Descripcion], [Ruta]) VALUES (4, N'DataAutomotriz.xls', N'Reporte Auomotriz', N'D:\TEMP\Comisiones\Automotriz\')
SET IDENTITY_INSERT [Comisiones].[Excel] OFF
INSERT [Comisiones].[ExcelHoja] ([ExcelId], [TipoArchivo], [FilaIni], [NombreHoja], [Descripcion]) VALUES (1, N'1', 7, N'Productividad', NULL)
INSERT [Comisiones].[ExcelHoja] ([ExcelId], [TipoArchivo], [FilaIni], [NombreHoja], [Descripcion]) VALUES (1, N'10', 18, N'Contactenos', N'input SLAContactenos UAC')
INSERT [Comisiones].[ExcelHoja] ([ExcelId], [TipoArchivo], [FilaIni], [NombreHoja], [Descripcion]) VALUES (1, N'4', 7, N'Contactenos', N'input ProductContactenos UAC')
INSERT [Comisiones].[ExcelHoja] ([ExcelId], [TipoArchivo], [FilaIni], [NombreHoja], [Descripcion]) VALUES (1, N'5', 7, N'SLA', NULL)
INSERT [Comisiones].[ExcelHoja] ([ExcelId], [TipoArchivo], [FilaIni], [NombreHoja], [Descripcion]) VALUES (2, N'2', 5, N'Monitoreo', N'Input base')
INSERT [Comisiones].[ExcelHoja] ([ExcelId], [TipoArchivo], [FilaIni], [NombreHoja], [Descripcion]) VALUES (3, N'3', 2, N'FPLPRBO (701)', N'una sola hoja')
INSERT [Comisiones].[ExcelHoja] ([ExcelId], [TipoArchivo], [FilaIni], [NombreHoja], [Descripcion]) VALUES (4, N'6', 11, N'Automotriz', N'Input Comision Auomotriz')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'1', N'DiasAsistencia', N'G')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'1', N'Empleado', N'C')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'1', N'Grupo', N'B')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'1', N'Logro', N'I')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'1', N'MetaDiaria', N'F')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'1', N'Supervisor', N'A')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'1', N'TotalProductividad', N'D')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'10', N'DentroPlazo', N'B')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'10', N'Empleado', N'A')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'10', N'FueraPlazo', N'C')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'10', N'SLA', N'G')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'10', N'TotalGeneral', N'D')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'4', N'DiasLaborados', N'C')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'4', N'Empleado', N'A')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'4', N'MetaDiaria', N'D')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'4', N'MetaMes', N'E')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'4', N'Productividad', N'G')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'4', N'TotalAtendido', N'B')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'5', N'DentroPlazo', N'E')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'5', N'Empleado', N'C')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'5', N'FueraPlazo', N'D')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'5', N'Grupo', N'B')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'5', N'Supervisor', N'A')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (1, N'5', N'TotalGeneral', N'F')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'CP1', N'Q')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'CR1', N'H')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'CR2', N'I')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'CR3', N'J')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'CR4', N'K')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'CR5', N'L')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'CR6', N'M')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'CR7', N'N')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'CS1', N'O')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'CS2', N'P')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'Empleado', N'E')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'FechaMuestra', N'B')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'Incidente', N'D')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'Mes', N'C')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'MR1', N'X')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'MR2', N'Y')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'MR3', N'Z')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'OR1', N'R')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'OR2', N'S')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'Proceso', N'F')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'Semana', N'A')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'TipoMonitoreo', N'G')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'VR1', N'T')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'VR2', N'U')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'VR3', N'V')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (2, N'2', N'VR4', N'W')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (3, N'3', N'Anio', N'J')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (3, N'3', N'Correlativo', N'L')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (3, N'3', N'Empleado', N'G')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (3, N'3', N'Empresa', N'B')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (3, N'3', N'EmpresaId', N'A')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (3, N'3', N'FechaProc', N'M')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (3, N'3', N'Mes', N'K')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (3, N'3', N'TotDiasNoLabor', N'U')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'Asistente', N'I')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'Canal', N'F')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'Captacion', N'G')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'CuotaInicial', N'L')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'Documento', N'C')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'Empleado', N'D')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'FechaDesembolso', N'E')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'Intermediacion', N'N')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'Monto', N'M')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'NroPrestamo', N'A')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'Precio', N'K')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'Promotor', N'H')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'TipoDoc', N'B')
INSERT [Comisiones].[ExcelHojaCampo] ([ExcelId], [TipoArchivo], [NombreCampo], [NombreCelda]) VALUES (4, N'6', N'TipoSeguro', N'J')
SET IDENTITY_INSERT [Comisiones].[Grupo] ON 

INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (1, N'G1', 78)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (2, N'G2', 78)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (3, N'G3', 79)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (4, N'G4', 79)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (5, N'G5', 80)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (6, N'G9-Piloto', 80)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (7, N'G9', 80)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (8, N'Impugnaciones', 79)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (9, N'Alo Banco', 73)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (10, N'Masivos', 73)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (11, N'G6', 0)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (12, N'G8', 79)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (13, N'G7', 78)
INSERT [Comisiones].[Grupo] ([Id], [Nombre], [ResponsableId]) VALUES (14, N'Contáctenos', 73)
SET IDENTITY_INSERT [Comisiones].[Grupo] OFF
SET IDENTITY_INSERT [Comisiones].[Homologacion] ON 

INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (1, N'ABREGU GONZÁLEZ ADELMO CRISTY', N'12896534')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (2, N'ABREU RODRÍGUEZ ADOLFO WALTER', N'12896535')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (3, N'ADAMES GÓMEZ ADRIANO TERESA', N'12896536')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (4, N'ADARO FERNÁNDEZ AILÍN FERNANDO', N'12896537')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (5, N'ADAUTO LÓPEZ ALBERTO SONIA', N'12896538')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (6, N'AGRADA DÍAZ ALEJANDRO ARLETH', N'12896539')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (7, N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', N'12896540')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (8, N'ALCABES PÉREZ ALFREDO ANGELA', N'12896541')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (9, N'ALMEIDA GARCÍA ALVAREZ JAVIER', N'12896542')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (10, N'ALMEYDA SÁNCHEZ ALVARO JOSE', N'12896543')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (11, N'ALVARES ROMERO ANA CRISTINA', N'12896544')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (12, N'ALVES SOSA ANDREA NORMA', N'12896545')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (13, N'AMADO ÁLVAREZ ANDRÉS ELSA', N'12896546')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (14, N'AMARAL TORRES ANGELO KRISTOFER', N'12896547')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (15, N'ANGOBALDO RAMÍREZ ARIEL JAMES', N'12896548')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (16, N'ANTUNES FLORES ARSENIO HINDRA', N'12896549')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (17, N'BAES ACOSTA ARTURO TELLO', N'12896550')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (18, N'BARBOZA BENÍTEZ BRAULIO FASABI', N'12896551')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (19, N'BARDALES MEDINA CARLOS MARIA', N'12896552')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (20, N'BARROSO SUÁREZ CRISTÓBAL NORIS', N'12896553')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (21, N'BATISTA HERRERA DIEGO LUZ', N'12896554')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (22, N'BRANCO AGUIRRE EDUARDO KEYKO', N'12896555')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (23, N'CALIENES PEREYRA ESTEBAN MELISSA', N'12896556')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (24, N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', N'12896557')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (25, N'CASAL GIMÉNEZ FERNANDO MARGOTH', N'12896558')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (26, N'CERNADES MOLINA FORTUNATO AMARELIS', N'12896559')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (27, N'CLIMACO SILVA GERARDO PIERO', N'12896560')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (28, N'COELHO CASTRO HECTOR DIANA', N'12896561')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (29, N'COIMBRA ROJAS HUENU LILIAN', N'12896562')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (30, N'COSINGA ORTÍZ HUGO DE', N'12896563')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (31, N'COSTA NÚÑEZ IGNACIO PAULA', N'12896564')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (32, N'GONZÁLEZ  LUNA JAVIER CARMEN', N'12896565')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (33, N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', N'12896566')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (34, N'PÉREZ CABRERA JORGE SUSANA', N'12896567')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (35, N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', N'12896568')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (36, N'GARCÍA FERREYRA JUAN LINDERIKA', N'12896569')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (37, N'MARTÍNEZ GODOY JULIAN MARINA', N'12896570')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (38, N'SÁNCHEZ MORALES JULIO JORGE', N'12896571')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (39, N'LÓPEZ DOMÍNGUEZ LEONARDO JORGE', N'12896572')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (40, N'DÍAZ MORENO LICHUEN WIDSENIA', N'12896573')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (41, N'ROJAS PERALTA LOLA URSULA', N'12896574')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (42, N'RAMÍREZ VEGA LUCHO MIRIAM', N'12896575')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (43, N'CASTILLO CARRIZO LUIS KATHERINE', N'12896576')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (44, N'GÓMEZ QUIROGA MAITEN DENISE', N'12896577')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (45, N'ROMERO CASTILLO MANQUE JOEL', N'12896578')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (46, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'12896579')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (47, N'TORRES MUÑOZ MARCELO DENISSE', N'12896580')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (48, N'MENDOZA OJEDA MARCO LUIS', N'12896581')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (49, N'MEDINA PONCE MIGUEL DAVID', N'12896582')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (50, N'MORENO VERA NAHUEL NEHUEN ANAVELA', N'12896583')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (51, N'GUTIÉRREZ VÁZQUEZ NEYEN GRECIA', N'12896584')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (52, N'DOCARMO VILLALBA NICOLAS LUYO', N'12896585')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (53, N'DOMINGUES CARDOZO NULPI YEFERSON', N'12896586')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (54, N'DORADOR NAVARRO PABLO HAROLD', N'12896587')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (55, N'DORREGO RAMOS PATRÍCIO SANTOS', N'12896588')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (56, N'DOS ARIAS PEDRO ELISA', N'12896589')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (57, N'DOSANTOS CORONEL PEHUEN JESSENIA', N'12896590')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (58, N'EVANGELISTA CÓRDOBA PICHI JANETH', N'12896591')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (59, N'FARIA FIGUEROA RADHIKA FULVIA', N'12896592')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (60, N'FAURA CORREA RAFAEL MARIANELA', N'12896593')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (61, N'FERNANDES CÁCERES RAIQUEN KAREN', N'12896594')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (62, N'FERREIRA VARGAS RAUL WILMER', N'12896595')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (63, N'FERREYRA MALDONADO RICARDO MIRTHA', N'12896596')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (64, N'FINO MANSILLA ROBERTO LILIA', N'12896597')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (65, N'FREITAS FARÍAS RODOLFO MAYRA', N'12896598')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (66, N'GOMES RIVERO ROLANDO CESIA', N'12896599')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (67, N'GONCALVES PAZ SANTIAGO JORGE', N'12896600')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (68, N'GUEDES MIRANDA SEBASTIAN ISAURA', N'12896601')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (69, N'GUIMAREY ROLDÁN SERGIO DIANA', N'12896602')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (70, N'JUNIOR MÉNDEZ VICENTE CANDY', N'12896603')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (71, N'LEANDRO LUCERO VICTOR ROSA', N'12896604')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (72, N'LEAO CRUZ XAVIER YACO YOEL', N'12896605')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (73, N'LENCASTRE HERNÁNDEZ YAMAI ANGIE', N'12896606')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (74, N'LOBATO AGÜERO YENIEN WILMER', N'12896607')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (75, N'LOBO PÁEZ YERIMEN KELY', N'12896608')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (76, N'LOPES BLANCO KATHERINE ', N'12896609')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (77, N'LUGO MENDOZA KERLY ', N'12896610')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (78, N'MAGALLANES BARRIOS YENNIFER ', N'12896611')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (79, N'MAQUEIRA ESCOBAR MARIA ', N'12896612')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (80, N'MARTOS ÁVILA KAYRO ', N'12896613')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (81, N'MAURO SORIA LORENA ', N'12896614')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (82, N'MEGO LEIVA NESTOR ', N'12896615')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (83, N'MELO ACUÑA JOSE ', N'12896616')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (84, N'MELLO MARTIN MILAGROS ', N'12896617')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (85, N'MENEJES MAIDANA LIZZET ', N'12896618')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (86, N'MERELLO MOYANO KATHERINE ', N'12896619')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (87, N'MERES CAMPOS ARIAGNA ', N'12896620')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (88, N'MIDEROS OLIVERA ROSA ', N'12896621')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (89, N'MINAURO DUARTE TREICY ', N'12896622')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (90, N'MIRELES SOTO CARLOS ', N'12896623')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (91, N'MIRES FRANCO LA ', N'12896624')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (92, N'Elka Mendoza Reategui', N'50098078')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (93, N'ROMERO CASTILLO MANQUE JOEL', N'8975541')
INSERT [Comisiones].[Homologacion] ([Id], [Nombre], [Codigo]) VALUES (94, N'FERNANDEZ LEDESMA MANUEL HELMUD', N'8975550')
SET IDENTITY_INSERT [Comisiones].[Homologacion] OFF
INSERT [Comisiones].[IndicadorMedicion] ([IndicadorId], [Indicador], [Porcentaje]) VALUES (N'CP', N'CONOCIMIENTO DEL PROCESO', CAST(0.04 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicion] ([IndicadorId], [Indicador], [Porcentaje]) VALUES (N'CR', N'CALIDAD DE RESPUESTA', CAST(0.53 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicion] ([IndicadorId], [Indicador], [Porcentaje]) VALUES (N'CRE', N'CASOS RESUELTOS', CAST(0.50 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicion] ([IndicadorId], [Indicador], [Porcentaje]) VALUES (N'CS', N'COMPLETITUD DE SUSTENTOS', CAST(0.08 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicion] ([IndicadorId], [Indicador], [Porcentaje]) VALUES (N'MR', N'MALAS RESPUESTAS', CAST(0.00 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicion] ([IndicadorId], [Indicador], [Porcentaje]) VALUES (N'OR', N'OPORTUNIDAD DE RESPUESTA', CAST(0.14 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicion] ([IndicadorId], [Indicador], [Porcentaje]) VALUES (N'SLA', N'SLA POR TIPOLOGIA', CAST(0.50 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicion] ([IndicadorId], [Indicador], [Porcentaje]) VALUES (N'VR', N'VALIDACIÓN Y REDACCIÓN', CAST(0.21 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'CP', N'CP1', NULL, CAST(0.04 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'CR', N'CR1', NULL, CAST(0.15 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'CR', N'CR2', NULL, CAST(0.05 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'CR', N'CR3', NULL, CAST(0.10 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'CR', N'CR4', NULL, CAST(0.08 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'CR', N'CR5', NULL, CAST(0.05 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'CR', N'CR6', NULL, CAST(0.05 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'CR', N'CR7', NULL, CAST(0.05 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'CS', N'CS1', NULL, CAST(0.05 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'CS', N'CS2', NULL, CAST(0.03 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'MR', N'MR1', NULL, CAST(1.00 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'MR', N'MR2', NULL, CAST(1.00 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'MR', N'MR3', NULL, CAST(1.00 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'OR', N'OR1', NULL, CAST(0.08 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'OR', N'OR2', NULL, CAST(0.06 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'VR', N'VR1', NULL, CAST(0.05 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'VR', N'VR2', NULL, CAST(0.06 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'VR', N'VR3', NULL, CAST(0.04 AS Decimal(8, 2)))
INSERT [Comisiones].[IndicadorMedicionNota] ([IndicadorId], [CampoId], [Pregunta], [Nota]) VALUES (N'VR', N'VR4', NULL, CAST(0.06 AS Decimal(8, 2)))
INSERT [Comisiones].[MetaEmpleado] ([Fecha], [EmpleadoId], [TipoComision], [Meta]) VALUES (CAST(N'2017-12-01 00:00:00.000' AS DateTime), 82, 2, CAST(24.00 AS Decimal(18, 2)))
INSERT [Comisiones].[MetaEmpleado] ([Fecha], [EmpleadoId], [TipoComision], [Meta]) VALUES (CAST(N'2017-12-01 00:00:00.000' AS DateTime), 83, 2, CAST(18.00 AS Decimal(18, 2)))
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 1, N'Del 04/09/2017 al 08/09/2017', 9, CAST(N'2017-09-08 00:00:00.000' AS DateTime), 2235478, 1, N'ABREGU GONZÁLEZ ADELMO CRISTY', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 2, N'Del 04/09/2017 al 08/09/2017', 9, CAST(N'2017-09-08 00:00:00.000' AS DateTime), 2235479, 2, N'ABREU RODRÍGUEZ ADOLFO WALTER', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 3, N'Del 04/09/2017 al 08/09/2017', 9, CAST(N'2017-09-08 00:00:00.000' AS DateTime), 2235480, 3, N'ADAMES GÓMEZ ADRIANO TERESA', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 4, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-15 00:00:00.000' AS DateTime), 2235481, 4, N'ADARO FERNÁNDEZ AILÍN FERNANDO', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 5, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-15 00:00:00.000' AS DateTime), 2235482, 5, N'ADAUTO LÓPEZ ALBERTO SONIA', N'Problemas en el Envío de Estado de Cuenta', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 6, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-15 00:00:00.000' AS DateTime), 2235483, 6, N'AGRADA DÍAZ ALEJANDRO ARLETH', N'Extornos', N'N', N'si', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 7, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-15 00:00:00.000' AS DateTime), 2235484, 7, N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', N'Extornos', N'N', N'si', N'no', N'si', N'no', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'si')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 8, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-21 00:00:00.000' AS DateTime), 2235485, 8, N'ALCABES PÉREZ ALFREDO ANGELA', N'Consumo No Reconocido', N'N', N'si', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'si', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 9, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-22 00:00:00.000' AS DateTime), 2235486, 9, N'ALMEIDA GARCÍA ALVAREZ JAVIER', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 10, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-22 00:00:00.000' AS DateTime), 2235487, 10, N'ALMEYDA SÁNCHEZ ALVARO JOSE', N'Explicación de Cuenta', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 11, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-29 00:00:00.000' AS DateTime), 2235488, 11, N'ALVARES ROMERO ANA CRISTINA', N'Consumo No Reconocido', N'N', N'si', N'no', N'no', N'no', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 12, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-29 00:00:00.000' AS DateTime), 2235489, 12, N'ALVES SOSA ANDREA NORMA', N'Consumo No Reconocido', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 13, N'Del 04/09/2017 al 08/09/2017', 9, CAST(N'2017-09-04 00:00:00.000' AS DateTime), 2235490, 13, N'AMADO ÁLVAREZ ANDRÉS ELSA', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 14, N'Del 04/09/2017 al 08/09/2017', 9, CAST(N'2017-09-05 00:00:00.000' AS DateTime), 2235491, 14, N'AMARAL TORRES ANGELO KRISTOFER', N'Inadecuada o Insuficiente Información', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 15, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-13 00:00:00.000' AS DateTime), 2235492, 15, N'ANGOBALDO RAMÍREZ ARIEL JAMES', N'Promociones y/u ofertas', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 16, N'Del 11/09/2017 al 15/09/2017', 9, CAST(N'2017-09-13 00:00:00.000' AS DateTime), 2235493, 16, N'ANTUNES FLORES ARSENIO HINDRA', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 17, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-19 00:00:00.000' AS DateTime), 2235494, 17, N'BAES ACOSTA ARTURO TELLO', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 18, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-20 00:00:00.000' AS DateTime), 2235495, 18, N'BARBOZA BENÍTEZ BRAULIO FASABI', N'Consumos no reconocidos', N'N', N'no', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'si', N'si', N'no', N'si', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 19, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-20 00:00:00.000' AS DateTime), 2235496, 19, N'BARDALES MEDINA CARLOS MARIA', N'Extornos', N'N', N'si', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 20, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-21 00:00:00.000' AS DateTime), 2235497, 20, N'BARROSO SUÁREZ CRISTÓBAL NORIS', N'Problemas con Pagos', N'N', N'no', N'no', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 21, N'Del 18/09/2017 al 22/09/2017', 9, CAST(N'2017-09-22 00:00:00.000' AS DateTime), 2235498, 21, N'BATISTA HERRERA DIEGO LUZ', N'Inadecuada o Insuficiente Información', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 22, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-25 00:00:00.000' AS DateTime), 2235499, 22, N'BRANCO AGUIRRE EDUARDO KEYKO', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 23, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-28 00:00:00.000' AS DateTime), 2235500, 23, N'CALIENES PEREYRA ESTEBAN MELISSA', N'Extornos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 24, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-29 00:00:00.000' AS DateTime), 2235501, 24, N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 25, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-29 00:00:00.000' AS DateTime), 2235502, 25, N'CASAL GIMÉNEZ FERNANDO MARGOTH', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no')
INSERT [Comisiones].[Monitoreo] ([CargaId], [Secuencia], [Semana], [Mes], [FechaMuestra], [Incidente], [EmpleadoId], [Empleado], [Proceso], [TipoMonitoreo], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CS1], [CS2], [CP1], [OR1], [OR2], [VR1], [VR2], [VR3], [VR4], [MR1], [MR2], [MR3]) VALUES (3, 26, N'Del 25/09/2017 al 29/09/2017', 9, CAST(N'2017-09-29 00:00:00.000' AS DateTime), 2235503, 26, N'CERNADES MOLINA FORTUNATO AMARELIS', N'Consumos no reconocidos', N'N', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'si', N'no', N'no', N'no', N'no', N'no')
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 1, 1, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 2, 2, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 3, 3, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 4, 4, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.17 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.96 AS Decimal(8, 2)), 0)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 5, 5, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.15 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.94 AS Decimal(8, 2)), 0)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 6, 6, CAST(0.15 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.48 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.95 AS Decimal(8, 2)), 0)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 7, 7, CAST(0.15 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.48 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), CAST(1.95 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 8, 8, CAST(0.15 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.48 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), CAST(1.95 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 9, 9, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 10, 10, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 11, 11, CAST(0.15 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.38 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.85 AS Decimal(8, 2)), 0)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 12, 12, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 13, 13, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 14, 14, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 15, 15, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 16, 16, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 17, 17, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 18, 18, CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.15 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), CAST(1.51 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 19, 19, CAST(0.15 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.48 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.17 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.91 AS Decimal(8, 2)), 0)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 20, 20, CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.57 AS Decimal(8, 2)), 0)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 21, 21, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 22, 22, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 23, 23, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 24, 24, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.15 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.94 AS Decimal(8, 2)), 0)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 25, 25, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.21 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(1.00 AS Decimal(8, 2)), 1)
INSERT [Comisiones].[Ponderacion] ([CargaId], [Secuencia], [EmpleadoId], [CR1], [CR2], [CR3], [CR4], [CR5], [CR6], [CR7], [CR_SUMA], [CS1], [CS2], [CS_SUMA], [CP1], [CP_SUMA], [OR1], [OR2], [OR_SUMA], [VR1], [VR2], [VR3], [VR4], [VR_SUMA], [MR1], [MR2], [MR3], [MR_SUMA], [Nota], [Cumple_Estand]) VALUES (3, 26, 26, CAST(0.15 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.10 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.53 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.03 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.04 AS Decimal(8, 2)), CAST(0.08 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.14 AS Decimal(8, 2)), CAST(0.05 AS Decimal(8, 2)), CAST(0.06 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.11 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.00 AS Decimal(8, 2)), CAST(0.90 AS Decimal(8, 2)), 0)
INSERT [Comisiones].[ProducContactenos] ([CargaId], [Secuencia], [EmpleadoId], [Empleado], [TotalAtendido], [DiasLaborados], [MetaDiaria], [MetaMes], [Productividad]) VALUES (5, 1, 55, N'DOS ARIAS PEDRO ELISA', 440, 21, 20, 420, CAST(1.05 AS Decimal(5, 2)))
INSERT [Comisiones].[ProducContactenos] ([CargaId], [Secuencia], [EmpleadoId], [Empleado], [TotalAtendido], [DiasLaborados], [MetaDiaria], [MetaMes], [Productividad]) VALUES (5, 2, 56, N'DOSANTOS CORONEL PEHUEN JESSENIA', 353, 21, 20, 420, CAST(0.84 AS Decimal(5, 2)))
INSERT [Comisiones].[ProducContactenos] ([CargaId], [Secuencia], [EmpleadoId], [Empleado], [TotalAtendido], [DiasLaborados], [MetaDiaria], [MetaMes], [Productividad]) VALUES (5, 3, 57, N'EVANGELISTA CÓRDOBA PICHI JANETH', 476, 21, 20, 420, CAST(1.12 AS Decimal(5, 2)))
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 1, NULL, N'MARIA TERESA', 3, N'G3', 1, N'ABREGU GONZÁLEZ ADELMO CRISTY', 21, 8, 295, 14)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 2, NULL, N'MARIA TERESA', 3, N'G3', 2, N'ABREU RODRÍGUEZ ADOLFO WALTER', 21, 8, 228, 11)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 3, NULL, N'MARIA TERESA', 3, N'G3', 3, N'ADAMES GÓMEZ ADRIANO TERESA', 18, 8, 192, 11)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 4, NULL, N'MARIA TERESA', 3, N'G3', 4, N'ADARO FERNÁNDEZ AILÍN FERNANDO', 16, 8, 154, 10)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 5, NULL, N'MARIA TERESA', 3, N'G3', 5, N'ADAUTO LÓPEZ ALBERTO SONIA', 21, 8, 144, 7)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 6, NULL, N'MARIA TERESA', 3, N'G3', 6, N'AGRADA DÍAZ ALEJANDRO ARLETH', 21, 8, 139, 7)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 7, NULL, N'MARIA TERESA', 3, N'G3', 7, N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', 21, 8, 117, 6)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 8, NULL, N'MARIA TERESA', 3, N'G3', 8, N'ALCABES PÉREZ ALFREDO ANGELA', 21, 8, 108, 5)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 9, NULL, N'MARIA TERESA', 3, N'G3', 9, N'ALMEIDA GARCÍA ALVAREZ JAVIER', 21, 8, 104, 5)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 10, NULL, N'MARIA TERESA', 3, N'G3', 10, N'ALMEYDA SÁNCHEZ ALVARO JOSE', 13, 7, 95, 7)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 11, NULL, N'MARIA TERESA', 3, N'G3', 11, N'ALVARES ROMERO ANA CRISTINA', 10, 8, 93, 9)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 12, NULL, N'MARIA TERESA', 3, N'G3', 12, N'ALVES SOSA ANDREA NORMA', 21, 8, 91, 4)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 13, NULL, N'MARIA TERESA', 3, N'G3', 13, N'AMADO ÁLVAREZ ANDRÉS ELSA', 21, 8, 88, 4)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 14, NULL, N'MARIA TERESA', 3, N'G3', 14, N'AMARAL TORRES ANGELO KRISTOFER', 21, 8, 65, 3)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 15, NULL, N'MARIA TERESA', 3, N'G3', 15, N'ANGOBALDO RAMÍREZ ARIEL JAMES', 21, 8, 49, 2)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 16, NULL, N'MARIA TERESA', 3, N'G3', 16, N'ANTUNES FLORES ARSENIO HINDRA', 6, 8, 30, 5)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 17, NULL, N'MARIA TERESA', 3, N'G3', 17, N'BAES ACOSTA ARTURO TELLO', 6, 8, 14, 2)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 18, NULL, N'MARIA TERESA', 3, N'G3', 18, N'BARBOZA BENÍTEZ BRAULIO FASABI', 6, 8, 10, 2)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 19, NULL, N'MARIA TERESA', 4, N'G4', 19, N'BARDALES MEDINA CARLOS MARIA', 21, 11, 319, 15)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 20, NULL, N'MARIA TERESA', 4, N'G4', 20, N'BARROSO SUÁREZ CRISTÓBAL NORIS', 14, 12, 211, 15)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 21, NULL, N'ROSA', 1, N'G1', 21, N'BATISTA HERRERA DIEGO LUZ', 21, 30, 533, 25)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 22, NULL, N'ROSA', 1, N'G1', 22, N'BRANCO AGUIRRE EDUARDO KEYKO', 21, 30, 494, 24)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 23, NULL, N'ROSA', 1, N'G1', 23, N'CALIENES PEREYRA ESTEBAN MELISSA', 20, 15, 359, 18)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 24, NULL, N'ROSA', 1, N'G1', 24, N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', 21, 15, 347, 17)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 25, NULL, N'ROSA', 1, N'G1', 25, N'CASAL GIMÉNEZ FERNANDO MARGOTH', 21, 15, 326, 16)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 26, NULL, N'ROSA', 1, N'G1', 26, N'CERNADES MOLINA FORTUNATO AMARELIS', 21, 15, 326, 16)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 27, NULL, N'ROSA', 1, N'G1', 27, N'CLIMACO SILVA GERARDO PIERO', 21, 15, 323, 15)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 28, NULL, N'ROSA', 1, N'G1', 28, N'COELHO CASTRO HECTOR DIANA', 21, 15, 322, 15)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 29, NULL, N'ROSA', 1, N'G1', 29, N'COIMBRA ROJAS HUENU LILIAN', 20, 15, 309, 15)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 30, NULL, N'ROSA', 1, N'G1', 30, N'COSINGA ORTÍZ HUGO DE', 11, 30, 276, 25)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 31, NULL, N'ROSA', 1, N'G1', 31, N'COSTA NÚÑEZ IGNACIO PAULA', 21, 15, 270, 13)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 32, NULL, N'ROSA', 1, N'G1', 32, N'GONZÁLEZ  LUNA JAVIER CARMEN', 19, 15, 221, 12)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 33, NULL, N'ROSA', 1, N'G1', 33, N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', 9, 15, 160, 18)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 34, NULL, N'ROSA', 1, N'G1', 34, N'PÉREZ CABRERA JORGE SUSANA', 9, 15, 87, 10)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 35, NULL, N'ROSA', 2, N'G2', 35, N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', 21, 30, 751, 36)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 36, NULL, N'ROSA', 2, N'G2', 36, N'GARCÍA FERREYRA JUAN LINDERIKA', 9, 30, 295, 33)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 37, NULL, N'ROSA', 8, N'Impugnaciones', 37, N'MARTÍNEZ GODOY JULIAN MARINA', 21, 8, 218, 10)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 38, NULL, N'ROSA', 8, N'Impugnaciones', 38, N'SÁNCHEZ MORALES JULIO JORGE', 17, 8, 136, 8)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 39, NULL, N'ROSA', 8, N'Impugnaciones', 39, N'LÓPEZ DOMÍNGUEZ LEONARDO JORGE', 17, 8, 116, 7)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 40, NULL, N'ROSA', 13, N'G7', 40, N'DÍAZ MORENO LICHUEN WIDSENIA', 20, 8, 179, 9)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 41, NULL, N'ROSA', 13, N'G7', 41, N'ROJAS PERALTA LOLA URSULA', 18, 8, 152, 8)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 42, NULL, N'BETSY', 5, N'G5', 42, N'RAMÍREZ VEGA LUCHO MIRIAM', 17, 9, 208, 12)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 43, NULL, N'BETSY', 5, N'G5', 43, N'CASTILLO CARRIZO LUIS KATHERINE', 21, 9, 123, 6)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 44, NULL, N'BETSY', 7, N'G9', 44, N'GÓMEZ QUIROGA MAITEN DENISE', 21, 10, 326, 16)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 45, NULL, N'BETSY', 7, N'G9', 45, N'ROMERO CASTILLO MANQUE JOEL', 21, 10, 316, 15)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 46, NULL, N'BETSY', 7, N'G9', 46, N'FERNANDEZ LEDESMA MANUEL HELMUD', 19, 9, 275, 14)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 47, NULL, N'BETSY', 7, N'G9', 47, N'TORRES MUÑOZ MARCELO DENISSE', 21, 10, 259, 12)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 48, NULL, N'BETSY', 7, N'G9', 48, N'MENDOZA OJEDA MARCO LUIS', 16, 10, 246, 15)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 49, NULL, N'BETSY', 7, N'G9', 49, N'MEDINA PONCE MIGUEL DAVID', 15, 10, 245, 16)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 50, NULL, N'BETSY', 7, N'G9', NULL, N'MORENO VERA NAHUEL NEHUEN ANAVELA', 21, 10, 241, 11)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 51, NULL, N'BETSY', 7, N'G9', 50, N'GUTIÉRREZ VÁZQUEZ NEYEN GRECIA', 21, 9, 241, 11)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 52, NULL, N'BETSY', 7, N'G9', 51, N'DOCARMO VILLALBA NICOLAS LUYO', 16, 10, 239, 15)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 53, NULL, N'BETSY', 7, N'G9', 52, N'DOMINGUES CARDOZO NULPI YEFERSON', 20, 10, 236, 12)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 54, NULL, N'BETSY', 7, N'G9', 53, N'DORADOR NAVARRO PABLO HAROLD', 21, 10, 233, 11)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 55, NULL, N'BETSY', 7, N'G9', 54, N'DORREGO RAMOS PATRÍCIO SANTOS', 20, 10, 229, 11)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 56, NULL, N'BETSY', 7, N'G9', 55, N'DOS ARIAS PEDRO ELISA', 21, 10, 229, 11)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 57, NULL, N'BETSY', 7, N'G9', 56, N'DOSANTOS CORONEL PEHUEN JESSENIA', 19, 10, 213, 11)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 58, NULL, N'BETSY', 7, N'G9', 57, N'EVANGELISTA CÓRDOBA PICHI JANETH', 21, 10, 212, 10)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 59, NULL, N'BETSY', 7, N'G9', 68, N'JUNIOR MÉNDEZ VICENTE CANDY', 17, 10, 211, 12)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 60, NULL, N'BETSY', 7, N'G9', 69, N'LEANDRO LUCERO VICTOR ROSA', 21, 10, 207, 10)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 61, NULL, N'BETSY', 7, N'G9', NULL, N'LEAO CRUZ XAVIER YACO YOEL', 19, 10, 196, 10)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 62, NULL, N'BETSY', 7, N'G9', NULL, N'ABRAHAM JOSÉ FLORES HERNANDEZ', 20, 10, 179, 9)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 63, NULL, N'BETSY', 7, N'G9', NULL, N'BRITT LOAYZA ALLCCA', 19, 10, 163, 9)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 64, NULL, N'BETSY', 7, N'G9', NULL, N'VILMA BOCANEGRA USCAMAYTA', 10, 10, 155, 16)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 65, NULL, N'BETSY', 7, N'G9', NULL, N'GLADIS SIVINCHA MILLIO', 9, 10, 114, 13)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 66, NULL, N'BETSY', 7, N'G9', NULL, N'ALEXANDRA CECILIA QUISPE TORO', 10, 10, 99, 10)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 67, NULL, N'BETSY', 7, N'G9', NULL, N'MAGDALENA BEATRIZ VICENTE PALACIOS', 4, 10, 39, 10)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 68, NULL, N'BETSY', 7, N'G9', NULL, N'CHRISTIAN CORRALES JAYO', 0, 10, 27, 0)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 69, NULL, N'BETSY', 7, N'G9', NULL, N'VICTOR SAAVEDRA ENCISO', 0, 10, 9, 0)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 70, NULL, N'BETSY', 7, N'G9', NULL, N'ALESSANDRA ROBATTI MEDINA', 0, 10, 8, 0)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 71, NULL, N'BETSY', 7, N'G9', NULL, N'JUNIOR JAVIER VILLEGAS SOLANO', 0, 10, 2, 0)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 72, NULL, N'BETSY', 7, N'G9', NULL, N'DIEGO ALONSO LEON ESPEJO', 0, 10, 1, 0)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 73, NULL, N'CARMEN', 12, N'G8', 9, N'ALMEIDA GARCÍA ALVAREZ JAVIER', 21, 8, 303, 14)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 74, NULL, N'CARMEN', 12, N'G8', 10, N'ALMEYDA SÁNCHEZ ALVARO JOSE', 21, 8, 198, 9)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 75, NULL, N'CARMEN', 12, N'G8', 11, N'ALVARES ROMERO ANA CRISTINA', 21, 8, 193, 9)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 76, NULL, N'CARMEN', 12, N'G8', 12, N'ALVES SOSA ANDREA NORMA', 21, 8, 171, 8)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 77, NULL, N'CARMEN', 12, N'G8', 13, N'AMADO ÁLVAREZ ANDRÉS ELSA', 21, 8, 168, 8)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 78, NULL, N'CARMEN', 12, N'G8', 14, N'AMARAL TORRES ANGELO KRISTOFER', 21, 8, 167, 8)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 79, NULL, N'CARMEN', 12, N'G8', 15, N'ANGOBALDO RAMÍREZ ARIEL JAMES', 18, 8, 151, 8)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 80, NULL, N'CARMEN', 12, N'G8', 16, N'ANTUNES FLORES ARSENIO HINDRA', 21, 8, 139, 7)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 81, NULL, N'CARMEN', 12, N'G8', 17, N'BAES ACOSTA ARTURO TELLO', 20, 8, 132, 7)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 85, NULL, N'CARMEN', 12, N'G8', NULL, N'ANDY ALONSO PIZARRO PONCE', 20, 8, 107, 5)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 86, NULL, N'CARMEN', 12, N'G8', NULL, N'MANUEL MORAN HERRERA', 21, 8, 104, 5)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 87, NULL, N'CARMEN', 12, N'G8', NULL, N'JHOSELYN FERNANDEZ QUISPE', 19, 8, 101, 5)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 88, NULL, N'CARMEN', 12, N'G8', NULL, N'ERIKA MONTENEGRO DEZA', 21, 8, 97, 5)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 89, NULL, N'CARMEN', 12, N'G8', 29, N'COIMBRA ROJAS HUENU LILIAN', 11, 8, 90, 8)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 90, NULL, N'CARMEN', 12, N'G8', 30, N'COSINGA ORTÍZ HUGO DE', 20, 8, 85, 4)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 91, NULL, N'CARMEN', 12, N'G8', 31, N'COSTA NÚÑEZ IGNACIO PAULA', 20, 8, 82, 4)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 92, NULL, N'CARMEN', 12, N'G8', 32, N'GONZÁLEZ  LUNA JAVIER CARMEN', 20, 8, 81, 4)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 93, NULL, N'CARMEN', 12, N'G8', 33, N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', 20, 8, 78, 4)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 94, NULL, N'CARMEN', 12, N'G8', 34, N'PÉREZ CABRERA JORGE SUSANA', 20, 8, 75, 4)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 95, NULL, N'CARMEN', 12, N'G8', 38, N'SÁNCHEZ MORALES JULIO JORGE', 0, 8, 68, 0)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 96, NULL, N'GINA', 9, N'Alo Banco', 30, N'COSINGA ORTÍZ HUGO DE', 21, 6, 145, 7)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (1, 97, NULL, N'GINA', 9, N'Alo Banco', 31, N'COSTA NÚÑEZ IGNACIO PAULA', 21, 6, 132, 6)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (5, 1, 73, N'MENDOZA MENDOZA ELKA PAOLA', 14, N'Contáctenos', 55, N'DOS ARIAS PEDRO ELISA', 21, 20, 440, 0)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (5, 2, 73, N'MENDOZA MENDOZA ELKA PAOLA', 14, N'Contáctenos', 56, N'DOSANTOS CORONEL PEHUEN JESSENIA', 21, 20, 353, 0)
INSERT [Comisiones].[Productividad] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DiasAsistencia], [MetaDiaria], [TotalProductividad], [Logro]) VALUES (5, 3, 73, N'MENDOZA MENDOZA ELKA PAOLA', 14, N'Contáctenos', 57, N'EVANGELISTA CÓRDOBA PICHI JANETH', 21, 20, 476, 0)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 1, N'3', NULL, 1, 28, CAST(0.50 AS Decimal(5, 2)), CAST(224.00 AS Decimal(5, 2)), 14, CAST(0.50 AS Decimal(5, 2)), CAST(0.25 AS Decimal(5, 2)), NULL, 0, 100, CAST(95.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.25 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 2, N'3', NULL, 2, 15, CAST(0.50 AS Decimal(5, 2)), CAST(120.00 AS Decimal(5, 2)), 11, CAST(0.73 AS Decimal(5, 2)), CAST(0.37 AS Decimal(5, 2)), NULL, 0, 112, CAST(110.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.37 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.24 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 3, N'3', NULL, 2, 29, CAST(0.50 AS Decimal(5, 2)), CAST(232.00 AS Decimal(5, 2)), 11, CAST(0.38 AS Decimal(5, 2)), CAST(0.19 AS Decimal(5, 2)), NULL, 0, 40, CAST(38.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.19 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.88 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 4, N'3', NULL, 1, 21, CAST(0.50 AS Decimal(5, 2)), CAST(168.00 AS Decimal(5, 2)), 10, CAST(0.48 AS Decimal(5, 2)), CAST(0.24 AS Decimal(5, 2)), NULL, 0, 7, CAST(7.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(0.74 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.98 AS Decimal(5, 2)), CAST(0.96 AS Decimal(5, 2)), CAST(0.95 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 5, N'3', NULL, 1, 18, CAST(0.50 AS Decimal(5, 2)), CAST(144.00 AS Decimal(5, 2)), 7, CAST(0.39 AS Decimal(5, 2)), CAST(0.19 AS Decimal(5, 2)), NULL, 0, 73, CAST(70.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.19 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.88 AS Decimal(5, 2)), CAST(0.94 AS Decimal(5, 2)), CAST(0.95 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 6, N'3', NULL, 1, 0, CAST(0.50 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), 7, CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), NULL, 0, 36, CAST(35.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.95 AS Decimal(5, 2)), CAST(0.95 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 7, N'3', NULL, 2, 16, CAST(0.50 AS Decimal(5, 2)), CAST(128.00 AS Decimal(5, 2)), 6, CAST(0.38 AS Decimal(5, 2)), CAST(0.19 AS Decimal(5, 2)), NULL, 0, 83, CAST(73.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.19 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.88 AS Decimal(5, 2)), CAST(1.95 AS Decimal(5, 2)), CAST(1.20 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 8, N'3', NULL, 2, 24, CAST(0.50 AS Decimal(5, 2)), CAST(192.00 AS Decimal(5, 2)), 5, CAST(0.21 AS Decimal(5, 2)), CAST(0.10 AS Decimal(5, 2)), NULL, 0, 52, CAST(41.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.10 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.70 AS Decimal(5, 2)), CAST(1.95 AS Decimal(5, 2)), CAST(1.20 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 9, N'12', NULL, 1, 23, CAST(0.50 AS Decimal(5, 2)), CAST(184.00 AS Decimal(5, 2)), 14, CAST(0.61 AS Decimal(5, 2)), CAST(0.30 AS Decimal(5, 2)), NULL, 0, 185, CAST(180.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.30 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.10 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 1504, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 9, N'3', NULL, 1, 23, CAST(0.50 AS Decimal(5, 2)), CAST(184.00 AS Decimal(5, 2)), 5, CAST(0.22 AS Decimal(5, 2)), CAST(0.11 AS Decimal(5, 2)), NULL, 0, 75, CAST(62.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.11 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.72 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 10, N'12', NULL, 1, 29, CAST(0.50 AS Decimal(5, 2)), CAST(232.00 AS Decimal(5, 2)), 9, CAST(0.31 AS Decimal(5, 2)), CAST(0.16 AS Decimal(5, 2)), NULL, 0, 142, CAST(141.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.16 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.82 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 1504, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 10, N'3', NULL, 1, 29, CAST(0.50 AS Decimal(5, 2)), CAST(203.00 AS Decimal(5, 2)), 7, CAST(0.24 AS Decimal(5, 2)), CAST(0.12 AS Decimal(5, 2)), NULL, 0, 69, CAST(67.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.12 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.74 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 11, N'12', NULL, 1, -1, CAST(0.50 AS Decimal(5, 2)), CAST(-8.00 AS Decimal(5, 2)), 9, CAST(-9.00 AS Decimal(5, 2)), CAST(-4.50 AS Decimal(5, 2)), NULL, 0, 94, CAST(87.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(-4.50 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(-8.50 AS Decimal(5, 2)), CAST(0.85 AS Decimal(5, 2)), CAST(0.80 AS Decimal(5, 2)), 1504, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 11, N'3', NULL, 1, -1, CAST(0.50 AS Decimal(5, 2)), CAST(-8.00 AS Decimal(5, 2)), 9, CAST(-9.00 AS Decimal(5, 2)), CAST(-4.50 AS Decimal(5, 2)), NULL, 0, 148, CAST(142.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(-4.50 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(-8.50 AS Decimal(5, 2)), CAST(0.85 AS Decimal(5, 2)), CAST(0.80 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 12, N'12', NULL, 1, 27, CAST(0.50 AS Decimal(5, 2)), CAST(216.00 AS Decimal(5, 2)), 8, CAST(0.30 AS Decimal(5, 2)), CAST(0.15 AS Decimal(5, 2)), NULL, 0, 123, CAST(116.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.15 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.80 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 1504, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 12, N'3', NULL, 1, 27, CAST(0.50 AS Decimal(5, 2)), CAST(216.00 AS Decimal(5, 2)), 4, CAST(0.15 AS Decimal(5, 2)), CAST(0.07 AS Decimal(5, 2)), NULL, 0, 85, CAST(83.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.07 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.64 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 13, N'12', NULL, 1, 16, CAST(0.50 AS Decimal(5, 2)), CAST(128.00 AS Decimal(5, 2)), 8, CAST(0.50 AS Decimal(5, 2)), CAST(0.25 AS Decimal(5, 2)), NULL, 0, 162, CAST(153.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.25 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 1504, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 13, N'3', NULL, 1, 16, CAST(0.50 AS Decimal(5, 2)), CAST(128.00 AS Decimal(5, 2)), 4, CAST(0.25 AS Decimal(5, 2)), CAST(0.13 AS Decimal(5, 2)), NULL, 0, 19, CAST(19.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(0.63 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.76 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 14, N'12', NULL, 1, 21, CAST(0.50 AS Decimal(5, 2)), CAST(168.00 AS Decimal(5, 2)), 8, CAST(0.38 AS Decimal(5, 2)), CAST(0.19 AS Decimal(5, 2)), NULL, 0, 72, CAST(71.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.19 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.88 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 1504, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 14, N'3', NULL, 1, 21, CAST(0.50 AS Decimal(5, 2)), CAST(168.00 AS Decimal(5, 2)), 3, CAST(0.14 AS Decimal(5, 2)), CAST(0.07 AS Decimal(5, 2)), NULL, 0, 116, CAST(114.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.07 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.64 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 15, N'12', NULL, 1, 21, CAST(0.50 AS Decimal(5, 2)), CAST(168.00 AS Decimal(5, 2)), 8, CAST(0.38 AS Decimal(5, 2)), CAST(0.19 AS Decimal(5, 2)), NULL, 0, 88, CAST(87.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.19 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.88 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 1504, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 15, N'3', NULL, 1, 21, CAST(0.50 AS Decimal(5, 2)), CAST(168.00 AS Decimal(5, 2)), 2, CAST(0.10 AS Decimal(5, 2)), CAST(0.05 AS Decimal(5, 2)), NULL, 0, 94, CAST(91.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.05 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.60 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 16, N'12', NULL, 2, 29, CAST(0.50 AS Decimal(5, 2)), CAST(232.00 AS Decimal(5, 2)), 7, CAST(0.24 AS Decimal(5, 2)), CAST(0.12 AS Decimal(5, 2)), NULL, 0, 75, CAST(74.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.12 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.74 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 1504, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 16, N'3', NULL, 2, 29, CAST(0.50 AS Decimal(5, 2)), CAST(232.00 AS Decimal(5, 2)), 5, CAST(0.17 AS Decimal(5, 2)), CAST(0.09 AS Decimal(5, 2)), NULL, 0, 42, CAST(40.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.09 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.68 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 17, N'12', NULL, 2, 23, CAST(0.50 AS Decimal(5, 2)), CAST(184.00 AS Decimal(5, 2)), 7, CAST(0.30 AS Decimal(5, 2)), CAST(0.15 AS Decimal(5, 2)), NULL, 0, 81, CAST(77.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.15 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.80 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 1504, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 17, N'3', NULL, 2, 23, CAST(0.50 AS Decimal(5, 2)), CAST(184.00 AS Decimal(5, 2)), 2, CAST(0.09 AS Decimal(5, 2)), CAST(0.04 AS Decimal(5, 2)), NULL, 0, 14, CAST(8.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), CAST(0.04 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.58 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 18, N'3', NULL, 2, 28, CAST(0.50 AS Decimal(5, 2)), CAST(224.00 AS Decimal(5, 2)), 2, CAST(0.07 AS Decimal(5, 2)), CAST(0.04 AS Decimal(5, 2)), NULL, 0, 32, CAST(32.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(0.54 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.58 AS Decimal(5, 2)), CAST(1.51 AS Decimal(5, 2)), CAST(1.20 AS Decimal(5, 2)), 2907, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 19, N'4', NULL, 2, 15, CAST(0.50 AS Decimal(5, 2)), CAST(165.00 AS Decimal(5, 2)), 15, CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), NULL, 0, 315, CAST(315.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(2.50 AS Decimal(5, 2)), CAST(0.91 AS Decimal(5, 2)), CAST(0.90 AS Decimal(5, 2)), 345, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 20, N'4', NULL, 2, 15, CAST(0.50 AS Decimal(5, 2)), CAST(180.00 AS Decimal(5, 2)), 15, CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), NULL, 0, 210, CAST(210.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(2.50 AS Decimal(5, 2)), CAST(0.57 AS Decimal(5, 2)), CAST(0.00 AS Decimal(5, 2)), 345, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 21, N'1', NULL, 2, 28, CAST(0.50 AS Decimal(5, 2)), CAST(840.00 AS Decimal(5, 2)), 25, CAST(0.89 AS Decimal(5, 2)), CAST(0.45 AS Decimal(5, 2)), NULL, 0, 230, CAST(230.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(0.95 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(2.40 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2535, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 22, N'1', NULL, 1, 15, CAST(0.50 AS Decimal(5, 2)), CAST(450.00 AS Decimal(5, 2)), 24, CAST(1.60 AS Decimal(5, 2)), CAST(0.80 AS Decimal(5, 2)), NULL, 0, 268, CAST(268.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(1.30 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(3.10 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2535, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 23, N'1', NULL, 2, 15, CAST(0.50 AS Decimal(5, 2)), CAST(225.00 AS Decimal(5, 2)), 18, CAST(1.20 AS Decimal(5, 2)), CAST(0.60 AS Decimal(5, 2)), NULL, 0, 206, CAST(206.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(1.10 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(2.70 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2535, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 24, N'1', NULL, 1, 15, CAST(0.50 AS Decimal(5, 2)), CAST(225.00 AS Decimal(5, 2)), 17, CAST(1.13 AS Decimal(5, 2)), CAST(0.57 AS Decimal(5, 2)), NULL, 0, 196, CAST(196.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(1.07 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(2.64 AS Decimal(5, 2)), CAST(0.94 AS Decimal(5, 2)), CAST(0.95 AS Decimal(5, 2)), 2535, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 25, N'1', NULL, 2, 25, CAST(0.50 AS Decimal(5, 2)), CAST(375.00 AS Decimal(5, 2)), 16, CAST(0.64 AS Decimal(5, 2)), CAST(0.32 AS Decimal(5, 2)), NULL, 0, 62, CAST(62.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(0.82 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(2.14 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), 2535, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[ProductividadEsp] ([CargaId], [EmpleadoId], [GrupoId], [SuperId], [CargoId], [DiasLaborados], [CRFactor], [CRMetaTotal], [CRCasosCerrados], [CRCumplimiento], [CRNota1], [SLAFactor], [SLATotal], [SLANroCasos], [SLACumplimiento], [SLANota2], [KPINota1y2], [KPISumaPesos], [KPINota], [KPIPuntaje], [CALImpug], [CALPuntaje], [CREMetaTotal], [CRECasosCerrados], [CRECumplimiento], [ComisionA], [PremioB], [TotalComisPremio]) VALUES (1, 26, N'1', NULL, 2, 28, CAST(0.50 AS Decimal(5, 2)), CAST(420.00 AS Decimal(5, 2)), 16, CAST(0.57 AS Decimal(5, 2)), CAST(0.29 AS Decimal(5, 2)), NULL, 0, 276, CAST(276.00 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(0.50 AS Decimal(5, 2)), CAST(0.79 AS Decimal(5, 2)), CAST(1.00 AS Decimal(5, 2)), CAST(2.08 AS Decimal(5, 2)), CAST(0.90 AS Decimal(5, 2)), CAST(0.90 AS Decimal(5, 2)), 2535, NULL, NULL, NULL, NULL, NULL)
INSERT [Comisiones].[SLAContactenos] ([CargaId], [Secuencia], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral], [SLA]) VALUES (6, 1, 46, N'FERNANDEZ LEDESMA MANUEL HELMUD', 374, 9, 383, CAST(0.98 AS Decimal(8, 2)))
INSERT [Comisiones].[SLAContactenos] ([CargaId], [Secuencia], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral], [SLA]) VALUES (6, 2, 47, N'TORRES MUÑOZ MARCELO DENISSE', 238, 53, 291, CAST(0.82 AS Decimal(8, 2)))
INSERT [Comisiones].[SLAContactenos] ([CargaId], [Secuencia], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral], [SLA]) VALUES (6, 3, 48, N'MENDOZA OJEDA MARCO LUIS', 223, 83, 306, CAST(0.73 AS Decimal(8, 2)))
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 1, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 1, N'ABREGU GONZÁLEZ ADELMO CRISTY', 95, 5, 100)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 2, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 2, N'ABREU RODRÍGUEZ ADOLFO WALTER', 110, 2, 112)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 3, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 3, N'ADAMES GÓMEZ ADRIANO TERESA', 38, 2, 40)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 4, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 4, N'ADARO FERNÁNDEZ AILÍN FERNANDO', 7, 0, 7)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 5, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 5, N'ADAUTO LÓPEZ ALBERTO SONIA', 70, 3, 73)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 6, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 6, N'AGRADA DÍAZ ALEJANDRO ARLETH', 35, 1, 36)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 7, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 7, N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', 73, 10, 83)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 8, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 8, N'ALCABES PÉREZ ALFREDO ANGELA', 41, 11, 52)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 9, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 9, N'ALMEIDA GARCÍA ALVAREZ JAVIER', 62, 13, 75)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 10, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 10, N'ALMEYDA SÁNCHEZ ALVARO JOSE', 67, 2, 69)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 11, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 11, N'ALVARES ROMERO ANA CRISTINA', 142, 6, 148)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 12, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 12, N'ALVES SOSA ANDREA NORMA', 83, 2, 85)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 13, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 13, N'AMADO ÁLVAREZ ANDRÉS ELSA', 19, 0, 19)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 14, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 14, N'AMARAL TORRES ANGELO KRISTOFER', 114, 2, 116)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 15, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 15, N'ANGOBALDO RAMÍREZ ARIEL JAMES', 91, 3, 94)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 16, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 16, N'ANTUNES FLORES ARSENIO HINDRA', 40, 2, 42)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 17, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 17, N'BAES ACOSTA ARTURO TELLO', 8, 6, 14)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 18, NULL, N'MIDEROS OLIVERA ROSA', 3, N'G3', 18, N'BARBOZA BENÍTEZ BRAULIO FASABI', 32, 0, 32)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 19, NULL, N'MIDEROS OLIVERA ROSA', 4, N'G4', 19, N'BARDALES MEDINA CARLOS MARIA', 315, 0, 315)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 20, NULL, N'MIDEROS OLIVERA ROSA', 4, N'G4', 20, N'BARROSO SUÁREZ CRISTÓBAL NORIS', 210, 0, 210)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 21, NULL, N'ROSA', 1, N'G1', 21, N'BATISTA HERRERA DIEGO LUZ', 230, 0, 230)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 22, NULL, N'ROSA', 1, N'G1', 22, N'BRANCO AGUIRRE EDUARDO KEYKO', 268, 0, 268)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 23, NULL, N'ROSA', 1, N'G1', 23, N'CALIENES PEREYRA ESTEBAN MELISSA', 206, 0, 206)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 24, NULL, N'ROSA', 1, N'G1', 24, N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', 196, 0, 196)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 25, NULL, N'ROSA', 1, N'G1', 25, N'CASAL GIMÉNEZ FERNANDO MARGOTH', 62, 0, 62)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 26, NULL, N'ROSA', 1, N'G1', 26, N'CERNADES MOLINA FORTUNATO AMARELIS', 276, 0, 276)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 27, NULL, N'ROSA', 1, N'G1', 27, N'CLIMACO SILVA GERARDO PIERO', 165, 8, 173)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 28, NULL, N'ROSA', 1, N'G1', 28, N'COELHO CASTRO HECTOR DIANA', 134, 0, 134)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 29, NULL, N'ROSA', 1, N'G1', 29, N'COIMBRA ROJAS HUENU LILIAN', 180, 0, 180)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 30, NULL, N'ROSA', 1, N'G1', 30, N'COSINGA ORTÍZ HUGO DE', 474, 0, 474)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 31, NULL, N'ROSA', 1, N'G1', 31, N'COSTA NÚÑEZ IGNACIO PAULA', 524, 0, 524)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 32, NULL, N'ROSA', 1, N'G1', 32, N'GONZÁLEZ  LUNA JAVIER CARMEN', 182, 0, 182)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 33, NULL, N'ROSA', 1, N'G1', 33, N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', 121, 9, 130)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 34, NULL, N'ROSA', 1, N'G1', 34, N'PÉREZ CABRERA JORGE SUSANA', 339, 0, 339)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 35, NULL, N'ROSA', 2, N'G2', 35, N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', 295, 0, 295)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 36, NULL, N'ROSA', 2, N'G2', 36, N'GARCÍA FERREYRA JUAN LINDERIKA', 742, 1, 743)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 37, NULL, N'ROSA', 13, N'G7', 37, N'MARTÍNEZ GODOY JULIAN MARINA', 88, 0, 88)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 38, NULL, N'ROSA', 13, N'G7', 38, N'SÁNCHEZ MORALES JULIO JORGE', 95, 0, 95)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 39, NULL, N'ROSA', 8, N'Impugnaciones', 39, N'LÓPEZ DOMÍNGUEZ LEONARDO JORGE', 45, 0, 45)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 40, NULL, N'ROSA', 8, N'Impugnaciones', 40, N'DÍAZ MORENO LICHUEN WIDSENIA', 72, 0, 72)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 41, NULL, N'ROSA', 8, N'Impugnaciones', 41, N'ROJAS PERALTA LOLA URSULA', 167, 8, 175)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 42, NULL, N'GINA', 9, N'Alo Banco', 27, N'CLIMACO SILVA GERARDO PIERO', 106, 4, 110)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 43, NULL, N'GINA', 9, N'Alo Banco', 28, N'COELHO CASTRO HECTOR DIANA', 93, 11, 104)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 44, NULL, N'BETSY', 5, N'G5', 35, N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', 200, 2, 202)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 45, NULL, N'BETSY', 5, N'G5', 36, N'GARCÍA FERREYRA JUAN LINDERIKA', 106, 4, 110)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 46, NULL, N'BETSY', 7, N'G9', 10, N'ALMEYDA SÁNCHEZ ALVARO JOSE', 5, 10, 15)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 47, NULL, N'BETSY', 7, N'G9', 11, N'ALVARES ROMERO ANA CRISTINA', 229, 4, 233)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 48, NULL, N'BETSY', 7, N'G9', 12, N'ALVES SOSA ANDREA NORMA', 136, 37, 173)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 49, NULL, N'BETSY', 7, N'G9', 13, N'AMADO ÁLVAREZ ANDRÉS ELSA', 71, 0, 71)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 50, NULL, N'BETSY', 7, N'G9', 14, N'AMARAL TORRES ANGELO KRISTOFER', 292, 5, 297)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 51, NULL, N'BETSY', 7, N'G9', 15, N'ANGOBALDO RAMÍREZ ARIEL JAMES', 200, 1, 201)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 52, NULL, N'BETSY', 7, N'G9', 16, N'ANTUNES FLORES ARSENIO HINDRA', 141, 1, 142)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 53, NULL, N'BETSY', 7, N'G9', 17, N'BAES ACOSTA ARTURO TELLO', 133, 0, 133)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 54, NULL, N'BETSY', 7, N'G9', 18, N'BARBOZA BENÍTEZ BRAULIO FASABI', 132, 10, 142)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 55, NULL, N'BETSY', 7, N'G9', 19, N'BARDALES MEDINA CARLOS MARIA', 189, 3, 192)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 56, NULL, N'BETSY', 7, N'G9', 20, N'BARROSO SUÁREZ CRISTÓBAL NORIS', 135, 23, 158)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 57, NULL, N'BETSY', 7, N'G9', 21, N'BATISTA HERRERA DIEGO LUZ', 17, 2, 19)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 58, NULL, N'BETSY', 7, N'G9', 22, N'BRANCO AGUIRRE EDUARDO KEYKO', 1, 0, 1)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 59, NULL, N'BETSY', 7, N'G9', 23, N'CALIENES PEREYRA ESTEBAN MELISSA', 177, 1, 178)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 60, NULL, N'BETSY', 7, N'G9', 24, N'CARDOSO GUTIÉRREZ ESTEVAN ALEX', 150, 11, 161)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 61, NULL, N'BETSY', 7, N'G9', 25, N'CASAL GIMÉNEZ FERNANDO MARGOTH', 156, 51, 207)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 62, NULL, N'BETSY', 7, N'G9', 26, N'CERNADES MOLINA FORTUNATO AMARELIS', 23, 1, 24)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 63, NULL, N'BETSY', 7, N'G9', 27, N'CLIMACO SILVA GERARDO PIERO', 147, 0, 147)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 64, NULL, N'BETSY', 7, N'G9', 28, N'COELHO CASTRO HECTOR DIANA', 117, 5, 122)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 65, NULL, N'BETSY', 7, N'G9', 29, N'COIMBRA ROJAS HUENU LILIAN', 18, 7, 25)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 66, NULL, N'BETSY', 7, N'G9', 30, N'COSINGA ORTÍZ HUGO DE', 82, 2, 84)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 67, NULL, N'BETSY', 7, N'G9', 31, N'COSTA NÚÑEZ IGNACIO PAULA', 130, 7, 137)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 68, NULL, N'BETSY', 7, N'G9', 32, N'GONZÁLEZ  LUNA JAVIER CARMEN', 71, 22, 93)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 69, NULL, N'BETSY', 7, N'G9', 33, N'RODRÍGUEZ JUÁREZ JOAQUIN JANNINA', 6, 0, 6)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 70, NULL, N'BETSY', 7, N'G9', 34, N'PÉREZ CABRERA JORGE SUSANA', 204, 13, 217)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 71, NULL, N'BETSY', 7, N'G9', 35, N'HERNÁNDEZ RÍOS JOSÉ GLADYZ', 199, 7, 206)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 72, NULL, N'BETSY', 7, N'G9', 36, N'GARCÍA FERREYRA JUAN LINDERIKA', 178, 17, 195)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 73, NULL, N'BETSY', 7, N'G9', 37, N'MARTÍNEZ GODOY JULIAN MARINA', 9, 0, 9)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 74, NULL, N'BETSY', 7, N'G9', 38, N'SÁNCHEZ MORALES JULIO JORGE', 1, 0, 1)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 75, NULL, N'CARMEN', 12, N'G8', 1, N'ABREGU GONZÁLEZ ADELMO CRISTY', 56, 1, 57)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 76, NULL, N'CARMEN', 12, N'G8', 2, N'ABREU RODRÍGUEZ ADOLFO WALTER', 125, 1, 126)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 77, NULL, N'CARMEN', 12, N'G8', 3, N'ADAMES GÓMEZ ADRIANO TERESA', 274, 8, 282)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 78, NULL, N'CARMEN', 12, N'G8', 4, N'ADARO FERNÁNDEZ AILÍN FERNANDO', 174, 4, 178)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 79, NULL, N'CARMEN', 12, N'G8', 5, N'ADAUTO LÓPEZ ALBERTO SONIA', 129, 3, 132)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 80, NULL, N'CARMEN', 12, N'G8', 6, N'AGRADA DÍAZ ALEJANDRO ARLETH', 163, 3, 166)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 81, NULL, N'CARMEN', 12, N'G8', 7, N'ALBURQUEQUE MARTÍNEZ ALFONSO MARITZA', 144, 7, 151)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 82, NULL, N'CARMEN', 12, N'G8', 8, N'ALCABES PÉREZ ALFREDO ANGELA', 80, 5, 85)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 83, NULL, N'CARMEN', 12, N'G8', 9, N'ALMEIDA GARCÍA ALVAREZ JAVIER', 180, 5, 185)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 84, NULL, N'CARMEN', 12, N'G8', 10, N'ALMEYDA SÁNCHEZ ALVARO JOSE', 141, 1, 142)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 85, NULL, N'CARMEN', 12, N'G8', 11, N'ALVARES ROMERO ANA CRISTINA', 87, 7, 94)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 86, NULL, N'CARMEN', 12, N'G8', 12, N'ALVES SOSA ANDREA NORMA', 116, 7, 123)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 87, NULL, N'CARMEN', 12, N'G8', 13, N'AMADO ÁLVAREZ ANDRÉS ELSA', 153, 9, 162)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 88, NULL, N'CARMEN', 12, N'G8', 14, N'AMARAL TORRES ANGELO KRISTOFER', 71, 1, 72)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 89, NULL, N'CARMEN', 12, N'G8', 15, N'ANGOBALDO RAMÍREZ ARIEL JAMES', 87, 1, 88)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 90, NULL, N'CARMEN', 12, N'G8', 16, N'ANTUNES FLORES ARSENIO HINDRA', 74, 1, 75)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 91, NULL, N'CARMEN', 12, N'G8', 17, N'BAES ACOSTA ARTURO TELLO', 77, 4, 81)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 92, NULL, N'CARMEN', 12, N'G8', 18, N'BARBOZA BENÍTEZ BRAULIO FASABI', 99, 6, 105)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 93, NULL, N'CARMEN', 12, N'G8', 19, N'BARDALES MEDINA CARLOS MARIA', 81, 3, 84)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 94, NULL, N'CARMEN', 12, N'G8', 20, N'BARROSO SUÁREZ CRISTÓBAL NORIS', 111, 0, 111)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 95, NULL, N'CARMEN', 12, N'G8', 21, N'BATISTA HERRERA DIEGO LUZ', 80, 1, 81)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 96, NULL, N'CARMEN', 12, N'G8', 22, N'BRANCO AGUIRRE EDUARDO KEYKO', 115, 1, 116)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (2, 97, NULL, N'CARMEN', 12, N'G8', 23, N'CALIENES PEREYRA ESTEBAN MELISSA', 97, 4, 101)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (6, 1, 73, N'MENDOZA MENDOZA ELKA PAOLA', 14, N'Contáctenos', 46, N'FERNANDEZ LEDESMA MANUEL HELMUD', 374, 9, 383)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (6, 2, 73, N'MENDOZA MENDOZA ELKA PAOLA', 14, N'Contáctenos', 47, N'TORRES MUÑOZ MARCELO DENISSE', 238, 53, 291)
INSERT [Comisiones].[SLAUAC] ([CargaId], [Secuencia], [SupervisorId], [Supervisor], [GrupoId], [Grupo], [EmpleadoId], [Empleado], [DentroPlazo], [FueraPlazo], [TotalGeneral]) VALUES (6, 3, 73, N'MENDOZA MENDOZA ELKA PAOLA', 14, N'Contáctenos', 48, N'MENDOZA OJEDA MARCO LUIS', 223, 83, 306)
GO
/****** Object:  StoredProcedure [Comisiones].[AddCabeceraCarga]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comisiones].[AddCabeceraCarga]
	@TipoArchivo CHAR(2),
	@FechaArchivo DATETIME,
	@FechaCargaIni DATETIME,
	@EstadoCarga INT
AS    
BEGIN
	DECLARE @OutputTbl TABLE (Id INT)

	INSERT INTO Comisiones.CabeceraCarga (TipoArchivo, FechaArchivo, FechaCargaIni, EstadoCarga)
	OUTPUT INSERTED.Id INTO @OutputTbl(Id)
	VALUES(@TipoArchivo, @FechaArchivo, @FechaCargaIni, @EstadoCarga);

	SELECT Id FROM @OutputTbl;
END


GO
/****** Object:  StoredProcedure [Comisiones].[AgregarEmpleadoId]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  StoredProcedure [Comisiones].[AgregarGrupoId]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [Comisiones].[CargarProducContactenos]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comisiones].[CargarProducContactenos]
AS
BEGIN
	--Agrega los datos cargados de ProducContactenos a Productividad para luego crear los reportes
	INSERT INTO [Comisiones].[Productividad](
		[CargaId],[Secuencia],[SupervisorId],[Supervisor],[GrupoId],[Grupo],[EmpleadoId],[Empleado],
		[DiasAsistencia],[MetaDiaria],[TotalProductividad],[Logro])
	SELECT 
		P.[CargaId],P.[Secuencia],
		(SELECT ResponsableId FROM Comisiones.Grupo WHERE Id = 14),
		(SELECT E.ApellidoPaterno + ' ' + E.ApellidoPaterno + ' ' + E.Nombres  
		 FROM Comisiones.Grupo G INNER JOIN Comisiones.Empleado E ON G.ResponsableId = E.Id WHERE G.Id = 14),
		 14,
		 'Contáctenos',
		[EmpleadoId],
		[Empleado],
		[DiasLaborados],
		[MetaDiaria],
		[TotalAtendido],
		0
	FROM [Comisiones].[ProducContactenos] P INNER JOIN Comisiones.CabeceraCarga C on P.CargaId = C.Id
	WHERE C.EstadoCarga = 1 AND C.TipoArchivo = 4 AND C.FechaCargaIni = (SELECT MAX(FechaCargaIni) 
																		 FROM Comisiones.CabeceraCarga 
																		 WHERE TipoArchivo = 4 and EstadoCarga=1)

END
GO
/****** Object:  StoredProcedure [Comisiones].[CargarSLAContactenos]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comisiones].[CargarSLAContactenos]
AS
BEGIN
	--Agrega los datos cargados de ProducContactenos a Productividad para luego crear los reportes
	INSERT INTO [Comisiones].[SLAUAC](
		[CargaId],[Secuencia],[SupervisorId],[Supervisor],[GrupoId],[Grupo],[EmpleadoId],[Empleado],[DentroPlazo],[FueraPlazo],[TotalGeneral])
	SELECT 
		S.[CargaId],S.[Secuencia],
		(SELECT ResponsableId FROM Comisiones.Grupo WHERE Id = 14),
		(SELECT E.ApellidoPaterno + ' ' + E.ApellidoPaterno + ' ' + E.Nombres  
		 FROM Comisiones.Grupo G INNER JOIN Comisiones.Empleado E ON G.ResponsableId = E.Id WHERE G.Id = 14),
		 14,
		 'Contáctenos',
		[EmpleadoId],
		[Empleado],
		[DentroPlazo],
		[FueraPlazo],
		[TotalGeneral]		
	FROM [Comisiones].[SLAContactenos] S INNER JOIN Comisiones.CabeceraCarga C on S.CargaId = C.Id
	WHERE C.EstadoCarga = 1 AND C.TipoArchivo = 10 AND C.FechaCargaIni = (SELECT MAX(FechaCargaIni) 
																		 FROM Comisiones.CabeceraCarga 
																		 WHERE TipoArchivo = 10 and EstadoCarga=1)

END

GO
/****** Object:  StoredProcedure [Comisiones].[GetCabeceraCargaProcesado]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
		FechaCargaIni,
		FechaCargaFin,
		EstadoCarga
	FROM Comisiones.CabeceraCarga	
	WHERE TipoArchivo = @TipoArchivo 
		AND FechaArchivo = @FechaArchivo
		AND EstadoCarga = 1
END


GO
/****** Object:  StoredProcedure [Comisiones].[GetExcel]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
		ehc.NombreCelda
	FROM Comisiones.Excel e
	INNER JOIN Comisiones.ExcelHoja eh ON eh.ExcelId = e.Id 
	INNER JOIN Comisiones.ExcelHojaCampo ehc ON ehc.ExcelId = e.Id and eh.TipoArchivo = ehc.TipoArchivo
END


GO
/****** Object:  StoredProcedure [Comisiones].[LlenarPonderacion]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comisiones].[LlenarPonderacion]
AS
BEGIN

/*Cargando tabla Ponderación con valores porcentuales de la tabla CumplimientoDetalle según indicador */
	insert into [Comisiones].[Ponderacion](
		[CargaId], [Secuencia], [EmpleadoId],
		[CR1],
		[CR2],
		[CR3],
		[CR4],
		[CR5],
		[CR6],
		[CR7],
		[CR_SUMA],
		[CS1],
		[CS2],
		[CS_SUMA],
		[CP1],
		[CP_SUMA],
		[OR1],
		[OR2],
		[OR_SUMA],
		[VR1],
		[VR2],
		[VR3],
		[VR4],
		[VR_SUMA],
		[MR1],
		[MR2],
		[MR3],
		[MR_SUMA],
		[Nota],
		[Cumple_Estand]
	)
	SELECT [CargaId],[Secuencia], [EmpleadoId],
		CASE WHEN UPPER([CR1]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='CR' AND [CampoId]='CR1')
		ELSE '0.0' END AS CR1,
		CASE WHEN UPPER([CR2]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='CR' AND [CampoId]='CR2')
		ELSE '0.0' END AS CR2,
		CASE WHEN UPPER([CR3]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='CR' AND [CampoId]='CR3')
		ELSE '0.0' END AS CR3,
		CASE WHEN UPPER([CR1]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='CR' AND [CampoId]='CR4')
		ELSE '0.0' END AS CR4,
		CASE WHEN UPPER([CR1]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='CR' AND [CampoId]='CR5')
		ELSE '0.0' END AS CR5,
		CASE WHEN UPPER([CR1]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='CR' AND [CampoId]='CR6')
		ELSE' 0.0' END AS CR6,
		CASE WHEN UPPER([CR1]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='CR' AND [CampoId]='CR7')
		ELSE '0.0' END AS CR7,
		0.0 AS CR_SUMA,
		CASE WHEN UPPER([CS1]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='CS' AND [CampoId]='CS1')
		ELSE '0.0' END AS CS1,
		CASE WHEN UPPER([CS2]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='CS' AND [CampoId]='CS2')
		ELSE '0.0' END AS CS2,
		0.0 AS CS_SUMA,
		CASE WHEN UPPER([CP1]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='CP' AND [CampoId]='CP1')
		ELSE '0.0' END AS CP1,
		0.0 AS CP_SUMA,
		CASE WHEN UPPER([OR1]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='OR' AND [CampoId]='OR1')
		ELSE '0.0' END AS OR1,
		CASE WHEN UPPER([OR2]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='OR' AND [CampoId]='OR2')
		ELSE '0.0' END AS OR2,
		0.0 AS OR_SUMA,
		CASE WHEN UPPER([VR1]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='VR' AND [CampoId]='VR1')
		ELSE '0.0' END AS VR1,
		CASE WHEN UPPER([VR2]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='VR' AND [CampoId]='VR2')
		ELSE '0.0' END AS VR2,
		CASE WHEN UPPER([VR3]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='VR' AND [CampoId]='VR3')
		ELSE '0.0' END AS VR3,
		CASE WHEN UPPER([VR4]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='VR' AND [CampoId]='VR4')
		ELSE '0.0' END AS VR4,
		0.0 AS VR_SUMA,
		CASE WHEN UPPER([MR1]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='MR' AND [CampoId]='MR1')
		ELSE '0.0' END AS MR1,
		CASE WHEN UPPER([MR2]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='MR' AND [CampoId]='MR2')
		ELSE '0.0' END AS MR2,
		CASE WHEN UPPER([MR3]) = 'SI' THEN (SELECT CONVERT(VARCHAR,[Nota]) FROM [Comisiones].[IndicadorMedicionNota] WHERE [IndicadorId]='MR' AND [CampoId]='MR3')
		ELSE '0.0' END AS MR3,
		0.0 AS MR_SUMA,
		0.0 AS Nota,
		0.0 AS Cumple_Estand
	FROM [Comisiones].[Monitoreo]

	/*Actualizar campos de suma */
	UPDATE Comisiones.Ponderacion
	SET [CR_SUMA] = P.CR1 + P.CR2 + P.CR3 + P.CR4 + P.CR5 + P.CR6 + P.CR7,
		[CS_SUMA] = P.CS1 + P.CS2,
		[CP_SUMA] = P.CP1,
		[OR_SUMA] = P.OR1 + P.OR2,
		[VR_SUMA] = P.VR1 + P.VR2 + P.VR3 + P.VR4,
		[MR_SUMA] = P.MR1 + P.MR2 + P.MR3
	FROM [Comisiones].[Ponderacion] P

	/*Actualizar campos de Nota Ponderación*/
	UPDATE Comisiones.Ponderacion
	SET [Nota] = P.[CR_SUMA] + [CS_SUMA] + [CP_SUMA] + [OR_SUMA] + [VR_SUMA] + [MR_SUMA]
	FROM [Comisiones].[Ponderacion] P

	/*Actualizar campo  Cumplimiento Ponderación */
	UPDATE Comisiones.Ponderacion
	SET [Cumple_Estand] = (CASE WHEN [Nota] <= 0.99 THEN 0 ELSE 1 END)
	FROM [Comisiones].[Ponderacion] P

	/* FIN LLENADO PONDERACION */


END
GO
/****** Object:  StoredProcedure [Comisiones].[LlenarProductividadEsp]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comisiones].[LlenarProductividadEsp]
AS
BEGIN

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
	FROM [Comisiones].[ProductividadEsp] AS PE 

	UPDATE PE
	SET PE.[CRECasosCerrados] = (SELECT SUM([CRECasosCerrados]) FROM [Comisiones].[ProductividadEsp] WHERE GrupoId = PE.GrupoId  GROUP BY GrupoId)
	FROM [Comisiones].[ProductividadEsp] AS PE 


	UPDATE [Comisiones].[ProductividadEsp] 
	SET [CRECumplimiento] = ROUND(([CRECasosCerrados]/[CREMetaTotal]),2)


END
GO
/****** Object:  StoredProcedure [Comisiones].[UpdateCabeceraCarga]    Script Date: 14/12/2017 06:16:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Comisiones].[UpdateCabeceraCarga]
	@Id INT,
	@FechaCargaFin DATETIME,
	@EstadoCarga INT
AS    
BEGIN
	UPDATE Comisiones.CabeceraCarga 
	SET EstadoCarga = @EstadoCarga, FechaCargaFin = @FechaCargaFin
	WHERE Id = @Id
END


GO
USE [master]
GO
ALTER DATABASE [Comisiones] SET  READ_WRITE 
GO
