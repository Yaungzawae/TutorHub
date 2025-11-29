-- DROP FUNCTION register_teacher(p_name varchar, p_email varchar, p_password varchar);

CREATE OR REPLACE FUNCTION register_teacher(
    p_name VARCHAR,
    p_email VARCHAR,
    p_password_hash VARCHAR
)
    RETURNS VOID
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF EXISTS (SELECT 1 FROM teacher WHERE email = p_email) THEN
            RAISE EXCEPTION 'Email already registered';
        END IF;

        INSERT INTO teacher (name, email, password_hash)
        VALUES (p_name, p_email, p_password_hash);
    END;
$$;


-- DROP FUNCTION login_teacher(p_email VARCHAR, p_password_hash VARCHAR);

CREATE OR REPLACE FUNCTION login_teacher(
    p_email VARCHAR,
    p_password_hash VARCHAR
)
RETURNS TABLE(
    id INT,
    name VARCHAR,
    email VARCHAR
)
LANGUAGE plpgsql
AS $$
    BEGIN
        RETURN QUERY
        SELECT s.id, s.name, s.email
        FROM teacher AS s
        WHERE s.email = p_email
        AND password_hash = p_password_hash
        LIMIT 1;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Invalid email or password';
        END IF;

    END;
$$;


SELECT * from register_teacher('yza', 'yezawd22.com', 'p1234');
SELECT * from login_teacher('yezawd22.com', 'p1234');