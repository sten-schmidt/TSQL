USE [DevTest]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	GRANT EXECUTE ON DevTest.dbo.spGetPersons_SqlServerQueryTimeout TO DbReader;
*/
CREATE PROCEDURE [dbo].[spGetPersons_SqlServerQueryTimeout]
	@DelaySeconds INT = 0
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @waitDelay VARCHAR(8) = '00:00:' + CONVERT(VARCHAR(2),@DelaySeconds);
	PRINT  @waitDelay

	WAITFOR DELAY @waitDelay;

    SELECT [Id]
		  ,[FirstName]
		  ,[LastName]
	  FROM [dbo].[Person]

END
