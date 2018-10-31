USE [Progra 3 Bases de Datos]
GO

/****** Object:  Table [dbo].[Movimiento Planilla]    Script Date: 31/10/2018 4:22:04 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Movimiento Planilla](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPlanillaSemanal] [int] NOT NULL,
	[IdTipoMovimiento] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Monto] [money] NOT NULL,
 CONSTRAINT [PK_Movimiento Planilla] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Movimiento Planilla]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento Planilla_Planilla Semanal] FOREIGN KEY([IdPlanillaSemanal])
REFERENCES [dbo].[Planilla Semanal] ([Id])
GO

ALTER TABLE [dbo].[Movimiento Planilla] CHECK CONSTRAINT [FK_Movimiento Planilla_Planilla Semanal]
GO

ALTER TABLE [dbo].[Movimiento Planilla]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento Planilla_Tipo Movimiento Planilla] FOREIGN KEY([IdTipoMovimiento])
REFERENCES [dbo].[Tipo Movimiento Planilla] ([Id])
GO

ALTER TABLE [dbo].[Movimiento Planilla] CHECK CONSTRAINT [FK_Movimiento Planilla_Tipo Movimiento Planilla]
GO


