-- Ex 1. Write the following queries in SQL, using the university schema.
-- Q 1.a. Find the titles of courses in the Comp. Sci. department that have 3 credits.
USE university;
SELECT * FROM course WHERE dept_name = 'Comp. Sci.' AND credits = 3;

-- Q 1.b. Find the IDs of all students who were taught by an instructor named Dale (no duplicates).
SELECT * FROM course;

-- Q 1.c. Find the highest salary of any instructor.
SELECT MAX(salary) FROM instructor;

-- Q 1.d. Find all instructors earning the highest salary.
SELECT name FROM instructor WHERE salary = (SELECT MAX(salary) FROM instructor);

-- Ex 2.	Write the following inserts, deletes, or updates using the university schema.
-- Q 2.a. Increase the salary of each instructor in the Comp. Sci. department by 10%.
UPDATE instructor SET salary = 1.1 * salary WHERE dept_name = 'Comp. Sci.';
SELECT * FROM student;

-- Q 2.b. Insert every student whose tot cred attribute is greater than 100 as an instructor in the same department, with a salary of $30,000.
-- TODO
INSERT INTO instructor (id, name, dept_name, salary) SELECT 
id, name, dept_name, 30000 AS salary FROM student WHERE tot_cred >= 100;
