CREATE OR REPLACE FUNCTION is_enrolled(
    p_student_id INT,
    p_course_id  INT
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    enrolled BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM enrollment
        WHERE student_id = p_student_id
        AND course_id = p_course_id
    )
    INTO enrolled;

    RETURN enrolled;
END;
$$;



CREATE OR REPLACE FUNCTION enroll_student(
    p_student_id INT,
    p_course_id INT
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM student WHERE id = p_student_id) THEN
        RAISE EXCEPTION 'Student with id % does not exist', p_student_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM course WHERE id = p_course_id) THEN
        RAISE EXCEPTION 'Course with id % does not exist', p_course_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM enrollment
        WHERE student_id = p_student_id
          AND course_id = p_course_id
    ) THEN
        RAISE EXCEPTION 'Student % is already enrolled in course %', p_student_id, p_course_id;
    END IF;

    INSERT INTO enrollment (student_id, course_id, created_at)
    VALUES (p_student_id, p_course_id, NOW());
END;
$$;


CREATE OR REPLACE FUNCTION get_enrolled_courses(
    p_student_id INT
)
RETURNS SETOF course
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM student WHERE id = p_student_id) THEN
        RAISE EXCEPTION 'Student with id % does not exist', p_student_id;
    END IF;

    RETURN QUERY
    SELECT c.*
    FROM enrollment e
    JOIN course c ON e.course_id = c.id
    WHERE e.student_id = p_student_id
    ORDER BY c.id;
END;
$$;
