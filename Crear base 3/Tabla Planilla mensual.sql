USE [Progra 3 Bases de Datos]
GO

/****** Object:  Table [dbo].[Planilla Mensual]    Script Date: 31/10/2018 4:24:50 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Planilla Mensual](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[SalarioBruto] [money] NOT NULL,
	[SalarioNeto] [money] NOT NULL,
 CONSTRAINT [PK_Planilla Mensual] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Planilla Mensual]  WITH CHECK ADD  CONSTRAINT [FK_Planilla Mensual_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO

ALTER TABLE [dbo].[Planilla Mensual] CHECK CONSTRAINT [FK_Planilla Mensual_Empleado]
GO


