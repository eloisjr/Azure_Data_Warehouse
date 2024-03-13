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

CREATE EXTERNAL TABLE dbo.staging_stations (
	[station_id] nvarchar(4000),
	[name] nvarchar(4000),
	[latitude] float,
	[longtitude] float
	)
	WITH (
	LOCATION = 'publicstations.txt',
	DATA_SOURCE = [synaproject_synaproject_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_stations
GO