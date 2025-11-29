CREATE OR REPLACE FUNCTION create_course(
    p_title VARCHAR,
    p_description TEXT,
    p_teacher_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM teacher WHERE id = p_teacher_id) THEN
        RAISE EXCEPTION 'Teacher with id % does not exist', p_teacher_id;
    END IF;

    INSERT INTO course (title, description, teacher_id)
    VALUES (p_title, p_description, p_teacher_id);
END;
$$;

CREATE OR REPLACE FUNCTION get_courses_by_teacher_id(
    p_teacher_id INTEGER
)
RETURNS SETOF course
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM teacher WHERE id = p_teacher_id) THEN
        RAISE EXCEPTION 'Teacher with id % does not exist', p_teacher_id;
    END IF;

    RETURN QUERY
    SELECT *
    FROM course
    WHERE teacher_id = p_teacher_id;
END;
$$;

CREATE OR REPLACE FUNCTION update_course(
    p_course_id INTEGER,
    p_title VARCHAR DEFAULT NULL,
    p_description TEXT DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM course WHERE id = p_course_id) THEN
        RAISE EXCEPTION 'Course with id % does not exist', p_course_id;
    END IF;

    UPDATE course
    SET
        title = COALESCE(p_title, title), -- to handle null
        description = COALESCE(p_description, description)
    WHERE id = p_course_id;
END;
$$;

CREATE OR REPLACE FUNCTION deleteCourse(
    p_course_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM course WHERE id = p_course_id) THEN
        RAISE EXCEPTION 'Course with id % does not exist', p_course_id;
    END IF;

    DELETE FROM course WHERE id = p_course_id;
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




SELECT * FROM enroll_student(1, 4);

SELECT * FROM update_course(2, 'AAAAA', 'world');