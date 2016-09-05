USE [SynergyOne]
GO

/****** Object:  Table [dbo].[uCanvasSections]    Script Date: 6/09/2016 8:11:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[uCanvasSections](
	[Seq] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [varchar](10) NULL,
	[section_id] [varchar](10) NULL,
	[name] [varchar](150) NULL,
	[status] [varchar](10) NULL,
	[end_date] [datetime] NULL,
	[start_date] [datetime] NULL,
	[StudentYearLevel] [smallint] NOT NULL,
 CONSTRAINT [PK_uCanvasSections] PRIMARY KEY CLUSTERED 
(
	[Seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


