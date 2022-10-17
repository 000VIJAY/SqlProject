select * from Demo 

create Procedure sp_Demo
@userId int,
@userName varchar,
@mobileNumber bigint,
@userAdderss int
as 
begin
insert into dbo.Demo (userId , userName,mobileNumber,userAddress)
values (@userId,@userName,@mobileNumber,@userAdderss)
end
go;

exec sp_Demo 124,'Rahul',7766885544,2;

create Procedure sp_DemoDelete
@userId int
as 
begin
delete from dbo.Demo where Demo.userId = @userId 
end
go
exec sp_DemoDelete 124

create proc spFilmCritria(@minLength as int)
as 
begin 
select FilmName,FilmRunTimeMinutes from tblFilm
where FilmRunTimeMinutes>@MinLength order by FilmRunTimeMinutes asc
end 
go 

exec spFilmCritria 100

alter procedure spFilmCritria
(
	@MinLength as int ,
	@MaxLength as int
)
as
begin 
select 
FilmName,FilmRunTimeMinutes from tblFilm  
where FilmRunTimeMinutes >=@MinLength AND
FilmRunTimeMinutes <= @MaxLength
order by FilmRunTimeMinutes Desc 
end

exec spFilmCritria 100,150
--when we give name of the parameter then ordeer not matter
exec spFilmCritria @MaxLength=150,@MinLength=120

create proc spFilmCritria(@minLength as int)
as 
begin 
select FilmName,FilmRunTimeMinutes from tblFilm
where FilmRunTimeMinutes>@MinLength order by FilmRunTimeMinutes asc
end 
go 

exec spFilmCritria 100
--default value as null can we write anything
create procedure spFilm_Critria
(
	@MinLength as int=NULL ,
	@MaxLength as int = NULL
)
as
begin 
select 
FilmName,FilmRunTimeMinutes from tblFilm  
where (@MinLength IS NULL OR FilmRunTimeMinutes >=@MinLength) AND
 (@MaxLength is NULL OR FilmRunTimeMinutes <= @MaxLength)
order by FilmRunTimeMinutes Desc 
end
exec spFilm_Critria 

--variable 
Declare @MyDate DateTime

SET @MyDate ='1980-01-01'

select FilmName,FilmReleaseDate ,'Film' as [type] from tblFilm
where FilmReleaseDate >= @MyDate
UNION ALL 
Select ActorName,ActorDOB,'Actor' from tblActor where ActorDOB >= @MyDate
UNION ALL 
SELECT DirectorName,DirectorDOB,'Director'
from tblDirector where DirectorDOB<=@MyDate;

--variable 
Declare @MyDate DateTime
Declare @NumFilms int
SET @MyDate ='1980-01-01'
SET @NumFilms =(select count(*) from tblFilm where FilmReleaseDate>=@MyDate)

--print
select 'Number of films',@NumFilms
--this will print in message
PRINT 'Number of films=' +cast(@NumFilms as varchar(MAX))
select FilmName,FilmReleaseDate ,'Film' as [type] from tblFilm
where FilmReleaseDate >= @MyDate
UNION ALL 
Select ActorName,ActorDOB,'Actor' from tblActor where ActorDOB >= @MyDate
UNION ALL 
SELECT DirectorName,DirectorDOB,'Director'
from tblDirector where DirectorDOB<=@MyDate;


--output parameter we can write output parameter in stored procedure we can have multiple output parameter stored procedure only return one value and number only

Create Procedure sp_Films_In_Year
(
@Year int
,@FilmList varchar(MAX) output,
@FilmCount int OUTPUT
)
as 
begin
DECLARE @Films Varchar(MAX)
Set @Films =''

select @Films = @Films + FilmName from tblFilm where YEAR(FilmReleaseDate) = @Year
order by FilmName ASC
SET @FilmCount = @@ROWCOUNT
SET @FilmList = @Films
end


DECLARE @Names Varchar(MAX)
DECLARE @Count int
EXEC sp_Films_In_Year @Year = 2000,@FilmList = @Names OUTPUT ,@FilmCount = @Count OUTPUT

SELECT @Count as [Number of Films] ,@Names 