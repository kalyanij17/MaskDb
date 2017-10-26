CREATE TABLE [MaskUnMask].[SourceAttribute](
	[SourceAttributeId] INT  NOT NULL PRIMARY KEY IDENTITY(1,1),
	[SourceAttributeName] VARCHAR(50) NULL,
	[ApplicationId] INT NOT NULL,
	[IsActive] BIT NOT NULL DEFAULT 1,
	[IsDeleted] BIT NOT NULL DEFAULT 0,
	[CreatedDate] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME (),
	[CreatedBy] VARCHAR(50) NOT NULL,
	[ModifiedDate] DATETIME2 NULL,
	[ModifiedBy] VARCHAR(50) NULL, 
    CONSTRAINT [FK_SourceAttributes_Application] FOREIGN KEY (ApplicationId) REFERENCES [MaskUnMask].[Application](ApplicationId),
	)