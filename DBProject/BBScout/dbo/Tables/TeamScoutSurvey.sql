CREATE TABLE [dbo].[TeamScoutSurvey] (
    [id]                      INT            IDENTITY (1, 1) NOT NULL,
    [teamId]                  INT            NOT NULL,
    [gameId]                  INT            NOT NULL,
    [scoutMatch]              CHAR (1)       NOT NULL,
    [scoutRobot]              CHAR (1)       NOT NULL,
    [scoutingDesc]            VARCHAR (4000) NULL,
    [scoutingDataStored]      VARCHAR (4000) NULL,
    [colaborate]              CHAR (1)       NOT NULL,
    [tbaForMatches]           CHAR (1)       NOT NULL,
    [tbaForAllianceSelection] CHAR (1)       NOT NULL,
    [wantBBScout]             CHAR (1)       NOT NULL,
    [overviewOfBBScout]       CHAR (1)       NOT NULL,
    [lastUpdated]             DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_TeamScoutSurvey_Game] FOREIGN KEY ([gameId]) REFERENCES [dbo].[Game] ([id]),
    CONSTRAINT [fk_TeamScoutSurvey_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_teamScoutSurvey]
    ON [dbo].[TeamScoutSurvey]([teamId] ASC, [gameId] ASC);

