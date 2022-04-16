# activity 2.7.3 

# task 3 - create a procedure to display the following information about any user-defined
# country: code, name, continent, population, head of state 

DELIMITER $ 
CREATE PROCEDURE worLd.turtleman_check(IN user_country varchar(255)) 
BEGIN
SELECT code, name, continent, population, headofstate FROM world.country 
WHERE name LIKE(user_country);
END $

CALL world.turtleman_check('Brazil');
