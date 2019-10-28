CREATE TABLE [dbo].[ContactInfo]
(
	[ContactInfoId] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [FirstName] VARCHAR(100) NOT NULL,
    [LastName] VARCHAR(100) NOT NULL,
    [Email] VARCHAR(100) NOT NULL,
	SubscribeToLetter bit not null,
	[State] smallint not null
)
