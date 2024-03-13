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

CREATE EXTERNAL TABLE dbo.fact_trip
WITH (
    LOCATION = 'fact_trip',
    DATA_SOURCE = [synaproject_synaproject_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
[trip_id] trip_id, 
[rideable_type] rideable_type, 
[started_at] started_at, 
[ended_at] ended_at, 
[start_station_id] start_station_id, 
[end_station_id] end_station_id,
[staging_riders].[rider_id] rider_id, 
DATEDIFF(year,CAST(birthday AS DATETIME2), CAST(account_start_date AS DATETIME2)) rider_age,
DATEDIFF(minute, CAST(started_at AS DATETIME2), CAST(ended_at AS DATETIME2)) trip_duration
FROM [dbo].[staging_trips] inner join [dbo].[staging_riders] on [dbo].[staging_trips].[rider_id] = [dbo].[staging_riders].[rider_id]
where [dbo].[staging_trips].[rider_id] = 70870;
GO

SELECT TOP 100 * FROM dbo.fact_trip
GO