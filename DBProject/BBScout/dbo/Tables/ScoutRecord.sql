CREATE TABLE [dbo].[ScoutRecord] (
    [id]           INT            IDENTITY (1, 1) NOT NULL,
    [scoutId]      INT            NOT NULL,
    [matchId]      INT            NOT NULL,
    [teamId]       INT            NOT NULL,
    [lastUpdated]  DATETIME       NULL,
    [scoutComment] VARCHAR (4000) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_ScoutRecord_Match] FOREIGN KEY ([matchId]) REFERENCES [dbo].[Match] ([id]) ON DELETE CASCADE,
    CONSTRAINT [fk_ScoutRecord_Scout] FOREIGN KEY ([scoutId]) REFERENCES [dbo].[Scout] ([id]),
    CONSTRAINT [fk_ScoutRecord_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);






GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_ScoutRecord]
    ON [dbo].[ScoutRecord]([matchId] ASC, [teamId] ASC, [scoutId] ASC);




GO
-- Trigger to maintain last updated value of ScoutRecord
CREATE trigger tr_sr_LastUpdated on ScoutRecord after insert, update
as
begin
	set nocount on
    update ScoutRecord set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
