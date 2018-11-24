USE [Progra 3 Bases de Datos]
GO

/****** Object:  Table [dbo].[Movimiento Horas Trabajadas]    Script Date: 24/11/2018 2:14:42 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Movimiento Horas Trabajadas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdAsistencia] [int] NOT NULL,
	[IdTipoMovimiento] [int] NOT NULL,
	[tipoJornada] [varchar](50) NOT NULL,
	[cantidadHoras] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Movimiento Horas Trabajadas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Movimiento Horas Trabajadas]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento_Horas_Trabajadas_Asistencia] FOREIGN KEY([IdAsistencia])
REFERENCES [dbo].[Asistencia] ([Id])
GO

ALTER TABLE [dbo].[Movimiento Horas Trabajadas] CHECK CONSTRAINT [FK_Movimiento_Horas_Trabajadas_Asistencia]
GO

ALTER TABLE [dbo].[Movimiento Horas Trabajadas]  WITH CHECK ADD  CONSTRAINT [FK_Movimiento_Horas_Trabajadas_Tipo Movimiento Planilla] FOREIGN KEY([IdTipoMovimiento])
REFERENCES [dbo].[Tipo Movimiento Planilla] ([Id])
GO

ALTER TABLE [dbo].[Movimiento Horas Trabajadas] CHECK CONSTRAINT [FK_Movimiento_Horas_Trabajadas_Tipo Movimiento Planilla]
GO


