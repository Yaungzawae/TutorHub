CREATE OR REPLACE FUNCTION add_course_review(
    p_student_id INT,
    p_course_id INT,
    p_review TEXT
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
        SELECT 1 FROM course_review
        WHERE student_id = p_student_id AND course_id = p_course_id
    ) THEN
        RAISE EXCEPTION 'Student % already reviewed course %', p_student_id, p_course_id;
    END IF;

    INSERT INTO course_review (student_id, course_id, review)
    VALUES (p_student_id, p_course_id, p_review);
END;
$$;


CREATE OR REPLACE FUNCTION get_course_review_by_course_id(
    p_course_id INT
)
RETURNS SETOF course_review
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check course exists
    IF NOT EXISTS (SELECT 1 FROM course WHERE id = p_course_id) THEN
        RAISE EXCEPTION 'Course with id % does not exist', p_course_id;
    END IF;

    RETURN QUERY
    SELECT *
    FROM course_review
    WHERE course_id = p_course_id
    ORDER BY id DESC;
END;
$$;
