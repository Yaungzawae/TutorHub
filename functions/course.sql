CREATE OR REPLACE FUNCTION create_course(
    p_title VARCHAR,
    p_description TEXT,
    p_teacher_id INTEGER,
    p_price MONEY DEFAULT NULL,
    p_img_url VARCHAR DEFAULT NULL
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check if teacher exists
    IF NOT EXISTS (SELECT 1 FROM teacher WHERE id = p_teacher_id) THEN
        RAISE EXCEPTION 'Teacher with id % does not exist', p_teacher_id;
    END IF;

    -- Insert new course
    INSERT INTO course (title, description, teacher_id, price, img_url)
    VALUES (p_title, p_description, p_teacher_id, p_price, p_img_url);
END;
$$;

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


CREATE OR REPLACE FUNCTION get_all_courses()
RETURNS TABLE(
    id INT,
    title VARCHAR,
    description TEXT,
    price MONEY,
    img_url VARCHAR,
    teacher_name VARCHAR,
    teacher_image VARCHAR,
    created_at TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.id,
        c.title,
        c.description,
        c.price,
        c.img_url,
        t.name,
        t.profile_image,
        c.created_at
    FROM course AS c
    JOIN teacher AS t
    ON c.teacher_id = t.id
    ORDER BY c.id;
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

CREATE OR REPLACE FUNCTION delete_course(
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
