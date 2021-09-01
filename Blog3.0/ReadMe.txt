# Blog Project
##### Author: Benjamin Lank
#### Description:
##### Console project (No UI) with database. 

#### Navigation menu:
ChangeLog:  
- [Version 4](#Version-4).  
- [Version 3](#Version-3).  
- [Version 2](#Version-2).  
- [Version 1](#Version-1).  
- [Setup](#Setup).


## Console menu.
### Short description of each method

	1. CreateBlogPost
		* Creates an entry as blog. storing information into the database over multiple tables.
		* As there isn't an UI there is no way at the moment to upload a file so we give it a random path that doesn't go to anything.
	2. GetAllBlogPosts
		* Pulls all Blog posts from database, inserting them into a list.
	3. UpdateBlogPost
		* As there isn't an UI where you can select a specific post, we just go from the ID that have been inserterd
		* Updates the specific post with the information you have decided
	

## ChangeLog.
### All changes will be added to this section.

###### 31/8/21
#### Version 4

###### Updated tables in database because of keyword problems.

##### Changed.
	
	* SQL script to create the correct tables with the right column names.

##### Removed.
	
	* Some SP in the SQL script.

---
###### 28/8/21
#### Version 3

###### Able to get all posts

##### Added.

	* GetAllPosts method

##### Changed.

##### Removed.

---
###### 27/8/21
#### Version 2

###### Able to update posts

##### Added.

	* UpdateBlogPosts Method

---
###### 25/8/21
#### Version 1

###### Able to create Posts

##### Added.
	
	* CreateBlogPost method
	* Appropiated properties 

##### Changed.

	* SQL Script (Create SP's & Get SP's)

---

###### 23/8/21
#### Setup

###### Setup of database, SP and Classes.

#### Added.

	* Model and UoW folder together with appropiated classes.
	* Interfaces.
	* SQL Script
	* SP
	* Database
	* Connection string to DB


	



