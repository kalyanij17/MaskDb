SET NOCOUNT ON

--Create a temp table for loading values to merge
Declare	@MaskingLevelToMerge Table  (

      [MaskingLevel] VARCHAR(10)
      ,[MaskedDataType] VARCHAR(50)
      ,[IsActive] BIT
      ,[IsDeleted] BIT
      ,[CreatedDate] DATETIME2
      ,[CreatedBy] VARCHAR(50)
      ,[ModifiedDate] DATETIME2
      ,[ModifiedBy] VARCHAR(50)
)




--Insert values into temp table for merging
INSERT  
INTO	@MaskingLevelToMerge
		(
		     [MaskingLevel] 
      ,[MaskedDataType] 
      ,[IsActive] 
      ,[IsDeleted] 
      ,[CreatedDate] 
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy] 
	  )
VALUES	('1:1', 'varchar', 1,0, SYSUTCDATETIME(),'SYSTEM',NULL,NULL)

MERGE	MaskUnmask.MaskingLevel AS TARGET  
		USING 
(SELECT     
		[MaskingLevel]
      ,[MaskedDataType]
      ,[IsActive]
      ,[IsDeleted]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
	  FROM	@MaskingLevelToMerge) AS Source 
		(	
		[MaskingLevel]
      ,[MaskedDataType]
      ,[IsActive]
      ,[IsDeleted]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]) 
		ON	(Target.[MaskingLevel] = Source.[MaskingLevel]) 
WHEN	NOT MATCHED BY TARGET THEN 
		INSERT (	[MaskingLevel]
      ,[MaskedDataType]
      ,[IsActive]
      ,[IsDeleted]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy])
		VALUES (
		source.[MaskingLevel], 
		source.[MaskedDataType], 
		source.[IsActive], 
		source.[IsDeleted], 
		source.[CreatedDate], 
		source.[CreatedBy],
		source.[ModifiedDate],
		source.[ModifiedBy]
		); 

SET NOCOUNT OFF
