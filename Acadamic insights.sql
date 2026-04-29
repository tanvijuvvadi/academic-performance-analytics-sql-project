------ Top-Performing Students
SELECT student_id,
ROUND(AVG(marks_obtained),2) AS avg_marks
FROM Marks
GROUP BY student_id
ORDER BY avg_marks DESC
LIMIT 10;

----- Low-Performing Students
SELECT student_id,
ROUND(AVG(marks_obtained),2) AS avg_marks
FROM Marks
GROUP BY student_id
HAVING AVG(marks_obtained) < 50
ORDER BY avg_marks;

----- Students with Low Attendance
SELECT student_id,
ROUND(
COUNT(CASE WHEN status='Present' THEN 1 END)*100.0/COUNT(*),2
) AS attendance_percentage
FROM Attendance
GROUP BY student_id
HAVING attendance_percentage < 75;


----- Course-wise Average Marks
SELECT c.course_name,
ROUND(AVG(m.marks_obtained),2) AS avg_marks
FROM Marks m
INNER JOIN Assessments a ON m.assessment_id = a.assessment_id
INNER JOIN Courses c ON a.course_id = c.course_id
GROUP BY c.course_name;

----- Department-wise Performance Comparison
SELECT c.department,
ROUND(AVG(m.marks_obtained),2) AS avg_marks
FROM Marks m
JOIN Assessments a ON m.assessment_id = a.assessment_id
JOIN Courses c ON a.course_id = c.course_id
GROUP BY c.department
ORDER BY avg_marks DESC;


----- Pass/Fail Analysis
SELECT 
CASE 
    WHEN marks_obtained >= 50 THEN 'Pass'
    ELSE 'Fail'
END AS result,
COUNT(*) AS total_students
FROM Marks
GROUP BY result;

----- Attendance vs Marks Relationship
SELECT m.student_id,
ROUND(AVG(m.marks_obtained),2) AS avg_marks,
ROUND(
COUNT(CASE WHEN a.status='Present' THEN 1 END)*100.0/COUNT(a.status),2
) AS attendance_percentage
FROM Marks m
JOIN Attendance a ON m.student_id = a.student_id
GROUP BY m.student_id
ORDER BY avg_marks DESC;

---- Monthly Learning Progress Trend
SELECT 
DATE_FORMAT(a.attendance_date,'%Y-%m') AS month,
COUNT(CASE WHEN a.status='Present' THEN 1 END) AS total_present_days,
ROUND(AVG(m.marks_obtained),2) AS avg_marks
FROM Attendance a
JOIN Marks m ON a.student_id = m.student_id
GROUP BY month
ORDER BY month;