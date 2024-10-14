USE gold_db
GO

-- This stored procedure creates or alters a serverless SQL view in Azure Synapse Analytics.
-- It takes a single parameter, @ViewName, which specifies the name of the view to be created.
-- The view is defined to select all records from Delta format files stored in Azure Data Lake Storage.
-- Dynamic SQL is used to construct the view definition, allowing for flexible naming.

     
CREATE OR ALTER PROC CreateSQLServerlessView_gold  @ViewName nvarchar(100)
AS 
BEGIN

-- Declare a variable to hold the dynamic SQL statement
DECLARE @statement VARCHAR(MAX)
     
-- Build the dynamic SQL for creating or altering the view
SET @statement = N'CREATE OR ALTER VIEW ' + @ViewName + ' AS
   SELECT *
   FROM
       OPENROWSET(
       BULK ''https://staccfprj.dfs.core.windows.net/gold/dbo/' + @ViewName + '/'',
       FORMAT = ''DELTA''
   ) as [result]'


EXEC (@statement)

END
GO
