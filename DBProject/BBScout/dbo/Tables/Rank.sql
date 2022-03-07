CREATE TABLE [dbo].[Rank] (
    [id]          INT          IDENTITY (1, 1) NOT NULL,
    [name]        VARCHAR (64) NOT NULL,
    [queryString] VARCHAR (64) NOT NULL,
    [type]        VARCHAR (1)  NOT NULL,
    [sortOrder]   INT          NULL,
    [lastUpdated] DATETIME     NULL,
    [gameId]      INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_Rank_Game] FOREIGN KEY ([gameId]) REFERENCES [dbo].[Game] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Rank]
    ON [dbo].[Rank]([gameId] ASC, [name] ASC);


GO
-- Trigger to maintain last updated value of Rank
CREATE trigger tr_r_LastUpdated on Rank after insert, update
as
begin
	set nocount on
    update Rank set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
