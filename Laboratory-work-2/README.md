# Laboratory work Nr.2

Database Creation and Maintenance Tools
===

1. Create a database DB1: 

*   DB1 by 5 MB, limited 100 MB; 
*   File1 by 10 MB, limited to 1000MB;
*   DB1_log by 20 MB limited to 1000 MB.

To create the new database diagram, we will need to right click on Database Diagrams folder and click on New Database Diagram. 
Once a new database is created, two files will be created automatically. These are the data files and the log files. 
The data file takes care of all the data that you want to store in database and log files is used to track the changes. 
As soon as, you click on the ‘OK’ button, Database is created with the cylindrical icon.

![DB1] (https://github.com/KatyaFAF172/BD/blob/master/DB1.png)

2. Create a database DB2:
Single user

![DB2_single_user] (https://github.com/KatyaFAF172/BD/blob/master/DB2_single%20user.png)

SQL Server 2014
![SQL_Server_2014] (https://github.com/KatyaFAF172/BD/blob/master/SQL%20Server%202014.png)

3&4.	

Starting the Database Maintenance Plan Wizard
Open Microsoft SQL Server Management Studio (SSMS) and expand the Management folder. 
Right-click on the Maintenance Plans folder and select Maintenance Plan Wizard from the pop-up menu. 
You will see the wizard's opening screen, as shown above. Click Next to continue.

Name the Database Maintenance Plan
In the next screen that appears, provide a name and description for your database maintenance plan.

Schedule my Database Maintenance Plan
Click the Change button to alter the default schedule and choose the date and time the plan will execute.

Select the Task for our Maintenance Plan
Select the task(s) that we wish to include in our database maintenance plan.

Ordering the Task in the Database Maintenance Plan
We can to change the order of tasks in our maintenance plan by using the Move Up and Move Down buttons.

Configure the Plan’s Task Details
Next, we'll have the opportunity to configure the details of each task.

Choose Maintenance Plan Reporting Options
Finally, we have the ability to have SQL Server create a report each time the plan executes containing detailed results.

![MP_BD1] (https://github.com/KatyaFAF172/BD/blob/master/MP_BD1.png)

![Reconstruire_index] (https://github.com/KatyaFAF172/BD/blob/master/Reconstruire%20index.png)

![MP_BD1.Subplan_1] (https://github.com/KatyaFAF172/BD/blob/master/MP_BD1.Subplan_1.png)

![Ri] (https://github.com/KatyaFAF172/BD/blob/master/Ri.png)

![SuccessMp] (https://github.com/KatyaFAF172/BD/blob/master/SuccessMp.png)

![Ri_subplan] (https://github.com/KatyaFAF172/BD/blob/master/Ri_subplan.png)

Conclusions:

This Software is available for free from the Microsoft to create and manage the SQL databases. 
The objective of this software is to make database handling easier with Graphical User-Interface instead of Command-Line prompt. 
It allows you to connect to a remote instance of an SQL Server and it is generally used by the administrator, testers, 
and the Developers.
Database Maintenance Plans allow us to automate many database administration tasks in Microsoft SQL Server. 
We can create maintenance plans using an easy wizard-based process without any knowledge of Transact-SQL.
