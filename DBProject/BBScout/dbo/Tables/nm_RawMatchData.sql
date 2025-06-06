﻿CREATE TABLE [dbo].[nm_RawMatchData] (
    [id]                     INT             IDENTITY (1, 1) NOT NULL,
    [ScoutName]              VARCHAR (128)   NULL,
    [ScoutTeam]              VARCHAR (128)   NULL,
    [MatchType]              VARCHAR (128)   NULL,
    [MatchNumber]            INT             NULL,
    [DriverStation]          VARCHAR (128)   NULL,
    [TeamNumber]             INT             NULL,
    [StartingPosition]       VARCHAR (128)   NULL,
    [Leave]                  VARCHAR (128)   NULL,
    [aCoralL4]               INT             NULL,
    [aCoralL3]               INT             NULL,
    [aCoralL2]               INT             NULL,
    [aCoralL1]               INT             NULL,
    [aAlgaeProc]             INT             NULL,
    [aAlgaeNet]              INT             NULL,
    [toAlgaeProc]            INT             NULL,
    [toAlgaeNet]             INT             NULL,
    [toCoralL4]              INT             NULL,
    [toCoralL3]              INT             NULL,
    [toCoralL2]              INT             NULL,
    [toCoralL1]              INT             NULL,
    [egClimbTimer]           NUMERIC (12, 2) NULL,
    [egPosition]             VARCHAR (128)   NULL,
    [egComments]             VARCHAR (1024)  NULL,
    [Defense]                VARCHAR (128)   NULL,
    [RobotDisabled]          VARCHAR (128)   NULL,
    [RobotTipped]            VARCHAR (128)   NULL,
    [Card]                   VARCHAR (128)   NULL,
    [Comments]               VARCHAR (1024)  NULL,
    [CorrectedMatchNumber]   INT             NULL,
    [CorrectedDriverStation] VARCHAR (128)   NULL,
    [Skip]                   INT             NULL
);

