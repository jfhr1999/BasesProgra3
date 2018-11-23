USE [Progra 3 Bases de Datos]
GO

/****** Object:  Table [dbo].[Deducciones x Empleado]    Script Date: 23/11/2018 11:03:55 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Deducciones x Empleado](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoDeduccion] [int] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[Valor] [money] NOT NULL,
 CONSTRAINT [PK_Deducciones x Empleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Deducciones x Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Deducciones x Empleado_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([Id])
GO

ALTER TABLE [dbo].[Deducciones x Empleado] CHECK CONSTRAINT [FK_Deducciones x Empleado_Empleado]
GO

ALTER TABLE [dbo].[Deducciones x Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Deducciones x Empleado_Tipo Deduccion] FOREIGN KEY([IdTipoDeduccion])
REFERENCES [dbo].[Tipo Deduccion] ([Id])
GO

ALTER TABLE [dbo].[Deducciones x Empleado] CHECK CONSTRAINT [FK_Deducciones x Empleado_Tipo Deduccion]
GO


