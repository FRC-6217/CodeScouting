CREATE TABLE [dbo].[Scout] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [lastName]     VARCHAR (128)    NOT NULL,
    [firstName]    VARCHAR (128)    NOT NULL,
    [teamId]       INT              NOT NULL,
    [isActive]     CHAR (1)         NOT NULL,
    [lastUpdated]  DATETIME         NULL,
    [emailAddress] VARCHAR (128)    NULL,
    [isAdmin]      CHAR (1)         NOT NULL,
    [scoutGUID]    UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_Scout_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_scout]
    ON [dbo].[Scout]([lastName] ASC, [firstName] ASC);


GO
CREATE NONCLUSTERED INDEX [idx2_scout]
    ON [dbo].[Scout]([emailAddress] ASC);


GO
-- Trigger to maintain last updated value of Scout
CREATE trigger tr_s_LastUpdated on Scout after insert, update
as
begin
	set nocount on
    update Scout set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
