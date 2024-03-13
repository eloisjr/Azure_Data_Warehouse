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

CREATE EXTERNAL TABLE dbo.dim_rider
WITH (
    LOCATION = 'dim_rider',
    DATA_SOURCE = [synaproject_synaproject_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
[rider_id] rider_id, 
[first] first_name, 
[last] last_name, 
[birthday] birthday,
[address] address, 
[account_start_date] account_start_date, 
[account_end_date] account_end_date,
[is_member] is_member
FROM [dbo].[staging_riders]
GO

SELECT TOP 100 * FROM dbo.dim_rider
GO