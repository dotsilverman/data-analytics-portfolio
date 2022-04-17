/*INFO: Module 6 of the SQL Unit focused on SELECT/INSERT INTO statments, subqueries, Null Values, and Functions. This 
activity uses the fictional island of Basura and the MySQL sample databaseworld. */ 
-- ----------------------------------------------------------------------------------------------------------------
# activity 2.6.1
# task 1 - Add basura's information to the country table in the world databse. 
INSERT INTO world.country 
VALUES ('BAS', 'Basura', 'Oceania', 'Polynesia', 450.0, 2005, 65000, 80.0, 1300.0, 1150.0, 'Basura', 'Federal Republic', 'Auntie A.', NULL, ' ');

SELECT * from world.country 
WHERE code like 'BAS';

# task 2 - update Basura's life extectancy from 80.0 to 79.9 
UPDATE world.country 
SET lifeexpectancy = 79.9
WHERE code = 'BAS';

# task 3 - create a list of the tp five countries with the highest life expectancies and what those life expectancies are
SELECT name, lifeexpectancy FROM world.country 
ORDER BY lifeexpectancy DESC 
LIMIT 5;
-- -------------------------------------------------------------------------
# activity 2.6.2
# task 1 - create two lists of invitees for "Basurafest": one listing countries that are completely independent and the other 
# listing countries taht are either terriotires or colonies of a larger state
SELECT * FROM world.country 
WHERE name IN 
(SELECT name FROM world.country 
WHERE indepyear IS NULL
AND continent = 'Oceania');

# task 2 - createa list of languages spoken in: American Samoa, Kiribati, and Tonga 
SELECT language, name FROM world.countrylanguage 
JOIN country 
ON countrylanguage.countrycode = country.code
WHERE name in ('American Samoa','Kiribati','Tonga');
-- --------------------------------------------------------------------------------------------
# activity 2.6.3 
# task 1 - identify the country with the smallest surface area 
SELECT name FROM world.country
WHERE surfacearea =
(SELECT MIN(surfacearea) FROM world.country);

# task 2 - write a query that returns any country with a surface area less than 1,500 sq km and a 
# GNP higher than the average country's GNP 
SELECT * FROM world.country 
WHERE GNP > (SELECT AVG(GNP) FROM world.country) 
AND surfacearea < 15000;

# task 3 - find the nation with the largest population  
SELECT name FROM world.country 
WHERE population = (SELECT MAX(population) FROM world.country); 

