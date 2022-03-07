CREATE TABLE [dbo].[ObjectiveGroupObjective] (
    [id]               INT      IDENTITY (1, 1) NOT NULL,
    [objectiveGroupId] INT      NOT NULL,
    [objectiveId]      INT      NOT NULL,
    [lastUpdated]      DATETIME NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_ObjectiveGroupObjective_Objective] FOREIGN KEY ([objectiveId]) REFERENCES [dbo].[Objective] ([id]),
    CONSTRAINT [fk_ObjectiveGroupObjective_ObjectiveGroup] FOREIGN KEY ([objectiveGroupId]) REFERENCES [dbo].[ObjectiveGroup] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_ObjectiveGroupObjective]
    ON [dbo].[ObjectiveGroupObjective]([objectiveGroupId] ASC, [objectiveId] ASC);


GO
-- Trigger to maintain last updated value of ObjectiveGroupObjective
create trigger tr_ogo_LastUpdated on ObjectiveGroupObjective after insert, update
as
begin
	set nocount on
    update ObjectiveGroupObjective set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
