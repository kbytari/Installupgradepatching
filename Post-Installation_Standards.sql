--Post Installtion Helper :
--==========================

-- To set a fixed amount of memory (Max memory on server 80% for SQL and 20% for OS)

EXEC sys.sp_configure N'show advanced options', N'1'  RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'max server memory (MB)', N'10240'
GO
RECONFIGURE WITH OVERRIDE
GO


-- MAXDOP and Cost Threshold for parallelism

EXEC sys.sp_configure N'show advanced options', N'1'  RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'cost threshold for parallelism', N'50'
GO
EXEC sys.sp_configure N'max degree of parallelism', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'show advanced options', N'0'  RECONFIGURE WITH OVERRIDE
GO


--Optimize Ad Hoc Workloads

EXEC sp_configure 'optimize for ad hoc workloads', 1

--SQL Server Backup Compression default  
EXEC sys.sp_configure N'backup compression default', N'1'
GO

-- Start Up parameters

--Check existing 

SELECT
    DSR.registry_key,
    DSR.value_name,
    DSR.value_data
FROM sys.dm_server_registry AS DSR
WHERE 
    DSR.registry_key LIKE N'%MSSQLServer\Parameters';
	
/*
-- Add new parameters

 -T1222 -- Deadlock info
 -T1118 -- Allocates a Uniform Extent 
 -T3226 -- Suppress log entries
 
 */
--Autogrowth Setting of DB

ALTER DATABASE [model] MODIFY FILE ( NAME = N'modeldev', SIZE = 262144KB )
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modellog', SIZE = 65536KB )
GO




