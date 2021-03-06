/****************************************************/
/* Created by: SQL Server 2008 Profiler             */
/* Date: 04/26/2012  02:39:29 PM         */
/****************************************************/


-- Create a Queue
declare @rc int
declare @TraceID int
declare @maxfilesize bigint
set @maxfilesize = 1000

-- Please replace the text InsertFileNameHere, with an appropriate
-- filename prefixed by a path, e.g., c:\MyFolder\MyTrace. The .trc extension
-- will be appended to the filename automatically. If you are writing from
-- remote server to local drive, please use UNC path and make sure server has
-- write access to your network share

exec @rc = sp_trace_create @TraceID output, 0, N'h:\V91_03', @maxfilesize, NULL 
if (@rc != 0) goto error

-- Client side File and Table cannot be scripted

-- Set the events
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 10, 15, @on
exec sp_trace_setevent @TraceID, 10, 8, @on
exec sp_trace_setevent @TraceID, 10, 16, @on
exec sp_trace_setevent @TraceID, 10, 1, @on
exec sp_trace_setevent @TraceID, 10, 9, @on
exec sp_trace_setevent @TraceID, 10, 17, @on
exec sp_trace_setevent @TraceID, 10, 2, @on
exec sp_trace_setevent @TraceID, 10, 10, @on
exec sp_trace_setevent @TraceID, 10, 18, @on
exec sp_trace_setevent @TraceID, 10, 26, @on
exec sp_trace_setevent @TraceID, 10, 34, @on
exec sp_trace_setevent @TraceID, 10, 11, @on
exec sp_trace_setevent @TraceID, 10, 35, @on
exec sp_trace_setevent @TraceID, 10, 12, @on
exec sp_trace_setevent @TraceID, 10, 13, @on
exec sp_trace_setevent @TraceID, 10, 6, @on
exec sp_trace_setevent @TraceID, 10, 14, @on
exec sp_trace_setevent @TraceID, 12, 15, @on
exec sp_trace_setevent @TraceID, 12, 8, @on
exec sp_trace_setevent @TraceID, 12, 16, @on
exec sp_trace_setevent @TraceID, 12, 1, @on
exec sp_trace_setevent @TraceID, 12, 9, @on
exec sp_trace_setevent @TraceID, 12, 17, @on
exec sp_trace_setevent @TraceID, 12, 6, @on
exec sp_trace_setevent @TraceID, 12, 10, @on
exec sp_trace_setevent @TraceID, 12, 14, @on
exec sp_trace_setevent @TraceID, 12, 18, @on
exec sp_trace_setevent @TraceID, 12, 26, @on
exec sp_trace_setevent @TraceID, 12, 11, @on
exec sp_trace_setevent @TraceID, 12, 35, @on
exec sp_trace_setevent @TraceID, 12, 12, @on
exec sp_trace_setevent @TraceID, 12, 13, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%spProdutoListar%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%SkuCampoValorAtualiza%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%spFlagListar%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%spFlagIncluir%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%spListarFlagsDestaqueColecao%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%spFlagAlterar%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%CategoriaCorrigirOrdemArvore %'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%CategoriaRearranjarOrdem %'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%BuscaExecutaNoFullText%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%BuscaTotalNoFullText%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%SkuDetalheInclui%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%SkuDetalheObter%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%BuscaExecutaNoFullTextLojista%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%ListarProdutoParceiro%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%spBuscaRelacionadaSliApagar%'
-- exec sp_trace_setfilter @TraceID, 1, 1, 6, N'%spListarTodosIdSku%'
--exec sp_trace_setfilter @TraceID, 1, 0, 7, N'%sp_reset_connection%'


exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Server Profiler%'
--exec sp_trace_setfilter @TraceID, 8, 0, 7, N'CL-HL-HSQLWEB01%'
--exec sp_trace_setfilter @TraceID, 8, 0, 7, N'VLO0%'
exec sp_trace_setfilter @TraceID, 35, 0, 7, N'tempdb'
exec sp_trace_setfilter @TraceID, 35, 0, 7, N'master'
exec sp_trace_setfilter @TraceID, 35, 0, 7, N'msdb'
exec sp_trace_setfilter @TraceID, 35, 0, 7, N'model'
exec sp_trace_setfilter @TraceID, 35, 0, 7, N'distribution'	
--exec sp_trace_setfilter @TraceID, 35, 0, 6, N'db_hom_extra'
--exec sp_trace_setfilter @TraceID, 35, 1, 6, N'db_hom_extra_barril'

-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
go


DECLARE @traceid INT
SET @traceid = 4
/*
exec sp_trace_setstatus 2, 1 --start
exec sp_trace_setstatus 3, 0 --stop
EXEC sp_trace_setstatus 3, 2; --close
*/
-----------------------------------------

SELECT * FROM sys.traces