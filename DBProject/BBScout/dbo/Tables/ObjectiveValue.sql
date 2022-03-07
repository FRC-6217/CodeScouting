CREATE TABLE [dbo].[ObjectiveValue] (
    [id]                 INT          IDENTITY (1, 1) NOT NULL,
    [objectiveId]        INT          NOT NULL,
    [displayValue]       VARCHAR (64) NOT NULL,
    [integerValue]       INT          NULL,
    [sortOrder]          INT          NULL,
    [scoreValue]         INT          NULL,
    [lastUpdated]        DATETIME     NULL,
    [sameLineAsPrevious] CHAR (1)     NOT NULL,
    [tbaValue]           VARCHAR (64) NULL,
    [tbaValue2]          VARCHAR (64) NULL,
    [tbaValue3]          VARCHAR (64) NULL,
    [tbaValue4]          VARCHAR (64) NULL,
    [tbaValue5]          VARCHAR (64) NULL,
    [tbaValue6]          VARCHAR (64) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_ObjectiveValue_Objective] FOREIGN KEY ([objectiveId]) REFERENCES [dbo].[Objective] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_ObjectiveValue]
    ON [dbo].[ObjectiveValue]([objectiveId] ASC, [displayValue] ASC);


GO
-- Trigger to maintain last updated value of ObjectiveValue
CREATE trigger tr_ov_LastUpdated on ObjectiveValue after insert, update
as
begin
	set nocount on
    update ObjectiveValue set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
