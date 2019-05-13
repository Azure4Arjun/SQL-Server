EXEC msdb.dbo.sp_attach_schedule @job_id=N'd3a459cb-fb5a-4342-892b-3eb51ddb1d15',@schedule_id=1010
GO
USE [msdb]
GO
DECLARE @sid INT = (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name='every 10 minutes')
EXEC msdb.dbo.sp_update_schedule @schedule_id=@sid, @active_start_time=70000 --changing the start time to 7 AM
EXEC msdb.dbo.sp_update_schedule @schedule_id=@sid, @freq_interval=2 --changing the execution day to monday
GO

SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name='every 10 minutes'
SELECT TOP 10 * FROM msdb.dbo.sysjobschedules WHERE schedule_id= (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name='every 10 minutes')

