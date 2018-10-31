USE [Progra 3 Bases de Datos]
GO

/****** Object:  Table [dbo].[Tipo Jornada]    Script Date: 31/10/2018 4:26:33 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tipo Jornada](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[HoraEntrada] [time](0) NOT NULL,
	[HoraSalida] [time](0) NOT NULL,
 CONSTRAINT [PK_Tipo Jornada] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


