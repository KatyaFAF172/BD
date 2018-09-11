# Datadases laboratory work #3

#Tema: Database Creation and Manipulation. DML

1.	Care din numerele prezentate mai jos pot fi introduse intr-un camp de tipul DECIMAL(4,1)?

Decimal (4,1) is a number that has 3 digits before the decimal and 1 digit after the decimal.
Correct answer: b) 116,2

a, c, d, e-nu correct:
16,2 its type is Decimal (3,1)
16,21 its type is Decimal (4,2)
1116,2 its type is Decimal (5,1)
1116,21 its type is Decimal (6,2)

2.	Create 4 tables as indicated in section 3.3 of the chapter. We create the necessary number of columns, we specify the Primary key and name of the table. 

Create Table Columns:
The design interface presents us with a three-column grid to specify the table properties. For each attribute we wish to store in the table, we will need to identify:

Column Name: This is, quite simply, the name of the attribute. Each database attribute is similar to a variable; it is a single data item that our database will store for each record. 

Data Type: The data type specifies the type of information that we will store in each column. For example, a person's first name consists of a string of letters, so we might use the varchar(4) data type to indicate that the column will contain a variable length string that is no longer than 4 characters. 

Allow Nulls: This is simply a checkbox. If we check it, the database will allow we to store null (or blank) values in that column.

Next step:  Identify a Primary Key.

Name and save table.

3.	After make a click with the right mouse button on dbo file and select the option: Edit Top 200 Rows. Now, we can enter data into the table. 

Conclusions:
 The table comprises of rows and columns. So while creating tables we have to provide all the information to SQL about the names of the columns, type of data to be stored in columns, size of the data etc. 
 Designing tables to store our data is an essential responsibility of a database developer. 
