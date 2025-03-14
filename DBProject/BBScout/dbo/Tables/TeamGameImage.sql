CREATE TABLE [dbo].[TeamGameImage] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [teamId]      INT           NOT NULL,
    [gameId]      INT           NOT NULL,
    [imageSource] VARCHAR (512) NOT NULL,
    [isPrimary]   CHAR (1)      NOT NULL,
    [lastUpdated] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_TeamGameImage_Game] FOREIGN KEY ([gameId]) REFERENCES [dbo].[Game] ([id]) ON DELETE CASCADE,
    CONSTRAINT [fk_TeamGameImage_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_TeamGameImage]
    ON [dbo].[TeamGameImage]([teamId] ASC, [gameId] ASC, [imageSource] ASC);

