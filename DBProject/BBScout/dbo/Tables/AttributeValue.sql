CREATE TABLE [dbo].[AttributeValue] (
    [id]           INT          IDENTITY (1, 1) NOT NULL,
    [attributeId]  INT          NOT NULL,
    [displayValue] VARCHAR (64) NOT NULL,
    [integerValue] INT          NULL,
    [sortOrder]    INT          NULL,
    [lastUpdated]  DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_AttributeValue_Attribute] FOREIGN KEY ([attributeId]) REFERENCES [dbo].[Attribute] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_AttributeValue]
    ON [dbo].[AttributeValue]([attributeId] ASC, [displayValue] ASC);


GO
-- Trigger to maintain last updated value of AttributeValue
CREATE trigger tr_av_LastUpdated on AttributeValue after insert, update
as
begin
	set nocount on
    update AttributeValue set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
