create database movie_assignment;
Create table movie_cast(
act_id int,
mov_id int,
role varchar(50));


Insert into movie_cast(act_id,mov_id,role) values
(101,901,'John Scottie Ferguson'),
(102,902,'Miss Giddens'),
(103,903,'T.E. Lawrence'),
(104,904,'Michael'),
(105,905,'Antonio Salieri'),
(106,906,'Rick Deckard'),
(107,907,'Alice Harford'),
(108,908,'McManus'),
(110,910,'Eddie Adams'),
(111,911,'Alvy Singer'),
(112,912,'San'),
(113,913,'Andy Dufresne'),
(114,914,'Lester Burnham'),
(115,915,'Rose DeWitt Bukater'),
(116,916,'Sean Maguire'),
(117,917,'Ed'),
(118,918,'Renton'),
(120,920,'Elizabeth Darko'),
(121,921,'Older Jamal'),
(122,922,'Ripley'),
(114,923,'Bobby Darin'),
(109,909,'J.J. Gittes'),
(119,919,'Alfred Borden');
Select * from movie_cast;
create table actor(
act_id int,
act_fname varchar(20),
act_lname varchar(20),
act_gender char(1));
Select concat(act_fname,' ',act_lname) as full_name from actor;
Insert into actor (act_id,act_fname,act_lname,act_gender) values
(101,'James','Stewart','M'),
(102,'Deborah','Kerr','F'),
(103,'Peter','OToole','M'),
(104,'Robert','De Niro','M'),
(105,'F. Murray','Abraham','M'),
(106,'Harrison','Ford','M'),
(107,'Nicole','Kidman','F'),
(108,'Stephen','Baldwin','M'),
(109,'Jack','Nicholson','M'),
(110,'Mark','Wahlberg','M'),
(111,'Woody','Allen','M'),
(112,'Claire','Danes','F'),
(113,'Tim','Robbins','M'),
(114,'Kevin','Spacey','M'),
(115,'Kate','Winslet','F'),
(116,'Robin','Williams','M'),
(117,'Jon','Voight','M'),
(118,'Ewan','McGregor','M'),
(119,'Christian','Bale','M'),
(120,'Maggie','Gyllenhaal','F'),
(121,'Dev','Patel','M'),
(122,'Sigourney','Weaver','F'),
(123,'David','Aston','M'),
(124,'Ali','Astin','F');



create table director(
dir_id int,
dir_fname varchar(20),
dir_lname varchar(20));
Select * from actor;
Select * from director;
Select * from genres;
Select * from movie;
Drop table movie;
alter table movie
change column ï»¿mov_id mov_id int null default null;
alter table movie
modify mov_tile varchar(50);
alter table movie
modify mov_year Year;
alter table movie
modify mov_time float;
alter table movie
modify mov_lang varchar(50);
alter table movie
modify mov_rel_country varchar(5);
Select * from movie_cast;
Select * from movie_direction;
Select * from rating;
Select * from reviewer;
alter table movie_cast
change column ï»¿act_id act_id int null default null;
alter table movie_cast
modify role varchar(30);
alter table actor
modify act_id int primary key;
alter table director
modify dir_id int primary key;
alter table movie
modify mov_id int primary key;
alter table reviewer
modify rev_id int primary key;
alter table genres
modify gen_id int primary key;
desc actor;
desc director;
desc movie;
desc reviewer;
desc genres;
alter table movie_cast
ADD FOREIGN KEY(act_id) REFERENCES actor(act_id);
alter table movie_cast 
add foreign key(mov_id) references movie(mov_id);
desc movie_cast;
alter table movie_direction
add foreign key(dir_id) references director(dir_id);
alter table movie_genres
add foreign key(mov_id) references movie(mov_id);
alter table movie_direction
add foreign key(mov_id) references movie(mov_id);
desc movie_direction;
alter table movie_genres
add foreign key(gen_id) references genres(gen_id);
desc movie_genres;
alter table rating
add foreign key(mov_id) references movie(mov_id);
alter table rating
add foreign key(rev_id) references reviewer(rev_id);
desc rating;


select reviewer.rev_name from reviewer cross join rating
where rating.rev_stars <> null;

SELECT rev_name
FROM reviewer
INNER JOIN rating USING(rev_id)
WHERE rev_stars IS NULL;


alter table movie
drop mov_dt_rel;
desc movie;
Select * from movie;
Select * from movie_cast;
alter table movie_cast
drop foreign key mov_id;

alter table movie
add mov_dt_rel date;

alter table movie
drop Primary key;

update movie
set mov_dt_rel ='1958-08-24'
where mov_id = 901;

update movie
set mov_dt_rel ='1962-02-19'
where mov_id = 902;
desc movie_cast;
select * from movie;



update movie
set mov_dt_rel ='1985-01-07'
where mov_id = 905;
update movie
set mov_dt_rel ='1982-09-09' 
where mov_id = 906;
select * from movie;
update movie set mov_dt_rel ='1995-08-25' where mov_id = 908;
update movie set mov_dt_rel ='1974-08-09' where mov_id = 909;
update movie set mov_dt_rel ='1998-02-16' where mov_id = 910;
update movie set mov_dt_rel ='1977-04-20'where mov_id = 911;

update movie set mov_dt_rel ='2001-10-19' where mov_id = 912;
update movie set mov_dt_rel ='1995-02-17' where mov_id = 913;
update movie set mov_dt_rel ='1998-01-23' where mov_id = 915;
update movie set mov_dt_rel ='1998-06-03' where mov_id = 916;
update movie set mov_dt_rel ='1982-10-05' where mov_id = 917;
update movie set mov_dt_rel ='996-02-23' where mov_id = 918;
update movie set mov_dt_rel ='2006-11-10'where mov_id =919;
select * from movie;
update movie set mov_dt_rel ='2009-01-09' where mov_id =921;
update movie set mov_dt_rel ='1986-08-29'where mov_id = 922;
update movie set mov_dt_rel ='2004-11-26' where mov_id = 923;
update movie set mov_dt_rel ='2009-12-17' where mov_id = 924;
update movie set mov_dt_rel ='1954-04-26' where mov_id = 926;
update movie set mov_dt_rel ='2003-09-12' where mov_id = 927;
update movie set mov_dt_rel ='1985-12-04'where mov_id =928;
update movie set mov_dt_rel ='1995-09-08' where mov_id = 925;
select * from movie;
delete from movie
where mov_id = null;



select rev_name from reviewer
where rev_id=(select rev_id from rating
where rev_stars>=7);

select *  from rating;






select * from rating;

select * from movie;