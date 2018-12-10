# Laboratory work Nr.11



Tasks
======

1. Sa se creeze un dosar Backup_labll. Sa se execute un backup complet al bazei de date universitatea in acest dosar. Fisierul copiei de rezerva sa se numeasca exercitiull.bak. Sa se scrie instructiunea SQL respectiva.

```sql
if EXISTS (select * from master.dbo.sysdevices where name='backup11')
exec sp_dropdevice 'backup11' , 'delfile';
go
exec sp_addumpdevice 'disk','backup11','D:\Anul II\SQL\Backup_lab11\exercitiul1.bak';
go
backup database universitatea
to disk = 'D:\Anul II\SQL\Backup_lab11\exercitiul1.bak'
with format,
name = 'universitatea = Full backup of universitatea';
go
```

![Nr1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-11/image/Nr1.PNG)

![Nr1-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-11/image/Nr1-1.PNG)


2. Sa se scrie instructiunea unui backup diferentiat al bazei de date universitatea. Fisierul copiei de rezerva sa se numeasca exercitiul2.bak.


```sql
use universitatea;
go
backup database universitatea
to disk = 'D:\Anul II\SQL\Backup_lab11\exercitiul2.bak'
with DIFFERENTIAL,
name = 'universitatea : Differential backup of universitatea';
go
```

![Nr2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-11/image/Nr2.PNG)

![Nr2-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-11/image/Nr2-1.PNG)


3. Sa se scrie instructiunea unui backup al jurnalului de tranzactii al bazei de date universitatea. Fisierul copiei de rezerva sa se numeasca exercitiul3.bak


```sql
use master;
go
exec sp_addumpdevice 'disk','backup_log',
'D:\Anul II\SQL\Backup_lab11\exercitiul3.bak';
go
backup LOG universitatea 
to disk = 'D:\Anul II\SQL\Backup_lab11\exercitiul3.bak';
go
```

![Nr3](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-11/image/Nr3.PNG)


![Nr3-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-11/image/Nr3-1.PNG)

4. Sa se execute restaurarea consecutiva a tuturor copiilor de rezerva create. Recuperarea trebuie sa fie realizata intr-o baza de date noua universitatea_labll. Fisierele bazei de date noi se afla in dosarul BD_labll. Sa se scrie instructiunile SQL respective.

```sql
restore database [universitatea_lab11] 
  from  disk = 'D:\Anul II\SQL\Backup_lab11\exercitiul1.bak' 
  with  file = 1,  
  move 'universitatea' to 'D:\Anul II\SQL\Backup_lab11\universitatea_lab11.mdf',  
  MOVE 'universitatea_log' to 'D:\Anul II\SQL\Backup_lab11\universitatea_lab11_log.ldf',  
  NORECOVERY,  NOUNLOAD,  REPLACE
GO
restore database [universitatea_lab11] 
  from  disk = 'D:\Anul II\SQL\Backup_lab11\exercitiul2.bak' 
 with  file = 1,  
 move 'universitatea' to 'D:\Anul II\SQL\Backup_lab11\universitatea_lab11.mdf',  
 move N'universitatea_log' to 'D:\Anul II\SQL\Backup_lab11\universitatea_lab11_log.ldf',  
  NORECOVERY,  NOUNLOAD,  REPLACE
go
restore LOG [universitatea_lab11] 
from disk = N'D:\Anul II\SQL\Backup_lab11\exercitiul3.bak' 
with file = 1,  
NOUNLOAD
go
```

![Nr4](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-11/image/Nr4.PNG)

![Nr4-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-11/image/Nr4-1.PNG)

