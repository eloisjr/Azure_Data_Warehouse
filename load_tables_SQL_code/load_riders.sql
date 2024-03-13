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

CREATE EXTERNAL TABLE dbo.staging_riders (
	[rider_id] bigint,
	[first] nvarchar(4000),
	[last] nvarchar(4000),
	[address] nvarchar(4000),
	[birthday] VARCHAR(50),
	[account_start_date] VARCHAR(50),
	[account_end_date] VARCHAR(50),
	[is_member] bit
	)

	WITH (
	LOCATION = 'publicriders.txt',
	DATA_SOURCE = [synaproject_synaproject_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_riders
GO