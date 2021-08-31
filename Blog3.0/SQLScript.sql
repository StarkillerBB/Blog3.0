﻿DROP TABLE IF EXISTS contact
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
DROP TABLE IF EXISTS tags
GO
DROP TABLE IF EXISTS images
GO

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
  [entryname] nvarchar(50),
  [postDate] datetime,
  [headline] nvarchar(50),
  [entrytext] nvarchar(MAX),
  [files] nvarchar(50),
  [active] bit,
  [tagsId] int,
  [imagesId] int,
)
GO

CREATE TABLE [blogPost] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [bEntryId] int,
  [startDate] datetime,
  [endDate] datetime,
  [postType] nvarchar(50)
)
GO

CREATE TABLE [frameworkReview] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [fEntryId] int,
  [numberOfStars] int,
  [link] nvarchar(50),
  [postType] nvarchar(50)
)
GO

CREATE TABLE [reference] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [rEntryId] int,
  [postType] nvarchar(50)
)
GO

CREATE TABLE [images] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [imagename] nvarchar(50),
  [imagedescription] nvarchar(50),
  [imagepath] nvarchar(50)
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
  [tags] nvarchar(50)
)
GO

ALTER TABLE [entries] ADD FOREIGN KEY ([tagsId]) REFERENCES [tags] ([id])
GO

ALTER TABLE [entries] ADD FOREIGN KEY ([imagesId]) REFERENCES [images] ([id])
GO

ALTER TABLE [reference] ADD FOREIGN KEY ([rEntryId]) REFERENCES [entries] ([id])
GO

ALTER TABLE [frameworkReview] ADD FOREIGN KEY ([fEntryId]) REFERENCES [entries] ([id])
GO

ALTER TABLE [blogpost] ADD FOREIGN KEY ([bEntryId]) REFERENCES [entries] ([id])
GO

ALTER TABLE [languages] ADD FOREIGN KEY ([referenceId]) REFERENCES [reference] ([id])
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
@text nvarchar(MAX),
@files nvarchar(50),
@active bit,
@tagsId int,
@imageId int
AS
INSERT INTO entries(entryname, postDate, headline, entrytext, files, active, tagsId, imagesId)
VALUES (@name, @postDate, @headline, @text, @files, @active, @tagsId, @imageId);
GO

DROP PROCEDURE IF EXISTS createBlogPost
GO
CREATE PROCEDURE createBlogPost
@bEntryId int,
@startDate datetime,
@endDate datetime,
@postType nvarchar(50)
AS
INSERT INTO blogPost(startDate, endDate, postType, bEntryId)
VALUES (@startDate, @endDate, @postType, @bEntryId)
GO

DROP PROCEDURE IF EXISTS createFrameworkReview
GO
CREATE PROCEDURE createFrameworkReview
@fEntryId int,
@numberOfStars int,
@link nvarchar(50),
@postType nvarchar(50)
AS
INSERT INTO frameworkReview(numberOfStars, link, postType, fEntryId)
VALUES(@numberOfStars, @link, @postType, @fEntryId)
GO

DROP PROCEDURE IF EXISTS createReference
GO
CREATE PROCEDURE createReference
@rEntryId int,
@postType nvarchar(50)
AS
INSERT INTO reference (postType, rEntryId)
VALUES (@postType, @rEntryId)
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
@tags nvarchar(50)
AS
INSERT INTO tags (tags)
VALUES (@tags)
GO

DROP PROCEDURE IF EXISTS createImages
GO
CREATE PROCEDURE createImages
@name nvarchar(50),
@description nvarchar(MAX),
@path nvarchar(50)
AS
INSERT INTO images (imagename, imagedescription, imagepath)
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

DROP PROCEDURE IF EXISTS getAllBlogPosts
GO
CREATE PROCEDURE getAllBlogPosts
AS
SELECT *
FROM entries
INNER JOIN blogPost
ON entries.id = blogPost.bEntryId
INNER JOIN tags
ON tags.id = entries.tagsId
INNER JOIN images
ON images.id = entries.imagesId
GO

DROP PROCEDURE IF EXISTS getAllFrameworkReviews
GO
CREATE PROCEDURE getAllFrameworkReviews
AS
SELECT *
FROM entries
INNER JOIN frameworkReview
ON entries.id = frameworkReview.fEntryId
INNER JOIN tags
ON tags.id = entries.tagsId
INNER JOIN images
ON images.id = entries.imagesId
GO

DROP PROCEDURE IF EXISTS getAllReference
GO
CREATE PROCEDURE getAllReference
AS
SELECT *
FROM entries
INNER JOIN reference
ON entries.id = reference.rEntryId
INNER JOIN tags
ON tags.id = entries.tagsId
INNER JOIN images
ON images.id = entries.imagesId
INNER JOIN languages
ON reference.id = languages.referenceId
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
@text nvarchar(MAX),
@files nvarchar(50),
@active bit
AS
UPDATE entries
SET entryname=@name, headline=@headline, entrytext=@text, files=@files, active=@active
WHERE id=@id
GO

DROP PROCEDURE IF EXISTS updateBlogPost
GO
CREATE PROCEDURE updateBlogPost
@id int,
@startDate datetime,
@endDate datetime
AS
UPDATE blogPost
SET startDate=@startDate, endDate=@endDate
WHERE id=@id
GO

DROP PROCEDURE IF EXISTS updateFrameworkReview
GO
CREATE PROCEDURE updateFrameworkReview
@id int,
@numberOfStars int,
@link nvarchar(50)
AS
UPDATE frameworkReview
SET numberOfStars=@numberOfStars, link=@link
WHERE id=@id
GO

DROP PROCEDURE IF EXISTS updateReference
GO
CREATE PROCEDURE updateReference
@id int,
@postType nvarchar(50)
AS
UPDATE reference
SET postType=@postType
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
SET imagename=@name, imagedescription=@description, imagepath=@path
WHERE id=@id
GO




