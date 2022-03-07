CREATE TABLE [dbo].[ScoringType] (
    [id]           INT          IDENTITY (1, 1) NOT NULL,
    [name]         VARCHAR (64) NOT NULL,
    [hasValueList] CHAR (1)     NOT NULL,
    [lastUpdated]  DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_ScoringType]
    ON [dbo].[ScoringType]([name] ASC);


GO
-- Trigger to maintain last updated value of ScoringType
CREATE trigger tr_st_LastUpdated on ScoringType after insert, update
as
begin
	set nocount on
    update ScoringType set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
