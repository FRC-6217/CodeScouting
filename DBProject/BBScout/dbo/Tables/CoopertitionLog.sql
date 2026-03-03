CREATE TABLE [dbo].[CoopertitionLog] (
    [id]          INT            IDENTITY (1, 1) NOT NULL,
    [scoutId]     INT            NOT NULL,
    [logDate]     DATE           NOT NULL,
    [teamId]      INT            NOT NULL,
    [logNotes]    VARCHAR (4000) NOT NULL,
    [logType]     CHAR (1)       NOT NULL,
    [eventId]     INT            NULL,
    [logLocation] VARCHAR (512)  NULL,
    [lastUpdated] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_CoopertitionLog_Event] FOREIGN KEY ([eventId]) REFERENCES [dbo].[Event] ([id]),
    CONSTRAINT [fk_CoopertitionLog_Scout] FOREIGN KEY ([scoutId]) REFERENCES [dbo].[Scout] ([id]),
    CONSTRAINT [fk_CoopertitionLog_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);

