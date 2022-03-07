CREATE TABLE [dbo].[Team] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [teamNumber]  INT           NOT NULL,
    [teamName]    VARCHAR (128) NOT NULL,
    [location]    VARCHAR (128) NULL,
    [lastUpdated] DATETIME      NULL,
    [gameEventId] INT           NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Team]
    ON [dbo].[Team]([teamNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [idx2_Team]
    ON [dbo].[Team]([gameEventId] ASC);


GO
-- Trigger to maintain last updated value of Team
CREATE trigger tr_t_LastUpdated on Team after insert, update
as
begin
	set nocount on
    update Team set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
