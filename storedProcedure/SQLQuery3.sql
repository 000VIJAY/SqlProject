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