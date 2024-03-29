﻿CREATE TABLE [dbo].[TeamGameEvent] (
    [id]                  INT             IDENTITY (1, 1) NOT NULL,
    [teamId]              INT             NOT NULL,
    [gameEventId]         INT             NOT NULL,
    [lastUpdated]         DATETIME        NULL,
    [rank]                INT             NULL,
    [rankingPointAverage] NUMERIC (10, 3) NULL,
    [scoringRank]         INT             NULL,
    [scoringAverage]      NUMERIC (10, 3) NULL,
    [selectedForPlayoff]  CHAR (1)        NULL,
    [oPR]                 NUMERIC (10, 3) NULL,
    [playoffAlliance]     INT             NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_TeamGameEvent_GameEvent] FOREIGN KEY ([gameEventId]) REFERENCES [dbo].[GameEvent] ([id]) ON DELETE CASCADE,
    CONSTRAINT [fk_TeamGameEvent_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);










GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_TeamGameEvent]
    ON [dbo].[TeamGameEvent]([teamId] ASC, [gameEventId] ASC);


GO
-- Trigger to maintain last updated value of TeamGameEvent
CREATE trigger tr_tge_LastUpdated on TeamGameEvent after insert, update
as
begin
	set nocount on
    update TeamGameEvent set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
