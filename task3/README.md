#Task 3

-Create a MySql container. 

C:\Users\diaal>docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=dianaspassword -d mysql:latest

-Create a database named “company”.

C:\Users\diaal>docker exec -it mysql-container mysql -uroot -pdianaspassword -e "CREATE DATABASE company;"

-Import the company.sql file in your company database.

I used this command: docker exec -i mysql-container mysql -uroot -pdianaspassword company < company.sql,
but i recived this ERROR:
ERROR 1366 (HY000) at line 12: Incorrect integer value: 'Consulting' for column 'department' at row 41

On the specified line this was the entry: ('Hannah', 'Murphy', 7, 'Consulting', 86000.00), but the fourth field must be an INT
so I change it whith the department_id (7), and then rerun the command.

-Create a user and assign all the permissions required for the database “company”

C:\Users\diaal\Desktop>docker exec -it mysql-container mysql -uroot -pdianaspassword -e "CREATE USER 'newuser'@'%' IDENTIFIED BY 'password';"

C:\Users\diaal\Desktop>docker exec -it mysql-container mysql -uroot -pdianaspassword -e "GRANT ALL PRIVILEGES ON company.* TO 'newuser'@'%';"

C:\Users\diaal\Desktop>docker exec -it mysql-container mysql -uroot -pdianaspassword -e "FLUSH PRIVILEGES;"

-Find the average salary for each department.

C:\Users\diaal\Desktop>docker exec -it mysql-container mysql -uroot -pdianaspassword -D company -e "SELECT department, AVG(salary) AS avg_salary FROM employees GROUP BY department;"
mysql: [Warning] Using a password on the command line interface can be insecure.
+------------+--------------+
| department | avg_salary   |
+------------+--------------+
|          1 | 60000.000000 |
|          2 | 75111.111111 |
|          3 | 53666.666667 |
|          4 | 67250.000000 |
|          5 | 51500.000000 |
|          6 | 63500.000000 |
|          7 | 83000.000000 |
|          8 | 58500.000000 |
+------------+--------------+





In the folder i added the updated database file 