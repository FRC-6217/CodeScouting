CREATE TABLE [dbo].[Game] (
    [id]                INT           IDENTITY (1, 1) NOT NULL,
    [name]              VARCHAR (128) NOT NULL,
    [gameYear]          INT           NOT NULL,
    [lastUpdated]       DATETIME      NULL,
    [alliancePtsHeader] VARCHAR (64)  NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Game]
    ON [dbo].[Game]([name] ASC);


GO
-- Trigger to maintain last updated value of Game
CREATE trigger tr_g_LastUpdated on Game after insert, update
as
begin
	set nocount on
    update Game set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
