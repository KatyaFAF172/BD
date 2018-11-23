# Laboratory work Nr.7
Diagrame, Scheme si Sinonime

Tasks
======

1. Creati o diagrama a bazei de date, folosind forma de vizualizare standard, structura careia aste descrisa la inceputul sarcinilor practice din capitolul 4.

![Nr1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr1.png)



2. Sa se adauge constrangeri referentiale (legate cu tabelele *studenti* si *profesori*) necesare coloanelor *Sef_grupa* si *Prof_Indrumator* (sarcina 3, capitolul 6) din tabelul grupe.


![Nr2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr2.png)

![Nr2-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr2-1.png)

![Nr2-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr2-2.png)



3. La diagrama construita, sa se adauge si tabelul *orarul* definit in capitolul 6 al acestei lucrari:tabelul orarul contine identificatorul disciplinei (ld_Disciplina), identificatorul profesorului(Id_Profesor) si blocul de studii (Bloc). Cheia tabelului este constituita din trei cîmpuri:identificatorul grupei (Id_ Grupa), ziua lectiei (Z1), ora de inceput a lectiei (Ora), sala unde are loc lectia (Auditoriu).

select distinct Id_Disciplina, Id_Profesor, Id_Grupa
into orarul
from studenti_reusita
where Id_Grupa = 1 or Id_Grupa = 2 
/*   */
*alter table orarul add ora varchar(5) not NULL default ('00:00'), Auditoriu int not NULL default (ABS(CHECKSUM(NEWID()) % 500)), Bloc char(255) not null default ('Bloc'), Zi char(10) not null default ('luni');*

```sql
create nonclustered index NIX_task6  
    on orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Bloc, Zi)  
go

alter database universitatea
add filegroup userdatafgroup1;
go
alter database universitatea
add file (name = FGTask6, filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\FGTask6.ndf')
to filegroup userdatafgroup1;

update orarul set ora = '08:00', Auditoriu = 202, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 107 and Id_Grupa = 1;
update orarul set ora = '11:30', Auditoriu = 501, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 108 and Id_Grupa = 1;
update orarul set ora = '13:00', Auditoriu = 501, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 119 and Id_Grupa = 1;
go

update orarul set ora = '08:00', Auditoriu = 123, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 108 and Id_Grupa = 2;
update orarul set ora = '11:30', Auditoriu = 321, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 120 and Id_Grupa = 2;
update orarul set ora = '13:00', Auditoriu = 602, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 107 and Id_Grupa = 2;
go

create nonclustered index NIX_task6  
    on orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Bloc, Zi)  
    with (DROP_EXISTING = on)  
    on userdatafgroup1; 

```

![Nr3](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr3.png)


![Nr3-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr3-1.PNG)



4. Tabelul orarul trebuie sa contina si 2 chei secundare: (Zi, Ora, Id_ Grupa, Id_ Profesor) si (Zi, Ora, ld_Grupa, ld_Disciplina).


![Nr4](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr4.PNG)

![Nr4-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr4-1.PNG)


5. In diagrama, de asemenea, trebuie sa se defineasca constrangerile referentiale (FK-PK) ale atributelor *ld_Disciplina, ld_Profesor, Id_ Grupa* din tabelului orarul cu atributele tabelelor respective.


![Nr5](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr5.PNG)

![Nr5-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr5-1.PNG)

![Nr5-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr5-2.PNG)

![Nr5-3](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr5-3.PNG)


6. Creati, in baza de date universitatea, trei scheme noi: *cadre_didactice, plan_studii* si *studenti*. Transferati tabelul profesori din schema dbo in schema cadre didactice, tinind cont de dependentele definite asupra tabelului mentionat. In acelasi mod sa se trateze tabelele orarul,discipline care apartin schemei plan_studii și tabelele studenți, studenti_reusita, care apartin schemei studenti. Se scrie instructiunile SQL respective.


```sql
use universitatea 
go

 create schema cadre_didactice;
  go

   alter schema cadre_didactice transfer dbo.profesori 
   alter schema cadre_didactice transfer dbo.studenti_reusita
    alter schema cadre_didactice transfer dbo.orarul
	 go
	  create schema plan_studii;
	   go
	    alter schema plan_studii transfer dbo.orarul 
		alter schema plan_studii transfer dbo.studenti_reusita 
		alter schema plan_studii transfer dbo.discipline 
		go
		 create schema studenti;
		  go 
          alter  schema studenti transfer dbo.studenti_reusita 
		  alter schema studenti transfer dbo.orarul
		   alter schema studenti transfer dbo.studenti
```

![Nr6](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr6.PNG)



I have a problem: the schemas are created, but there are errors. After removing these schemes and running the code, the same errors still appear. Also, I can not solve 7 and 8 tasks because they are associated with 6 task.  
====


7. Modificati 2-3 interogari asupra bazei de date universitatea prezentate in capitolul 4 astfel ca numele tabelelor accesate sa fie descrise in mod explicit, tinind cont de faptul ca tabelele au fost mutate in scheme noi.



![Nr7](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr7.PNG)


8. Creati sinonimele respective pentru a simplifica interogarile construite in exercitiul precedent si reformulati interogarile, folosind sinonimele create.



Cream tabelul orarul:
CLUSTERED INDEX
*With a non clustered index there is a second list that has pointers to the physical rows. We can have many non clustered indexes, although each new index will increase the time it takes to write new records. Faster to read than non clustered as data is physically stored in index order.*
*Additional disk space: not needed.*
*A clustered index is faster than non-clustered index because the non-clustered index has to refer back to the base table.*

```sql
create table orarul
	(Id_Profesor int not null
	,Id_Disciplina int not null
	,Id_Grupa int default(1)
	,Bloc char(255) default('B')
	,Auditoriu int
	,Ora time
	,Zi char(10) 
	primary key(Id_Grupa,Zi,Id_Disciplina));
	
insert into orarul(Id_Disciplina, Id_Profesor, Zi, Ora, Auditoriu) values(107, 101, 'Luni', '08:00', 202)
insert into orarul(Id_Disciplina, Id_Profesor, Zi, Ora, Auditoriu) values(108, 101, 'Luni', '11:30', 501)
insert into orarul(Id_Disciplina, Id_Profesor, Zi, Ora, Auditoriu) values(119, 117, 'Luni', '13:00', 501)
```
![Nr8](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr8.PNG)



```sql
select *
into orarul_student
from orarul
```
![Nr8-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr8-1.PNG)

NONCLUSTERED INDEX
```sql
select distinct Id_Disciplina, Id_Profesor, Id_Grupa
into orarul
from studenti_reusita
where Id_Grupa = 1 or Id_Grupa = 2 
alter table orarul add ora varchar(5) NULL, Auditoriu int NULL, Bloc char(255), Zi char(10);
go

create nonclustered index NIX_task6  
    on orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Bloc, Zi)  
go

alter database universitatea
add filegroup userdatafgroup1;
go
alter database universitatea
add file (name = FGTask6, filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\FGTask6.ndf')
to filegroup userdatafgroup1;

update orarul set ora = '08:00', Auditoriu = 202, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 107 and Id_Grupa = 1;
update orarul set ora = '11:30', Auditoriu = 501, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 108 and Id_Grupa = 1;
update orarul set ora = '13:00', Auditoriu = 501, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 119 and Id_Grupa = 1;
go

update orarul set ora = '08:00', Auditoriu = 123, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 108 and Id_Grupa = 2;
update orarul set ora = '11:30', Auditoriu = 321, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 120 and Id_Grupa = 2;
update orarul set ora = '13:00', Auditoriu = 602, Bloc = 'B', Zi = 'Luni' where Id_Disciplina = 107 and Id_Grupa = 2;
go

create nonclustered index NIX_task6  
    on orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Bloc, Zi)  
    with (DROP_EXISTING = on)  
    on userdatafgroup1; 
```
*Determines the storage order of the rows in a table with the help of separate physical structure. Slower as compared to the clustered index. Additional disk space: required to store the indices separately.*
![Nr8-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr8-2.png)