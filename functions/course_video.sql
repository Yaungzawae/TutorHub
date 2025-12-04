CREATE OR REPLACE FUNCTION create_course_video(
    p_course_id INTEGER,
    p_title VARCHAR,
    p_description TEXT,
    p_url VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM course WHERE id = p_course_id) THEN
        RAISE EXCEPTION 'Course with id % does not exist', p_course_id;
    END IF;

    INSERT INTO course_video (course_id, title, description, url)
    VALUES (p_course_id, p_title, p_description, p_url);
END;
$$;


CREATE OR REPLACE FUNCTION get_course_videos_by_course_id(
    p_course_id   INTEGER,
    p_student_id  INTEGER
)
RETURNS TABLE(
    id INT,
    course_id INT,
    title VARCHAR,
    description TEXT,
    url VARCHAR,
    rating NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM course WHERE course.id = p_course_id) THEN
        RAISE EXCEPTION 'Course with id % does not exist', p_course_id;
    END IF;

    IF is_enrolled(p_student_id, p_course_id) THEN
        RETURN QUERY
        SELECT
            cv.id,
            cv.course_id,
            cv.title,
            cv.description,
            cv.url, -- video url
            get_video_avg_rating(cv.id)
        FROM course_video cv
        WHERE cv.course_id = p_course_id
        ORDER BY cv.id;

    ELSE
        RETURN QUERY
        SELECT
            cv.id,
            cv.course_id,
            cv.title,
            cv.description,
            'Locked'::VARCHAR, -- hide URL
            get_video_avg_rating(cv.id)
        FROM course_video cv
        WHERE cv.course_id = p_course_id
        ORDER BY cv.id;
    END IF;
END;
$$;




CREATE OR REPLACE FUNCTION update_course_video(
    p_video_id INTEGER,
    p_title VARCHAR DEFAULT NULL,
    p_description TEXT DEFAULT NULL,
    p_url VARCHAR DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM course_video WHERE id = p_video_id) THEN
        RAISE EXCEPTION 'Video with id % does not exist', p_video_id;
    END IF;

    UPDATE course_video
    SET
        title = COALESCE(p_title, title),
        description = COALESCE(p_description, description),
        url = COALESCE(p_url, url)
    WHERE id = p_video_id;
END;
$$;



CREATE OR REPLACE FUNCTION delete_course_video(
    p_video_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM course_video WHERE id = p_video_id) THEN
        RAISE EXCEPTION 'Video with id % does not exist', p_video_id;
    END IF;

    DELETE FROM course_video
    WHERE id = p_video_id;
END;
$$;

