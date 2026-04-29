------- Performance Category Classification
SELECT student_id,
ROUND(AVG(marks_obtained),2) AS avg_marks,
CASE 
    WHEN AVG(marks_obtained) >= 80 THEN 'Excellent'
    WHEN AVG(marks_obtained) >= 60 THEN 'Good'
    WHEN AVG(marks_obtained) >= 50 THEN 'Average'
    ELSE 'Needs Improvement'
END AS performance_category
FROM Marks
GROUP BY student_id;


----- At-Risk Student Identification
SELECT m.student_id,
ROUND(AVG(m.marks_obtained),2) AS avg_marks,
ROUND(
COUNT(CASE WHEN a.status='Present' THEN 1 END)*100.0/COUNT(a.status),2
) AS attendance_percentage
FROM Marks m
JOIN Attendance a ON m.student_id = a.student_id
GROUP BY m.student_id
HAVING avg_marks < 50 OR attendance_percentage < 75;


------ Course Completion Rate
SELECT c.course_name,
COUNT(CASE WHEN e.status='Completed' THEN 1 END)*100.0/COUNT(*) AS completion_rate
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

----- Instructor-wise Student Performance
	SELECT i.name AS instructor_name,
ROUND(AVG(m.marks_obtained),2) AS avg_student_marks
FROM Enrollments e
JOIN Instructors i ON e.instructor_id = i.instructor_id
JOIN Marks m ON e.student_id = m.student_id
GROUP BY i.name;


----- Assessment-wise Score Analysis
SELECT a.type AS assessment_type,
ROUND(AVG(m.marks_obtained),2) AS avg_marks,
MAX(m.marks_obtained) AS highest_marks,
MIN(m.marks_obtained) AS lowest_marks
FROM Marks m
JOIN Assessments a ON m.assessment_id = a.assessment_id
GROUP BY a.type;

----- Student Ranking (Window Function)
SELECT student_id,
ROUND(AVG(marks_obtained),2) AS avg_marks,
RANK() OVER (ORDER BY AVG(marks_obtained) DESC) AS rank_student
FROM Marks
GROUP BY student_id;


----- Improvement / Repeat Analysis
SELECT student_id,
MIN(marks_obtained) AS first_score,
MAX(marks_obtained) AS latest_score,
(MAX(marks_obtained) - MIN(marks_obtained)) AS improvement
FROM Marks
GROUP BY student_id;

----- Top 3 Students Per Course
SELECT *
FROM (
    SELECT e.course_id,
           m.student_id,
           AVG(m.marks_obtained) AS avg_marks,
           RANK() OVER (PARTITION BY e.course_id ORDER BY AVG(m.marks_obtained) DESC) AS rank_student
    FROM Marks m
    JOIN Enrollments e ON m.student_id = e.student_id
    GROUP BY e.course_id, m.student_id
) ranked
WHERE rank_student <= 3;