CREATE TABLE [dbo].[MatchObjective] (
    [id]           INT             IDENTITY (1, 1) NOT NULL,
    [matchId]      INT             NOT NULL,
    [alliance]     CHAR (1)        NOT NULL,
    [objectiveId]  INT             NOT NULL,
    [integerValue] INT             NULL,
    [decimalValue] DECIMAL (18, 2) NULL,
    [textValue]    VARCHAR (4000)  NULL,
    [scoreValue]   INT             NULL,
    [lastUpdated]  DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_MatchObjective_Match] FOREIGN KEY ([matchId]) REFERENCES [dbo].[Match] ([id]) ON DELETE CASCADE,
    CONSTRAINT [fk_MatchObjective_Objective] FOREIGN KEY ([objectiveId]) REFERENCES [dbo].[Objective] ([id])
);






GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_MatchObjective]
    ON [dbo].[MatchObjective]([matchId] ASC, [alliance] ASC, [objectiveId] ASC);


GO
-- Trigger to maintain last updated and scoreValue after insert/update of MatchObjective
create trigger tr_mo_CalcScoreValue on MatchObjective after insert, update
as
begin
	set nocount on
    update MatchObjective
	   set scoreValue = (select dbo.calcScoreValue(i.objectiveId, i.integerValue, i.decimalValue)
	                       from inserted i
						  where i.id = MatchObjective.id)
		 , lastUpdated = getDate() at time zone 'UTC' at time zone 'Central Standard Time'
	 where MatchObjective.id in (select i.id from inserted i);
	set nocount off
end
