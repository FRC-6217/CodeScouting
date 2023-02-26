CREATE TABLE [dbo].[Objective] (
    [id]                  INT          IDENTITY (1, 1) NOT NULL,
    [gameId]              INT          NOT NULL,
    [name]                VARCHAR (64) NOT NULL,
    [label]               VARCHAR (64) NOT NULL,
    [scoringTypeId]       INT          NOT NULL,
    [lowRangeValue]       INT          NULL,
    [highRangeValue]      INT          NULL,
    [scoreMultiplier]     INT          NULL,
    [sortOrder]           INT          NOT NULL,
    [lastUpdated]         DATETIME     NULL,
    [tableHeader]         VARCHAR (64) NOT NULL,
    [reportDisplay]       VARCHAR (1)  NOT NULL,
    [sameLineAsPrevious]  CHAR (1)     NOT NULL,
    [addTeamScorePortion] CHAR (1)     NOT NULL,
    [reportSortOrder]     INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_Objective_Game] FOREIGN KEY ([gameId]) REFERENCES [dbo].[Game] ([id]),
    CONSTRAINT [fk_Objective_ScoringType] FOREIGN KEY ([scoringTypeId]) REFERENCES [dbo].[ScoringType] ([id])
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Objective]
    ON [dbo].[Objective]([gameId] ASC, [name] ASC);


GO
-- Trigger to maintain last updated value of Objective
CREATE trigger tr_o_LastUpdated on Objective after insert, update
as
begin
	set nocount on
    update Objective set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
