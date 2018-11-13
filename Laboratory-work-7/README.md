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


![Nr3](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-7/image/Nr3.png)



4. Tabelul orarul trebuie sa contina si 2 chei secundare: (Zi, Ora, Id_ Grupa, Id_ Profesor) si (Zi, Ora, ld_Grupa, ld_Disciplina).

5. In diagrama, de asemenea, trebuie sa se defineasca constrangerile referentiale (FK-PK) ale atributelor *ld_Disciplina, ld_Profesor, Id_ Grupa* din tabelului orarul cu atributele tabelelor respective.

6. Creati, in baza de date universitatea, trei scheme noi: *cadre_didactice, plan_studii* si *studenti*. Transferati tabelul profesori din schema dbo in schema cadre didactice, tinind cont de dependentele definite asupra tabelului mentionat. In acelasi mod sa se trateze tabelele orarul,discipline care apartin schemei plan_studii și tabelele studenți, studenti_reusita, care apartin schemei studenti. Se scrie instructiunile SQL respective.

7. Modificati 2-3 interogari asupra bazei de date universitatea prezentate in capitolul 4 astfel ca numele tabelelor accesate sa fie descrise in mod explicit, tinind cont de faptul ca tabelele au fost mutate in scheme noi.

8. Creati sinonimele respective pentru a simplifica interogarile construite in exercitiul precedent si reformulati interogarile, folosind sinonimele create.