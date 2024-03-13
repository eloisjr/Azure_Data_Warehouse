IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'synaproject_synaproject_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [synaproject_synaproject_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://synaproject@synaproject.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.fact_payment
WITH (
    LOCATION = 'fact_payment',
    DATA_SOURCE = [synaproject_synaproject_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
[payment_id] payment_id, 
[payment_date] payment_date, 
[amount] amount, 
[rider_id] rider_id
FROM [dbo].[staging_payments]
GO



SELECT TOP 100 * FROM dbo.fact_payment
GO