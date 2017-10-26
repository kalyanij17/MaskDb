print 'Start of Script to deploy default data'

print 'Deploying ApplicationData...'
go
:r .\PrepopulatedData\ApplicationData.sql
go
:r .\PrepopulatedData\MaskingLevelData.sql
go
:r .\PrepopulatedData\SourceAttributeData.sql
print 'Script completed succesfully.'
go