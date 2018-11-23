USE [Progra 3 Bases de Datos]
GO

/****** Object:  Table [dbo].[Planilla Semanal]    Script Date: 23/11/2018 11:05:24 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Planilla Semanal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPlanillaMensual] [int] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[SalarioBruto] [money] NOT NULL,
	[SalarioNeto] [money] NOT NULL,
 CONSTRAINT [PK_Planilla Semanal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Planilla Semanal]  WITH CHECK ADD  CONSTRAINT [FK_Planilla Semanal_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO

ALTER TABLE [dbo].[Planilla Semanal] CHECK CONSTRAINT [FK_Planilla Semanal_Empleado]
GO

ALTER TABLE [dbo].[Planilla Semanal]  WITH CHECK ADD  CONSTRAINT [FK_Planilla Semanal_Planilla Mensual] FOREIGN KEY([IdPlanillaMensual])
REFERENCES [dbo].[Planilla Mensual] ([Id])
GO

ALTER TABLE [dbo].[Planilla Semanal] CHECK CONSTRAINT [FK_Planilla Semanal_Planilla Mensual]
GO


