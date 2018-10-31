USE [Progra 3 Bases de Datos]
GO

/****** Object:  Table [dbo].[Puesto x Tipo Jornada]    Script Date: 31/10/2018 4:25:45 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Puesto x Tipo Jornada](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoJornada] [int] NOT NULL,
	[IdPuesto] [int] NOT NULL,
	[SalarioxHoras] [money] NOT NULL,
 CONSTRAINT [PK_Puesto x Tipo Jornada] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Puesto x Tipo Jornada]  WITH CHECK ADD  CONSTRAINT [FK_Puesto x Tipo Jornada_Puesto] FOREIGN KEY([IdPuesto])
REFERENCES [dbo].[Puesto] ([Id])
GO

ALTER TABLE [dbo].[Puesto x Tipo Jornada] CHECK CONSTRAINT [FK_Puesto x Tipo Jornada_Puesto]
GO

ALTER TABLE [dbo].[Puesto x Tipo Jornada]  WITH CHECK ADD  CONSTRAINT [FK_Puesto x Tipo Jornada_Tipo Jornada] FOREIGN KEY([IdTipoJornada])
REFERENCES [dbo].[Tipo Jornada] ([Id])
GO

ALTER TABLE [dbo].[Puesto x Tipo Jornada] CHECK CONSTRAINT [FK_Puesto x Tipo Jornada_Tipo Jornada]
GO


