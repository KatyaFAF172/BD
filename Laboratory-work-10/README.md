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



3. Sa se creeze un declansator, care ar interzice micsorarea notelor in tabelul *studenti_reusita* si modificarea valorilor campului *Data_Evaluare*, unde valorile acestui camp sunt nenule.
Declansatorul trebuie sa se lanseze, numai daca sunt afectate datele studentilor din grupa "CIB171". Se va afisa un mesaj de avertizare in cazul tentativei de a incalca constrangerea.


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



6. Sa se creeze un declansator DDL care, la modificarea proprietatilor coloanei Id_Profesor dintr-un tabel, ar face schimbari asemanatoare in mod automat in restul tabelelor.



