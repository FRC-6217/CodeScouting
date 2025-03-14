CREATE TABLE [dbo].[TeamAttributeScouts] (
    [id]          INT      IDENTITY (1, 1) NOT NULL,
    [teamId]      INT      NOT NULL,
    [gameId]      INT      NOT NULL,
    [scoutId1]    INT      NOT NULL,
    [scoutId2]    INT      NOT NULL,
    [scoutId3]    INT      NOT NULL,
    [lastUpdated] DATETIME NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_TeamAttributeScouts_Game] FOREIGN KEY ([gameId]) REFERENCES [dbo].[Game] ([id]),
    CONSTRAINT [fk_TeamAttributeScouts_Scout1] FOREIGN KEY ([scoutId1]) REFERENCES [dbo].[Scout] ([id]),
    CONSTRAINT [fk_TeamAttributeScouts_Scout2] FOREIGN KEY ([scoutId2]) REFERENCES [dbo].[Scout] ([id]),
    CONSTRAINT [fk_TeamAttributeScouts_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);


GO
-- Trigger to maintain last updated value of TeamAttribute
CREATE trigger tr_tas_LastUpdated on TeamAttributeScouts after insert, update
as
begin
	set nocount on
    update TeamAttributeScouts set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end