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