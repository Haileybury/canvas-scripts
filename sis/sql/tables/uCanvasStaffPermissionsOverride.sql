USE [SynergyOne]
GO

/****** Object:  Table [dbo].[uCanvasStaffPermissionsOverride]    Script Date: 6/09/2016 8:12:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[uCanvasStaffPermissionsOverride](
	[Seq] [int] IDENTITY(1,1) NOT NULL,
	[ID] [varchar](50) NOT NULL,
	[Master_Course_ID] [varchar](150) NOT NULL,
	[Role] [varchar](25) NOT NULL,
	[Comments] [varchar](250) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


