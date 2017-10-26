SET NOCOUNT ON

--Create a temp table for loading values to merge


DECLARE @ApplicationId INT  = (SELECT TOP 1 ApplicationId FROM MAskUnmask.[Application]  WHERE ApplicationName = 'OnDot');
Declare	@SourceAttributeToMerge Table  (

       [SourceAttributeName] VARCHAR(50)
      ,[ApplicationId] INT
      ,[IsActive] BIT
      ,[IsDeleted] BIT
      ,[CreatedDate] DATETIME2
      ,[CreatedBy] VARCHAR(50)
      ,[ModifiedDate] DATETIME2
      ,[ModifiedBy] VARCHAR(50)
)

--Insert values into temp table for merging
INSERT  
INTO	@SourceAttributeToMerge
		(
	[SourceAttributeName] 
      ,[ApplicationId] 
      ,[IsActive] 
      ,[IsDeleted] 
      ,[CreatedDate] 
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy] 
	  )
VALUES	('PersonNumber', @ApplicationId, 1,0, SYSUTCDATETIME(),'SYSTEM',NULL,NULL)

MERGE	MaskUnmask.SourceAttribute AS TARGET  
		USING 
(SELECT
	  [SourceAttributeName] 
      ,[ApplicationId] 
      ,[IsActive] 
      ,[IsDeleted] 
      ,[CreatedDate] 
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy] 
	  FROM	@SourceAttributeToMerge) AS Source 
		(	
	   [SourceAttributeName] 
      ,[ApplicationId] 
      ,[IsActive] 
      ,[IsDeleted] 
      ,[CreatedDate] 
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy] 
	  
	  ) 
		ON	(Target.[SourceAttributeName] = Source.[SourceAttributeName]) 
WHEN	NOT MATCHED BY TARGET THEN 
		INSERT (	
	   [SourceAttributeName] 
      ,[ApplicationId] 
      ,[IsActive] 
      ,[IsDeleted] 
      ,[CreatedDate] 
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy] 
	  
	  )
		VALUES (
		source.[SourceAttributeName], 
		source.[ApplicationId], 
		source.[IsActive], 
		source.[IsDeleted], 
		source.[CreatedDate], 
		source.[CreatedBy],
		source.[ModifiedDate],
		source.[ModifiedBy]
		); 

SET NOCOUNT OFF
