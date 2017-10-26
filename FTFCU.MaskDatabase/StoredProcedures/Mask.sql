CREATE PROCEDURE MaskUnMask.Mask (@applicationname VARCHAR(50), 
                                 @attribute       VARCHAR(MAX), 
                                 @maskingLevel    VARCHAR(10) =NULL, 
                                 @createdBy       VARCHAR(50) ='SYSTEM') 
AS 
    DECLARE @ApplicationId INT = (SELECT TOP 1 applicationid 
       FROM   maskunmask.[application] 
       WHERE  applicationname = @applicationname); 
    DECLARE @MaskValue VARCHAR(8000) = (SELECT a.maskedvalue 
       FROM   maskunmask.maskedvalue A 
              INNER JOIN MaskUnmask.sourceattribute B 
                      ON a.sourceattributeid = b.sourceattributeid 
              INNER JOIN (SELECT applicationid 
                          FROM   maskunmask.[application] 
                          WHERE  applicationname = @applicationname)C 
                      ON b.applicationid = c.applicationid 
       WHERE  sourceattributevalue IN (SELECT TOP 1 value 
                                       FROM   maskunmask.Split(@attribute))) 

    IF @MaskValue IS NULL 
      BEGIN 
          IF @maskingLevel = '1:1' 
              OR @maskingLevel IS NULL 
            BEGIN 
                SET @maskingLevel = Isnull(@maskingLevel, '1:1'); 

                DECLARE @MaskingLevelIdUseCase1 INT = (SELECT maskinglevelid 
                   FROM   maskinglevel 
                   WHERE  maskinglevel = @maskingLevel); 
                DECLARE @SourceAttributeId INT = (SELECT TOP 1 sourceattributeid 
                   FROM   maskunmask.sourceattribute 
                   WHERE  applicationid = @ApplicationId) 
                DECLARE @RandomMaskValue UNIQUEIDENTIFIER = Newid() 
                DECLARE @SourceAttributeValue VARCHAR(8000) = 
                        (SELECT TOP 1 value 
                   FROM   maskunmask.Split(@attribute)); 

                INSERT INTO maskunmask.maskedvalue 
                            ([maskinglevelid], 
                             [sourceattributeid], 
                             [sourceattributevalue], 
                             [maskedvalue], 
                             [isactive], 
                             [isdeleted], 
                             [createddate], 
                             [createdby], 
                             [modifieddate], 
                             [modifiedby]) 
                VALUES      ( @MaskingLevelIdUseCase1, 
                              @SourceAttributeId, 
                              @SourceAttributeValue, 
                              @RandomMaskValue, 
                              1, 
                              0, 
                              Sysdatetime(), 
                              @createdBy, 
                              NULL, 
                              NULL ) 

                SELECT @RandomMaskValue maskedValue 
            END 
      END 
    ELSE IF @MaskValue IS NOT NULL
      BEGIN 
          IF @maskingLevel = '1:1' 
              OR @maskingLevel IS NULL 
            BEGIN 
                SELECT @MaskValue AS maskedValue 
            END 
      END 