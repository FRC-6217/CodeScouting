CREATE TABLE [dbo].[Match] (
    [id]                 INT          IDENTITY (1, 1) NOT NULL,
    [gameEventId]        INT          NOT NULL,
    [number]             VARCHAR (8)  NOT NULL,
    [dateTime]           DATETIME     NOT NULL,
    [type]               VARCHAR (8)  NOT NULL,
    [isActive]           CHAR (1)     NOT NULL,
    [redScore]           INT          NULL,
    [blueScore]          INT          NULL,
    [lastUpdated]        DATETIME     NULL,
    [redAlliancePoints]  INT          NULL,
    [redFoulPoints]      INT          NULL,
    [blueAlliancePoints] INT          NULL,
    [blueFoulPoints]     INT          NULL,
    [matchCode]          VARCHAR (16) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_Match_GameEvent] FOREIGN KEY ([gameEventId]) REFERENCES [dbo].[GameEvent] ([id]) ON DELETE CASCADE
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Match]
    ON [dbo].[Match]([gameEventId] ASC, [type] ASC, [number] ASC);


GO
-- Trigger to maintain last updated value of Match
CREATE trigger tr_m_LastUpdated on Match after insert, update
as
begin
	set nocount on
    update Match set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
