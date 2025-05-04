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
