CREATE TABLE [dbo].[ObjectiveGroup] (
    [id]          INT          IDENTITY (1, 1) NOT NULL,
    [name]        VARCHAR (64) NOT NULL,
    [sortOrder]   INT          NULL,
    [lastUpdated] DATETIME     NULL,
    [groupCode]   VARCHAR (32) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_ObjectiveGroup]
    ON [dbo].[ObjectiveGroup]([name] ASC, [groupCode] ASC);


GO
-- Trigger to maintain last updated value of ObjectiveGroup
CREATE trigger tr_og_LastUpdated on ObjectiveGroup after insert, update
as
begin
	set nocount on
    update ObjectiveGroup set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
