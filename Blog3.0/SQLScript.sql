﻿DROP TABLE IF EXISTS contact
GO
DROP TABLE IF EXISTS tags
GO
DROP TABLE IF EXISTS images
GO
DROP TABLE IF EXISTS languages
GO
DROP TABLE IF EXISTS blogPost
GO
DROP TABLE IF EXISTS frameworkReview
GO
DROP TABLE IF EXISTS reference
GO
DROP TABLE IF EXISTS entries
GO



CREATE TABLE [contact] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(50),
  [address] nvarchar(50),
  [phone] nvarchar(10),
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
  [files] nvarchar(50),
  [type] nvarchar(50)
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
  [files] nvarchar(50),
  [type] nvarchar(50)
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
  [files] nvarchar(50),
  [type] nvarchar(50)
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

-- CREATE

DROP PROCEDURE IF EXISTS createContact
GO
CREATE PROCEDURE createContact
@name nvarchar(50),
@address nvarchar(50),
@phone nvarchar(10),
@mail nvarchar(50),
@linkedin nvarchar(50)
AS
INSERT INTO contact(name, address, phone, mail, linkedin)
VALUES (@name, @address, @phone, @mail, @linkedin)
GO

DROP PROCEDURE IF EXISTS createEntries
GO
CREATE PROCEDURE createEntries
@name nvarchar(50),
@postDate datetime,
@headline nvarchar(50),
@active bit
AS
INSERT INTO entries(name, postDate, headline, active)
VALUES (@name, @postDate, @headline, @active);
GO

DROP PROCEDURE IF EXISTS createBlogPost
GO
CREATE PROCEDURE createBlogPost
@text nvarchar(MAX),
@startDate datetime,
@endDate datetime,
@files nvarchar(50),
@type nvarchar(50)
AS
INSERT INTO blogPost(text, startDate, endDate, files, type)
VALUES (@text, @startDate, @endDate, @files, @type)
GO

DROP PROCEDURE IF EXISTS createFrameworkReview
GO
CREATE PROCEDURE createFrameworkReview
@text nvarchar(MAX),
@numberOfStars int,
@link nvarchar(50),
@headline nvarchar(50),
@postDate datetime,
@files nvarchar(50),
@type nvarchar(50)
AS
INSERT INTO frameworkReview(text, numberOfStars, link, headline, postDate, files, type)
VALUES(@text, @numberOfStars, @link, @headline, @postDate, @files, @type)
GO

DROP PROCEDURE IF EXISTS createReference
GO
CREATE PROCEDURE createReference
@text nvarchar(MAX),
@headline nvarchar(50),
@postDate datetime,
@files nvarchar(50),
@type nvarchar(50)
AS
INSERT INTO reference (text, headline, postDate, files, type)
VALUES (@text, @headline, @postDate, @files, @type)
GO

DROP PROCEDURE IF EXISTS createLanguages
GO
CREATE PROCEDURE createLanguages
@name nvarchar(50)
AS
INSERT INTO languages(name)
VALUES(@name)
GO

DROP PROCEDURE IF EXISTS createTags
GO
CREATE PROCEDURE createTags
@tag nvarchar(50)
AS
INSERT INTO tags (tags)
VALUES (@tag)
GO

DROP PROCEDURE IF EXISTS createImages
GO
CREATE PROCEDURE createImages
@name nvarchar(50),
@description nvarchar(MAX),
@path nvarchar(50)
AS
INSERT INTO images (name, description, path)
VALUES(@name, @description, @path)
GO

-- GET information
-- Since there is only one contact there is no need for any where statement
DROP PROCEDURE IF EXISTS getContact
GO
CREATE PROCEDURE getContact
AS
SELECT *
FROM contact
GO

DROP PROCEDURE IF EXISTS getAllPosts
GO
CREATE PROCEDURE getAllPosts
AS
SELECT *
FROM entries
INNER JOIN reference 
ON entries.id = reference.entryId
INNER JOIN languages
ON reference.id = languages.referenceId
INNER JOIN frameworkReview
ON entries.id = frameworkReview.entryId
INNER JOIN blogPost
ON entries.id = blogPost.entryId
INNER JOIN tags
ON entries.id = tags.entryId
INNER JOIN images
ON entries.id = images.entryId
GO

--UPDATE information

DROP PROCEDURE IF EXISTS updateContact
GO
CREATE PROCEDURE updateContact
@id int,
@name nvarchar(50),
@address nvarchar(50),
@phone nvarchar(10),
@mail nvarchar(50),
@linkedin nvarchar(50)
AS
UPDATE contact
SET name=@name, address=@address, phone=@phone, mail=@mail, linkedin=@linkedin
WHERE id=@id
GO

DROP PROCEDURE IF EXISTS updateEntries
GO
CREATE PROCEDURE updateEntries
@id int,
@name nvarchar(50),
@headline nvarchar(50),
@active bit
AS
UPDATE entries
SET name=@name, headline=@headline, active=@active
WHERE id=@id
GO

DROP PROCEDURE IF EXISTS updateBlogPost
GO
CREATE PROCEDURE updateBlogPost
@id int,
@text nvarchar(MAX),
@startDate datetime,
@endDate datetime,
@files nvarchar(50)
AS
UPDATE blogPost
SET text=@text, startDate=@startDate, endDate=@endDate, files=@files
WHERE id=@id
GO

DROP PROCEDURE IF EXISTS updateFrameworkReview
GO
CREATE PROCEDURE updateFrameworkReview
@id int,
@text nvarchar(MAX),
@numberOfStars int,
@link nvarchar(50),
@headline nvarchar(50),
@postDate datetime,
@files nvarchar(50)
AS
UPDATE frameworkReview
SET text=@text, numberOfStars=@numberOfStars, link=@link, headline=@headline, files=@files
WHERE id=@id
GO

DROP PROCEDURE IF EXISTS updateReference
GO
CREATE PROCEDURE updateReference
@id int,
@text nvarchar(MAX),
@headline nvarchar(50),
@postDate datetime,
@files nvarchar(50)
AS
UPDATE reference
SET text=@text, headline=@headline, files=@files
WHERE id=@id
GO

DROP PROCEDURE IF EXISTS updatelanguages
GO
CREATE PROCEDURE updatelanguages
@id int,
@name nvarchar(50)
AS
UPDATE languages
SET name=@name
WHERE id=@id
GO

DROP PROCEDURE IF EXISTS updateTags
GO
CREATE PROCEDURE updateTags
@id int,
@tags nvarchar(50)
AS
UPDATE tags
SET tags=@tags
WHERE id=@id
GO

DROP PROCEDURE IF EXISTS updateImages
GO
CREATE PROCEDURE updateImages
@id int,
@name nvarchar(50),
@description nvarchar(50),
@path nvarchar(50)
AS
UPDATE images
SET name=@name, description=@description, path=@path
WHERE id=@id
GO













