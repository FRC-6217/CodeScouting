CREATE TABLE [dbo].[Attribute] (
    [id]                 INT            IDENTITY (1, 1) NOT NULL,
    [gameId]             INT            NOT NULL,
    [name]               VARCHAR (64)   NOT NULL,
    [label]              VARCHAR (64)   NOT NULL,
    [scoringTypeId]      INT            NOT NULL,
    [lowRangeValue]      INT            NULL,
    [highRangeValue]     INT            NULL,
    [sortOrder]          INT            NOT NULL,
    [lastUpdated]        DATETIME       NULL,
    [tableHeader]        CHAR (64)      NOT NULL,
    [sameLineAsPrevious] CHAR (1)       NOT NULL,
    [defaultText]        VARCHAR (4000) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [fk_Attribute_Game] FOREIGN KEY ([gameId]) REFERENCES [dbo].[Game] ([id]),
    CONSTRAINT [fk_Attribute_ScoringType] FOREIGN KEY ([scoringTypeId]) REFERENCES [dbo].[ScoringType] ([id])
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Attribute]
    ON [dbo].[Attribute]([gameId] ASC, [name] ASC);


GO
-- Trigger to maintain last updated value of Attribute
CREATE trigger tr_a_LastUpdated on Attribute after insert, update
as
begin
	set nocount on
    update Attribute set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
