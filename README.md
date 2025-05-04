# 🎓 Student Course Management System

This project is a simple yet complete SQL-based Student Course Management System built for an EdTech company. It includes database schema design, sample data insertion, analytical queries, and advanced SQL features like views, indexing, and triggers.

## 📂 Project Structure


---

## 🔧 How to Run the SQL Code

1. **Create a new PostgreSQL database** named `course_management`.
2. Execute `create_tables.sql` to create the schema and tables.
3. Run `sample_data.sql` to populate the database.
4. Use `basic_queries.sql` and `advanced_queries.sql` to perform analysis.
5. Optionally create views and triggers using `views_and_indexes.sql`.

You can use tools like **DBeaver**, **pgAdmin**, or the PostgreSQL command line (`psql`) to run these scripts.

---

## 🧱 Schema Overview

- **Students**: student info including name, email, and DOB.
- **Instructors**: instructors with unique IDs and emails.
- **Courses**: course details, linked to instructors.
- **Enrollments**: tracks which student is in which course, their grade, and when they enrolled.

📌 Relationships:
- `Enrollments` links `Students` and `Courses`
- `Courses` are assigned to `Instructors`

---

## 🔍 Key SQL Queries Included

### Basic Analysis
- Students who enrolled in at least one course
- Students enrolled in more than two courses
- Courses with total enrolled students
- Students who haven’t enrolled in any course
- Students with their average grade across all courses

### Advanced Analysis
- Average grade per course (GPA scale)
- Instructors with number of courses they teach
- Students enrolled in courses taught by “John Smith”
- Top 3 students by GPA
- Students failing in more than one course

---

## 🧠 Advanced Features

- ✅ View: `student_course_summary` to simplify joins
- ✅ Index: on `enrollments.student_id` to optimize performance
- ✅ Trigger: logs every new enrollment into a log table with a timestamp

---

## 📚 Lessons Learned

- Hands-on practice with **relational schema design**
- Improved understanding of **JOINs, aggregates, and subqueries**
- Experience using **views, indexing, and triggers** in PostgreSQL
- Project documentation and GitHub collaboration

---

## 👨‍💻 Author

**James Muchai**  
Junior Database Developer  
