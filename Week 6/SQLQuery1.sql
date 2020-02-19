--Adding a row to the vc_Status table
INSERT INTO vc_Status(StatusText)
VALUES ('Scheduled')
-- The following line shows all the rows of vc_Status
SELECT  * FROM vc_Status 
--Adding three more values to the vc_Status table
INSERT INTO vc_Status(StatusText)
VALUES ('Started'), ('Finished'), ('On Time')
INSERT INTO vc_VidCast
	(VidCastTitle, StartDateTime, EndDateTime, ScheduledDurationMinutes
	, RecordingURL, vc_UserID, vc_StatusID)
VALUES
	('December Snow', '3/1/2018 14:00', '3/1/2018 14:30', 30
	, '/XVF1234', 2, 3)

SELECT * FROM vc_User WHERE UserName= 'SaulHudson'
SELECT * FROM vc_Status WHERE StatusText= 'Finished'
SELECT * FROM vc_VidCast
SELECT 
	vc_User.UserName
	, vc_User.EmailAddress
	, vc_VidCast.VidCastTitle
	, vc_VidCast.StartDateTime
	, vc_VidCast.EndDateTime
	, vc_VidCast.ScheduledDurationMinutes/60.0 as ScheduledHours
	, vc_Status.StatusText
FROM vc_VidCast
JOIN vc_User ON vc_VidCast.vc_UserID=vc_User.vc_UserID
JOIN vc_Status ON vc_VidCast.vc_StatusID=vc_Status.vc_StatusID
WHERE vc_User.UserName ='SaulHudson'
ORDER BY vc_VidCast.StartDateTime
-- Correcting a User's UserRegisteredDate
UPDATE vc_User SET UserRegisteredDate='3/1/2018' WHERE UserName='SaulHudson'
SELECT * FROM vc_User WHERE UserName='SaulHudson'
--Deleting from table
SELECT * FROM vc_Status
DELETE vc_Status WHERE StatusText='On Time'
SELECT * FROM vc_Tag
INSERT INTO vc_Tag
	(TagText, TagDescription)
VALUES
	('Personal', 'About people'),('Professional','Business, business, business'),('Sports','All manner of sports'),
	('Music','Music analysis, news, and thoughts'),('Games','Live streaming our favorite games')
SELECT * FROM vc_User
INSERT INTO vc_User
	(UserName, EmailAddress, UserDescription)
VALUES
	('TheDoctors', 'tomBaker@nodomain.xyz', 'The definite article'),('HairCut','S.todd@nodomain.xyz', 'Fleet Street barber shop'),('DnDGal','dnd@nodomain.xyz','NULL')
SELECT * FROM vc_User

--User Tag List

INSERT INTO vc_UserTagList (vc_UserID, vc_TagID) 
VALUES  
	((SELECT vc_UserID FROM vc_User WHERE UserName='DnDGal'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Sports')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='DnDGal'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Professional')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='RDwight'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Professional')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='SaulHudson'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Sports')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='Gordon'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Personal')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='DnDGal'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Personal')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='Gordon'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Games')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='HairCut'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Professional')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='TheDoctors'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Music')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='DnDGal'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Games')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='SaulHudson'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Games')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='Gordon'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Professional')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='HairCut'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Music')),  
	((SELECT vc_UserID FROM vc_User WHERE UserName='TheDoctors'),  
	(SELECT vc_TagID FROM vc_Tag WHERE TagText='Personal'))
SELECT * FROM vc_UserTagList

-- User Tags Report
SELECT 
	vc_User.UserName,
	vc_User.EmailAddress,
	vc_Tag.TagText
FROM vc_UserTagList
JOIN vc_User ON vc_UserTagList.vc_UserID=vc_User.vc_UserID
JOIN vc_Tag ON vc_UserTagList.vc_TagID=vc_Tag.vc_TagID
ORDER BY vc_User.UserName, vc_Tag.TagText
