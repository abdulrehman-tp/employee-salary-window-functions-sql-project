use basic_project;

CREATE TABLE emp_salary (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
department VARCHAR(50),
salary INT
);

INSERT INTO emp_salary VALUES
(1,'Ali','IT',60000),
(2,'Sara','HR',45000),
(3,'John','IT',70000),
(4,'Ayesha','Finance',65000),
(5,'David','IT',72000),
(6,'Fatima','HR',48000),
(7,'Ahmed','Finance',55000),
(8,'Zara','IT',68000),
(9,'Usman','Marketing',50000),
(10,'Noah','Marketing',52000),

(11,'Liam','IT',71000),
(12,'Olivia','HR',46000),
(13,'Ethan','Finance',58000),
(14,'Sophia','IT',69000),
(15,'Mason','Marketing',51000),
(16,'Isabella','HR',47000),
(17,'Lucas','Finance',62000),
(18,'Mia','IT',73000),
(19,'Logan','Marketing',54000),
(20,'Amelia','HR',49000),

(21,'James','Finance',66000),
(22,'Charlotte','IT',75000),
(23,'Benjamin','Marketing',53000),
(24,'Harper','HR',48000),
(25,'Elijah','IT',77000),
(26,'Evelyn','Finance',61000),
(27,'Alexander','Marketing',55000),
(28,'Abigail','HR',50000),
(29,'Daniel','IT',72000),
(30,'Emily','Finance',64000),

(31,'Matthew','IT',68000),
(32,'Avery','Marketing',52000),
(33,'Joseph','Finance',59000),
(34,'Ella','HR',47000),
(35,'Samuel','IT',76000),
(36,'Scarlett','Marketing',56000),
(37,'David Jr','Finance',63000),
(38,'Victoria','HR',49000),
(39,'Carter','IT',70000),
(40,'Aria','Marketing',54000),

(41,'Wyatt','Finance',60000),
(42,'Grace','HR',48000),
(43,'Jayden','IT',71000),
(44,'Chloe','Marketing',55000),
(45,'Luke','Finance',62000),
(46,'Lily','HR',47000),
(47,'Henry','IT',74000),
(48,'Hannah','Marketing',53000),
(49,'Sebastian','Finance',65000),
(50,'Nora','HR',46000),

(51,'Owen','IT',69000),
(52,'Layla','HR',45000),
(53,'Jack','Finance',61000),
(54,'Zoey','IT',72000),
(55,'Leo','Marketing',52000),
(56,'Penelope','HR',49000),
(57,'Isaac','Finance',63000),
(58,'Riley','IT',74000),
(59,'Gabriel','Marketing',54000),
(60,'Aurora','HR',50000),

(61,'Julian','Finance',66000),
(62,'Hazel','IT',76000),
(63,'Levi','Marketing',56000),
(64,'Violet','HR',47000),
(65,'Christopher','IT',78000),
(66,'Stella','Finance',62000),
(67,'Andrew','Marketing',53000),
(68,'Lucy','HR',48000),
(69,'Joshua','IT',75000),
(70,'Paisley','Finance',64000),

(71,'Nathan','IT',70000),
(72,'Ellie','Marketing',51000),
(73,'Aaron','Finance',60000),
(74,'Skylar','HR',49000),
(75,'Christian','IT',77000),
(76,'Bella','Marketing',55000),
(77,'Adrian','Finance',65000),
(78,'Claire','HR',46000),
(79,'Thomas','IT',73000),
(80,'Anna','Marketing',52000),

(81,'Charles','Finance',61000),
(82,'Caroline','HR',47000),
(83,'Isaiah','IT',74000),
(84,'Kennedy','Marketing',54000),
(85,'Eli','Finance',63000),
(86,'Samantha','HR',50000),
(87,'Jonathan','IT',76000),
(88,'Maya','Marketing',56000),
(89,'Hunter','Finance',62000),
(90,'Naomi','HR',48000),

(91,'Connor','IT',79000),
(92,'Elena','Marketing',53000),
(93,'Jeremiah','Finance',66000),
(94,'Alice','HR',49000),
(95,'Landon','IT',78000),
(96,'Madelyn','Marketing',55000),
(97,'Easton','Finance',64000),
(98,'Eva','HR',47000),
(99,'Colton','IT',75000),
(100,'Ruby','Marketing',54000);


-- basic
-- 1. Show salary rank of all employees
select*,
rank() over (order by salary desc) as salary_rank
from emp_salary;

-- 2. Show highest salary employee in each department
with cte as (select*,
dense_rank() over (partition by department order by salary desc) as highest_salary
from emp_salary)
select * from cte where highest_salary = 1;

-- 3. Show second highest salary in each department

with cte1 as (select*,
dense_rank() over (partition by department order by salary desc) as second_highest_salary
from emp_salary)
select * from cte1 where second_highest_salary = 2;

-- medium 

-- 4.Show department average salary beside every employee

select*,
avg(salary) over (PARTITION BY department order by salary desc) as avg_salary
from emp_salary; 

-- 5. Show running total of salaries

select*,
sum(salary) over (order by emp_id) as running_total_salary
from emp_salary;

-- 6. Show employees ranked by salary inside department

select*,
rank() over (partition by department order by salary desc) as emp_rank
from emp_salary;

-- Advance

-- 7. Difference between RANK() and DENSE_RANK()
select*,
rank() over (order by salary desc ) as emp_rank,
dense_rank() over (order by salary desc) as emp_dense_rank
from emp_salary;

-- or

with cte2 as (select*,
rank() over (order by salary desc ) as emp_rank,
dense_rank() over (order by salary desc) as emp_dense_rank
from emp_salary)
select *,emp_rank - emp_dense_rank as diff from cte2;

-- 8 Show top 2 highest paid employees from each department

with cte3 as ( select*,
dense_rank() over (partition by department order by salary desc) as highest_salary
from emp_salary)
select* from cte3 where highest_salary in (1,2);

-- 9. Show employees earning above department average using window function

with cte4 as (select*,
avg(salary) over (partition by department) as avg_dept_salary
from emp_salary)
select* from cte4 where salary > avg_dept_salary;






