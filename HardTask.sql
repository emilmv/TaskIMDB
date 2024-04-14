create database IMDB
use IMDB
create table Directors
(
ID int primary key identity,
DirectorName nvarchar(20) not null,
DirectorSurname nvarchar(20) not null
)
create table Actors
(
ID int primary key identity,
ActorName nvarchar(20) not null,
ActorSurname nvarchar(20) not null,
)
create table Genres
(
ID int primary key identity,
GenreName nvarchar(20) not null,
)
create table Movies
(
ID int primary key identity,
MovieName nvarchar(40) unique not null,
ReleaseYear int not null,
MovieDuration nvarchar(20) not null,
Rating decimal(3,1) not null,
DirectorID int foreign key references Directors(ID)
)
create table MovieActors
(
ID int primary key identity,
MovieID int foreign key references Movies(ID),
ActorID int foreign key references Actors(ID)
)
create table MovieGenres
(
ID int primary key identity,
MovieID int foreign key references Movies(ID),
GenreID int foreign key references Genres(ID)
)
insert into Directors (DirectorName,DirectorSurname) values
('Frank','Darabont'),
('Francis Ford','Coppola'),
('Christopher','Nolan'),
('Sidney','Lumet'),
('Steven','Spielberg')
insert into Actors (ActorName,ActorSurname) values
--Shawshank Redemption Actors
('Tim','Robbins'),			--ID=1
('Morgan','Freeman'),	    --ID=2
('Bob','Gunton'),			--ID=3
--The Godfather Actors
('Marlon','Brando'),		--ID=4
('Al','Pacino'),			--ID=5
('James','Caan'),			--ID=6
--The Dark Knight Actors
('Christian','Bale'),		--ID=7
('Heath','Ledger'),			--ID=8
('Aaron','Eckhart'),		--ID=9
--The Godfather II Actors (Al pacino already exists above)
('Robert', 'De Niro'),		--ID=10
('Robert','Duvall'),		--ID=11
--Angry Men Actors
('Henry','Fonda'),			--ID=12
('Lee J.','Cobb'),			--ID=13
('Martin','Balsam'),		--ID=14
--Schindler's List Actors
('Liam','Neeson'),			--ID=15
('Ralph','Fiennes'),		--ID=16
('Ben','Kingsley')			--ID=17
insert into Genres(GenreName) values
('Drama'),					--ID=1
('Crime'),					--ID=2
('Action'),					--ID=3
('Biography'),				--ID=4
('History')					--ID=5
insert into Movies (MovieName,ReleaseYear,MovieDuration,Rating,DirectorID) values
('The Shawshank Redemption',1994,'2h 22m',9.3,1),		--ID=1
('The Godfather',1972,'2h 55m',9.2,2),					--ID=2
('The Dark Knight',2008,'2h 32m',9.0,3),				--ID=3
('The Godfather Part II',1974,'3h 22m',9.0,1),			--ID=4
('12 Angry Men',1957,'1h 36m',9.0,4),					--ID=5
('Schindlers List',1993,'3h 15m',9.0,5)					--ID=6
insert into MovieActors (MovieID,ActorID) values
(1,1),
(1,2),
(1,3),
(2,4),
(2,5),
(2,6),
(3,7),
(3,8),
(3,9),
(4,4),
(4,10),
(4,11),
(5,12),
(5,13),
(5,14),
(6,15),
(6,16),
(6,17)
insert into MovieGenres (MovieID,GenreID) values
(1,1),
(2,1),
(2,2),
(3,1),
(3,2),
(3,3),
(4,1),
(4,2),
(5,1),
(5,2),
(6,1),
(6,4),
(6,5)

--QUERY 1
SELECT 
m.MovieName as 'Movie Name',
m.Rating,
g.GenreName as 'Genre Name',
concat(d.DirectorName, ' ', d.DirectorSurname) as 'Director Name',
concat(a.ActorName, ' ', a.ActorSurname) as 'Actor Name'
from 
Movies m
join 
Directors d on m.DirectorID = d.ID
join 
MovieGenres mg on m.ID = MG.MovieID
join 
Genres g on mg.GenreID = g.ID
join 
MovieActors ma on m.ID = ma.MovieID
join 
actors a on ma.ActorID = a.ID
where m.Rating>6

--QUERY 2
select 
MovieName as 'Movie Name',
Rating,
GenreName as 'Genre'
from 
Movies
join 
MovieGenres on Movies.ID = MovieGenres.MovieID
join 
Genres on MovieGenres.GenreID = Genres.ID
where 
MovieName like '%a%'

--QUERY 3
select 
M.MovieName as 'Movie Name',
M.Rating,
M.MovieDuration as 'Duration',
G.GenreName as 'Genre'
from 
Movies m
join 
MovieGenres mg ON m.ID = mg.MovieID
join 
Genres g ON mg.GenreID = g.ID
where 
len(m.MovieName) > 10 and MovieName like '%t'

--QUERY 4
select 
m.MovieName as 'Movie Name',
m.Rating,
g.GenreName as 'Genre',
concat(D.DirectorName, ' ', D.DirectorSurname) as 'Director',
concat(A.ActorName, ' ', A.ActorSurname) as 'Actor'
from 
Movies m
join 
Directors d on m.DirectorID = d.ID
join 
MovieGenres mg on m.ID = mg.MovieID
join 
Genres g on mg.GenreID = g.ID
join 
MovieActors ma ON m.ID = ma.MovieID
join 
Actors a on ma.ActorID = a.ID
where 
m.Rating > (select avg(Rating) from Movies)
order by
M.Rating desc