-- Students & Teachers

CREATE TABLE student (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE teacher (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Courses & Videos

CREATE TABLE course (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  teacher_id INTEGER NOT NULL REFERENCES teacher(id)
);

CREATE TABLE course_video (
  id SERIAL PRIMARY KEY,
  course_id INTEGER NOT NULL REFERENCES course(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  url VARCHAR(500) NOT NULL
);

-- Enrollment & Reviews
CREATE TABLE enrollment (
  id SERIAL PRIMARY KEY,
  student_id INTEGER NOT NULL,
  course_id INTEGER NOT NULL REFERENCES course(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(student_id, course_id)
);


DROP table enrollment;
CREATE TABLE course_review (
  id SERIAL PRIMARY KEY,
  course_id INTEGER NOT NULL REFERENCES course(id) ON DELETE CASCADE,
  student_id INTEGER NOT NULL REFERENCES student(id) ON DELETE CASCADE,
  review TEXT
);


-- Ratings

CREATE TABLE rating (
    id SERIAL PRIMARY KEY,

    student_id INT NOT NULL REFERENCES student(id),

    target_type TEXT NOT NULL CHECK (target_type IN ('course', 'teacher', 'video')),
    target_id INT NOT NULL,

    stars INT NOT NULL CHECK (stars BETWEEN 1 AND 5),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),

    UNIQUE (student_id, target_type, target_id)
);

