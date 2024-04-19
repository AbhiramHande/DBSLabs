-- Ex.1	Write the following queries in SQL, using the university schema.
-- Q 1.a. Find the ID and name of each student who has taken at least one Comp. Sci. course.
-- 		  Make sure there are no duplicate names in the result.
USE university;
SELECT DISTINCT student.ID, student.name 
FROM student JOIN takes ON student.ID = takes.ID
JOIN course ON takes.course_id = course.course_id 
WHERE course.dept_name = 'Comp. Sci.';

-- Q 1.b. Find the ID and name of each student who has not taken any course offered after 2017.
SELECT DISTINCT ID, name FROM student
WHERE NOT EXISTS (SELECT DISTINCT student.ID, student.name 
FROM student JOIN takes ON student.ID = takes.ID
WHERE takes.year > 2017);

-- Q 1.c. For each department, find the maximum salary of instructors in that department.
-- 		  You may assume that every department has at least one instructor.
SELECT dept_name, MAX(salary) AS max_salary
FROM instructor GROUP BY dept_name;

-- Q 1.d. Find the lowest, across all departments, of the per-department maximum salary computed by the preceding query.
-- TODO

-- Ex.2 Write the SQL statements using the university schema to perform the following operations:
-- Q 2.a. Create a new course “CS-001”, titled “Weekly Seminar”, with 2 credits.
INSERT INTO course (course_id, title, dept_name, credits) 
VALUES ('CS-001', 'Weekly Seminar', 'Comp. Sci.', 2);

-- Q 2.b. Create a section of this course in Fall 2017, with sec id of 1, and with the location of this section not yet specified.
INSERT INTO section (course_id, sec_id, semester, year)
VALUES ('CS-001', '1', 'Fall', 2017);

-- Q 2.c. Enroll every student in the Comp. Sci. department in the above section.
INSERT INTO takes (ID, course_id, sec_id, semester, year)
SELECT student.ID, 'CS-001', 1, 'Fall', 2017
FROM student WHERE student.dept_name = 'Comp. Sci.';

-- Q 2.d. Delete enrollments in the above section where the student’s ID is 12345.
DELETE FROM takes WHERE course_id = 'CS-001' AND sec_id = '1' AND semester = 'Fall' AND year = 2017 AND ID = '12345';

-- Q 2.e. Delete the course CS-001. 
-- 		  What will happen if you run this delete statement without first deleting offerings of this course?
DELETE FROM takes WHERE course_id = 'CS-001';
DELETE FROM section WHERE course_id = 'CS-001';
DELETE FROM course WHERE course_id = 'CS-001';

-- Q 2.f. Delete all takes tuples corresponding to any section of any course with the word “Geology” as a part of the title
--  	  Ignore case when matching the word with the title.
-- TODO
