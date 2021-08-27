CREATE TABLE [contact] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(50),
  [address] nvarchar(50),
  [phone] int,
  [mail] nvarchar(50),
  [linkedin] nvarchar(50)
)
GO

CREATE TABLE [entries] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(50),
  [postDate] datetime,
  [headline] nvarchar(50),
  [active] bit
)
GO

CREATE TABLE [blogPost] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [entryId] int,
  [text] nvarchar(MAX),
  [startDate] datetime,
  [endDate] datetime,
  [files] nvarchar(50)
)
GO

CREATE TABLE [frameworkReview] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [entryId] int,
  [text] nvarchar(MAX),
  [numberOfStars] int,
  [link] nvarchar(50),
  [headline] nvarchar(50),
  [active] bit,
  [postDate] datetime,
  [files] nvarchar(50)
)
GO

CREATE TABLE [reference] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [entryId] int,
  [text] nvarchar(MAX),
  [languages] nvarchar(50),
  [headline] nvarchar(50),
  [active] bit,
  [postDate] datetime,
  [files] nvarchar(50)
)
GO

CREATE TABLE [images] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [entryId] int,
  [name] nvarchar(50),
  [description] nvarchar(50),
  [path] nvarchar(50)
)
GO

CREATE TABLE [languages] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [referenceId] int,
  [name] nvarchar(50)
)
GO

CREATE TABLE [tags] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [entryId] int,
  [tags] nvarchar(50)
)
GO

ALTER TABLE [blogPost] ADD FOREIGN KEY ([entryId]) REFERENCES [entries] ([id])
GO

ALTER TABLE [frameworkReview] ADD FOREIGN KEY ([entryId]) REFERENCES [entries] ([id])
GO

ALTER TABLE [reference] ADD FOREIGN KEY ([entryId]) REFERENCES [entries] ([id])
GO

ALTER TABLE [images] ADD FOREIGN KEY ([entryId]) REFERENCES [entries] ([id])
GO

ALTER TABLE [languages] ADD FOREIGN KEY ([referenceId]) REFERENCES [reference] ([id])
GO

ALTER TABLE [tags] ADD FOREIGN KEY ([entryId]) REFERENCES [entries] ([id])
GO



CREATE PROCEDURE newContact
@name nvarchar(50),
@address nvarchar(50),
@phone nvarchar(50),
@mail nvarchar(50),
@linkedin nvarchar(50)
AS
INSERT INTO contact(name, address, phone, mail, linkedin)
VALUES (@name, @address, @phone, @mail, @linkedin)
GO

CREATE PROCEDURE blogPost
@text nvarchar(50),
@startDate datetime,
@endDate datetime,
@file nvarchar(50)
AS
INSERT INTO blogPost(text, startDate, endDate, files)
VALUES (@text, @startDate, @endDate, @file)
GO








