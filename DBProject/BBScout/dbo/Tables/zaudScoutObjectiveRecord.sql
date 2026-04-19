CREATE TABLE [dbo].[zaudScoutObjectiveRecord] (
    [id]            INT             NOT NULL,
    [scoutRecordId] INT             NOT NULL,
    [objectiveId]   INT             NOT NULL,
    [integerValue]  INT             NULL,
    [decimalValue]  DECIMAL (18, 2) NULL,
    [textValue]     VARCHAR (4000)  NULL,
    [scoreValue]    INT             NULL,
    [lastUpdated]   DATETIME        NULL,
    [auditAction]   CHAR (1)        NULL,
    [auditDate]     DATETIME        NULL
);

