DROP FUNCTION register_student(p_name varchar, p_email varchar, p_password varchar);

CREATE OR REPLACE FUNCTION register_student(
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

    -- Insert user credentials
    INSERT INTO "user" (email, password_hash)
    VALUES (p_email, p_password_hash)
    RETURNING id INTO new_user_id;

    -- Insert student profile
    INSERT INTO student (id, name)
    VALUES (new_user_id, p_name);

END;
$$;



DROP FUNCTION login_student(p_email VARCHAR, p_password_hash VARCHAR);

CREATE OR REPLACE FUNCTION login_student(
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
        s.id
    FROM "user" u
    JOIN student s ON s.id = u.id
    WHERE u.email = p_email
      AND u.password_hash = p_password_hash
    LIMIT 1;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Invalid email or password';
    END IF;

END;
$$;

CREATE OR REPLACE FUNCTION get_student_detail_by_id(
    p_student_id INT
)
RETURNS student
LANGUAGE plpgsql
AS $$
DECLARE
    result student;
BEGIN
    SELECT *
    INTO result
    FROM student
    WHERE id = p_student_id;

    IF result IS NULL THEN
        RAISE EXCEPTION 'Student with id % does not exist', p_student_id;
    END IF;

    RETURN result;
END;
$$;



CREATE OR REPLACE FUNCTION edit_student_profile_pic(
    p_student_id INT,
    p_profile_image VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    -- check student exists
    IF NOT EXISTS (SELECT 1 FROM student WHERE id = p_student_id) THEN
        RAISE EXCEPTION 'Student with id % does not exist', p_student_id;
    END IF;

    -- override previous value (including null)
    UPDATE student
    SET profile_image = p_profile_image
    WHERE id = p_student_id;

END;
$$;


SELECT * from register_student('yza', 'yezawd221.com', 'p1234');
SELECT * from login_student('yezawd221.com', 'p1234');
