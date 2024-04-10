-- Basic Questions--

/*1.Write a query in SQL to find the name and year of the movies.*/

Select mov_title,mov_year from movie;

/*2.Write a query in SQL to find the year when the movie American Beauty was released.*/

Select mov_year from movie
where mov_title = 'American Beauty';

/*3. Write a query in SQL to find the movie which was released in the year 1999.*/

Select mov_title from movie
where mov_year = 1999;

/*4. Write a query in SQL to find the movies which were released before 1998.*/

Select mov_title,mov_year from movie
where mov_year > 1998;

/*5.Write a query in SQL to return the name of all reviewers and name of movies
together in a single list.*/

Select rev_name from reviewer
union
select mov_title from movie;

/*6. Write a query in SQL to find the name of all reviewers who have rated 7 or more
stars to their rating.*/

select rev_name from reviewer , rating
where 
reviewer.rev_id = rating.rev_id
and rev_stars >=7;

/*7. Write a query in SQL to find the titles of all movies that have no ratings*/
Select mov_id,mov_title from movie
where mov_id not in(select mov_id from rating);

/*8. Write a query in SQL to find the titles of the movies with ID 905, 907, 917.*/

Select mov_title,mov_id from movie
where mov_id in(905,907,917);

/*9. Write a query in SQL to find the list of all those movies with year which include the
words Boogie Nights.*/

Select mov_title,mov_year from movie
where mov_title like '%Boogie Nights%';

/*10Write a query in SQL to find the ID number for the actor whose first name is
'Woody' and the last name is 'Allen'.*/

Select act_id from actor
where act_fname like 'Woody' and
 act_lname like 'Allen';
 
 select * from actor;
 
 
-- Intermediate Questions --

/*1. Write a query in SQL to list all the information of the actors who played a role in the
movie 'Annie Hall'.*/

select * from actor where act_id in 
(select act_id from movie_cast where mov_id in 
(Select mov_id from movie where mov_title = 'Annie Hall'));

/*2.Write a query in SQL to find the name of the director (first and last names) who
directed a movie that casted a role for 'Eyes Wide Shut'. (using subquery)*/

Select dir_fname,dir_lname from director where dir_id in
(select dir_id from movie_direction where mov_id in 
(Select mov_id from movie_direction where mov_id in
(select mov_id from movie_cast where role in 
(Select role from movie_cast where mov_id in
(select mov_id from movie where mov_title ='Eyes Wide Shut'
)))));


/*3.Write a query in SQL to list all the movies which were released in countries other
than the UK.*/

Select mov_title,mov_rel_country from movie
where mov_rel_country <> 'UK';

/*4. Write a query in SQL to find the movie title, year, date of release, director and actor
for those movies whose reviewer is unknown.'*/

Select mov_title,dir_fname,act_fname from movie,director,
actor,movie_direction,movie_cast,rating,reviewer
where movie.mov_id=movie_direction.mov_id
and movie_direction.dir_ID=director.dir_id
and movie.mov_id=movie_cast.mov_id
and movie_cast.act_id=actor.act_id
and movie.mov_id=rating.mov_id
and rating.rev_id=reviewer.rev_id
and reviewer.rev_name is not null;

/*5. Write a query in SQL to find the titles of all movies directed by the director whose
first and last name are Woddy Allen.*/

select mov_title from movie where mov_id in 
(select mov_id from movie_direction where dir_id in
(select dir_id from movie_direction where dir_id in
(select dir_id from director where dir_fname = 'Woody' and dir_lname = 'Allen'))); 

/*6. Write a query in SQL to find all the years which produced at least one movie and that
received a rating of more than 3 stars. Show the results in increasing order.*/

select mov_year,rev_stars from movie,rating
where movie.mov_id=rating.mov_id
and mov_year <> 0
and rev_stars>3
order by mov_year asc;

SELECT DISTINCT mov_year FROM movie WHERE mov_id IN (
SELECT mov_id FROM rating WHERE rev_stars>3) ORDER BY mov_year;
/*7. Write a query in SQL to find the titles of all movies that have no ratings.*/

select mov_id,mov_title from movie 
where mov_id not in (Select mov_id from rating);

/*8. Write a query in SQL to find the names of all reviewers who have ratings with a
NULL value.*/

select rev_name from reviewer where rev_id in
(select rev_id from rating where rev_stars is null);

/*9Write a query in SQL to return the reviewer name, movie title, and stars for those
movies which are reviewed by a reviewer and must be rated. Sort the result by reviewer
name, movie title, and number of stars*/

Select rev_name,mov_title,rev_stars from reviewer,movie,rating
where reviewer.rev_id = rating.rev_id
and rating.mov_id=movie.mov_id
and rev_stars is not null
and rev_name is not null
order by rev_name,mov_title,rev_stars;

/*10. Write a query in SQL to find the reviewer's name and the title of the movie for those
reviewers who rated more than one movie.*/

select rev_name,mov_title from reviewer,movie,rating,rating r2
where rating.mov_id=movie.mov_id
AND reviewer.rev_id=rating.rev_ID 
    AND rating.rev_id = r2.rev_id 
    GROUP BY rev_name, mov_title HAVING count(*) > 1;
    
   
    
/*11. Write a query in SQL to find the movie title, and the highest number of stars that
movie received and arrange the result according to the group of a movie and the movie
title appear alphabetically in ascending order.*/

Select mov_title,max(rev_stars) from movie,rating
where movie.mov_id=rating.mov_id
group by mov_title
order by mov_title asc;

/*12.Write a query in SQL to find the names of all reviewers who rated the movie
American Beauty.*/
 
 Select rev_name from reviewer where rev_id in
 (Select rev_id from rating where mov_id in
 (select mov_id from movie where mov_title = 'American Beauty'));
 
  /*13. Write a query in SQL to find the titles of all movies which have been reviewed by
anybody except by Paul Monks.*/

Select mov_title from movie where mov_id in
(Select mov_id from rating where rev_id  in
(Select rev_id from reviewer where rev_name <> 'Paul Monks'))
order by mov_title asc;

/*14. Write a query in SQL to return the reviewer name, movie title, and number of stars
for those movies whose rating is the lowest one.*/

Select rev_name,mov_title,rev_stars from reviewer,movie,rating
where rev_stars in (select min(rev_stars) from rating)
and reviewer.rev_id=rating.rev_id
and rating.mov_id=movie.mov_id;

/*15. Write a query in SQL to find the titles of all movies directed by James Cameron.*/

Select mov_title from movie where mov_id in
(select mov_id from movie_direction where dir_id in
(Select dir_id from director where dir_fname = 'James' and dir_lname ='Cameron'));

/*16. Write a query in SQL to find the name of those movies where one or more actors
acted in two or more movies.*/

select mov_title from movie where mov_id in
(Select mov_id from movie_cast where act_id in
(Select act_id from actor where act_id in
(select act_id from movie_cast
group by act_id having count(act_id)>1)));

-- Advance --

/*1. Write a query in SQL to find the name of all reviewers who have rated their ratings
with a NULL value.*/


Select rev_name from reviewer where rev_id in
(Select rev_id from rating where rev_stars is null);

Select reviewer.rev_name,rating.rev_stars from reviewer
inner join rating on reviewer.rev_id = rating.rev_id
 and rating.rev_stars is null;

 
 /*2Write a query in SQL to list the first and last names of all the actors who were cast in
the movie 'Annie Hall', and the roles they played in that production*/

select actor.act_fname,actor.act_lname,role from actor 
inner join movie_cast on actor.act_id = movie_cast.act_id
inner join movie on movie.mov_id = movie_cast.mov_id
where movie.mov_title = 'Annie Hall';


-- using sub query

Select act_fname,act_lname,role from actor,movie_cast
where actor.act_id = movie_cast.act_id and
mov_id in (select mov_id from movie where mov_title = 'Annie Hall');

/*3. Write a query in SQL to find the name of the movie and director (first and last
names) who directed a movie that casted a role for 'Eyes Wide Shut'.*/
-- using sub query
select dir_fname,dir_lname,mov_title from movie ,director,movie_direction
where movie.mov_id = movie_direction.mov_id
and movie_direction.dir_id = director.dir_id
and mov_title = 'Eyes Wide Shut';

-- using join
 select director.dir_fname,director.dir_lname,movie.mov_title from director 
 inner join movie_direction on movie_direction.dir_id = director.dir_id
  inner join movie on movie_direction.mov_id = movie.mov_id
 where mov_title = 'Eyes Wide Shut';

-- using join and subquery
select dir_fname, dir_lname,
    (select mov_title from movie m inner join movie_direction md on md.mov_id = m.mov_id
    where md.dir_id = d.dir_id) as movie_title
from director d 
where dir_id in (select md.dir_id
from movie_direction md
inner join
movie m ON md.mov_id = m.mov_id
where m.mov_title = 'Eyes Wide Shut');


/*4. Write a query in SQL to find the name of the movie and director (first and last
names) who directed a movie that casted a role as Sean Maguire.*/

-- using sub query
Select mov_title,dir_fname,dir_lname,role from movie,director,movie_cast,movie_direction
where movie.mov_id = movie_direction.mov_id
and movie_direction.dir_id=director.dir_id
and movie_cast.mov_id=movie_direction.mov_id
and role ='Sean Maguire';

-- using join

select movie.mov_title,director.dir_fname,director.dir_lname,movie_cast.role from director
inner join movie_direction on  movie_direction.dir_id = director.dir_id
inner join movie on movie.mov_id = movie_direction.mov_id
inner join movie_cast on movie_cast.mov_id = movie.mov_id
where role ='Sean Maguire';

/*5. Write a query in SQL to list all the actors who have not acted in any movie between
1990 and 2000.*/

-- using join

select actor.act_fname,actor.act_lname,movie.mov_title,movie.mov_year from actor 
inner join movie_cast on movie_cast.act_id = actor.act_id 
inner join movie on movie.mov_id = movie_cast.mov_id
where movie.mov_year not between 1990 and 2000
order by mov_title asc;

-- using sub query

select act_fname,act_lname,mov_title,mov_year from actor,movie,movie_cast
where actor.act_id = movie_cast.act_id
and movie_cast.mov_id = movie.mov_id
and mov_year not between 1990 and 2000;

Select * from actor where act_id in 
(Select act_id from movie_cast where mov_id in
(Select mov_id from movie where mov_year not between 1990 and 2000 ));

/*6. Write a query in SQL to list first and last name of all the directors with the number
of genres of movies they directed with genres name, and arrange the result
alphabetically with the first and last name of the director.*/

Select director.dir_fname,director.dir_lname,genres.gen_title,count(gen_title) from director
inner join movie_direction on movie_direction.dir_id = director.dir_id
inner join movie_genres on movie_genres.mov_id = movie_direction.mov_id
inner join genres on genres.gen_id = movie_genres.gen_id
group by dir_fname,dir_lname,gen_title
order by dir_fname ,dir_lname asc  ;

/*7. Write a query in SQL to list all the movies with year and genres.*/

select mov_title,mov_year,gen_title from movie
inner join movie_genres on movie_genres.mov_id = movie.mov_id
inner join genres on genres.gen_id = movie_genres.gen_id;

/*8. Write a query in SQL to list all the movies with year, genres, and name of the
director.*/

select mov_title,mov_year,gen_title,dir_fname,dir_lname from movie
inner join movie_genres inner join genres inner join movie_direction inner join director
where movie.mov_id = movie_genres.mov_id
and movie_genres.gen_id = genres.gen_id
and movie_genres.mov_id = movie_direction.mov_id
and movie_direction.dir_id = director.dir_id;


SELECT mov_title, mov_year, gen_title, dir_fname, dir_lname
FROM movie
NATURAL JOIN movie_genres
NATURAL JOIN genres
NATURAL JOIN movie_direction
NATURAL JOIN director;

/*9. Write a query in SQL to list all the movies with title, year, date of release, movie
duration, and first and last name of the director which released before 1st january
1989, and sort the result set according to release date from highest date to lowest.*/

Select mov_title,mov_year,mov_dt_rel,mov_time,dir_fname,dir_lname from movie
inner join movie_direction on movie.mov_id = movie_direction.mov_id
inner join director on movie_direction.dir_id = director.dir_id
where mov_dt_rel < '1989-01-01' order by mov_dt_rel desc;

/*10. Write a query in SQL to compute a report which contains the genres of those
movies with their average time and number of movies for each genre.*/

select avg(mov_time) as Duration,gen_title,count(gen_title) from movie
inner join movie_genres using(mov_id)
inner join genres using(gen_id)
group by gen_title;

/*11. Write a query in SQL to find those lowest duration movies along with the year,
director's name, actor's name and his/her role in that production.*/

Select mov_title,mov_year,concat(dir_fname,' ',dir_lname) as dir_fullname,
concat(act_fname,' ',act_lname)as act_fullname,role from movie
inner join movie_direction on movie_direction.mov_id = movie.mov_id
inner join director on director.dir_id = movie_direction.dir_id
inner join movie_cast on movie_cast.mov_id = movie_direction.mov_id
inner join actor on actor.act_id = movie_cast.act_id
where mov_time = (select min(mov_time) from movie);

Select mov_title,mov_year,concat(dir_fname,' ',dir_lname) as dir_fullname,
concat(act_fname,'',act_lname)as act_fullname,role from movie
inner join movie_direction using(mov_id)
inner join director using(dir_id)
inner join movie_cast using(mov_id)
inner join actor using(act_id)
where mov_time = (select min(mov_time) from movie);

/*12. Write a query in SQL to find all the years which produced a movie that received a
rating of 3 or 4, and sort the result in increasing order*/

select mov_title,mov_year,rev_stars from movie
inner join rating using(mov_id)
where rev_stars in (3,4)
order by rev_stars asc;

/*13. Write a query in SQL to return the reviewer name, movie title, and stars in an order
that reviewer name will come first, then by movie title, and lastly by number of stars.*/

Select rev_name,mov_title,rev_stars from reviewer
inner join rating using (rev_id)
inner join movie using(mov_id)
where rev_name is not null
and mov_title is not null
and rev_stars is not null
order by rev_name,mov_title,rev_stars;

/*14. Write a query in SQL to find movie title and number of stars for each movie that has
at least one rating and find the highest number of stars that movie received and sort
the result by movie title.*/

Select mov_title,max(rev_stars) from movie
inner join rating using (mov_id)
where rev_stars is not null
group by mov_title
order by mov_title asc;

/*15. Write a query in SQL to find the director's first and last name together with the title
of the movie(s) they directed and received the rating.*/

Select concat(dir_fname,' ',dir_lname) as dir_name,mov_title,rev_stars from director
inner join movie_direction using(dir_id)
inner join movie using(mov_id)
inner join rating using (mov_id)
where rev_stars is not null;

/*16. Write a query in SQL to find the movie title, actor first and last name, and the role
for those movies where one or more actors acted in two or more movies.*/

Select mov_title,act_fname,act_lname,role from movie
inner join movie_cast using (mov_id)
inner join actor using (act_id)
where act_id in (select act_id from movie_cast
GROUP BY act_id HAVING COUNT(act_id)>=2); 

/*17. Write a query in SQL to find the first and last name of a director and the movie he or
she directed, and the actress appeared whose first name was Claire and last name was
Danes along with her role in that movie.*/

select dir_fname,dir_lname,mov_title,act_fname,act_lname,role from director
inner join movie_direction using(dir_id)
inner join movie using (mov_id)
inner join movie_cast using (mov_id)
inner join actor using (act_id)
where act_fname = 'Claire' and act_lname = 'Danes';																			

/*18. Write a query in SQL to find the first and last name of an actor with their role in the
movie which was also directed by themselves.*/

Select act_fname,act_lname,role,mov_title from actor
inner join movie_cast using(act_id)
inner join movie using(mov_id)
inner join movie_direction using(mov_id)
inner join director using(dir_id)
where act_fname = dir_fname and act_lname = dir_lname;


/*19. Write a query in SQL to find the cast list for the movie Chinatown.*/

select act_fname,act_lname,mov_title,role from actor
inner join movie_cast using (act_id)
inner join movie using (mov_id)
where mov_title = 'Chinatown';

/*20 Write a query in SQL to find the movie in which the actor appeared whose first and
last name are 'Harrison' and 'Ford'.*/

Select mov_title,act_fname,act_lname from movie
inner join movie_cast using(mov_id)
inner join actor using(act_id)
where act_id in(Select act_id from actor where act_fname = 'Harrison'
and act_lname = 'Ford');

/*21Write a query in SQL to find the highest-rated movie, and report its title, year,
rating, and releasing country.*/

Select mov_title,mov_year,rev_stars,mov_rel_country from movie
inner join rating using (mov_id)
where rev_stars in (select max(rev_stars) from rating);

/*22. Write a query in SQL to find the highest-rated Mystery movie, and report the title,
year, and rating.*/

Select mov_title,mov_year,rev_stars,gen_title from movie
inner join rating using (mov_id)
inner join movie_genres using (mov_id)
inner join genres using (gen_id)
where gen_title = 'Mystery';

/*23. Write a query in SQL to generate a report which shows the year when most of the
Mystery movies are produced, and number of movies and their average rating*/

Select mov_year,gen_title,count(gen_title),avg(rev_stars) from movie
inner join rating using (mov_id)
inner join movie_genres using (mov_id)
inner join genres using(gen_id)
where gen_title ='Mystery'
group by gen_title,mov_year;

/*24. Write a query in SQL to generate a report which contains the columns movie title,
name of the female actor, year of the movie, role, movie genres, the director, date of
release, and rating of that movie.*/

Select mov_title,concat(act_fname,' ',act_lname) as Act_name,mov_year,act_gender,
role,gen_title,concat(dir_fname,' ',dir_lname) as Director_name,mov_rel_country,rev_name,
mov_dt_rel,rev_stars  from movie
inner join movie_cast using (mov_id)
inner join actor using (act_id)
inner join movie_genres using (mov_id)
inner join genres using (gen_id)
inner join movie_direction using(mov_id)
inner join director using(dir_id)
inner join rating using (mov_id)
inner join reviewer using(rev_id)
where act_gender = 'F';