/*
Ent�o, Voc� consegue ver isso de duas maneiras: Atrav�s de uma query de work items no pr�prio Visual Studio (estou anexando a query pra vc entender), que � a maneira mais f�cil.
Ou pela pr�pria base do tfs. A base Tfs_Warehouse cont�m uma tabela chamada DimWorkItem que tem todos os WIs e seu respectivo hist�rico. � a ideal pra usar se tiver a inten��o de fazer reports.

Ah, e na base �live� do tfs (Tfs_Nova.com) voc� tamb�m consegue pegar essas informa��es atrav�s de uma view chamada WorkItemsLatestUsed. Se quiser pegar o hist�rico, pode ser tamb�m na WorkItemsWereUsed.

Quanto ao �trazer seus respectivos work items�, a coisa funciona da seguinte maneira: O tfs guarda teus CR em um tipo de WI chamado �Code Review Response�, que � onde vc d� o Looks Good ou o Needs Work, etc. 
Esse Work Item est� associado a um outro WI do tipo �Code Review Request�, que define o que est� sendo revisado. 
Dentro deste WI existe um campo chamado �Associated Context�, que define o n�mero do changeset para CR ou o nome do shelveset, dependendo do tipo de CR.

Vc consegue pegar os work items associados atrav�s destes changesets apenas, n�o h� uma liga��o direta entre CR e WorkItem de tarefa
*/

SELECT object_name(object_id),* FROM sys.columns WHERE name LIKE '%external%'

select * FROM dbo.WorkItemsWere WHERE ID=32843
select DISTINCT [System.WorkItemType] FROM WorkItemsLatestUsed WHERE [System.Id]=32843
select top 10 * FROM dbo.WorkItemTypes
select top 10 * FROM dbo.WorkItemTypeCategories
select top 10 * FROM dbo.WorkItemTypeCategoryMembers
SELECT top 1 * FROM dbo.tbl_ChangeSet WHERE ChangeSetId=32458
select top 10 * FROM dbo.ForwardLinks WHERE SourceID IN (33393,33395)
select top 10 * FROM dbo.LinkTypes
SELECT * FROM [dbo].[WorkItemsAre] WHERE ID LIKE N'%32843%'

SELECT [System.Title],COUNT(*)
FROM dbo.WorkItemsLatestUsed WHERE [System.WorkItemType]='Task' 
GROUP BY [System.Title]
HAVING count(*)>1
AND [System.Title]='Impossibilidade de carregar precifica��o massiva por utm'

select * 
FROM dbo.WorkItemsLatestUsed 
WHERE [System.WorkItemType]='Code Review Request' 
AND [System.Title] LIKE '%Impossibilidade de carregar precifica��o massiva por utm%'

--AND [System.AssignedTo] LIKE 'Rodrigo da Silva Brito' 
--ORDER BY [System.Id] desc

select top 10 * FROM dbo.LinksWere WHERE TargetID=28694 OR SourceID=28694
select top 10 * FROM dbo.LinkTreesLatest WHERE TargetID=28694 OR SourceID=28694
select top 10 * FROM dbo.ForwardLinks WHERE TargetID=28694 OR SourceID=28694




SELECT * FROM [dbo].[LinksAre] WHERE TargetID LIKE N'%32843%'
SELECT * FROM [dbo].[LinksAre] WHERE TargetID LIKE N'%32365%'

select top 10 * FROM dbo.WorkItemChanges
select top 10 * FROM dbo.tbl_ChangeSet WHERE ChangeSetId=134587

--AND [System.AssignedTo] LIKE 'Rodrigo da Silva Brito' 
--AND [Microsoft.VSTS.CodeReview.Context]='135789'
--ORDER BY [System.Id] DESC

select [System.WorkItemType],* FROM WorkItemsLatestUsed WHERE [System.Id]=134805
select top 10 * FROM tbl_ChangeSet WHERE ChangeSetId=134805

select [System.WorkItemType],* FROM WorkItemsLatestUsed WHERE [System.Id]=32843 AND [System.WorkItemType]='task'

SELECT  [Microsoft.VSTS.CodeReview.ContextType],[Microsoft.VSTS.CodeReview.Context],* 
FROM dbo.WorkItemsLatestUsed 
WHERE 1=1
--and [Microsoft.VSTS.CodeReview.ClosedStatusCode]=3 
AND [System.WorkItemType]='Code Review Response' 
AND [System.Id]=33394


SELECT
--I.FilePath
SUBSTRING(I.FilePath,CHARINDEX('changeset/',FilePath,1)+10,2000000000) AS Changeset
,i.ID
--,U.ObjectID,I.FldID,U.DirectObjectID
FROM dbo.WorkItemFiles I JOIN dbo.FieldUsages U ON I.FldID = U.FldID
AND U.ObjectID = -100
AND U.fDeleted = 0
JOIN WorkItemsLatestUsed wi ON wi.[Microsoft.VSTS.CodeReview.Context]=SUBSTRING(I.FilePath,CHARINDEX('changeset/',FilePath,1)+10,2000000000)
AND wi.[System.WorkItemType]='Code Review Request' 
WHERE
I.PartitionId = 1
--AND 32981 = I.ID
