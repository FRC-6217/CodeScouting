CREATE TABLE [dbo].[GameRankingPoint] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [gameId]      INT           NOT NULL,
    [sortOrder]   INT           NOT NULL,
    [name]        VARCHAR (128) NOT NULL,
    [tableHeader] VARCHAR (64)  NOT NULL,
    [tbaKey]      VARCHAR (128) NULL,
    [lastUpdated] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_GameRankingPoint_Game] FOREIGN KEY ([gameId]) REFERENCES [dbo].[Game] ([id])
);

