CREATE TABLE [dbo].[archiveTeamAttribute] (
    [id]           INT             NOT NULL,
    [teamId]       INT             NOT NULL,
    [attributeId]  INT             NOT NULL,
    [integerValue] INT             NULL,
    [decimalValue] DECIMAL (18, 2) NULL,
    [textValue]    VARCHAR (4000)  NULL,
    [lastUpdated]  DATETIME        NULL
);

