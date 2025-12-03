-- DROP FUNCTION register_teacher(p_name varchar, p_email varchar, p_password varchar);

CREATE OR REPLACE FUNCTION register_teacher(
    p_name VARCHAR,
    p_email VARCHAR,
    p_password_hash VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    new_user_id INT;
BEGIN
    -- Check if email already exists
    IF EXISTS (SELECT 1 FROM "user" WHERE email = p_email) THEN
        RAISE EXCEPTION 'Email already registered';
    END IF;

    -- Insert into user table
    INSERT INTO "user" (email, password_hash)
    VALUES (p_email, p_password_hash)
    RETURNING id INTO new_user_id;

    -- Insert teacher profile
    INSERT INTO teacher (id, name)
    VALUES (new_user_id, p_name);

END;
$$;



-- DROP FUNCTION login_teacher(p_email VARCHAR, p_password_hash VARCHAR);

CREATE OR REPLACE FUNCTION login_teacher(
    p_email VARCHAR,
    p_password_hash VARCHAR
)
RETURNS TABLE(
    id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        t.id
    FROM "user" u
    JOIN teacher t ON t.id = u.id
    WHERE u.email = p_email
      AND u.password_hash = p_password_hash
    LIMIT 1;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Invalid email or password';
    END IF;

END;
$$;


CREATE OR REPLACE FUNCTION get_all_teachers()
RETURNS TABLE(
    id INT,
    name VARCHAR,
    title VARCHAR,
    descripton TEXT,
    profile_image VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        t.id,
        t.name,
        t.title,
        t.description,
        t.profile_image
    FROM teacher AS t
    ORDER BY t.id;
END;
$$;



CREATE OR REPLACE FUNCTION get_teacher_detail(
    p_teacher_id INT
)
RETURNS TABLE(
    id INT,
    name VARCHAR,
    email VARCHAR,
    title VARCHAR,
    description TEXT,
    profile_image VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        t.id,
        t.name,
        u.email,
        t.title,
        t.description,
        t.profile_image
    FROM teacher t
    JOIN "user" u ON u.id = t.id
    WHERE t.id = p_teacher_id
    LIMIT 1;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Teacher with id % does not exist', p_teacher_id;
    END IF;
END;
$$;


CREATE OR REPLACE FUNCTION edit_teacher_details(
    p_teacher_id INT,
    p_name VARCHAR,
    p_title VARCHAR,
    p_description TEXT,
    p_profile_image VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    -- ensure teacher exists
    IF NOT EXISTS (SELECT 1 FROM teacher WHERE id = p_teacher_id) THEN
        RAISE EXCEPTION 'Teacher with id % does not exist', p_teacher_id;
    END IF;

    -- update teacher fields
    UPDATE teacher
    SET
        name = p_name,
        title = p_title,
        description = p_description,
        profile_image = p_profile_image
    WHERE id = p_teacher_id;
END;
$$;



SELECT * from register_teacher('yza', 'yezawd22.com', 'p1234');
SELECT * from login_teacher('yezawd22.com', 'p1234');


SELECT * from edit_teacher_details(1,'www' ,'muicddd teacher', 'Hello World!', 'www.ww.com')

SELECT * from get_teacher_detail(1);