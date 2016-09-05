USE [SynergyOne]
GO

/****** Object:  Table [dbo].[uCanvasSubAccounts]    Script Date: 6/09/2016 8:12:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[uCanvasSubAccounts](
	[AccountID] [int] NULL,
	[AccountName] [varchar](100) NULL,
	[Hierarchy] [varchar](10) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


