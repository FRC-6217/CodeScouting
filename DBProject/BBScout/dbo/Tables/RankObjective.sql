CREATE TABLE [dbo].[RankObjective] (
    [id]          INT      IDENTITY (1, 1) NOT NULL,
    [rankId]      INT      NOT NULL,
    [objectiveId] INT      NOT NULL,
    [lastUpdated] DATETIME NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_RankObjective_Objective] FOREIGN KEY ([objectiveId]) REFERENCES [dbo].[Objective] ([id]),
    CONSTRAINT [fk_RankObjective_Rank] FOREIGN KEY ([rankId]) REFERENCES [dbo].[Rank] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_RankObjective]
    ON [dbo].[RankObjective]([rankId] ASC, [objectiveId] ASC);


GO
-- Trigger to maintain last updated value of RankObjective
CREATE trigger tr_ro_LastUpdated on RankObjective after insert, update
as
begin
	set nocount on
    update RankObjective set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
