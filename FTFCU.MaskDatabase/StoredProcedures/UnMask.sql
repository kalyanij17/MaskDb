CREATE PROCEDURE MaskUnMask.UnMask (
								 @maskedValue VARCHAR(50),
								 @applicationname VARCHAR(50), 
                                 @attributeName     VARCHAR(50)
								 )
 AS                  
    DECLARE @ApplicationId INT = (SELECT TOP 1 applicationid 
       FROM   maskunmask.[application] 
       WHERE  applicationname = @applicationname);

 
	SELECT TOP 1 A.SourceAttributeValue 
       FROM   maskunmask.maskedvalue A 
              INNER JOIN MaskUnmask.sourceattribute B 
                      ON a.sourceattributeid = b.sourceattributeid AND B.SourceAttributeName = @attributeName
              INNER JOIN (SELECT applicationid 
                          FROM   maskunmask.[application] 
                          WHERE  applicationname = @applicationname
						  )
						  C 
                      ON b.applicationid = c.applicationid 
       WHERE  MaskedValue = @maskedValue 