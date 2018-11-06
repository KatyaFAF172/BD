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



![Nr6_7_8](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-6/image/Nr6_7_8.png)