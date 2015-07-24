--1. Read the notes about this table. Observe the result of running a simple SQL command.

SELECT name, continent, population FROM world;

--2. Show the name for the countries that have a population of at least 200 million.

SELECT name FROM world
WHERE population>200000000;

--3. Give the name and the per capita GDP for those countries with a population of at least 200 million.

SELECT name, gdp/population FROM world WHERE population>200000000;

--4. Show the name and population in millions for the countries of the continent 'South America'.

SELECT name, population/1000000 FROM world WHERE continent = 'South America';

--5. Show the name and population for France, Germany, Italy

SELECT name, population FROM world WHERE name IN ('France', 'Germany', 'Italy');

--6. Show the countries which have a name that includes the word 'United'

SELECT name FROM world WHERE name LIKE '%united%';

--7. Show the countries that are big by area or big by population. Show name, population and area.

SELECT name, population, area FROM world WHERE area > 3000000 OR population > 250000000;

--8. Show the countries that are big by area or big by population but not both. Show name, population and area.

SELECT name, population, area FROM world WHERE (area > 3000000 AND population < 250000000) OR (population > 250000000 AND area < 3000000);

--9. For South America show population in millions and GDP in billions to 2 decimal places.

SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) FROM world WHERE continent = 'South America';

--10. Show per-capita GDP for the trillion dollar countries to the nearest $1000.

SELECT name, ROUND(gdp/population, -3) FROM world WHERE gdp > 1000000000000;

--11. Show the name and the continent - but substitute Australasia for Oceania - for countries beginning with N.

SELECT name, CASE WHEN continent='Oceania' THEN 'Australasia'
            ELSE continent END
  FROM world
 WHERE name LIKE 'N%';

 --12. Show the name and the continent - but substitute Eurasia for Europe and Asia; substitute America - for each country in North America or South America or Caribbean. Show countries beginning with A or B

SELECT name, CASE 
WHEN continent IN ('Europe', 'Asia') THEN 'Eurasia'
WHEN continent IN ('North America', 'South America', 'Caribbean') THEN 'America'
ELSE continent END
FROM world
WHERE name LIKE 'A%' OR name LIKE 'B%';

--13. Put the continents right...Oceania becomes Australasia Countries in Eurasia and Turkey go to Europe/Asia. Caribbean islands starting with 'B' go to North America, other Caribbean islands go to South America. Show the name, the original continent and the new continent of all countries.

SELECT name, continent, CASE 
WHEN continent = 'Oceania' THEN 'Australasia'
WHEN continent IN ('Eurasia', 'Turkey') THEN 'Europe/Asia'
WHEN continent = 'Caribbean' AND name LIKE 'B%' THEN 'North America'
WHEN continent = 'Caribbean' THEN 'South America'
ELSE continent END
FROM world
ORDER BY name;
