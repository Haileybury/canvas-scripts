USE [SynergyOne]
GO

/****** Object:  Table [dbo].[uCanvasMasterCourses]    Script Date: 6/09/2016 8:11:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[uCanvasMasterCourses](
	[PrimaryID] [int] IDENTITY(1,1) NOT NULL,
	[Master_Course_ID] [varchar](50) NOT NULL,
	[Description] [varchar](100) NULL,
	[SubAccount] [varchar](50) NULL,
	[School] [varchar](50) NULL,
	[FileYear] [int] NOT NULL,
	[status] [varchar](10) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


