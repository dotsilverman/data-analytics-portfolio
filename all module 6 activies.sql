# activity 2.6.1
# task 1
INSERT INTO world.country 
VALUES ('BAS', 'Basura', 'Oceania', 'Polynesia', 450.0, 2005, 65000, 80.0, 1300.0, 1150.0, 'Basura', 'Federal Republic', 'Auntie A.', NULL, ' ');

SELECT * from world.country 
WHERE code like 'BAS';

# task 2 
UPDATE world.country 
SET lifeexpectancy = 80.0
WHERE code = 'BAS';

# task 3
SELECT name, lifeexpectancy FROM world.country 
ORDER BY lifeexpectancy DESC 
LIMIT 5;

# activity 2.6.2
# task 1 
SELECT * FROM world.country 
WHERE name IN 
(SELECT name FROM world.country 
WHERE indepyear IS NULL
AND continent = 'Oceania');

# task 2 
SELECT language, name FROM world.countrylanguage 
JOIN country 
ON countrylanguage.countrycode = country.code
WHERE name in ('American Samoa','Kiribati','Tonga');

# activity 2.6.3 
# task 1 
SELECT name FROM world.country
WHERE surfacearea =
(SELECT MIN(surfacearea) FROM world.country);

# task 2 
SELECT * FROM world.country 
WHERE GNP > (SELECT AVG(GNP) FROM world.country) 
AND surfacearea < 15000;

# task 3
SELECT name FROM world.country 
WHERE population = (SELECT MAX(population) FROM world.country); 


