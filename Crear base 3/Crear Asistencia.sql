USE [Progra 3 Bases de Datos]
GO

/****** Object:  Table [dbo].[Asistencia]    Script Date: 23/11/2018 11:02:58 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Asistencia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[IdTipoJornada] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[HoraEntrada] [time](7) NOT NULL,
	[HoraSalida] [time](7) NOT NULL,
	[Incapacidad] [bit] NOT NULL,
 CONSTRAINT [PK_Asistencia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Asistencia]  WITH CHECK ADD  CONSTRAINT [FK_Asistencia_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO

ALTER TABLE [dbo].[Asistencia] CHECK CONSTRAINT [FK_Asistencia_Empleado]
GO

ALTER TABLE [dbo].[Asistencia]  WITH CHECK ADD  CONSTRAINT [FK_Asistencia_Tipo Jornada] FOREIGN KEY([IdTipoJornada])
REFERENCES [dbo].[Tipo Jornada] ([Id])
GO

ALTER TABLE [dbo].[Asistencia] CHECK CONSTRAINT [FK_Asistencia_Tipo Jornada]
GO


