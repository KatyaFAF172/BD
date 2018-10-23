# Laboratory work Nr.3

Database Creation and Manipulation. DML
===

1.	Care din numerele prezentate mai jos pot fi introduse intr-un camp de tipul DECIMAL(4,1)?

Decimal (4,1) is a number that has 3 digits before the decimal and 1 digit after the decimal.
Correct answer: b) 116,2

a, c, d, e-nu correct:
16,2 its type is Decimal (3,1)
16,21 its type is Decimal (4,2)
1116,2 its type is Decimal (5,1)
1116,21 its type is Decimal (6,2)

Create 4 tables as indicated in section 3.3 of the chapter. We create the necessary number of columns, 
we specify the Primary key and name of the table. 

Create Table Columns:
The design interface presents us with a three-column grid to specify the table properties. 
For each attribute we wish to store in the table, we will need to identify:

Column Name: This is, quite simply, the name of the attribute. Each database attribute is similar to a variable; 
it is a single data item that our database will store for each record. 

Data Type: The data type specifies the type of information that we will store in each column. 
For example, a person's first name consists of a string of letters, so we might use the varchar(4) data type to indicate 
that the column will contain a variable length string that is no longer than 4 characters. 

Allow Nulls: This is simply a checkbox. If we check it, the database will allow we to store null (or blank) values in that column.

Next step:  Identify a Primary Key.

Name and save table.
After make a click with the right mouse button on dbo file and select the option: Edit Top 200 Rows. 
Now, we can enter data into the table. 

![Diagram_0](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Diagram_0.png)

To create the new database diagram, we will need to right click on Database Diagrams folder and click on New Database Diagram. 
A window will appear with list of all the tables in our database. To add the tables to the diagram select them (use Control 
or Shift keys to select multiple at once) and click Add button or double click on them. 
When we add all required tables click Close button. This will create a diagram with the tables columns, primary keys, 
and relationships that were read from the schema.

1.	Aflati toate datele despre grupele de studii de la facultate.
2.	Sa se obtine lista disciplinelor in ordine descrescatoare a numarului de ore.

SELECT	Disciplina, Nr_ore_plan_disciplina FROM discipline
ORDER BY Nr_ore_plan_disciplina DESC;

![Q2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Q2.png)

3.	Aflati cursurile predate de fiecare profesor sortate descrescator dupa nume si apoi prenume.

4.	Afisati care dintre discipline au denumirea formata din mai mult de 20 de caractere?

SELECT	Disciplina FROM discipline WHERE LEN(Disciplina)>= 20;

![Q4](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Q4.png)

5.	Sa se afiseze lista studentilor al caror nume se termina in “u”

SELECT *FROM studenti WHERE Nume_Student LIKE '%u';

![Q5](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Q5.png)

6.	Afisati numele si prenumele primilor 5 studentii, care au obtinut note in ordine descrescatoare 
la al doilea test de la disciplina Baze de date. Sa se folosesc optiunea TOP…WITH TIES.

SELECT TOP (5) WITH TIES Tip_Evaluare, Nota, Id_Student, Id_Disciplina
FROM studenti_reusita 
WHERE Tip_Evaluare LIKE '%test2' AND Id_Disciplina = 107
ORDER BY Nota DESC;
GO
SELECT Nume_Student, Prenume_Student
FROM studenti ORDER BY Id_Student 

![Q6](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Q6.png)

7.	In ce grupa invata studentii care locuiesc pe strada 31 August?

SELECT Id_Student, Nume_Student, Prenume_Student, Adresa_Postala_Student 
FROM studenti WHERE Adresa_Postala_Student LIKE '%strada August 31'
GO 
SELECT Id_Grupa ,Cod_Grupa
FROM grupe1
GO
SELECT Id_Grupa, Id_Student
FROM studenti_reusita

![Q7](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Q7.png)

8.	Obtineti identificatorii si numele studentilor, ale examenelor sustinute in anul 2018.

SELECT Id_Student, Data_Evaluare
FROM studenti_reusita 
WHERE YEAR(Data_Evaluare) = 2018
GO 
SELECT Id_Student, Nume_Student, Prenume_Student
FROM studenti

![Q8](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Q8.png)

9.	Gasiti numele, aadresa studentilor si codul disciplinei la care studentii au avut cel putin o nota mai mare decat 8 in 2018.


SELECT Nume_Student, Adresa_Postala_Student
FROM studenti 
GO
SELECT Id_Student, Id_Disciplina, Nota, Data_Evaluare
FROM studenti_reusita
WHERE YEAR(Data_Evaluare) = 2018 AND Nota > 80

![Q9](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Q9.png)

10.	Gasiti studentii(numele, prenumele), care au obtinut la disciplina Baze de date(examen), in anul 2018, 
vreo nota mica de 8 si mai mare ca 4.

SELECT Nume_Student, Prenume_Student
FROM studenti 
GO
SELECT Id_Student, Id_Disciplina, Nota, Data_Evaluare
FROM studenti_reusita
WHERE YEAR(Data_Evaluare) = 2018 AND Nota BETWEEN 40 AND 80 AND Id_Disciplina = 107

![Q10](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Q10.png)

11.	Furnizati numele si prenumele profesorilor, care au predat disciplina Baze de date, in 2018, si au evaluat 
vreun student cu nota nesatisfacatoare la reusita curenta.


SELECT Id_Profesor, Nume_Profesor, Prenume_Profesor
FROM profesori 
GO
SELECT Id_Disciplina, Id_Profesor, Id_Student, Nota, Data_Evaluare
FROM studenti_reusita
WHERE YEAR(Data_Evaluare) = 2018 AND Nota <50 AND Id_Disciplina = 107

![Q11](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-3/image/Q11.png)

Conclusions:
 The table comprises of rows and columns. So while creating tables we have to provide all the information to SQL about 
 the names of the columns, type of data to be stored in columns, size of the data etc. Designing tables to store our data
 is an essential responsibility of a database developer. 