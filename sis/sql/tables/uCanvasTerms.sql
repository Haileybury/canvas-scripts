USE [SynergyOne]
GO

/****** Object:  Table [dbo].[uCanvasTerms]    Script Date: 6/09/2016 8:12:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[uCanvasTerms](
	[TermID] [varchar](10) NOT NULL,
	[TermName] [varchar](50) NOT NULL,
	[TermStatus] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[FileYear] [int] NOT NULL,
 CONSTRAINT [PK_uCanvasTerms] PRIMARY KEY CLUSTERED 
(
	[TermID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


