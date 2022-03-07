CREATE TABLE [dbo].[GameEventJSON] (
    [id]          INT            IDENTITY (1, 1) NOT NULL,
    [gameEventId] INT            NOT NULL,
    [jsonType]    NVARCHAR (32)  NOT NULL,
    [jsonData]    NVARCHAR (MAX) NOT NULL,
    [lastUpdated] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_GameEventJSON_GameEvent] FOREIGN KEY ([gameEventId]) REFERENCES [dbo].[GameEvent] ([id])
);

