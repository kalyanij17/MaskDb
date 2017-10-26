CREATE TABLE [MaskUnMask].[MaskedValue](
	[MaskedValueId] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[MaskingLevelId] INT NOT NULL,
	[SourceAttributeId] INT NOT NULL,
	[SourceAttributeValue] VARCHAR(8000) NOT NULL,
	[MaskedValue] VARCHAR(50) NOT NULL,
	[IsActive] BIT NOT NULL DEFAULT 1,
	[IsDeleted] BIT NOT NULL DEFAULT 0,
	[CreatedDate] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME ( )  ,
	[CreatedBy] VARCHAR(50) NOT NULL DEFAULT 'System',
	[ModifiedDate] DATETIME2 NULL,
	[ModifiedBy] VARCHAR(50) NULL, 
    CONSTRAINT [FK_MaskedValue_SourceAttributeId] FOREIGN KEY (SourceAttributeId) REFERENCES [MaskUnMask].SourceAttribute(SourceAttributeId), 
    CONSTRAINT [FK_MaskedValue_MaskingLevel] FOREIGN KEY (MaskingLevelId) REFERENCES [MaskUnMask].MaskingLevel(MaskingLevelId)
	)