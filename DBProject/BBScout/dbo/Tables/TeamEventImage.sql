CREATE TABLE [dbo].[TeamEventImage] (
    [id]           INT            IDENTITY (1, 1) NOT NULL,
    [teamId]       INT            NOT NULL,
    [EventId]      INT            NOT NULL,
    [imageGUID]    VARCHAR (4000) NOT NULL,
    [imageComment] VARCHAR (4000) NULL,
    [iPrimary]     CHAR (1)       NOT NULL,
    [sortOrder]    INT            NULL,
    [lastUpdated]  DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_TeamEventImage_Event] FOREIGN KEY ([EventId]) REFERENCES [dbo].[Event] ([id]) ON DELETE CASCADE,
    CONSTRAINT [fk_TeamEventImage_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);

