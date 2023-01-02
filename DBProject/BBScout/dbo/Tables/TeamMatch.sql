CREATE TABLE [dbo].[TeamMatch] (
    [id]                      INT             IDENTITY (1, 1) NOT NULL,
    [matchId]                 INT             NOT NULL,
    [teamId]                  INT             NOT NULL,
    [alliance]                CHAR (1)        NOT NULL,
    [alliancePosition]        INT             NOT NULL,
    [lastUpdated]             DATETIME        NULL,
    [portionOfAlliancePoints] NUMERIC (11, 3) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_TeamMatch_Match] FOREIGN KEY ([matchId]) REFERENCES [dbo].[Match] ([id]) ON DELETE CASCADE,
    CONSTRAINT [fk_TeamMatch_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_TeamMatch]
    ON [dbo].[TeamMatch]([matchId] ASC, [teamId] ASC);


GO
-- Trigger to maintain last updated value of TeamMatch
CREATE trigger tr_tm_LastUpdated on TeamMatch after insert, update
as
begin
	set nocount on
    update TeamMatch set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
