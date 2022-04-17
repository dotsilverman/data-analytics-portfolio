/* INFO: Unit 7 focused on CASE statements, creating views, and stored procedures. The three activities 
below are based on the ficticious island Basura and the mysql world databse.*/

# activity 2.7.1 
# task 1 - create a list of languages that are spoken by more than 10% of any country's poulation 
SELECT language FROM countrylanguage 
WHERE percentage > 10.0;

# task 2 - create a list of cities in the United States with populations 
# greater than one million
SELECT name FROM city 
WHERE countrycode = (SELECT code FROM country WHERE Name = 'United States')
AND population > 1000000;
-- -----------------------------------------------------------------------------------------
# activity 2.7.2 
# task 1 - create a view that lists every country with a surface area of less than 1500 sq/km
CREATE VIEW  tinycountries AS
SELECT name, surfacearea FROM country 
WHERE surfacearea < 1500; 

# task 2 - create a view that lists all countries that are federal republics 
CREATE VIEW federalrepublics_list AS 
SELECT code, name, population, headofstate, language FROM country 
JOIN countrylanguage 
ON country.code = countrylanguage.countrycode 
WHERE governmentform = 'Federal Republic';

-- -----------------------------------------------------------------------------------------
# activity 2.7.3 
# task 1 - create a procedure to display: code, name, continent, population, head of state 
DELIMITER $ 
CREATE PROCEDURE worLd.turtleman_check(IN user_country varchar(255)) 
BEGIN
SELECT code, name, continent, population, headofstate FROM world.country 
WHERE name LIKE(user_country);
END $

CALL world.turtleman_check('Brazil');
