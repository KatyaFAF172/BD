# Laboratory work Nr.4

Introduction
===

The COUNT() function returns the number of rows that matches a specified criteria.

COUNT() Syntax
SELECT COUNT(column_name)
FROM table_name
WHERE condition;



The AVG() function returns the average value of a numeric column.

AVG() Syntax
SELECT AVG(column_name)
FROM table_name
WHERE condition;



The LEFT JOIN keyword returns all records from the left table (table1), 
and the matched records from the right table (table2). The result is NULL from the right side, if there is no match.

LEFT JOIN Syntax
SELECT column_name(s)
FROM table1
LEFT JOIN table2 ON table1.column_name = table2.column_name;



The CAST() function converts a value (of any type) into a specified datatype.

Syntax
CAST(expression AS datatype(length))



The FULL OUTER JOIN keyword return all records when there is a match in either left (table1) or right (table2) table records.

Note: FULL OUTER JOIN can potentially return very large result-sets!

FULL OUTER JOIN Syntax
SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2 ON table1.column_name = table2.column_name;




Tasks:

11.	Furnizati numele si prenumele profesorilor, care au predat disciplina Baze de date, in 2018, 
si au evaluat vreun student cu nota nesatisfacatoare la reusita curenta.

SELECT profesori.Nume_Profesor, profesori.Prenume_Profesor, studenti_reusita.Id_Disciplina, studenti_reusita.nota
FROM profesori 
INNER JOIN studenti_reusita 
ON profesori.Id_Profesor = studenti_reusita.Id_Profesor AND YEAR(Data_Evaluare) = 2018 AND Nota <5 AND Id_Disciplina = 107


![Nr11](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Nr.11.png)



12.	Furnizati, in evidenta academica(reusita) a studentilor cu prenumele Alex, urmatoarele date:
Numele, prenumele, denumirea disciplinei, notele(inclusive la probele intermediate) si anul la care au sustinut.


SELECT Nume_Student, Prenume_Student,Disciplina, Nota, YEAR(Data_Evaluare) AS Year
FROM studenti_reusita 
INNER JOIN studenti 
ON studenti.Id_Student = studenti_reusita.Id_Student 
INNER JOIN discipline
ON discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
WHERE Prenume_Student = 'Alex' 
ORDER BY Prenume_Student;

![Nr12](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Nr.12.png)

![Nr12-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Nr.12-1.png)


25. In ce grupe de studii(Cod_Grupa) figureaza mai mult de 24 de studentii? 

SELECT
    Cod_Grupa, COUNT(DISTINCT Id_Student) AS student_number
FROM
    grupe
        LEFT OUTER JOIN
    studenti_reusita ON studenti_reusita.Id_Grupa = grupe.Id_Grupa
GROUP BY grupe.Cod_Grupa
HAVING  count(Id_Student) > 24
ORDER BY student_number DESC , grupe.Cod_Grupa
;

![Nr25](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-4/image/Nr.25.png)


35. gasiti denumirile disciplinelor si media notelor pe disciplina. afisati numai disciplinele cu medii mai mari de 7.0
SELECT discipline.Disciplina, AVG(CAST(Nota AS Float)) AS Media
FROM studenti_reusita
FULL JOIN discipline ON discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
GROUP BY discipline.Disciplina
HAVING  AVG(CAST(Nota AS FLOAT)) > 7.0
ORDER BY  media

![Nr35](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-4/image/Nr.35.png)

Conclusions:
The table comprises of rows and columns. So while creating tables we have to provide all the information 
to SQL about the names of the columns, type of data to be stored in columns, size of the data etc.
Designing tables to store our data is an essential responsibility of a database developer.
