-- Zach Dravis Assignment Two

DROP TABLE IF EXISTS Videos;
DROP TABLE IF EXISTS Reviews;

CREATE TABLE Videos(
VideoID INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
Title VARCHAR(100) NOT NULL,
MinutesLong INTEGER NOT NULL,
URL VARCHAR(100) NOT NULL
);

CREATE TABLE Reviews(
ReviewID INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
ReviewerName VARCHAR(40) NOT NULL,
Rating INTEGER,
VideoID INTEGER NOT NULL,
FOREIGN KEY(VideoID)
	REFERENCES Videos(VideoID),
Review VARCHAR(100)
);

INSERT INTO Videos(Title, MinutesLong, URL) VALUES('MySQL Beginner Tutorial 1 - Introduction to MySQL', 10, 'https://www.youtube.com/watch?v=nN4Kjdverzs');
INSERT INTO Videos(Title, MinutesLong, URL) VALUES('MySQL Tutorial 2 - Primary Keys', 5, 'https://www.youtube.com/watch?v=bzvEf4s9EOQ');
INSERT INTO Videos(Title, MinutesLong, URL) VALUES('MySQL tutorial 3 - Selecting stuff', 12, 'https://www.youtube.com/watch?v=AzZtsGGSkh8');

INSERT INTO Reviews(ReviewerName, Rating, VideoID, Review) VALUES('Zach', 3, 1, 'This is moderately helpful');
INSERT INTO Reviews(ReviewerName, Rating, VideoID, Review) VALUES('Jeff', 5, 2, 'This was the best tutorial I have ever seen!!');
INSERT INTO Reviews(ReviewerName, Rating, VideoID, Review) VALUES('Tyler', 1, 1, 'This video really did not help me at all.');
INSERT INTO Reviews(ReviewerName, Rating, VideoID, Review) VALUES('Zach', 4, 2, 'This video was much better than the last one I watched');

-- If we want to see only video titles and rating information that have reviews:
SELECT Videos.Title, Reviews.ReviewerName, Reviews.Rating, Reviews.Review
FROM Videos
INNER JOIN Reviews
ON Videos.VideoID = Reviews.VideoID;

-- If we want to see all video titles, minutes long, and rating information, regardless of if they have a review or not:
SELECT v.Title, v.MinutesLong, r.ReviewerName, r.Rating, r.Review
FROM Videos v
LEFT JOIN Reviews r
ON v.VideoID = r.VideoID;
