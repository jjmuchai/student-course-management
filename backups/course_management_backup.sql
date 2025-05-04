--Step 1: Create the Database and Schema
create database course_management;

create schema school;

-- Students Table
create table school.students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    date_of_birth DATE
);

-- Instructors Table
create table school.instructors (
    instructor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

-- Courses Table
create table school.courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    course_description TEXT,
    instructor_id INT REFERENCES school.instructors(instructor_id)
);

-- Enrollments Table
create table school.enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES school.students(student_id),
    course_id INT REFERENCES school.courses(course_id),
    enrollment_date DATE,
    grade CHAR(1)
);


--Part 2: Insert Sample Data
-- Insert Students
insert into school.students (first_name, last_name, email, date_of_birth) values
('Alice', 'Johnson', 'alice.johnson@example.com', '2000-05-10'),
('Brian', 'Kimani', 'brian.kimani@example.com', '1999-11-22'),
('Catherine', 'Ouma', 'catherine.ouma@example.com', '2001-01-17'),
('David', 'Mwangi', 'david.mwangi@example.com', '1998-03-04'),
('Esther', 'Wambui', 'esther.wambui@example.com', '2000-09-25'),
('Frank', 'Otieno', 'frank.otieno@example.com', '2001-06-30'),
('Grace', 'Chebet', 'grace.chebet@example.com', '1999-08-14'),
('Henry', 'Kamau', 'henry.kamau@example.com', '2002-02-10'),
('Ivy', 'Njeri', 'ivy.njeri@example.com', '2001-12-01'),
('Jake', 'Obuya', 'jake.obuya@example.com', '2000-07-21');

-- Insert Instructors
insert into school.instructors (first_name, last_name, email) values
('John', 'Smith', 'john.smith@edtech.com'),
('Linda', 'Ngugi', 'linda.ngugi@edtech.com'),
('Raj', 'Patel', 'raj.patel@edtech.com');

-- Insert Courses
insert into school.courses (course_name, course_description, instructor_id) values
('Intro to Databases', 'Fundamentals of relational databases.', 1),
('Web Development', 'Frontend and backend web technologies.', 2),
('Data Structures', 'Understanding how data is organized and manipulated.', 3),
('SQL Programming', 'Mastering SQL queries and logic.', 1),
('Python for Beginners', 'Introduction to programming with Python.', 2);

-- Insert Enrollments (student_id, course_id, date, grade)
insert into school.enrollments (student_id, course_id, enrollment_date, grade) values
(1, 1, '2025-01-10', 'A'),
(1, 2, '2025-01-12', 'B'),
(1, 3, '2025-01-15', 'A'),
(2, 1, '2025-01-10', 'C'),
(2, 2, '2025-01-12', 'D'),
(3, 4, '2025-01-14', 'B'),
(4, 1, '2025-01-11', 'F'),
(4, 5, '2025-01-17', 'F'),
(5, 3, '2025-01-18', 'A'),
(6, 5, '2025-01-20', 'B'),
(7, 2, '2025-01-21', 'C'),
(8, 4, '2025-01-22', 'A'),
(8, 1, '2025-01-23', 'B'),
(9, 2, '2025-01-24', 'A'),
(10, 3, '2025-01-25', 'C');


--Part 3: Write SQL Queries
select * from school.students;
select * from school.instructors;
select * from school.courses;
select * from school.enrollments;

--Query 1: Students who enrolled in at least one course
select distinct s.student_id, s.first_name, s.last_name
from school.students s
join school.enrollments e ON s.student_id = e.student_id;

--Query 2: Students enrolled in more than two courses
select s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS total_courses
from school.students s
join school.enrollments e ON s.student_id = e.student_id
group by s.student_id
having COUNT(e.course_id) > 2;

--Query 3: Courses with total enrolled students
select c.course_id, c.course_name, COUNT(e.student_id) AS total_students
from school.courses c
left join school.enrollments e ON c.course_id = e.course_id
group by c.course_id;

--Query 4: Average grade per course
select 
    c.course_name,
    ROUND(AVG(CASE e.grade
        WHEN 'A' THEN 4
        WHEN 'B' THEN 3
        WHEN 'C' THEN 2
        WHEN 'D' THEN 1
        WHEN 'F' THEN 0
    END), 2) AS average_grade
from school.courses c
join school.enrollments e ON c.course_id = e.course_id
group by c.course_name;

--Query 5: Students who haven’t enrolled in any course
select s.student_id, s.first_name, s.last_name
from school.students s
left join school.enrollments e ON s.student_id = e.student_id
where e.enrollment_id IS NULL;

--Query 6: Students with their average grade across all courses
select 
    s.student_id,
    s.first_name,
    s.last_name,
    ROUND(AVG(CASE e.grade
        WHEN 'A' THEN 4
        WHEN 'B' THEN 3
        WHEN 'C' THEN 2
        WHEN 'D' THEN 1
        WHEN 'F' THEN 0
    END), 2) AS average_gpa
from school.students s
join school.enrollments e ON s.student_id = e.student_id
group by s.student_id;

--Query 7: Instructors with the number of courses they teach
select 
    i.instructor_id,
    i.first_name,
    i.last_name,
    COUNT(c.course_id) AS courses_taught
from school.instructors i
left join school.courses c ON i.instructor_id = c.instructor_id
group by i.instructor_id;

--Query 8: Students enrolled in a course taught by “John Smith”
select distinct 
    s.student_id,
    s.first_name,
    s.last_name
from school.students s
join school.enrollments e ON s.student_id = e.student_id
join school.courses c ON e.course_id = c.course_id
join school.instructors i ON c.instructor_id = i.instructor_id
where i.first_name = 'John' AND i.last_name = 'Smith';

--Query 9: Top 3 students by average grade
select 
    s.student_id,
    s.first_name,
    s.last_name,
    ROUND(AVG(CASE e.grade
        WHEN 'A' THEN 4
        WHEN 'B' THEN 3
        WHEN 'C' THEN 2
        WHEN 'D' THEN 1
        WHEN 'F' THEN 0
    END), 2) AS average_gpa
from school.students s
join school.enrollments e ON s.student_id = e.student_id
group by s.student_id
order by average_gpa DESC
limit 3;

--Query 10: Students failing (grade = ‘F’) in more than one course
select 
    s.student_id,
    s.first_name,
    s.last_name,
    COUNT(*) AS fail_count
from school.students s
join school.enrollments e ON s.student_id = e.student_id
where e.grade = 'F'
group by s.student_id
having COUNT(*) > 1;



--1. Create a VIEW: student_course_summary
CREATE VIEW school.student_course_summary AS
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    e.grade
FROM school.students s
JOIN school.enrollments e ON s.student_id = e.student_id
JOIN school.courses c ON e.course_id = c.course_id;

SELECT * FROM school.student_course_summary WHERE grade = 'A';

--2. Add an INDEX on enrollments.student_id
CREATE INDEX idx_student_id ON school.enrollments(student_id);

-- 3. (Optional) Trigger to Log New Enrollments
--first create a log table:
CREATE TABLE school.enrollment_log (
    log_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--Then, create a trigger function:
CREATE OR REPLACE FUNCTION school.log_new_enrollment()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO school.enrollment_log (student_id, course_id)
    VALUES (NEW.student_id, NEW.course_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--And finally, attach the trigger to the enrollments table:
CREATE TRIGGER trg_log_enrollment
AFTER INSERT ON school.enrollments
FOR EACH ROW
EXECUTE FUNCTION school.log_new_enrollment();








