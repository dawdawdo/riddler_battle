
SELECT Warning = 'No Accidents'

SET NOEXEC ON

IF OBJECT_ID('dbo.Tower_Distributions_MAILBOX') IS NOT NULL
	DROP TABLE dbo.Tower_Distributions_MAILBOX
GO
CREATE TABLE dbo.Tower_Distributions_MAILBOX
(
	Tower1 VARCHAR(255) NULL
	, Tower2 VARCHAR(255) NULL
	, Tower3 VARCHAR(255) NULL
	, Tower4 VARCHAR(255) NULL
	, Tower5 VARCHAR(255) NULL
	, Tower6 VARCHAR(255) NULL
	, Tower7 VARCHAR(255) NULL
	, Tower8 VARCHAR(255) NULL
	, Tower9 VARCHAR(255) NULL
	, Tower10 VARCHAR(255) NULL
)

IF OBJECT_ID('dbo.Tower_Permutations_MAILBOX') IS NOT NULL
	DROP TABLE dbo.Tower_Permutations_MAILBOX
GO
CREATE TABLE dbo.Tower_Permutations_MAILBOX
(
	 P1 VARCHAR(25) NULL
	, P2 VARCHAR(25) NULL
	, P3 VARCHAR(25) NULL
	, P4 VARCHAR(25) NULL
	, P5 VARCHAR(25) NULL
	, P6 VARCHAR(25) NULL
	, P7 VARCHAR(25) NULL
	, P8 VARCHAR(25) NULL
	, P9 VARCHAR(25) NULL
	, P10 VARCHAR(25) NULL
)

SET NOEXEC OFF

IF OBJECT_ID('dbo.Tower_Unique_Partitions') IS NOT NULL
     DROP TABLE dbo.Tower_Unique_Partitions
GO
CREATE TABLE dbo.Tower_Unique_Partitions
(
     PartitionId INT IDENTITY(1, 1) NOT NULL
          CONSTRAINT PK_Tower_Unique_Partitions PRIMARY KEY
     , T1 TINYINT NOT NULL
     , T2 TINYINT NOT NULL
     , T3 TINYINT NOT NULL
     , T4 TINYINT NOT NULL
     , T5 TINYINT NOT NULL
     , T6 TINYINT NOT NULL
     , T7 TINYINT NOT NULL
     , T8 TINYINT NOT NULL
     , T9 TINYINT NOT NULL
     , T10 TINYINT NOT NULL
)
GO

INSERT
	dbo.Tower_Unique_Partitions
	(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
SELECT
	T1=Tower1, T2=Tower2, T3=Tower3, T4=Tower4, T5=Tower5
	, T6=Tower6, T7=Tower7, T8=Tower8, T9=Tower9, T10=Tower10
FROM
	dbo.Tower_Distributions_MAILBOX


IF OBJECT_ID('dbo.Tower_Permutations') IS NOT NULL
	DROP TABLE dbo.Tower_Permutations
GO
CREATE TABLE dbo.Tower_Permutations 
(
     PermutationId INT IDENTITY(1, 1) NOT NULL
          CONSTRAINT PK_Tower_Permutations PRIMARY KEY
     , P1 TINYINT NOT NULL
     , P2 TINYINT NOT NULL
     , P3 TINYINT NOT NULL
     , P4 TINYINT NOT NULL
     , P5 TINYINT NOT NULL
     , P6 TINYINT NOT NULL
     , P7 TINYINT NOT NULL
     , P8 TINYINT NOT NULL
     , P9 TINYINT NOT NULL
     , P10 TINYINT NOT NULL
)
 

INSERT
	dbo.Tower_Permutations
	(P1, P2, P3, P4, P5, P6, P7, P8, P9, P10)
SELECT
	P1, P2, P3, P4, P5, P6, P7, P8, P9, P10
FROM
	dbo.Tower_Permutations_MAILBOX


IF OBJECT_ID('dbo.Tower_Candidates') IS NOT NULL
	DROP TABLE dbo.Tower_Candidates
GO
CREATE TABLE dbo.Tower_Candidates
(
	CandidateId BIGINT IDENTITY(1, 1) NOT NULL
		CONSTRAINT PK_Tower_Candidates PRIMARY KEY
	, PartitionId INT NOT NULL
	, PermutationId INT NOT NULL
)
GO

IF OBJECT_ID('dbo.Tower_Evolution') IS NOT NULL
	DROP TABLE dbo.Tower_Evolution
GO
CREATE TABLE dbo.Tower_Evolution
(
	EvolutionId SMALLINT IDENTITY(1, 1) NOT NULL
		CONSTRAINT PK_Tower_Evolution PRIMARY KEY
	, AnnealingFactor FLOAT NOT NULL
	, BreederCount TINYINT NOT NULL
	, EvolutionStatus VARCHAR(25) NOT NULL
		CONSTRAINT DF_Tower_Evolution DEFAULT('ready')
)

IF OBJECT_ID('dbo.Tower_Evolution_Generation') IS NOT NULL
	DROP TABLE dbo.Tower_Evolution_Generation
GO
CREATE TABLE dbo.Tower_Evolution_Generation
(
	GenerationId INT NOT NULL
		CONSTRAINT Tower_Evolution_Generation PRIMARY KEY
	, EvolutionId SMALLINT NOT NULL
	, GenerationStatus VARCHAR(25) NOT NULL
		CONSTRAINT DF_Tower_Evolution_Generation DEFAULT('processing')
)
GO

IF OBJECT_ID('dbo.Tower_Evolution_Generation_Candidates') IS NOT NULL
	DROP TABLE dbo.Tower_Evolution_Generation_Candidates
GO
CREATE TABLE dbo.Tower_Evolution_Generation_Candidates
(
	GenerationId INT NOT NULL
     , T1Value TINYINT NOT NULL
     , T2Value TINYINT NOT NULL
     , T3Value TINYINT NOT NULL
     , T4Value TINYINT NOT NULL
     , T5Value TINYINT NOT NULL
     , T6Value TINYINT NOT NULL
     , T7Value TINYINT NOT NULL
     , T8Value TINYINT NOT NULL
     , T9Value TINYINT NOT NULL
     , T10Value TINYINT NOT NULL
)

	

