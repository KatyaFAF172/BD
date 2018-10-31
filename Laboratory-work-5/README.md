# Laboratory work Nr.5

TRANSACT-SQL: INSTRUCTIUNI PROCEDURALE
===

Task 1

Completati urmatorul cod pentru a afisa cel mai mare numar dintre cele trei numere prezentate:

DECLARE @N1 INT, @N2 INT, @N3 INT;
DECLARE @MAI_MARE INT;
SET @N1 = 60 * RAND();
SET @N2 = 60 * RAND();
SET @N3 = 60 * RAND();

--Aici ar trebui plasate IF-urile-----

PRINT @N1;
PRINT @N2;
PRINT @N3;
PRINT 'Mai mare = ' + CAST(@MAI_MARE AS VARCHAR(2));

![Nr1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-5/image/Nr1.png)


Task 2

Afisati primele zece date (numele, prenumele studentului) in functie de valoarea notei (cu exceptia notelor 6 si 8) a studentului la primul test al disciplinei *Bazei de date*, folosind structura de alternativa *IF...ELSE*. Sa se foloseasca variabilele.

![Nr2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-5/image/Nr2.png)

![Nr2-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-5/image/Nr2-1.png)

RESULT:

![Nr2-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-5/image/Nr2-2.png)


Task 3

Rezolvati aceeasi sarcina, 1, apeland la structura selectiva *CASE*.

![Nr3](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-5/image/Nr3.png)

Task 4

Modificati exercitiile din sarcinile 1 si 2 pentru a inclde procesarea erorilor cu *TRY* si *CATCH*, si *RAISERROR*.

SYNTAX

BEGIN TRY  
     { sql_statement | statement_block }  
END TRY  
BEGIN CATCH  
     [ { sql_statement | statement_block } ]  
END CATCH  
[ ; ]  

ARGUMENTS

*sql_statement*
Is any Transact-SQL statement.

*statement_block*
Any group of Transact-SQL statements in a batch or enclosed in a BEGIN…END block. 

A TRY…CATCH construct catches all execution errors that have a severity higher than 10 that do not close the database connection.

Retrieving Error Information

In the scope of a CATCH block, the following system functions can be used to obtain information about the error that caused the CATCH block to be executed:
*ERROR_NUMBER()* returns the number of the error.

*ERROR_SEVERITY()* returns the severity.

*ERROR_STATE()* returns the error state number.

*ERROR_PROCEDURE()* returns the name of the stored procedure or trigger where the error occurred.

*ERROR_LINE()* returns the line number inside the routine that caused the error.

*ERROR_MESSAGE()* returns the complete text of the error message. The text includes the values supplied for any substitutable parameters, such as lengths, object names, or times.

These functions return NULL if they are called outside the scope of the CATCH block.

![Nr4-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-5/image/Nr4-1.png)

![Nr4-1-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-5/image/Nr4-1-1.png)

RAISERROR

Syntax

RAISERROR ( { msg_id | msg_str | @local_variable }  
    { ,severity ,state }  
    [ ,argument [ ,...n ] ] )  
    [ WITH option [ ,...n ] ]  

 ARGUMENTS

*msg_id*
Is a user-defined error message number stored in the sys.messages catalog view using sp_addmessage. Error numbers for user-defined error messages should be greater than 50000. 

*msg_str*
Is a user-defined message with formatting similar to the printf function in the C standard library. The error message can have a maximum of 2,047 characters. If the message contains 2,048 or more characters, only the first 2,044 are displayed and an ellipsis is added to indicate that the message has been truncated.

*@local_variable*
Is a variable of any valid character data type that contains a string formatted in the same manner as msg_str. @local_variable must be char or varchar, or be able to be implicitly converted to these data types.

*severity*
Is the user-defined severity level associated with this message. When using msg_id to raise a user-defined message created using sp_addmessage, the severity specified on RAISERROR overrides the severity specified in sp_addmessage.
Severity levels from 0 through 18 can be specified by any user. 

*state*
Is an integer from 0 through 255. Negative values default to 1. Values larger than 255 should not be used.

*argument*
Are the parameters used in the substitution for variables defined in msg_str or the message corresponding to msg_id. There can be 0 or more substitution parameters, but the total number of substitution parameters cannot exceed 20. Each substitution parameter can be a local variable or any of these data types: tinyint, smallint, int, char, varchar, nchar, nvarchar, binary, or varbinary. No other data types are supported.

*option*
Is a custom option for the error and can be one of the values: LOG, NOWAIT and SETERROR.


 ![Nr4-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-5/image/Nr4-2.png)

 ![Nr4-2-1](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-5/image/Nr4-2-1.png)

RESULT

![Nr4-2-2](https://github.com/KatyaFAF172/BD/blob/master/Laboratory-work-5/image/Nr4-2-2.png)