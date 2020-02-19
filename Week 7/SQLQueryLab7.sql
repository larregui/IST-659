/*
	Name: Laura Larregui
	Date: 2/19/2020
	Lab 07: Advanced Query
*/

--Exploratory Data Analysis

SELECT 
	vc_User.UserName
	, vc_User.EmailAddress
	, vc_VidCast.vc_VidCastID
FROM vc_VidCast
JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
ORDER BY vc_User.UserName

-- BASIC SUMMARIES
-- LOOK FOR USER THAT DON'T HAVE VIDEOS
SELECT * FROM vc_User 
WHERE vc_UserID NOT IN (SELECT vc_UserID FROM vc_VidCast)
--INCLUDES ALL USERS
SELECT 
	vc_User.UserName
	, vc_User.EmailAddress
	, vc_VidCast.vc_VidCastID
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
ORDER BY vc_User.UserName
-- HIGH-LEVEL DESCRIPTIVE STATS 
SELECT
	COUNT(vc_VidCastID) as NumberOfVidCasts
	, SUM(ScheduleDurationMinutes) as TotalScheduledMinutes
	, MIN(ScheduleDurationMinutes) as MinScheduledMinutes
	, AVG(ScheduleDurationMinutes) as AvgScheduledMinutes
	, MAX(ScheduleDurationMinutes) as MaxScheduledMinutes
FROM vc_VidCast
--GROUP BY CLAUSE
SELECT 
	vc_User.UserName
	, vc_User.EmailAddress
	, COUNT(vc_VidCast.vc_VidCastID) AS CountOfVidCasts
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
GROUP BY vc_User.UserName, vc_User.EmailAddress
ORDER BY CountOfVidCasts DESC, vc_User.UserName 
--HAVING CLAUSE
SELECT 
	vc_User.UserName
	, vc_User.EmailAddress
	, COUNT(vc_VidCast.vc_VidCastID) AS CountOfVidCasts
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
GROUP BY vc_User.UserName, vc_User.EmailAddress
HAVING COUNT(vc_VidCast.vc_VidCastID) <10
ORDER BY CountOfVidCasts DESC, vc_User.UserName 
-- more EDA
SELECT 
	vc_User.UserName
	, vc_User.EmailAddress
	, SUM(DATEDIFF(n, StartDateTime, EndDateTime)) AS SumActualDurationMinutes
FROM vc_VidCast
JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
JOIN vc_Status ON vc_Status.vc_StatusID = vc_VidCast.vc_StatusID
WHERE vc_Status.StatusText='Finished'
GROUP BY vc_User.UserName, vc_User.EmailAddress
ORDER BY vc_User.UserName
-- Part 2: Putting All together
SELECT 
	vc_User.UserName
	, vc_User.EmailAddress
	, SUM(DATEDIFF(n, StartDateTime, EndDateTime)) as SumActualDurationMinutes
	, COUNT(vc_VidCast.vc_VidCastID) AS CountOfVidCasts
	, MIN(DATEDIFF(n, StartDateTime, EndDateTime)) as MinActualDurationMinutes
	, AVG(DATEDIFF(n, StartDateTime, EndDateTime)) as AvgActualDurationMinutes
	, MAX(DATEDIFF(n, StartDateTime, EndDateTime)) as MaxActualDurationMinutes
FROM vc_VidCast
RIGHT JOIN vc_User ON vc_User.vc_UserID = vc_VidCast.vc_UserID
GROUP BY vc_User.UserName, vc_User.EmailAddress
ORDER BY CountOfVidCasts DESC, vc_User.UserName
