USE [CodeLib]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
	--Example:
	DECLARE @LastWriteTime DATETIME;
	EXEC File_GetLastWriteTime 
		@LastWriteTime = @LastWriteTime OUTPUT,
		@FilePath = 'C:\Temp\Test.txt';
	SELECT @LastWriteTime AS LastWriteTime;
*/

CREATE PROCEDURE [dbo].[File_GetLastWriteTime]
	@LastWriteTime DATETIME OUTPUT,
	@FilePath VARCHAR(4096)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @psCommand AS varchar(4096) = 
		'powershell.exe -command if(Test-Path -Path '''+ @filePath +''') { (Get-Item ''' + @filePath + ''').LastWriteTime.ToString(''dd.MM.yyyy'') } ';

	DECLARE @cmdResults TABLE (
		[output] varchar(4096)
	);

	INSERT INTO @cmdResults
	EXEC xp_cmdshell @psCommand;

	SELECT @LastWriteTime = CONVERT(DATETIME, [output], 104)
		FROM @cmdResults 
		WHERE [output] IS NOT NULL;

END;