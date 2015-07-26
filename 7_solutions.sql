--1. List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962;

 --2. Give year of 'Citizen Kane'.

SELECT yr FROM movie WHERE title = 'Citizen Kane';

--3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr FROM movie WHERE title LIKE '%Star Trek%' ORDER BY yr;

--4. What are the titles of the films with id 11768, 11955, 21191

SELECT title FROM movie WHERE id IN (11768,11955, 21191); 

--5. What id number does the actress 'Glenn Close' have?

SELECT id FROM actor WHERE name = 'Glenn Close';

--6. What is the id of the film 'Casablanca'

SELECT id FROM movie WHERE title = 'Casablanca';

--7. Obtain the cast list for 'Casablanca'.

SELECT name FROM actor JOIN casting ON id=actorid WHERE movieid = 11768; 

--8. Obtain the cast list for the film 'Alien'

SELECT name FROM actor JOIN casting ON id = actorid WHERE movieid = (SELECT id FROM movie WHERE title = 'Alien');

--9. List the films in which 'Harrison Ford' has appeared

SELECT title FROM movie JOIN casting ON movieid = id WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford');

--10. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

SELECT title FROM movie JOIN casting ON movieid = id WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford') AND ord != 1;

--11. List the films together with the leading star for all 1962 films.

SELECT title, name FROM (actor JOIN casting ON  id = actorid) JOIN movie ON movie.id = movieid WHERE ord = 1 AND yr = 1962 GROUP BY title; 

--12. Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr, COUNT(*) FROM (actor JOIN casting ON actorid = actor.id) JOIN movie ON movieid = movie.id WHERE name = 'John Travolta' GROUP BY yr HAVING COUNT(*) > 2;

--13. List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT title, name
FROM (movie JOIN casting ON movie.id=movieid) JOIN actor on actor.id=actorid
WHERE ord=1 AND title IN(SELECT title
FROM (movie JOIN casting ON movie.id=movieid) JOIN actor on actor.id=actorid
WHERE name='Julie Andrews') AND movie.id IN(SELECT movie.id FROM(movie JOIN casting ON movie.id=movieid) JOIN actor on actor.id=actorid WHERE name='Julie Andrews')
ORDER BY name;

--14. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.

SELECT name FROM (actor JOIN casting ON actorid = actor.id) JOIN movie ON movieid = movie.id WHERE ord = 1 AND actor.id = actorid GROUP BY name HAVING count(*) >= 30;

--15. List the films released in the year 1978 ordered by the number of actors in the cast.

SELECT title, COUNT(actorid) FROM (movie JOIN casting ON movieid = movie.id) JOIN actor ON actor.id = actorid WHERE yr = 1978 GROUP BY title ORDER BY COUNT(actorid) DESC, movieid;

--16. List all the people who have worked with 'Art Garfunkel'.
SELECT name FROM (actor JOIN casting ON actorid = actor.id) JOIN movie ON movieid = movie.id WHERE movieid IN (SELECT movieid FROM  (actor JOIN casting ON actorid = actor.id) JOIN movie ON movieid = movie.id WHERE name = 'Art Garfunkel') AND name != 'Art Garfunkel';

