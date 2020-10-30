
CREATE TABLE Artist (
       artID serial NOT NULL,
       artName VARCHAR(255) NOT NULL,
       CONSTRAINT pk_artist PRIMARY KEY (artID),
       CONSTRAINT ck_artist UNIQUE (artName)	
);
	
CREATE TABLE CD (
       cdID serial NOT NULL,
       artID INT NOT NULL,
       cdTitle VARCHAR(255) NOT NULL,
       cdPrice REAL NOT NULL,
       cdGenre VARCHAR(255) NULL,
	   cdNumTracks INT NULL,
       CONSTRAINT pk_cd PRIMARY KEY (cdID),
       CONSTRAINT fk_cd_art FOREIGN KEY (artID) REFERENCES Artist (artID)
       ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO Artist (artID, artName) Values 
(6,'Animal Collective'), 
(3, 'Deadmau5'),
(7, 'Kings of Leon'), 
(4, 'Mark Ronson'),
(5, 'Mark Ronson & The Business Intl'),
(8, 'Maroon 5'), 
(2, 'Mr. Scruff'), 
(1, 'Muse');

--- CD

INSERT INTO CD (artID, cdTitle, cdPrice, cdGenre)
VALUES (1, 'Black Holes and Revelations', 9.99, 'Rock'),
(1, 'The Resistance ', 11.99, 'Rock'),
(2, 'Ninja Tuna ', 9.99, 'Electronica'),
(3, 'For Lack of a Better Name ', 9.99, 'Electro House'),
(4, 'Record Collection ', 11.99, 'Alternative Rock'),
(5, 'Version', 12.99, 'Pop'),
(6, 'Merriweather Post Pavilion', 12.99, 'Electronica'),
(7, 'Only By The Night', 9.99, 'Rock'),
(7, 'Come Around Sundown', 12.99, 'Rock'),
(8, 'Hands All Over', 11.99, 'Pop');



SELECT * FROM Artist;

SELECT * FROM CD;

-- List the artist names in alphabetical order [Output1].
SELECT artName FROM Artist order by artName ASC;

-- List the titles and prices of CDsin order of price from highest to lowest [Output 2].
SELECT cdTitle,cdPrice FROM CD order by cdPrice DESC;

--  List the titles and prices of CDsin order of price from lowest to highest [Output 3].
SELECT cdTitle,cdPrice FROM CD order by cdPrice ASC;

--  List the titles, genres and prices CDs in alphabetical order by genre, then by price from
-- the highest price to the lowest one [Output 4]
SELECT cdTitle,cdGenre,cdPrice FROM CD order by cdGenre ASC, cdPrice DESC;

-- • Find the lowest price of any CD [Output 5].
SELECT MIN(cdPrice) FROM CD;

-- • Find the number of CDs costing 11.99 [Output 6].
SELECT COUN(cdPrice) FROM CD WHERE cdPrice = 11.99; 

-- • Find the title of the most expensive rock CD(s) [Output 7].
SELECT cdTitle FROM CD WHERE cdPrice =
		(SELECT MAX(cdPRice) FROM CD WHERE cdGenre = 'Rock');
SELECT cdTitle FROM CD WHERE cdPrice = MAX AND cdGenre = 'Rock';

-- • Find the number of different Genres in the CD table [Output 8].
SELECT COUNT( DISTINCT cdGenre) FROM CD;

-- • List all the information about the cheapest CDs[Output 9].
SELECT * FROM CD WHERE cdPrice = (SELECT MIN(cdPrice) FROM CD);


-- • Find a list of artist names, the number of CDs they have produced, and the average price for
-- their CDs. Only return results for artists with more than one CD [Output 10].
SELECT artName, COUNT(CD.cdTitle) AS numOfCD, avg(CD.cdPrice) FROM Artist
INNER JOIN CD on Artist.artID = CD.artID
GROUP BY artName HAVING  COUNT(CD.cdTitle) > 1;


-- • Find a list of artist names, the number of CDs by that artist and the average price for their
-- CDs but not including ‘Electronica’ albums (you might like to use a WHERE in this one too) [Output 11].
SELECT artName, COUNT(CD.cdTitle), AVG(CD.cdPrice) FROM Artist
INNER JOIN CD on Artist.artID = CD.artID
WHERE cdTitle != 'Electronica' GROUP BY artName;


-- • Find the difference between the average price of an album by the artist ‘Muse’, and the
-- average price of all albums in the database (ABS() will produce the absolute value of a
-- calculation) [Output 12].
SELECT ABS((SELECT AVG(cdPrice) FROM CD INNER JOIN Artist on CD.artID = Artist.artID WHERE
artName = 'Muse') - ABS(AVG(cdPrice))) FROM CD

-- Find the most expensive genre of music by calculating the maximum of the averages of  all  genres [Output13].

SELECT cdGenre, avg(cdPrice) FROM CD
GROUP BY cdGenre HAVING max(cdPrice) > AVG(cdPrice) AND AVG(cdPrice) > 12;


-- Find the artist name(s)with the mostexpensive CDs by average[Output14]
SELECT artName FROM Artist
INNER JOIN CD on Artist.artID = CD.artID
GROUP BY artName HAVING AVG(CD.cdPrice) > MIN(CD.cdPrice);


