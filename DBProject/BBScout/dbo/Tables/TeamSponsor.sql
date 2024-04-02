CREATE TABLE [dbo].[TeamSponsor] (
    [id]                 INT             IDENTITY (1, 1) NOT NULL,
    [teamId]             INT             NOT NULL,
    [gameId]             INT             NOT NULL,
    [sponsorName]        NVARCHAR (128)  NOT NULL,
    [isPrimary]          BIT             NOT NULL,
    [sortOrder]          INT             NOT NULL,
    [logoFile]           NVARCHAR (128)  NULL,
    [referenceURL]       NVARCHAR (1024) NULL,
    [maxWidthPercent]    INT             NOT NULL,
    [lastUpdated]        DATETIME        NULL,
    [width]              INT             NULL,
    [height]             INT             NULL,
    [sameLineAsPrevious] CHAR (1)        NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_TeamSponsor_Game] FOREIGN KEY ([gameId]) REFERENCES [dbo].[Game] ([id]) ON DELETE CASCADE,
    CONSTRAINT [fk_TeamSponsor_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_TeamSponsor]
    ON [dbo].[TeamSponsor]([teamId] ASC, [gameId] ASC, [sponsorName] ASC);

