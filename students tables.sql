CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    email VARCHAR(100),
    phone VARCHAR(15),
    join_date DATE
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    department VARCHAR(50),
    duration_months INT
);

CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    instructor_id INT,
    enrollment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    attendance_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

CREATE TABLE Assessments (
    assessment_id INT PRIMARY KEY,
    course_id INT,
    type VARCHAR(50),
    max_marks INT
);

CREATE TABLE Marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    assessment_id INT,
    marks_obtained INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    rating INT,
    comments TEXT
);