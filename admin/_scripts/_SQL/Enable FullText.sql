use CCPD_PROD
go
EXEC sp_fulltext_database 'enable'
go
CREATE FULLTEXT CATALOG searchall
go