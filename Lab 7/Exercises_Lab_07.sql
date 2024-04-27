-- Ex. Write stored routines for following task
-- Ex.1. List name of student from student table who takes course in given semester.
USE university;
DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE list_students (IN sem_name VARCHAR(10))
	READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	SELECT DISTINCT student.name 
    FROM university.student
	WHERE student.ID IN (
		SELECT takes.ID FROM university.takes 
        WHERE takes.semester = sem_name
	);
END $$

-- Ex.2. List all customer who done a payment with a given staff id.
USE sakila$$

CREATE DEFINER = 'root'@'localhost' PROCEDURE list_customer (IN s_id TINYINT)
	READS SQL DATA
    DETERMINISTIC 
    SQL SECURITY INVOKER 
BEGIN
	SELECT customer_id FROM customer
    WHERE customer_id IN (
		SELECT DISTINCT customer_id FROM rental
        WHERE staff_id = s_id
	);
END$$

-- Ex.3. List instructor’s name and ID whose salary is less or more than a given amount to
--       the average salary of all instructors in the university.
USE university$$

CREATE DEFINER = 'root'@'localhost' PROCEDURE list_instructors (IN deviation DECIMAL(8,2))
	READS SQL DATA
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	DECLARE avg_salary DECIMAL(8, 2);
	SELECT AVG(COALESCE(salary, 0)) INTO avg_salary FROM instructor;
    SELECT name, ID FROM instructor 
    WHERE salary >= avg_salary + deviation OR salary <= avg_salary - deviation;
END$$

-- Ex.4. Find the name of all ingredients supplied by a specific vendor.
USE restaurant$$

DELIMITER ;