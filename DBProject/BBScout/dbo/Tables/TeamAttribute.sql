CREATE TABLE [dbo].[TeamAttribute] (
    [id]           INT             IDENTITY (1, 1) NOT NULL,
    [teamId]       INT             NOT NULL,
    [attributeId]  INT             NOT NULL,
    [integerValue] INT             NULL,
    [decimalValue] DECIMAL (18, 2) NULL,
    [textValue]    VARCHAR (4000)  NULL,
    [lastUpdated]  DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_TeamAttribute_Attribute] FOREIGN KEY ([attributeId]) REFERENCES [dbo].[Attribute] ([id]),
    CONSTRAINT [fk_TeamAttribute_Team] FOREIGN KEY ([teamId]) REFERENCES [dbo].[Team] ([id])
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_TeamAttribute]
    ON [dbo].[TeamAttribute]([teamId] ASC, [attributeId] ASC);


GO
-- Trigger to maintain last updated value of TeamAttribute
CREATE trigger tr_ta_LastUpdated on TeamAttribute after insert, update
as
begin
	set nocount on
    update TeamAttribute set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
