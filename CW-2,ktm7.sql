#F28DM CW2
#username = ktm7
#question 1
SELECT COUNT(*) Number_Of_Female_Actors FROM imdb_actors WHERE sex='F';
 
#question 2
SELECT * FROM imdb_movies ORDER BY year ASC LIMIT 1;
 
#question 3 
SELECT COUNT(*) Number_Of_Movies FROM (SELECT movieid, COUNT(directorid) count FROM imdb_movies2directors GROUP BY movieid HAVING count > 5) q;
 
#question 4
SELECT COUNT(*) NumberOfDirectors, title FROM imdb_movies2directors AS MD, imdb_movies AS M WHERE MD.movieid = M.movieid GROUP BY MD.movieid ORDER BY NumberOfDirectors DESC LIMIT 1;
 
#question 5
SELECT genre, SUM(time1) Total_Running_Time FROM imdb_movies2directors AS M2D, imdb_runningtimes AS RT WHERE  M2D.movieid = RT.movieid AND genre = 'Sci-Fi';
 
#question 6
SELECT COUNT(*) Number_Of_Movies FROM(SELECT title, count(title) count FROM imdb_actors JOIN  imdb_movies2actors AS MA ON MA.actorid = imdb_actors.actorid JOIN imdb_movies AS M ON MA.movieid = M.movieid WHERE name IN ('McGregor, Ewan', 'Carlyle, Robert (I)') group by title HAVING count >= 2)q;
 
#question 7**
SELECT COUNT(*) Number_Of_Movies FROM (SELECT COUNT(movieid), actorid count FROM `imdb_movies2actors` GROUP BY movieid HAVING count >= 10)p;
 
#question 8
SELECT COUNT(movieid) Number_Of_Movies, (FLOOR(year / 10) * 10) Decde FROM imdb_movies WHERE year >= 1960 GROUP BY FLOOR(year / 10);
 
#question 9
SELECT COUNT(*) Number_Of_Movies FROM  
(SELECT COUNT(movieid) fcount, movieid  FROM imdb_actors, imdb_movies2actors WHERE imdb_actors.actorid = imdb_movies2actors.actorid AND sex = 'F' GROUP BY movieid) F JOIN 
(SELECT COUNT(movieid) mcount,  movieid  FROM imdb_actors, imdb_movies2actors WHERE imdb_actors.actorid = imdb_movies2actors.actorid AND sex = 'M' GROUP BY movieid) M 
ON F.movieid = M.movieid WHERE fcount > mcount;
 
#question 10
SELECT genre, AVG(rank) AS average FROM imdb_ratings AS R, imdb_movies2directors AS MD WHERE R.movieid = MD.movieid AND votes >= 10000 GROUP BY genre ORDER BY average DESC LIMIT 1;
 
#question 11
SELECT name,COUNT(*) Number_Of_Genres FROM
(SELECT  genre, A.name
FROM imdb_actors AS A, imdb_movies2actors AS M2A, imdb_movies2directors AS M2D WHERE A.actorid = M2A.actorid 
AND M2D.movieid = M2A.movieid GROUP BY M2D.genre, A.actorid)p
GROUP BY name HAVING Number_Of_Genres >= 10;
 
#question 12
SELECT COUNT(*) Number_Of_Movies FROM 
( 
SELECT COUNT(*) 
FROM 
(SELECT  movieid, M2D.directorid,name FROM imdb.imdb_directors AS D, imdb.imdb_movies2directors AS M2D WHERE D.directorid = M2D.directorid) AS Directors
JOIN 
(SELECT name, movieid, A.actorid FROM imdb.imdb_movies2actors AS M2A, imdb.imdb_actors AS A WHERE M2A.actorid = A.actorid) AS Actors 
ON Actors.movieid = Directors.movieid 
JOIN 
(SELECT M2W.writerid, W.name, M2W.movieid FROM imdb.imdb_writers AS W, imdb.imdb_movies2writers as M2W WHERE W.writerid = M2W.writerid) as Writers 
ON Directors.movieid = Writers.movieid 
WHERE Directors.name = Actors.name AND Directors.name = Writers.name GROUP BY Directors.movieid 
)p;
 
#question 13
SELECT AVG(rank) AS average, (FLOOR(year/10)* 10) AS Decade FROM imdb_movies AS M, imdb_ratings AS R WHERE M.movieid = R.movieid GROUP BY FLOOR(year/10) ORDER BY average DESC LIMIT 1;
 
#question 14
SELECT DISTINCT genre, COUNT(movieid) Number_Of_Movies  FROM `imdb_movies2directors` WHERE genre is NULL;
 
#question 15
SELECT count(*) Number_Of_Movies 
FROM (SELECT count(*) AS records 
FROM (SELECT  movieid, M2D.directorid,name FROM imdb.imdb_directors AS D, imdb.imdb_movies2directors AS M2D WHERE D.directorid = M2D.directorid) AS Directors 
JOIN  
(SELECT name, movieid, A.actorid FROM imdb.imdb_movies2actors AS M2A, imdb.imdb_actors AS A WHERE M2A.actorid = A.actorid) AS Actors  
ON Actors.movieid = Directors.movieid  
JOIN  
(SELECT M2W.writerid, W.name, M2W.movieid FROM imdb.imdb_writers AS W, imdb.imdb_movies2writers as M2W WHERE W.writerid = M2W.writerid) as Writers  
ON Directors.movieid = Writers.movieid  
WHERE Directors.name = Writers.name AND NOT Directors.name = Actors.name GROUP BY Directors.movieid  HAVING records > 1)p;
 


