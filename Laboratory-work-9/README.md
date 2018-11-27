# Laboratory work Nr.9

Proceduri stocate si functii definite de utilizator

Tasks
======

1. Sa se creeze proceduri stocate in baza exercitiilor (2 exercitii) din capitolul 4. Parametrii de intrare trebuie sa corespunda criteriilor din clauzele WHERE ale exercitiilor respective.

```sql
--11.	Furnizati numele si prenumele profesorilor, care au predat disciplina Baze de date, in 2018, 
--si au evaluat vreun student cu nota nesatisfacatoare la reusita curenta.
use universitatea
go
drop procedure if exists task_1_11;
go
create procedure task_1_11
@nota int = 5, @Disciplina varchar(60) = 'Baze de date', @year int = 2018
as
SELECT distinct profesori.Nume_Profesor, profesori.Prenume_Profesor
from studenti_reusita
INNER JOIN profesori
ON studenti_reusita.Id_Profesor = profesori.Id_Profesor
inner join discipline
on discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
where Nota < @nota and @Disciplina = Disciplina
go
execute task_1_11;
```

![Nr1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr1.PNG)

```sql
--12.	Furnizati, in evidenta academica(reusita) a studentilor cu prenumele Alex, urmatoarele date:
--Numele, prenumele, denumirea disciplinei, notele(inclusive la probele intermediate) 
--si anul la care au sustinut.

use universitatea
go
drop procedure if exists task_1_12;
go
create procedure task_1_12
@Prenume varchar(120) = 'Alex'
as
SELECT distinct Nume_Student, Prenume_Student,Disciplina, Nota, YEAR(Data_Evaluare) AS Year
FROM studenti_reusita 
INNER JOIN studenti 
ON studenti.Id_Student = studenti_reusita.Id_Student 
INNER JOIN discipline
ON discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
WHERE Prenume_Student = @Prenume and Nota >= 5
go
execute task_1_12;
```

![Nr1-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr1-1.PNG)


![Nr1-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr1-2.PNG)

2. Sa se creeze o procedura stocata, care nu are niciun parametru de intrare si poseda un parametru de iesire. Parametrul de iesire trebuie sa returneze numarul de studenti, care nu au sustinut cel putin o forma de evaluare (nota mai mica de 5 sau valoare NULL).


```sql
use universitatea
go

drop procedure if exists task2;
go

	create procedure task2
		@Amount_of_bad_students int output
	as
		select @Amount_of_bad_students = count(distinct Id_Student)
		from studenti_reusita where Nota < 5 or Nota is NULL
go

declare @the_count int;
execute task2 @Amount_of_bad_students = @the_count output;

select the_count = @the_count
go
```

![Nr2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr2.PNG)


3. Sa se creeze o procedura stocata, care ar insera in baza de date informatii despre un student nou. In calitate de parametri de intrare sa serveasca datele personale ale studentului nou si Cod_ Grupa. Sa se genereze toate intrarile-cheie necesare in tabelul studenti_reusita. Notele de evaluare sa fie inserate ca NULL.

```sql
use universitatea
go

drop procedure if exists task3;
go

create procedure task3
		@Id_student int,
		@Nume varchar(50),
		@Prenume varchar(50),
		@Data_de_nastere date,
		@Adresa_postala varchar(500),
		@Cod_grupa smallint
	as
		insert dbo.studenti(Id_Student, Nume_Student, Prenume_Student, Data_Nastere_Student
							, Adresa_Postala_Student)
			values(@Id_student, @Nume, @Prenume, @Data_de_nastere, @Adresa_postala)
		insert dbo.studenti_reusita(Id_Student, Id_Disciplina, Id_Grupa, Id_Profesor, Tip_Evaluare
									, Nota, Data_Evaluare)
			values(@Id_student, cast((rand() * 20 + 100) as int), @Cod_Grupa, cast((rand() * 30 + 100) as int)
					, 'Examen', NULL, NULL)
		go

exec task3 @Id_student = 201, @Nume = 'Dolev', @Prenume = 'Kfir', @Data_de_nastere = '1992-08-10'
			, @Adresa_Postala = 'Mun. Chisinau, str. G.Asachi, 60', @Cod_Grupa = 1;
go
```

![Nr3](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr3.PNG)

![Nr3-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr3-1.PNG)

4. Fie ca un profesor se elibereaza din functie la mijlocul semestrului. Sa se creeze o procedura stocata care ar reatribui inregistrarile din tabelul studenti_reusita unui alt profesor. Parametri de intrare: numele si prenumele profesorului vechi, numele si prenumele profesorului nou,disciplina. in cazul in care datele inserate sunt incorecte sau incomplete, sa se afiseze un mesaj de avertizare.

```sql
use universitatea
go

drop procedure if exists task_4;
go

create procedure task_4
	@Nume_old_profesor varchar(60),
	@Prenume_old_profesor varchar(60),
	@Nume_new_profesor varchar(60),
	@Prenume_new_profesor varchar(60),
	@Disciplina varchar(255)
as
	if (@Nume_old_profesor is NULL) or (@Prenume_old_profesor is NULL) or (@Nume_new_profesor is NULL) 
		or (@Prenume_new_profesor is NULL) or (@Disciplina is NULL)
		print 'There are missing values!'

	declare @Id_of_new_profesor int = (select Id_Profesor from profesori 
				where Nume_Profesor = @Nume_new_profesor and Prenume_Profesor = @Prenume_new_profesor)
	declare @Id_of_old_profesor int = (select Id_Profesor from profesori 
				where Nume_Profesor = @Nume_old_profesor and Prenume_Profesor = @Prenume_old_profesor)
	declare @Id_of_discipline int = (select Id_Disciplina from discipline 
				where Disciplina = @Disciplina)

	update studenti_reusita
	set Id_Profesor = @Id_of_new_profesor
	where Id_Disciplina = @Id_of_discipline and Id_Profesor = @Id_of_old_profesor
	go

exec task_4 @Nume_old_profesor = 'Popescu', @Prenume_old_profesor = 'Gabriel'
			, @Nume_new_profesor = 'Nechita', @Prenume_new_profesor = 'Vasile'
			, @Disciplina = 'Cercetari operationale';
go
```
![Nr4](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr4.PNG)

5. Sa se creeze o procedura stocata care ar forma o lista cu primii 3 cei mai buni studenti la o disciplina, si acestor studenti sa le fie marita nota la examenul final cu un punct (nota maximala posibila este 10). In calitate de parametru de intrare, va servi denumirea disciplinei. Procedura sa returneze urmatoarele campuri: Cod_ Grupa, Nume_Prenume_Student, Disciplina, Nota _ Veche, Nota _ Noua.

```sql
use universitatea
go

drop procedure if exists task_5;
go

create procedure task_5
	@Discipline varchar(255)
as
	declare @Id_Best_Students int;
	declare @Id_of_BDisciplina int;
	set @Id_of_BDisciplina = (select Id_Disciplina from discipline where Disciplina = @Discipline);
	declare @Old_notes table(
		Id_Student int,
		Note int,
		Discipline varchar(255)
	)
	insert into @Old_notes
		select top(3) Id_Student, Nota, Disciplina
		from studenti_reusita
		inner join discipline
		on studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
		where Disciplina = @Discipline
		order by Nota desc;
	declare @cursor cursor
	set @cursor = cursor scroll
	for
		select top(3) Id_Student
		from studenti_reusita
		inner join discipline
		on studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
		where Disciplina = @Discipline
		group by Id_Student, Nota
		order by Nota desc;
	open @cursor
	fetch next from @cursor into @Id_Best_Students
	while @@FETCH_STATUS = 0
	begin
		update studenti_reusita
		set Nota = iif(Nota < 10, Nota + 1, Nota)
		where Id_Student = @Id_Best_Students and Id_Disciplina = @Id_of_BDisciplina
		fetch next from @cursor into @Id_Best_Students
	end
	close @cursor

	select distinct studenti_reusita.Id_Student, Nume_Student, Prenume_Student, Nota as New_Nota, Old_Note.Note as Old_Nota, Old_Note.Discipline
	from studenti_reusita
	inner join studenti
	on studenti_reusita.Id_Student = studenti.Id_Student
	inner join @Old_notes as Old_Note
	on Old_Note.Id_Student = studenti_reusita.Id_Student
go

exec task_5 @Discipline = 'Baze de date';
go
```

![Nr5](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr5.PNG)

![Nr5-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr5-1.PNG)



6. Sa se creeze functii definite de utilizator in baza exercitiilor (2 exercitii) din capitolul 4. 
    Parametrii de intrare trebuie sa corespunda criteriilor din clauzele WHERE ale exercitiilor respective.

```sql
--11.	Furnizati numele si prenumele profesorilor, 
--care au predat disciplina Baze de date, in 2018, 
--si au evaluat vreun student cu nota nesatisfacatoare la reusita curenta.
use universitatea
go
--functii de tip tabel simplu
drop function if exists dbo.tabel;
go
create function dbo.tabel(@Disciplina varchar(120), @year date, @nota tinyint)
returns table
as
return
(select distinct profesori.Nume_Profesor, profesori.Prenume_Profesor
from studenti_reusita
INNER JOIN profesori
ON studenti_reusita.Id_Profesor = profesori.Id_Profesor
inner join discipline
on discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
where @Disciplina = Disciplina
and Nota < @nota)
```

![Nr6-11](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr6-11.PNG)

```sql
select *
from dbo.tabel('Baze de date', '2018', '5')
```

![Nr6-11-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr6-11-1.PNG)

```sql
--12.	Furnizati, in evidenta academica(reusita) a studentilor cu prenumele Alex, urmatoarele date:
--Numele, prenumele, denumirea disciplinei, notele(inclusive la probele intermediate) 
--si anul la care au sustinut.

use universitatea
go
--functii de tip tabel simplu
drop function if exists dbo.student
go
create function dbo.student(@Prenume varchar(120))
returns table
as
return
(SELECT distinct Nume_Student, Prenume_Student,Disciplina, Nota, YEAR(Data_Evaluare) AS Year
FROM studenti_reusita 
INNER JOIN studenti 
ON studenti.Id_Student = studenti_reusita.Id_Student 
INNER JOIN discipline
ON discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
WHERE Prenume_Student = @Prenume and Nota >= 5)
```
![Nr6-12](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr6-12.PNG)

```sql
select *
from dbo.student('Alex')
```
![Nr6-12-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr6-12-1.PNG)

![Nr6-12-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr6-12-2.PNG)


7. Sa se scrie functia care ar calcula varsta studentului. Sa se defineasca urmatorul format al functiei: <nume_functie>(<Data_Nastere_Student>).


```sql
use universitatea
go
Select  getdate() as CurrentDate
Go
Declare @CurrentDate datetime = getdate()
--Brasovianu Teodora
Declare @Data_Nastere_Student datetime = '2000-11-24'
Select  DATEDIFF( Year, @Data_Nastere_Student, @CurrentDate) as Age
```
Sau

```sql
use universitatea
go
drop function if exists dbo.varsta;
go
CREATE FUNCTION dbo.varsta(@Data_Nastere_Student DATETIME, @Current_Date datetime='2018-11-25')
returns int
as
begin
declare @age int
select @age = datediff(YY, @Data_Nastere_Student, @Current_Date)-
case when(
		(MONTH(@Data_Nastere_Student)*100 + DAY(@Data_Nastere_Student)) >
      (MONTH(@Current_Date)*100 + DAY(@Current_Date))
	  ) then 1
	  else 0
end
return @age
end
go
```
![Nr7](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr7.PNG)

We open new Query:

```sql
select dbo.varsta('2000-11-24', '2018-11-27')
select*
from studenti
```

![Nr7-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr7-1.PNG)

8. Sa se creeze o functie definita de utilizator, care ar returna datele referitoare la reusita unui student. Se defineste urmatorul format al functiei: (<Nume_Prenume_Student>). Sa fie afisat tabelul cu urmatoarele campuri: Nume_Prenume_Student, Disticplina, Nota, Data_Evaluare.

```sql
use universitatea
go
--functii de tip tabel simplu
drop function if exists dbo.tabel8;
go
create function dbo.tabel8(@student varchar(120))
returns table
as
return
(select distinct (Nume_Student+' '+Prenume_Student) as Name_Student_Name, Disciplina, Nota, Data_Evaluare
from studenti_reusita
inner join studenti
ON studenti.Id_Student = studenti_reusita.Id_Student
inner join discipline
on discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
where @student = (Nume_Student+' '+Prenume_Student) and Nota >= 5)
```
![Nr8](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr8.PNG)

```sql
select *
from dbo.tabel8('Brasovianu Teodora')
```
![Nr8-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr8-1.PNG)

![Nr8-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr8-2.PNG)



9. Se cere realizarea unei functii definite de utilizator, care ar gasi cel mai sarguincios sau cel mai slab student dintr-o grupa. Se defineste urmatorul format al functiei: (<Cod_ Grupa>, <is_good>). Parametrul <is_good> poate accepta valorile "sarguincios" sau "slab", respectiv. Functia sa returneze un tabel cu urmatoarele campuri Grupa, Nume_Prenume_Student, Nota Medie , is_good. Nota Medie sa fie cu precizie de 2 zecimale.

```sql
use universitatea
go
--functii de tip tabel simplu
drop function if exists dbo.tabel9;
go
create function dbo.tabel9(@Cod_Grupa char(6), @is_good varchar(15))
returns @result table(Nume_Prenume_Student varchar(120), Cod_Grupa char(6), Nota_Medie decimal (4,2), Parametrul varchar(15) )
as

begin
if @is_good = 'sarguincios'

begin
insert into @result
select top(1) Nume_Student+' '+Prenume_Student as Nume_Prenume_Student, Cod_Grupa as Grupa
				,cast(avg(Nota*1.0) as decimal (4,2)) as Nota_Medie, @is_good
from grupe 
inner join studenti_reusita
on studenti_reusita.Id_Grupa = grupe.Id_Grupa
inner join studenti
on studenti.Id_Student = studenti_reusita.Id_Student
where @Cod_Grupa = Cod_Grupa
group by Nume_Student, Prenume_Student, Cod_Grupa
order by avg(Nota) desc
end

else

begin
if @is_good = 'slab'
begin
insert into @result
select top(1) Nume_Student+' '+Prenume_Student as Nume_Prenume_Student, Cod_Grupa as Grupa
				,cast(avg(Nota*1.0) as decimal (4,2)) as Nota_Medie, @is_good
from grupe 
inner join studenti_reusita
on studenti_reusita.Id_Grupa = grupe.Id_Grupa
inner join studenti
on studenti.Id_Student = studenti_reusita.Id_Student
where @Cod_Grupa = Cod_Grupa
group by Nume_Student, Prenume_Student, Cod_Grupa
order by avg(Nota) asc
end

end
return 
end
```

![Nr9](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr9.PNG)

TI171

```sql
select *
from dbo.tabel9('TI171', 'slab')
```

![Nr9-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr9-1.PNG)

![Nr9-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr9-2.PNG)

CIB171

```sql
select *
from dbo.tabel9('CIB171', 'sarguincios')
```

![Nr9-3](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr9-3.PNG)

![Nr9-4](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr9-4.PNG)


INF171

```sql
select *
from dbo.tabel9('INF171', 'slab')
```

![Nr9-5](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr9-5.PNG)

![Nr9-6](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-9/image/Nr9-6.PNG)
