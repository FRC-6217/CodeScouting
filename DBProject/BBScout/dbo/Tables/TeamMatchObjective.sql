CREATE TABLE [dbo].[TeamMatchObjective] (
    [id]           INT            IDENTITY (1, 1) NOT NULL,
    [teamMatchId]  INT            NOT NULL,
    [objectiveId]  INT            NOT NULL,
    [integerValue] INT            NULL,
    [decimalValue] INT            NULL,
    [textValue]    VARCHAR (4000) NULL,
    [scoreValue]   INT            NULL,
    [lastUpdated]  DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_TeamMatchObjective_Objective] FOREIGN KEY ([objectiveId]) REFERENCES [dbo].[Objective] ([id]),
    CONSTRAINT [fk_TeamMatchObjective_TeamMatch] FOREIGN KEY ([teamMatchId]) REFERENCES [dbo].[TeamMatch] ([id]) ON DELETE CASCADE
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_TeamMatchObjective]
    ON [dbo].[TeamMatchObjective]([teamMatchId] ASC, [objectiveId] ASC);


GO
-- Trigger to maintain last updated and scoreValue after insert/update of TeamMatchObjective
create trigger tr_tmo_CalcScoreValue on TeamMatchObjective after insert, update
as
begin
	set nocount on
    update TeamMatchObjective
	   set scoreValue = (select dbo.calcScoreValue(i.objectiveId, i.integerValue, i.decimalValue)
	                       from inserted i
						  where i.id = TeamMatchObjective.id)
		 , lastUpdated = getDate() at time zone 'UTC' at time zone 'Central Standard Time'
	 where TeamMatchObjective.id in (select i.id from inserted i);
	set nocount off
end
