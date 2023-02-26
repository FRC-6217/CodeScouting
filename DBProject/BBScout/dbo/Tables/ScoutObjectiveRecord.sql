CREATE TABLE [dbo].[ScoutObjectiveRecord] (
    [id]            INT             IDENTITY (1, 1) NOT NULL,
    [scoutRecordId] INT             NOT NULL,
    [objectiveId]   INT             NOT NULL,
    [integerValue]  INT             NULL,
    [decimalValue]  DECIMAL (18, 2) NULL,
    [textValue]     VARCHAR (4000)  NULL,
    [scoreValue]    INT             NULL,
    [lastUpdated]   DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_ScoutObjectiveRecord_Objective] FOREIGN KEY ([objectiveId]) REFERENCES [dbo].[Objective] ([id]),
    CONSTRAINT [fk_ScoutObjectiveRecord_ScoutRecord] FOREIGN KEY ([scoutRecordId]) REFERENCES [dbo].[ScoutRecord] ([id]) ON DELETE CASCADE
);






GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_ScoutObjectiveRecord]
    ON [dbo].[ScoutObjectiveRecord]([scoutRecordId] ASC, [objectiveId] ASC);


GO

-- Trigger to maintain scoreValue after insert/update of Scout Objective Record
CREATE trigger tr_SOR_CalcScoreValue on ScoutObjectiveRecord
after insert, update
as
begin
	set nocount on
    update ScoutObjectiveRecord
	   set scoreValue = (select dbo.calcScoreValue(i.objectiveId, i.integerValue, i.decimalValue)
	                       from inserted i
						  where i.id = ScoutObjectiveRecord.id)
		 , lastUpdated = getDate() at time zone 'UTC' at time zone 'Central Standard Time'
	 where ScoutObjectiveRecord.id in (select i.id from inserted i);
	set nocount off
end;
