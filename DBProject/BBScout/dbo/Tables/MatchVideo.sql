CREATE TABLE [dbo].[MatchVideo] (
    [id]          INT          IDENTITY (1, 1) NOT NULL,
    [matchId]     INT          NOT NULL,
    [videoKey]    VARCHAR (64) NOT NULL,
    [videoType]   VARCHAR (64) NOT NULL,
    [lastUpdated] DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_MatchVideo_Match] FOREIGN KEY ([matchId]) REFERENCES [dbo].[Match] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_MatchVideo]
    ON [dbo].[MatchVideo]([matchId] ASC, [videoKey] ASC, [videoType] ASC);


GO
-- Trigger to maintain last updated value of MatchVideo
create trigger tr_mv_LastUpdated on MatchVideo after insert, update
as
begin
	set nocount on
    update MatchVideo set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
