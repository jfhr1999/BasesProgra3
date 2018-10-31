USE [Progra 3 Bases de Datos]
GO

/****** Object:  Table [dbo].[Deduccion Mensual]    Script Date: 31/10/2018 4:21:10 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Deduccion Mensual](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPlanillaMensual] [int] NOT NULL,
	[IdTipoDeduccion] [int] NOT NULL,
	[total] [money] NOT NULL,
 CONSTRAINT [PK_Deduccion Mensual] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Deduccion Mensual]  WITH CHECK ADD  CONSTRAINT [FK_Deduccion Mensual_Planilla Mensual] FOREIGN KEY([IdPlanillaMensual])
REFERENCES [dbo].[Planilla Mensual] ([Id])
GO

ALTER TABLE [dbo].[Deduccion Mensual] CHECK CONSTRAINT [FK_Deduccion Mensual_Planilla Mensual]
GO

ALTER TABLE [dbo].[Deduccion Mensual]  WITH CHECK ADD  CONSTRAINT [FK_Deduccion Mensual_Tipo Deduccion] FOREIGN KEY([IdTipoDeduccion])
REFERENCES [dbo].[Tipo Deduccion] ([Id])
GO

ALTER TABLE [dbo].[Deduccion Mensual] CHECK CONSTRAINT [FK_Deduccion Mensual_Tipo Deduccion]
GO


