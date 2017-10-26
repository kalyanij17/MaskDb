SET NOCOUNT ON

--Create a temp table for loading values to merge
Declare	@ApplicationToMerge Table  (

      [ApplicationName] VARCHAR(10)
      ,[Description] VARCHAR(50)
      ,[IsActive] BIT
      ,[IsDeleted] BIT
      ,[CreatedDate] DATETIME2
      ,[CreatedBy] VARCHAR(50)
      ,[ModifiedDate] DATETIME2
      ,[ModifiedBy] VARCHAR(50)
)




--Insert values into temp table for merging
INSERT  
INTO	@ApplicationToMerge
		(
		     [ApplicationName] 
      ,[Description] 
      ,[IsActive] 
      ,[IsDeleted] 
      ,[CreatedDate] 
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy] 
	  )
VALUES	('OnDot', 'Ondot Project', 1,0, SYSUTCDATETIME(),'SYSTEM',NULL,NULL)

MERGE	MaskUnmask.[Application] AS TARGET  
		USING 
(SELECT     
		[ApplicationName]
      ,[Description]
      ,[IsActive]
      ,[IsDeleted]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
	  FROM	@ApplicationToMerge) AS Source 
		(	
		[ApplicationName]
      ,[Description]
      ,[IsActive]
      ,[IsDeleted]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]) 
		ON	(Target.[ApplicationName] = Source.[ApplicationName]) 
WHEN	NOT MATCHED BY TARGET THEN 
		INSERT (	[ApplicationName]
      ,[Description]
      ,[IsActive]
      ,[IsDeleted]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy])
		VALUES (
		source.[ApplicationName], 
		source.[Description], 
		source.[IsActive], 
		source.[IsDeleted], 
		source.[CreatedDate], 
		source.[CreatedBy],
		source.[ModifiedDate],
		source.[ModifiedBy]
		); 

SET NOCOUNT OFF
