# Laboratory work Nr.8

Administrarea Viziunilor si a Expresiilor-Table

Tasks
======

1. Sa se creeze doua viziuni in baza interogarilor formulate in doua exercitii indicate din capitolul 4. Prima viziune sa fie construita in *Editorul de interogari*, iar a doua, utilizand View Designer.

*Editorul de interogari*:

        11.	Furnizati numele si prenumele profesorilor, care au predat disciplina Baze de date, in 2018, 
            si au evaluat vreun student cu nota nesatisfacatoare la reusita curenta.

            use universitatea
            go
            drop view if exists dbo.task11;
            go
            --crearea viziune task11
            create view task11 as 
	        select distinct profesori.Nume_Profesor, profesori.Prenume_Profesor
	        , studenti_reusita.Id_Disciplina, studenti_reusita.nota
	        from profesori 
	        INNER JOIN studenti_reusita 
	        ON profesori.Id_Profesor = studenti_reusita.Id_Profesor 
	        AND YEAR(Data_Evaluare) = 2018 AND Nota <5 AND Id_Disciplina = 107
            go
            --test interogare viziune
            select * from task11



![Nr1-11](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr1-11.png)


![Nr1-11-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr1-11-1.png)


*View Designer*:

![Nr1-11-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr1-11-2.png)



*Editorul de interogari*:


        12.Furnizati, in evidenta academica(reusita) a studentilor cu prenumele Alex, urmatoarele date:
            Numele, prenumele, denumirea disciplinei, notele(inclusive la probele intermediate) si anul la care au sustinut.

            use universitatea
            go
            drop view if exists dbo.task12;
            go
            --crearea viziune task12
            create view task12 as 
	        select Nume_Student, Prenume_Student,Disciplina, Nota, YEAR(Data_Evaluare) AS Year
	        FROM studenti_reusita 
	        INNER JOIN studenti 
	        ON studenti.Id_Student = studenti_reusita.Id_Student 
	        INNER JOIN discipline
	        ON discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
	        WHERE Prenume_Student = 'Alex' 
            go
            --test interogare viziune
            select * from task12
        

![Nr1-12](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr1-12.png)

![Nr1-12-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr1-12-1.png)


*View Designer*:

![Nr1-12-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr1-12-2.png)


2. Sa se scrie cate un exemplu de instructiuni *INSERT, UPDATE, DELETE* asupra viziunilor create. Sa se adauge comentariile respective referitoare la rezultatele executarii acestor instructiuni.

 --To change the data type of a column in a table
alter view task11 as 
	        select distinct profesori.Nume_Profesor, profesori.Prenume_Profesor
	        , studenti_reusita.Id_Disciplina, studenti_reusita.nota
	        from profesori 
	        INNER JOIN studenti_reusita 
	        ON profesori.Id_Profesor = studenti_reusita.Id_Profesor 
	        AND YEAR(Data_Evaluare) = 2018 AND Nota <5 AND Id_Disciplina = 107
 go
 --test interogare viziune
select * from task11
go
alter  view task11_2 as
		select profesori.Nume_Profesor, profesori.Prenume_Profesor
		from profesori
go
--delete column
delete from profesori
where Nume_Profesor='Gal'
go
--insert values
insert into task11
	values('Gal', 'Gadot')
go
select * from task11_2
go
--update table
update task11
set Nume_Profesor='Adrei', Prenume_Profesor='Cojusco'
where Id_Profesor = 101
select * from task11
--delete
delete from task11_2 where Prenume_Profesor='Gadot'
select * from task11_2


![Nr2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr2.png)

![Nr2-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr2-1.png)

![Nr2-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr2-2.png)

3. Sa se scrie instructiunile SQL care ar modifica viziunile create 9 in exercitiu 1) in asa fel, incat sa nu fie posibila modificarea sau stergerea tabelelor pe care acestea sunt definite si viziunile sa nu accepte operatiuni DML, daca conditiile clauzei *WHERE* nu sunt satisfacute.


use universitatea
go
drop view if exists dbo.exemplul3;
go
--crearea viziune 
create view exemplul3 (Nume_Profesor, Prenume_Profesor, Id_Disciplina, nota) 
with schemabinding as
select distinct profesori.Nume_Profesor, profesori.Prenume_Profesor
, studenti_reusita.Id_Disciplina, studenti_reusita.nota
from dbo.profesori 
INNER JOIN dbo.studenti_reusita 
ON profesori.Id_Profesor = studenti_reusita.Id_Profesor 
where YEAR(Data_Evaluare) = 2018 AND Nota <5 AND Id_Disciplina = 107
with check option;
go
            --try to remove the column attached to the view
            alter table profesori drop column Prenume_Profesor
go
            --trying to insert into view
            insert into exemplul3
                values('Andrei', 'Cojusco')
go
--show
select * from exemplul3

4. Sa se scrie instructiunile de testare a proprietatilor noi definite.

CHECK OPTION
Forces all data modification statements executed against the view to follow the criteria set within select_statement. When a row is modified through a view, the WITH CHECK OPTION makes sure the data remains visible through the view after the modification is committed.

use universitatea
go
drop view if exists dbo.exemplul4;
go
--view cu conditie de filtru
create view exemplul4 as
	        select profesori.Nume_Profesor, profesori.Prenume_Profesor
	        , studenti_reusita.Id_Disciplina, studenti_reusita.nota
	        from profesori 
	        INNER JOIN studenti_reusita 
	        ON profesori.Id_Profesor = studenti_reusita.Id_Profesor 
	        AND YEAR(Data_Evaluare) = 2018 AND Nota <5 AND Id_Disciplina = 107
			with check option;
 go
 --test interogare viziune
select * from exemplul4
go


![Nr4](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr4.png)

![Nr4-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr4-1.png)

5. Sa se rescrie 2 interogari formulate in exercitiile din capitolul 4, in asa fel. incat interogarile imbricate sa fie redate sub forma expresiilor CTE.

 with check_note_data (Id_Profesor, Nota, Id_Disciplina) as
 (select Id_Profesor, Nota, Id_Disciplina
	        from studenti_reusita
			where YEAR(Data_Evaluare) = 2018 AND Nota <5 AND Id_Disciplina = 107)
select distinct Nume_Profesor, Prenume_Profesor, Nota, Id_Disciplina
	        from profesori 
	        INNER JOIN check_note_data studenti_reusita 
	        ON profesori.Id_Profesor = studenti_reusita.Id_Profesor; 

![Nr5](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr5.png)


6. Se considera un graf orientat, precum cel din figura de mai jos


with f(id, Fact) as (select 5,0
                union all
                select id-1, ((-1)*(id-2)*((id-1)*(id-1)-5*(id-1)))/6 from f
                where id-1>0)

select * from f


![Nr6](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-8/image/Nr6.png)