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