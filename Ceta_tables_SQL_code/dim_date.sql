IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'synaproject_synaproject_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [synaproject_synaproject_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://synaproject@synaproject.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.dim_date
WITH (
    LOCATION = 'dim_date',
    DATA_SOURCE = [synaproject_synaproject_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
[rider_id] rider_id,
[payment_date] payment_date, 
DATEPART(DAY, CONVERT(DATE,payment_date)) day,
DATEPART(MONTH, CONVERT(DATE, payment_date)) month,
DATEPART(QUARTER, CONVERT(DATE, payment_date)) quarter,
DATEPART(YEAR, CONVERT(DATE, payment_date)) year,
DATEPART(WEEKDAY, CONVERT(DATE, payment_date)) day_of_week,
DATEPART(WEEK, CONVERT(DATE, payment_date)) AS week_of_year,
DATEPART(DAYOFYEAR, CONVERT(DATE, payment_date)) day_of_year
FROM [dbo].[staging_payments]
GO

SELECT TOP 100 * FROM dbo.dim_date
GO