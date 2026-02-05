CREATE TABLE [dbo].[GameEventWebcast] (
    [id]             INT            IDENTITY (1, 1) NOT NULL,
    [gameEventId]    INT            NOT NULL,
    [webcastType]    NVARCHAR (64)  NOT NULL,
    [webcastChannel] NVARCHAR (128) NOT NULL,
    [lastUpdated]    DATETIME       NULL,
    [webcastURL]     AS             (case when [webcastType]='twitch' then (('https://www.'+[webcastType])+'.tv/')+[webcastChannel]  end),
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_GameEventWebcast_GameEvent] FOREIGN KEY ([gameEventId]) REFERENCES [dbo].[GameEvent] ([id])
);


GO

-- Trigger to maintain last updated value of GameEventWebcast
CREATE trigger [dbo].[tr_gew_LastUpdated] on [dbo].[GameEventWebcast] after insert, update
as
begin
	set nocount on
    update GameEventWebcast set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end