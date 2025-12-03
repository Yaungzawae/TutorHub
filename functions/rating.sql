CREATE OR REPLACE FUNCTION rate_teacher(
    p_student_id INT,
    p_teacher_id INT,
    p_stars INT
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM teacher WHERE id = p_teacher_id) THEN
        RAISE EXCEPTION 'Teacher with id % does not exist', p_teacher_id;
    END IF;

    INSERT INTO teacher_rating(student_id, teacher_id, stars)
    VALUES (p_student_id, p_teacher_id, p_stars)
    ON CONFLICT (student_id, teacher_id)
    DO UPDATE SET stars = EXCLUDED.stars, created_at = NOW();
END;
$$;


CREATE OR REPLACE FUNCTION rate_course(
    p_student_id INT,
    p_course_id INT,
    p_stars INT
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM course WHERE id = p_course_id) THEN
        RAISE EXCEPTION 'Course with id % does not exist', p_course_id;
    END IF;

    INSERT INTO course_rating (student_id, course_id, stars)
    VALUES (p_student_id, p_course_id, p_stars)
    ON CONFLICT (student_id, course_id)
    DO UPDATE SET stars = EXCLUDED.stars, created_at = NOW();
END;
$$;

CREATE OR REPLACE FUNCTION rate_video(
    p_student_id INT,
    p_video_id INT,
    p_stars INT
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM course_video WHERE id = p_video_id) THEN
        RAISE EXCEPTION 'Video with id % does not exist', p_video_id;
    END IF;

    INSERT INTO video_rating (student_id, video_id, stars)
    VALUES (p_student_id, p_video_id, p_stars)
    ON CONFLICT (student_id, video_id)
    DO UPDATE SET stars = EXCLUDED.stars, created_at = NOW();
END;
$$;

CREATE OR REPLACE FUNCTION get_teacher_avg_rating(
    p_teacher_id INT
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    avg_rating NUMERIC;
BEGIN
    SELECT AVG(stars)
    INTO avg_rating
    FROM teacher_rating
    WHERE teacher_id = p_teacher_id;

    RETURN avg_rating;
END;
$$;

DROP FUNCTION get_courses_by_teacher_id(p_teacher_id INTEGER);

CREATE OR REPLACE FUNCTION get_courses_by_teacher_id(
    p_teacher_id INTEGER
)
RETURNS TABLE(
    id INT,
    title VARCHAR,
    description TEXT,
    teacher_id INT,
    price MONEY,
    img_url VARCHAR,
    avg_course_rating NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM teacher WHERE teacher.id = p_teacher_id) THEN
        RAISE EXCEPTION 'Teacher with id % does not exist', p_teacher_id;
    END IF;

    RETURN QUERY
    SELECT
        c.id,
        c.title,
        c.description,
        c.teacher_id,
        c.price,
        c.img_url,
        get_course_avg_rating(c.id) AS avg_course_rating
    FROM course c
    WHERE c.teacher_id = p_teacher_id;
END;
$$;


CREATE OR REPLACE FUNCTION get_video_avg_rating(
    p_video_id INT
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    avg_rating NUMERIC;
BEGIN
    SELECT AVG(stars)
    INTO avg_rating
    FROM video_rating
    WHERE video_id = p_video_id;

    RETURN avg_rating;
END;
$$;


SELECT * FROM rate_teacher(1, 21, 4);

SELECT * FROM get_teacher_avg_rating(21);