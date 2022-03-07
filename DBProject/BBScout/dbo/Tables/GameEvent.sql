CREATE TABLE [dbo].[GameEvent] (
    [id]          INT      IDENTITY (1, 1) NOT NULL,
    [eventId]     INT      NOT NULL,
    [gameId]      INT      NOT NULL,
    [eventDate]   DATE     NOT NULL,
    [lastUpdated] DATETIME NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_GameEvent_Game] FOREIGN KEY ([gameId]) REFERENCES [dbo].[Game] ([id]),
    CONSTRAINT [fk_GameEvent_Team] FOREIGN KEY ([eventId]) REFERENCES [dbo].[Event] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_GameEvent]
    ON [dbo].[GameEvent]([eventId] ASC, [eventDate] ASC);


GO
-- Trigger to maintain last updated value of GameEvent
CREATE trigger tr_ge_LastUpdated on GameEvent after insert, update
as
begin
	set nocount on
    update GameEvent set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
