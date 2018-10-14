SELECT Nume_Student, Prenume_Student,Disciplina, Nota, YEAR(Data_Evaluare)
FROM studenti_reusita 
INNER JOIN studenti 
ON studenti.Id_Student = studenti.Id_Student 
INNER JOIN discipline
ON discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
WHERE Prenume_Student = 'Alex' 
ORDER BY Prenume_Student;