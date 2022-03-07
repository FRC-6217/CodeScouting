CREATE TABLE [dbo].[Event] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [name]        VARCHAR (128) NOT NULL,
    [location]    VARCHAR (128) NOT NULL,
    [eventCode]   VARCHAR (16)  NOT NULL,
    [lastUpdated] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Event]
    ON [dbo].[Event]([name] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_Event_2]
    ON [dbo].[Event]([eventCode] ASC);


GO
-- Trigger to maintain last updated value of Event
CREATE trigger tr_e_LastUpdated on Event after insert, update
as
begin
	set nocount on
    update Event set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
