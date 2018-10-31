USE [Progra 3 Bases de Datos]
GO

/****** Object:  Table [dbo].[Movimiento_Horas_Trabajadas]    Script Date: 31/10/2018 4:22:23 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Movimiento Horas Trabajadas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdAsistencia] [int] NOT NULL,
	[IdTipoMovimiento] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Monto] [money] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Movimiento Horas Trabajadas]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento_Horas_Trabajadas_Asistencia] FOREIGN KEY([IdAsistencia])
REFERENCES [dbo].[Asistencia] ([Id])
GO

ALTER TABLE [dbo].[Movimiento Horas Trabajadas] CHECK CONSTRAINT [FK_Movimiento_Horas_Trabajadas_Asistencia]
GO

ALTER TABLE [dbo].[Movimiento Horas Trabajadas]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento_Horas_Trabajadas_Movimiento Planilla] FOREIGN KEY([Id])
REFERENCES [dbo].[Movimiento Planilla] ([Id])
GO

ALTER TABLE [dbo].[Movimiento Horas Trabajadas] CHECK CONSTRAINT [FK_Movimiento_Horas_Trabajadas_Movimiento Planilla]
GO

ALTER TABLE [dbo].[Movimiento Horas Trabajadas]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento_Horas_Trabajadas_Tipo Movimiento Planilla] FOREIGN KEY([IdTipoMovimiento])
REFERENCES [dbo].[Tipo Movimiento Planilla] ([Id])
GO

ALTER TABLE [dbo].[Movimiento Horas Trabajadas] CHECK CONSTRAINT [FK_Movimiento_Horas_Trabajadas_Tipo Movimiento Planilla]
GO


