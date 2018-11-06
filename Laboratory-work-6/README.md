# Laboratory work Nr.6

Tasks
======

1. Sa se scrie o instructiune T-SQL, care ar popula coloana Adresa_Postala_Profesor din tabelul profesori cu valoarea *'mun.Chisinau'*, unde adresa este necunoscuta.

UPDATE Syntax

UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;


![Nr1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-6/image/Nr1.png)

![Nr1-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-6/image/Nr1-1.png)


2. Sa se modifice schema tabelului grupe, ca sa corespunda urmatoarelor cerinte:

a) Campul Cod_Grupa sa accepte numai valorile unice si sa nu accepte valori necunoscute.

The ALTER TABLE statement is used to add, delete, or modify columns in an existing table.

The ALTER TABLE statement is also used to add and drop various constraints on an existing table.

*ALTER TABLE - ADD Column*
ALTER TABLE table_name
ADD column_name datatype;

*ALTER TABLE - DROP COLUMN*
ALTER TABLE table_name
DROP COLUMN column_name;

*ALTER TABLE - ALTER/MODIFY COLUMN*
SQL Server / MS Access:

ALTER TABLE table_name
ALTER COLUMN column_name datatype;

*SQL UNIQUE Constraint on ALTER TABLE*
To create a UNIQUE constraint on the "ID" column when the table is already created, use the following SQL:

MySQL / SQL Server / Oracle / MS Access:

ALTER TABLE table_name
ADD UNIQUE (column_name);

![Nr2-a](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-6/image/Nr2-a.png)


b) Sa se tina cont ca cheie primara, deja, este definita asupra coloanei Id_Grupa.

*Change Data Type Example*

ALTER TABLE table_name
ALTER COLUMN column_name;

![Nr2-b](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-6/image/Nr2-b.png)




3. La tabelul *grupe*, sa se adauge 2 coloane noi *Sef_grupa* si *Prof_Indrumator*, ambele de tip *INT*. Sa se populeze campurile nou-create cu cele mai potrivite candidaturi in baza criteriilor de mai jos:

a) *Seful grupei* trebuie sa aiba cea mai buna reusita (medie) din grupa la toate formele de evaluare si la toate disciplinele. Un student nu poate fi sef de grupa la mai multe grupe.

DECLARE @id_grupa_current INT 
		, @group_count INT;
SET @id_grupa_current = 0;
SET @group_count = (SELECT count(Id_Grupa)
                    FROM grupe);
WHILE @id_grupa_current < @group_count 
BEGIN
    SET @id_grupa_current = @id_grupa_current + 1
    update grupe
    SET Sef_grupa =  (
        SELECT DISTINCT Id_Student
        FROM studenti_reusita
        WHERE Id_Student in (SELECT Id_Student 
            FROM studenti_reusita
            GROUP BY Id_Student, Id_Grupa

            HAVING avg(cast(Nota AS FLOAT)) = any(
                SELECT max(media)
                FROM (
                SELECT  Id_Grupa, Id_Student, avg(cast(studenti_reusita.Nota AS FLOAT)) AS media
                FROM studenti_reusita
                GROUP BY Id_Student, Id_Grupa) AS T
                GROUP BY Id_Grupa
            ) and Id_Grupa = @id_grupa_current
        ) 
    )
    WHERE Id_Grupa = @id_grupa_current
	END;

![Nr3-a](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-6/image/Nr3-a.png)

![Nr3-a-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-6/image/Nr3-a-1.png)

![Nr3-a-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-6/image/Nr3-a-2.png)


b) *Profesorul indrumator* trebuie sa predea un numar maximal posibil de discipline la grupa data. Daca nu exista o singura candidatura, care corespunde primei cerinte, atunci este ales din grupul de candidati acel cu identificatorul (Id_Profesor) minimal. Un profesor nu poate fi indrumator la mai multe grupe.



c)Sa se scrie instructiunile *ALERT, SELECT, UPDATE* necesare pentru crearea coloanelor in tabelul grupe, pentru selectarea candidatilor si inserarea datelor.



4. Sa se scrie o instructiune T-SQL, care ar mari toate notele de evaluare sefilor de grupe cu un punct. Nota maximala (10) nu poate fi marita.

5. Sa se creeze un tabel *profesori_new*, care include urmatoarele coloane:
Id_Profesor, Nume_Profesor, Prenume_Profesor, Localitate, Adresa_1, Adresa_2.

a) Coloana *Id_Profesor* trebuie sa fie definita drept cheie primara si, in baza ei, sa fie construit un index CLUSTERED.

b) Campul *Localitate* trebuie sa posede proprietatea DEFAULT = "mun.Chisinau".

c) Sa se insereze toate datele din tabelul *profesori* in tabelul *profesori_new*. Sa se scrie, cu acest scop, un numar potrivit de instructiuni T-SQL. Datele trebuie sa fie transferate in felul urmator:


In coloana *Localitate* sa fie inserata doar informatia despre denumirea localitatii din coloana-sursa *Adresa_Postala_Profesor*. In coloana Adresa_1, doar denumirea strazii. In coloana Adresa_2, sa se pastreze numarul casei si (posibil) a apartamentului.

USE universitatea
SELECT  Id_Profesor, 
		Nume_Profesor, 
		Prenume_Profesor, 
		Adresa_Postala_Profesor as Localitate, 
		substring(Adresa_Postala_Profesor, charindex('str.', Adresa_Postala_Profesor), 15) as Adresa_1, 
		substring(Adresa_Postala_Profesor, charindex(', ', Adresa_Postala_Profesor), 5) as Adresa_2

into profesori_new
from profesori

alter table profesori_new
add default 'Mun. Chisinau' for Localitate;
alter table profesori_new   
add constraint Id_Profesor PRIMARY KEY CLUSTERED (Id_Profesor);

![Nr5](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-6/image/Nr5.png)


6. Sa se insereze datele in tabelul *orarul* pentru Grupa = 'CIB171' (Id_Grupa = 1) pentru ziua de luni. Toate lectiile vor avea loc in blocul de studii 'B'. Mai jos, sunt prezentate detaliile de inserare:

(Id_Disciplina = 107, Id_Profesor = 101, Ora = '08:00', Auditoriu = 202);
(Id_Disciplina = 108, Id_Profesor = 101, Ora = '11:30', Auditoriu = 501);
(Id_Disciplina = 119, Id_Profesor = 117, Ora = '13:00', Auditoriu = 501);


7. Sa se scrie expresiile T-SQL necesare pentru a popula tabelul *orarul* pentru grupa INF171, ziua de luni.

Datele necesare pentru inserare trebuie sa fie colectate cu ajutorul instructiunii/instructiunilor SELECT si introduse in tabelul-destinatie, stiind ca:

lectie #1 (Ora = '08:00', Disciplina = 'Structuri de date si algoritmi', Profesor = 'Bivol Ion')
lectie #2 (Ora = '11:30', Disciplina = 'Programe aplicative', Profesor = 'Mircea Sorin')
lectie #3 (Ora = '13:00', Disciplina = 'Baze de date', Profesor = 'Micu Elena')

8. Sa se scrie interogarile de creare a indecsilor asupra tabelelor din baza de date *universitatea* pentru a asigura o performanta sporita la executarea interogarilor SELECT din Lucrarea practica 4. Rezultatele optimizarii sa fie analizate in baza planurilor de executie, pana la si dupa crearea indecsilor.

Indecsii nou-creati sa fie plasati fizic in grupul de fisiere userdatafgroup1.


select distinct Id_Disciplina, Id_Profesor, Id_Grupa
into orarul
from studenti_reusita
where Id_Grupa = 1 or Id_Grupa = 2 
alter table orarul add ora varchar(5) NULL, Auditoriu int NULL;
go

create nonclustered index NIX_task6  
    on orarul (Id_Disciplina, Id_Profesor, Id_Grupa)  
go

alter database universitatea
add file (name = FGTask6, filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\FGTask6.ndf')
to filegroup userdatafgroup1;

update orarul set ora = '08:00', Auditoriu = 202 where Id_Disciplina = 107 and Id_Grupa = 1;
update orarul set ora = '11:30', Auditoriu = 501 where Id_Disciplina = 108 and Id_Grupa = 1;
update orarul set ora = '13:00', Auditoriu = 501 where Id_Disciplina = 119 and Id_Grupa = 1;
go

update orarul set ora = '08:00', Auditoriu = 123 where Id_Disciplina = 108 and Id_Grupa = 2;
update orarul set ora = '11:30', Auditoriu = 321 where Id_Disciplina = 120 and Id_Grupa = 2;
update orarul set ora = '13:00', Auditoriu = 602 where Id_Disciplina = 107 and Id_Grupa = 2;
go

create nonclustered index NIX_task6  
    on orarul (Id_Disciplina, Id_Profesor, Id_Grupa)  
    with (DROP_EXISTING = on)  
    on userdatafgroup1; 


![Nr6_7_8](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-6/image/Nr6_7_8.png)