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