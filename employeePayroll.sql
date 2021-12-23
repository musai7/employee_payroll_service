------------------------ uc 1 ---------------------------
mysql> create database payroll_service;
Query OK, 1 row affected (0.25 sec)

mysql> show databases
    -> ;
+----------------------+
| Database             |
+----------------------+
| address_book_service |
| bridgelabsdemo       |
| information_schema   |
| mysql                |
| payroll_service      |
| performance_schema   |
| sakila               |
| sys                  |
| world                |
+----------------------+
9 rows in set (0.00 sec)

mysql> use payroll_service
Database changed

------------------------ uc 2 --------------------------

mysql>  create table employee_payroll (emp_id int unsigned not null auto_increment,
    -> emp_name varchar(50) not null,
    -> salary double not null,
    -> startdate date not null,
    -> primary key(emp_id)
    -> );
Query OK, 0 rows affected (1.73 sec)

----------------------- uc 3 ----------------------------

mysql> insert into employee_payroll (emp_name,salary,startdate) values ('musai','25000','2022-01-12'),('mani','30000','2021-12-21'),('gana','27000','2020-05-1');
Query OK, 3 rows affected (0.28 sec)
Records: 3  Duplicates: 0  Warnings: 0

----------------------- uc 4--------------------------

mysql> select * from employee_payroll
    -> ;
+--------+----------+--------+------------+
| emp_id | emp_name | salary | startdate  |
+--------+----------+--------+------------+
|      1 | musai    |  25000 | 2022-01-12 |
|      2 | mani     |  30000 | 2021-12-21 |
|      3 | gana     |  27000 | 2020-05-01 |
+--------+----------+--------+------------+
3 rows in set (0.02 sec)

--------------------- uc 5 ---------------------------

mysql> select salary from employee_payroll where emp_name = 'mani';
+--------+
| salary |
+--------+
|  30000 |
+--------+
1 row in set (0.00 sec)

mysql> select * from employee_payroll
    -> where startdate between cast('2020-01-01' as date) and date(now());
+--------+----------+--------+------------+
| emp_id | emp_name | salary | startdate  |
+--------+----------+--------+------------+
|      2 | mani     |  30000 | 2021-12-21 |
|      3 | gana     |  27000 | 2020-05-01 |
+--------+----------+--------+------------+
2 rows in set (0.00 sec)

------------------------uc 6 ---------------------

mysql> alter table employee_payroll add gender char(1) after emp_name;
Query OK, 0 rows affected (2.20 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll;
+--------+----------+--------+--------+------------+
| emp_id | emp_name | gender | salary | startdate  |
+--------+----------+--------+--------+------------+
|      1 | musai    | NULL   |  25000 | 2022-01-12 |
|      2 | mani     | NULL   |  30000 | 2021-12-21 |
|      3 | gana     | NULL   |  27000 | 2020-05-01 |
+--------+----------+--------+--------+------------+
3 rows in set (0.00 sec)

mysql> update employee_payroll set gender = 'M' where emp_name ='musai' or emp_name = 'mani';
Query OK, 2 rows affected (0.05 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> select * from employee_payroll;
+--------+----------+--------+--------+------------+
| emp_id | emp_name | gender | salary | startdate  |
+--------+----------+--------+--------+------------+
|      1 | musai    | M      |  25000 | 2022-01-12 |
|      2 | mani     | M      |  30000 | 2021-12-21 |
|      3 | gana     | NULL   |  27000 | 2020-05-01 |
+--------+----------+--------+--------+------------+
3 rows in set (0.02 sec)

-------------------------uc 7----------------------------------

mysql> select sum(salary) from employee_payroll where gender ='M' group by gender;
+-------------+
| sum(salary) |
+-------------+
|       82000 |
+-------------+
1 row in set (0.00 sec)

mysql> select avg(salary) from employee_payroll where gender ='M' group by gender;
+--------------------+
| avg(salary)        |
+--------------------+
| 27333.333333333332 |
+--------------------+
1 row in set (0.00 sec)

mysql> select min(salary) from employee_payroll where gender ='M' group by gender;
+-------------+
| min(salary) |
+-------------+
|       25000 |
+-------------+
1 row in set (0.00 sec)

mysql> select max(salary) from employee_payroll where gender ='M' group by gender;
+-------------+
| max(salary) |
+-------------+
|       30000 |
+-------------+

--------------------------uc 8--------------------------------

mysql> alter table employee_payroll add phonenumber long after emp_name;
Query OK, 0 rows affected (2.53 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll add address varchar(250) default '5-133 near gokulamba temple'after phonenumber;
Query OK, 0 rows affected (1.23 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll add department varchar(150) not null after address;
Query OK, 0 rows affected (2.26 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll;
+--------+-----------+-------------+-----------------------------+------------+--------+--------+------------+
| emp_id | emp_name  | phonenumber | address                     | department | gender | salary | startdate  |
+--------+-----------+-------------+-----------------------------+------------+--------+--------+------------+
|      1 | musai     | NULL        | 5-133 near gokulamba temple |            | M      |  25000 | 2022-01-12 |
|      2 | mani      | NULL        | 5-133 near gokulamba temple |            | M      |  30000 | 2021-12-21 |
|      3 | gana      | NULL        | 5-133 near gokulamba temple |            | M      |  27000 | 2020-05-01 |
|      4 | santhoshi | NULL        | 5-133 near gokulamba temple |            | F      |  30000 | 2021-08-30 |
|      5 | kajol     | NULL        | 5-133 near gokulamba temple |            | F      |  28000 | 2019-07-29 |
|      6 | dipika    | NULL        | 5-133 near gokulamba temple |            | F      |  38000 | 2018-06-21 |
+--------+-----------+-------------+-----------------------------+------------+--------+--------+------------+
6 rows in set (0.00 sec)

-------------------------- uc 9 --------------------------------

mysql> alter table employee_payroll add deduction varchar(150) not null after basic_pay;
Query OK, 0 rows affected (2.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll add taxable_pay varchar(150) after deduction;
Query OK, 0 rows affected (1.43 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll add income_tax varchar(150) after taxable_pay;
Query OK, 0 rows affected (2.19 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table employee_payroll add net_pay varchar(150) after income_tax;
Query OK, 0 rows affected (1.71 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll;
+--------+-----------+-------------+-----------------------------+------------+--------+-----------+-----------+-------------+------------+---------+------------+
| emp_id | emp_name  | phonenumber | address                     | department | gender | basic_pay | deduction | taxable_pay | income_tax | net_pay | startdate  |
+--------+-----------+-------------+-----------------------------+------------+--------+-----------+-----------+-------------+------------+---------+------------+
|      1 | musai     | NULL        | 5-133 near gokulamba temple |            | M      |     25000 |           | NULL        | NULL       | NULL    | 2022-01-12 |
|      2 | mani      | NULL        | 5-133 near gokulamba temple |            | M      |     30000 |           | NULL        | NULL       | NULL    | 2021-12-21 |
|      3 | gana      | NULL        | 5-133 near gokulamba temple |            | M      |     27000 |           | NULL        | NULL       | NULL    | 2020-05-01 |
|      4 | santhoshi | NULL        | 5-133 near gokulamba temple |            | F      |     30000 |           | NULL        | NULL       | NULL    | 2021-08-30 |
|      5 | kajol     | NULL        | 5-133 near gokulamba temple |            | F      |     28000 |           | NULL        | NULL       | NULL    | 2019-07-29 |
|      6 | dipika    | NULL        | 5-133 near gokulamba temple |            | F      |     38000 |           | NULL        | NULL       | NULL    | 2018-06-21 |
+--------+-----------+-------------+-----------------------------+------------+--------+-----------+-----------+-------------+------------+---------+------------+
6 rows in set (0.01 sec)

------------------------------uc 10 --------------------------------

mysql> insert into employee_payroll (emp_name,phonenumber,address,department, gender,basic_pay,deduction,taxable_pay,income_tax,net_pay,startdate) values ('musai','8463985868'
    -> ,' 5-133 near gokulamba temple','HR','M','30000',
    ->
    -> '2000','500','500','27000','2022-01-12');
Query OK, 1 row affected (0.08 sec)

mysql> select * from employee_payroll;
+--------+----------+-------------+------------------------------+------------+--------+-----------+-----------+-------------+------------+---------+------------+
| emp_id | emp_name | phonenumber | address                      | department | gender | basic_pay | deduction | taxable_pay | income_tax | net_pay | startdate  |
+--------+----------+-------------+------------------------------+------------+--------+-----------+-----------+-------------+------------+---------+------------+
|      7 | musai    | 8463985868  |  5-133 near gokulamba temple | HR         | M      |     30000 | 2000      | 500         | 500        | 27000   | 2022-01-12 |
+--------+----------+-------------+------------------------------+------------+--------+-----------+-----------+-------------+------------+---------+------------+
1 row in set (0.02 sec)


------------------------- uc12------------------------

mysql>  create table company (company_id int not null,company_name varchar(150),primary key(company_id,company_name));
Query OK, 0 rows affected (0.57 sec)

mysql> describe company;
+--------------+--------------+------+-----+---------+-------+
| Field        | Type         | Null | Key | Default | Extra |
+--------------+--------------+------+-----+---------+-------+
| company_id   | int          | NO   | PRI | NULL    |       |
| company_name | varchar(150) | NO   | PRI | NULL    |       |
+--------------+--------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> insert into company values (1,'nokia'),(2,'apple'),(3,'samsung'),(4,'tata'),(5,'infosys');
Query OK, 5 rows affected (0.38 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from company;
+------------+--------------+
| company_id | company_name |
+------------+--------------+
|          1 | nokia        |
|          2 | apple        |
|          3 | samsung      |
|          4 | tata         |
|          5 | infosys      |
+------------+--------------+
5 rows in set (0.00 sec)

 create table employee (emp_id int,emp_name varchar(150) not null,phonenumber long not null,company_id int , primary key(emp_id),foreign key (company_id)
    -> references company(company_id));
Query OK, 0 rows affected (1.49 sec)

mysql> describe employee;
+-------------+--------------+------+-----+---------+-------+
| Field       | Type         | Null | Key | Default | Extra |
+-------------+--------------+------+-----+---------+-------+
| emp_id      | int          | NO   | PRI | NULL    |       |
| emp_name    | varchar(150) | NO   |     | NULL    |       |
| phonenumber | mediumtext   | NO   |     | NULL    |       |
| company_id  | int          | YES  | MUL | NULL    |       |
+-------------+--------------+------+-----+---------+-------+
4 rows in set (0.18 sec)

mysql> alter table employee add address varchar(150) after phonenumber;
Query OK, 0 rows affected (1.59 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> describe employee;
+-------------+--------------+------+-----+---------+-------+
| Field       | Type         | Null | Key | Default | Extra |
+-------------+--------------+------+-----+---------+-------+
| emp_id      | int          | NO   | PRI | NULL    |       |
| emp_name    | varchar(150) | NO   |     | NULL    |       |
| phonenumber | mediumtext   | NO   |     | NULL    |       |
| address     | varchar(150) | YES  |     | NULL    |       |
| company_id  | int          | YES  | MUL | NULL    |       |
+-------------+--------------+------+-----+---------+-------+
5 rows in set (0.06 sec)

mysql> create table department (emp_id int,department_id int primary key, department_name varchar (150), foreign key(emp_id) references employee(emp_id));
Query OK, 0 rows affected (0.65 sec)

mysql> describe department;
+-----------------+--------------+------+-----+---------+-------+
| Field           | Type         | Null | Key | Default | Extra |
+-----------------+--------------+------+-----+---------+-------+
| emp_id          | int          | YES  | MUL | NULL    |       |
| department_id   | int          | NO   | PRI | NULL    |       |
| department_name | varchar(150) | YES  |     | NULL    |       |
+-----------------+--------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> create table payroll (emp_id int ,basic_pay long ,deduction long,taxable_pay long,income_tax long,net_pay long ,foreign key (emp_id) references employee(emp_id));
Query OK, 0 rows affected (2.16 sec)

mysql> describe payroll;
+-------------+------------+------+-----+---------+-------+
| Field       | Type       | Null | Key | Default | Extra |
+-------------+------------+------+-----+---------+-------+
| emp_id      | int        | YES  | MUL | NULL    |       |
| basic_pay   | mediumtext | YES  |     | NULL    |       |
| deduction   | mediumtext | YES  |     | NULL    |       |
| taxable_pay | mediumtext | YES  |     | NULL    |       |
| income_tax  | mediumtext | YES  |     | NULL    |       |
| net_pay     | mediumtext | YES  |     | NULL    |       |
+-------------+------------+------+-----+---------+-------+
6 rows in set (0.10 sec)

