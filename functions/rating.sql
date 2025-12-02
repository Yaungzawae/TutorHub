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

    INSERT INTO rating (student_id, target_type, target_id, stars)
    VALUES (p_student_id, 'teacher', p_teacher_id, p_stars)
    ON CONFLICT (student_id, target_type, target_id)
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

    INSERT INTO rating (student_id, target_type, target_id, stars)
    VALUES (p_student_id, 'course', p_course_id, p_stars)
    ON CONFLICT (student_id, target_type, target_id)
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

    INSERT INTO rating (student_id, target_type, target_id, stars)
    VALUES (p_student_id, 'video', p_video_id, p_stars)
    ON CONFLICT (student_id, target_type, target_id)
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
    FROM rating
    WHERE target_type = 'teacher'
      AND target_id = p_teacher_id;

    RETURN avg_rating;
END;
$$;



CREATE OR REPLACE FUNCTION get_course_avg_rating(
    p_course_id INT
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    avg_rating NUMERIC;
BEGIN
    SELECT AVG(stars)
    INTO avg_rating
    FROM rating
    WHERE target_type = 'course'
      AND target_id = p_course_id;

    RETURN avg_rating;
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
    FROM rating
    WHERE target_type = 'video'
      AND target_id = p_video_id;

    RETURN avg_rating;
END;
$$;

SELECT * FROM rate_teacher(1, 7, 5);

SELECT * FROM get_teacher_avg_rating(11);