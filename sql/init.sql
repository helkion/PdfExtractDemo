-- English comments in code as requested
-- Create schema for storing extracted PDF data


CREATE TABLE Documents (
Id INT IDENTITY(1,1) PRIMARY KEY,
FileName NVARCHAR(260),
ExtractedTitle NVARCHAR(500),
ExtractedDate DATE NULL,
ExtractedEmail NVARCHAR(200) NULL,
RawJson NVARCHAR(MAX),
CreatedAt DATETIME2 DEFAULT SYSUTCDATETIME()
);
