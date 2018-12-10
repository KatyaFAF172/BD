# Laboratory work Nr.10

Crearea si utilizarea declansatoarelor

Tasks
======

1. Sa se modifice declansatorul inregistrare_noua, in asa  fel, incat in cazul actualizarii auditoriului sa apara mesajul de informare, care, in afara de disciplina si ora, va afisa codul grupei afectate, ziua, blocul, auditoriul vechi si auditoriul nou.

```sql
use universitatea
go
drop trigger if exists dbo.inregistrare_noua
go
create trigger inregistrare_noua on orarul
after update 
as
print 'O noua inregistrare a fost inclusa cu succes'
go
```

![Nr1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr1.PNG)

```sql
alter table dbo.orarul 
drop column Auditoriu_nou
go
alter table dbo.orarul
add Auditoriu_nou int
go
update dbo.orarul
set Auditoriu_nou='118'
go
alter table dbo.orarul
alter column Auditoriu_nou int not null
select *
from dbo.orarul
```

![Nr1-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr1-1.PNG)

![Nr1-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr1-2.PNG)

SAU

```sql
use universitatea
go
drop trigger if exists dbo.inregistrare_noua
go
create trigger inregistrare_noua on orarul
after update 
as
set nocount on
if UPDATE(Auditoriu)
select 'Lectia la disciplina "' + UPPER(discipline.Disciplina)+ 
		'"de la ora ' + cast(inserted.ora as varchar(5)) +
		' a fost transferata in aula ' + cast(inserted.Auditoriu as char(5))
from inserted
join discipline
on inserted.Id_Disciplina = discipline.Id_Disciplina
GO
print 'O noua inregistrare a fost inclusa cu succes'
go
update orarul
set Auditoriu = 510
where Zi = 'luni'
```
before:

![Nr1-3](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr1-3.PNG)

After:

![Nr1-4](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr1-4.PNG)

![Nr1-5](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr1-5.PNG)



2. Sa se creeze declansatorul, care ar asigura popularea corecta (consecutiva) a tabelelor *studenti* si *studenti_reusita*, si ar permite evitarea erorilor la nivelul cheilor externe.


```sql
use universitatea
go
drop trigger if exists declansator2
go
CREATE TRIGGER declansator2 ON studenti 
AFTER INSERT 
AS
DECLARE @id AS INT
SET @id = (SELECT TOP 1 inserted.Id_Student FROM inserted)
IF @id<201
BEGIN 
 RAISERROR  ('Cannot insert Id_Student less than 201',16,10);
  ROLLBACK
END
```

![Nr2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr2.PNG)


```sql
insert into dbo.studenti ( [Id_Student], [Nume_Student], [Prenume_Student]
						, [Data_Nastere_Student], [Adresa_Postala_Student])
values (202, 'Rivka', 'Emanuil', '1992-10-10', 'mun.Chisinau, str. Stefan cel Mare si Sfant 125, ap.89')
		,(203, 'Gil', 'Shoshan', '1991-12-27', 'mun.Chisinau, str. G.Asachi 6, ap.12')
go
select *
from dbo.studenti
```

![Nr2-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr2-1.PNG)

![Nr2-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr2-2.PNG)


Daca Id_Student < 201, atunci apare eroare

```sql
insert into dbo.studenti ( [Id_Student], [Nume_Student], [Prenume_Student]
						, [Data_Nastere_Student], [Adresa_Postala_Student])
values (202, 'Rivka', 'Emanuil', '1992-10-10', 'mun.Chisinau, str. Stefan cel Mare si Sfant 125, ap.89')
		,(203, 'Gil', 'Shoshan', '1991-12-27', 'mun.Chisinau, str. G.Asachi 6, ap.12')
		,(200, 'AAA', 'BBB', '1790-12-12', 'mun.Chisinau')
go
select *
from dbo.studenti
```

![Nr2-3](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr2-3.PNG)


SAU


```sql
use universitatea
go

drop trigger if exists declansator_2_1
go
drop trigger if exists declansator_2_2
go

create trigger declansator_2_1 on studenti
    after insert
    as
    declare @id as int
    declare @cursor_studenti cursor 
    set @cursor_studenti = cursor scroll
    for
        select Id_Student from inserted
    open @cursor_studenti
    fetch next from @cursor_studenti into @id
    while @@FETCH_STATUS = 0
    begin
        if @id < 201
        begin
            raiserror('Cannot insert Id_Student less than 201', 16, 10);
            rollback transaction
        end
    fetch next from @cursor_studenti into @id
    end
    close @cursor_studenti
go

create trigger declansator_2_2 on studenti_reusita
    after insert
    as
    declare @id as int
    declare @cursor_studenti_reusita cursor 
    set @cursor_studenti_reusita = cursor scroll
    for
        select Id_Student from inserted
    open @cursor_studenti_reusita
    fetch next from @cursor_studenti_reusita into @id
    while @@FETCH_STATUS = 0
    begin
        if @id < 201
        begin
            raiserror('Cannot insert Id_Student less than 201', 16, 10);
            rollback transaction
        end
    fetch next from @cursor_studenti_reusita into @id
    end
    close @cursor_studenti_reusita
go
```
![Nr2-4](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr2-4.PNG)

```sql
insert into dbo.studenti ( [Id_Student], [Nume_Student], [Prenume_Student]
                            , [Data_Nastere_Student], [Adresa_Postala_Student])
values (204, 'Kfir', 'Dolev', '1992-01-21', ' Chisinau, str. G.Asachi 66')
        , (205, 'Shoshan', 'Gil', '1988-09-09', ' Chisinau, str. Bucuresti 123')

go
select *
from dbo.studenti
```
![Nr2-5](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr2-5.PNG)



3. Sa se creeze un declansator, care ar interzice micsorarea notelor in tabelul *studenti_reusita* si modificarea valorilor campului *Data_Evaluare*, unde valorile acestui camp sunt nenule.
Declansatorul trebuie sa se lanseze, numai daca sunt afectate datele studentilor din grupa "CIB171". Se va afisa un mesaj de avertizare in cazul tentativei de a incalca constrangerea.


```sql
create or alter trigger ex3 on studenti_reusita
after update 
as
begin

    declare @Id_Student int,@Id_Disciplina int,@Id_Profesor int,@Id_Grupa int,@Tip_Evaluare char(20),@NewNote int,@Data_Evaluare date;

    DECLARE db_cursor CURSOR FOR 
    SELECT Id_Student,Id_Disciplina,Id_Profesor, Id_Grupa,Tip_Evaluare, Nota, Data_Evaluare
    FROM inserted 

    OPEN db_cursor
    FETCH NEXT FROM db_cursor INTO @Id_Student,@Id_Disciplina,@Id_Profesor,@Id_Grupa,@Tip_Evaluare,@NewNote,@Data_Evaluare

    WHILE @@FETCH_STATUS = 0
    BEGIN
        if @Id_Grupa in (select Id_Grupa from grupe where Cod_Grupa = 'CIB171')
        begin
            -- start task 1
            declare @OldNote int = ( select Nota from deleted where Id_Student=@Id_Student and Tip_Evaluare = @Tip_Evaluare and Id_Disciplina = @Id_Disciplina)

            select  @OldNote = Nota from deleted where Id_Student= @Id_Student 
            if (@OldNote > @NewNote and @OldNote is not null)
            begin
                UPDATE studenti_reusita
                SET Nota = @OldNote
                WHERE Nota = @NewNote and Id_Student=@Id_Student and Tip_Evaluare = @Tip_Evaluare and Id_Disciplina = @Id_Disciplina  
            end
            -- start task2
            
            
         
            
            declare @OldDate date = ( select Data_Evaluare from deleted where Id_Student=@Id_Student and Tip_Evaluare = @Tip_Evaluare and Id_Disciplina = @Id_Disciplina)

            
            if (@OldDate is not null)  --  or @NewDate is not null
            begin
                UPDATE studenti_reusita
                SET Data_Evaluare = @OldDate
                WHERE Data_Evaluare = @Data_Evaluare and Id_Student=@Id_Student and Id_Disciplina=@Id_Disciplina and Tip_Evaluare= @Tip_Evaluare
            end
            
            FETCH NEXT FROM db_cursor INTO @Id_Student,@Id_Disciplina,@Id_Profesor,@Id_Grupa,@Tip_Evaluare,@NewNote,@Data_Evaluare

            Print 'TRIGGER HAS BEEN TRIGGERED'
        end -- end if cib 


    end -- end while
    CLOSE db_cursor
    DEALLOCATE db_cursor
end -- end trigger

go
update studenti_reusita
set  Data_Evaluare = '1998-08-08'
where Id_Student = 101 and Tip_Evaluare='Examen' and Id_Disciplina=105
```


```sql
use universitatea
go
drop trigger if exists declansator3
go
--Declansator ar interzice micsorarea notelor in tabelul studenti_reusita
CREATE TRIGGER declansator3 ON studenti_reusita 
AFTER INSERT, update, delete
AS
declare @nota int
--declare @data date
			select @nota = count(Nota) from studenti_reusita
			where Nota = 9 and Data_Evaluare = '2018-01-25'
			if @nota < 9			
				BEGIN 
					RAISERROR  ('Atentie, micsorarea notelor este interzisa!',16,10);
					ROLLBACK
					END
				--else
				--begin
					--if @data<>'2018-01-25'
					--RAISERROR  ('Atentie, modificarea valorilor campului Data_Evaluare este interzisa!',16,10);
					--ROLLBACK
					--END
go
update studenti_reusita
set Nota = 6
where Data_Evaluare ='2018-01-25' and Id_Student = 100 and Id_Disciplina = 105
go 
select *
from studenti_reusita
```

```sql
use universitatea
go
drop trigger if exists declansator3
go
--Declansator ar interzice micsorarea notelor in tabelul studenti_reusita
CREATE TRIGGER declansator3 ON studenti_reusita 
AFTER INSERT, update, delete
AS
declare @nota int
declare @data date
--declare @data date
			select @nota = count(Nota), @data = Data_Evaluare from studenti_reusita
			where Nota = 9 and Data_Evaluare = '2018-01-25'
			if @nota < 9			
				BEGIN 
					RAISERROR  ('Atentie, micsorarea notelor este interzisa!',16,10);
					ROLLBACK
					END
				else
					if @data<>'2018-01-25'
					begin
					RAISERROR  ('Atentie, modificarea valorilor campului Data_Evaluare este interzisa!',16,10);
					ROLLBACK
					end
go
update studenti_reusita
set Nota = 6
--set Data_Evaluare = '2020-01-25'
where Tip_Evaluare = 'Examen' and Id_Disciplina = 105 and Id_Student =100
go 
select *
from studenti_reusita
```





4. Sa se creeze un declansator DDL care ar interzice modificarea coloanei Id_Disciplina in tabelele bazei de date universitatea cu afisarea mesajului respectiv.

```sql
use universitatea
go
drop trigger if exists declansator4 on database
go
create trigger declansator4 on database
for alter_table
as
set nocount on
DECLARE @id int
SELECT @id=EVENTDATA().value('(/EVENT_INSTANCE/AlterTableActionList/*/Columns/Name)[1]', 'nvarchar(max)')
IF @id='Id_Disciplina'
begin
RAISERROR ( 'Modificarea coloanei Id_Disciplina este interzisa!', 16,1)
rollback
end
go

alter table discipline
alter column Id_Disciplina varchar(6)
```

![Nr4](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr4.PNG)



5. Sa se creeze un declansator DDL care ar interzice modificarea schemei bazei de date in afara orelor de lucru.

```sql
use  universitatea
go
drop trigger if exists de5 
go
create trigger de5 on database
for ALTER_TABLE
as
set nocount on
 declare @CurrentTime time
 declare @starttime time
 declare @endtime time

 select @CurrentTime = CONVERT(Time, GETDATE())
 select @starttime = '08:00:00'
 select @endtime = '16:00:00'

if ( @CurrentTime < @starttime) or (@CurrentTime > @endtime) 
 begin
 raiserror( 'All database changes can be made only from 8 am to 14 pm', 16, 1)
 rollback
end
 go
alter table dbo.grupe
alter column Cod_Grupa char(7);
```

![Nr5](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr5.PNG)

6. Sa se creeze un declansator DDL care, la modificarea proprietatilor coloanei Id_Profesor dintr-un tabel, ar face schimbari asemanatoare in mod automat in restul tabelelor.



```sql
use universitatea
go
if exists (select * from sys.triggers where parent_class = 0
and name = 'exec6')
drop trigger  exec6 on database;
go
create trigger exec6 on database
for alter_table
as
begin

declare @schema varchar(max)
declare @command varchar(max)
declare @command_new varchar(max)

set @command=EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand)[1]','varchar(MAX)')
set @schema=EVENTDATA().value('(/EVENT_INSTANCE/Objectname)[1]','varchar(MAX)')
set @command_new=replace(@command, @schema,'studenti_reusita')

if @command like '%Id_Profesor%'
	begin
	if (@schema != 'id_pr')
			begin 
				set @command_new=REPLACE (@command,'Id_Profesor\','studenti_reusita')
				execute(@command_new)
			end
	end
end
go

```

![Nr6](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-10/image/Nr6.PNG)

