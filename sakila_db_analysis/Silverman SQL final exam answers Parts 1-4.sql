-- Dot Silverman's SQL and Databases Final 

-- -------------------------------------------------------
/* Part 1, Task 1 - Write a query that shows bands & their respective albums’ release date in descending order. 
First, explore the data */

SELECT bandname, releasedate FROM band_db.band 
JOIN band_db.album 
ON band.idband = album.idband 
ORDER BY releasedate DESC;

-- -------------------------------------------------------
/* Part 1, Task 2 - Some venues request bands that feature certain instruments. 
Write a query that shows all of the players that utilize drums along with the bands 
that they are a part of. You should only have one column that shows the full 
player name (i.e., the player’s first and last name should not be split into two columns). */

# testing to make sure it works 
SELECT CONCAT(pfname,' ', plname) AS drummers, instrument FROM player
JOIN instrument
ON player.InstID = instrument.InstID
WHERE instrument like '%drums%';

# final query 
SELECT CONCAT(pfname,' ', plname) AS drummer, bandname FROM player
JOIN instrument
ON player.InstID = instrument.InstID
JOIN band 
ON player.idband = band.idband
WHERE instrument like '%drums%';

-- -------------------------------------------------------------------------------------------
/* Part 1, Task 3 - Write a query that describes the number of instruments used by each
band. */ 

/* checking to see how some bands may have multple players using the same instrument
I honestly don't see this scenario in this data. 
 */
SELECT instrument.instid, player.idplayer, player.idband FROM instrument 
JOIN player 
ON player.instid = instrument.instid 
JOIN band 
ON player.idband = band.idband;

# query 
SELECT COUNT(instrument), bandname FROM instrument 
JOIN player 
ON player.instid = instrument.instid 
JOIN band 
ON player.idband = band.idband
GROUP BY bandname;

-- -------------------------------------------------------------------------------------------
/* Part 1, Task 4 - Write a query that list the most popular instrument amongst the players */ 

# query
SELECT instrument, COUNT(instrument) AS instrument_count FROM instrument 
JOIN player 
ON player.instid = instrument.instid
GROUP BY instrument
ORDER BY COUNT(instrument) DESC 
LIMIT 1;

-- -------------------------------------------------------------------------------------------
/* Part 1, Task 5 - Write a query that describes the number of instruments used by each
band. */ 
SELECT * FROM album
WHERE albumname IS NULL OR releasedate IS NULL;

/* MY FINDINGS: from this last query, it appears that idalubm 5 and 31 have NULL values. idalbum = 5 has a 
missing releasedate, and idalbum = 31 has a missing albumname and release date. 

/* IDEAS FOR HANDING NULL VALUES FOR idalbum = 5: idalbum = 5 is produed by idband = 2. It's one album is called "Slim Shady", by Eminem. My only 
idea is to google the start and finish of Eminem's career and take the average of that to create a false release date. He 
began his career in 1988, and it's now 2022, so the middle of his career was 2005; 
*/
UPDATE album
SET releasedate = '2005-01-01'
WHERE idalbum = 5;

/* IDEAS FOR HANDING NULL VALUES FOR idalbum = 31: We don't know that album name, but that's ok. What we can figure out is a fake
release date. Luckily for us, the band producing this album (bandid=12) has produced other albums before. I will average the release dates
of their other albums to create a false release date. Note: I know there is a more elegant way to set the release date with 
subqueries, but I'm a little rushed right now. */
SELECT FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(releasedate))) FROM album
WHERE idband = 12;

UPDATE album 
SET releasedate = '1996-02-20'
WHERE idalbum = 31;

-- -------------------------------------------------------------------------------------------
/* Part 2, Task 1 - Add more bands to the band table  
*/ 
SELECT * FROM band;

INSERT INTO band(aid,bandname) VALUES
(1, 'Weezer'),
(1,'Paramore'),
(1,'Blackpink'),
(1,'Vampire Weekend');

-- -------------------------------------------------------------------------------------------
/* Part 2, Task 2 - Now that we have added more bands, we need to ensure that we add the band members
to the appropriate table. Which table would we use to add the names of band members?

ANSWER: player table 
*/ 

-- -------------------------------------------------------------------------------------------
/* Part 2, Task 3 - Using the table you identified in Task 2, add the following values
*/ 
SELECT * FROM player;

# I probs should have done with with subqueries... oh well. You'll see those in the next section 
INSERT INTO player (instid, idband, pfname, plname, homecity, homestate) VALUES 
	(3, 22, 'Rivers','Cuomo','Rochester','New York'), 
    (1, 22, 'Brian', 'Bell', 'Iowa City', 'Iowa'),
    (4, 22, 'Patrick', 'Wilson','Buffalo','New York'),
    (2, 22, 'Scott', 'Shriner', 'Toledo', 'Ohio'),
    (3, 23, 'Tionne', 'Watkins', 'Des Moines', 'Iowa'),
    (3, 23, 'Rozonda', 'Thomas', 'Columbus', 'Georgia'),
    (3, 24, 'Hayley', 'Williams', 'Franklin', 'Tennessee'),
    (1, 24, 'Taylor','York','Nashville','Tennessee'),
    (4, 24, 'Zac', 'Farro','Voorhees Township', 'New Jersey'),
    (1, 25, 'Jisoo','Kim', ' ', 'South Korea'),
    (1, 25, 'Jeannie', 'Kim', ' ', 'South Korea'), 
    (1, 25, 'Roseanne', 'Park', ' ', 'New Zealand'),
    (1, 25, 'Lisa', 'Manoban', ' ' , 'Thailand'),
    (1, 26, 'Ezra','Koenig','New York', 'New York'),
    (2, 26, 'Chris', 'Baio', 'Bronxwille','New York'),
    (4, 26, 'Chris', 'Tomson','Upper Freehold Township', 'New Jersey');

-- -------------------------------------------------------------------------------------------
/* Part 2, Task 4 - Drop Table Records has signed a contract with a new venue! A new venue should be added
to the venue table. */ 
INSERT INTO venue (vname, city, state, zipcode, seats) 
VALUES ('Twin City Rock House','Minneapolis','MN', '55414', 2000);

# test to see if query worked 
SELECT * FROM venue; 

-- -------------------------------------------------------------------------------------------
/* Part 2, Task 5 - Which state has the largest amount of seating available (regardless of the number of
venues at the state)?*/ 

SELECT state FROM venue 
WHERE seats = (
SELECT MAX(seats) FROM venue
);

-- -------------------------------------------------------------------------------------------
/* Part 3, Task 1 - We need to add some data on upcoming performances for some of the artists. Which table
should we use to add this information?

Answer = gig table 
*/

-- -------------------------------------------------------------------------------------------
/* Part 3, Task 2 - Using the table you mentioned in Task 1 (above), add the following information
*/  
INSERT INTO gig (idvenue, idband, gigdate, numattendees) VALUES
((SELECT idvenue FROM venue WHERE vname = 'TD Garden'), (SELECT idband FROM band WHERE bandname = 'Eminem'), '2022-05-05', 19000),
((SELECT idvenue FROM venue WHERE vname = 'Twin City Rock House'), (SELECT idband FROM band WHERE bandname = 'Vampire Weekend'), '2022-04-15', NULL),
((SELECT idvenue FROM venue WHERE vname = 'SAP'), (SELECT idband FROM band WHERE bandname = 'TLC'), '2022-06-07', 18000),
((SELECT idvenue FROM venue WHERE vname = 'The River Club'), (SELECT idband FROM band WHERE bandname = 'Weezer'), '2022-07-03', 175);

# test to make sure it worked 
SELECT * from gig; 

-- -------------------------------------------------------------------------------------------
/* Part 3, Task 3 - Are any of the venues oversold? */
SELECT vname FROM venue 
JOIN gig 
ON venue.idvenue = gig.idvenue 
WHERE numattendees > seats; 

-- -------------------------------------------------------------------------------------------
/* Part 3, Task 4 - We just got word that Vampire Weekend can expect 1,750 guests. Write a query to update
the table accordingly */
UPDATE gig 
SET numattendees = 1750 
WHERE gigid = 2;

-- -------------------------------------------------------------------------------------------
/* Part 3, Task 5 - We just got word that Vampire Weekend can expect 1,750 guests. Write a query to update
the table accordingly */
UPDATE gig 
SET numattendees = 125 
WHERE gigid = 4;

-- -------------------------------------------------------------------------------------------
/* Part 3, Task 6 - Create a view (called vw_giginfo) that will show the band, the dates they will play, the venue
they will play at, the number of attendees, and the venue capacity. For this view, also create
a column that describes what percentage of the venue capacity was utilized.
 */
 
# I'm missing TLC for some reason and I don't know why :( :( 
CREATE VIEW band_db.vw_giginfo AS 
SELECT bandname , gigdate `date` , vname `venue`, numattendees AS `number of attendees`, seats `venue capacity`, CASE 
WHEN numattendees < seats THEN numattendees/seats*100 
END AS `% capacity utilized`
FROM band 
JOIN gig 
ON band.idband = gig.idband
JOIN venue 
ON gig.idvenue = venue.idvenue;

# check to see if it worked 
SELECT * FROM vw_giginfo; 

-- -------------------------------------------------------------------------------------------
/* Part 4, Task 1 - Create a stored procedure that lists all of the venues that can handle more than 10,000
guests. */

DELIMITER $$
CREATE PROCEDURE band_db.big_venues()
BEGIN
SELECT vname FROM venue 
WHERE seats > 10000;
END $$

# check to see if it works 
CALL big_venues();
 
 -- -------------------------------------------------------------------------------------------
/* Part 4, Task 2 - Create a stored procedure that lists all of the players that come from a specific state. We
want to see (once we run this stored procedure), what bands they are a part of, their full
name (in one column), and the state they are from. */


DELIMITER $$
CREATE PROCEDURE band_db.players_from_state(IN user_term varchar(45))
BEGIN
	SELECT CONCAT(pfname, ' ', plname) AS player_name, bandname, homestate FROM player 
    JOIN band 
    ON player.idband = band.idband
    WHERE homestate = user_term;
END $$

# check to see if it works 
CALL players_from_state('Ireland');