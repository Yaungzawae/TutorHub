-- USERS (authentication + identity)

CREATE TABLE "user" (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- STUDENT and TEACHER

CREATE TABLE student (
  id INTEGER PRIMARY KEY REFERENCES "user"(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  profile_image VARCHAR(500)
);

CREATE TABLE teacher (
  id INTEGER PRIMARY KEY REFERENCES "user"(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  title VARCHAR(255),
  description TEXT,
  profile_image VARCHAR(500)
);

-- COURSES


CREATE TABLE course (
  id SERIAL PRIMARY KEY,
  teacher_id INTEGER NOT NULL REFERENCES teacher(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  price MONEY,
  img_url VARCHAR(255) NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE course_video (
  id SERIAL PRIMARY KEY,
  course_id INTEGER NOT NULL REFERENCES course(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  url VARCHAR(500) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- ENROLLMENTS

CREATE TABLE enrollment (
  id SERIAL PRIMARY KEY,
  student_id INTEGER NOT NULL REFERENCES student(id) ON DELETE CASCADE,
  course_id INTEGER NOT NULL REFERENCES course(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(student_id, course_id)
);

-- REVIEWS

CREATE TABLE course_review (
  id SERIAL PRIMARY KEY,
  course_id INTEGER NOT NULL REFERENCES course(id) ON DELETE CASCADE,
  student_id INTEGER NOT NULL REFERENCES student(id) ON DELETE CASCADE,
  review TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(course_id, student_id)
);

-- RATINGS

CREATE TABLE course_rating (
  id SERIAL PRIMARY KEY,
  student_id INT REFERENCES student(id),
  course_id INT REFERENCES course(id),
  stars INT CHECK (stars BETWEEN 1 AND 5),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE(student_id, course_id)
);

CREATE TABLE teacher_rating (
  id SERIAL PRIMARY KEY,
  student_id INT REFERENCES student(id),
  teacher_id INT REFERENCES teacher(id),
  stars INT CHECK (stars BETWEEN 1 AND 5),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE(student_id, teacher_id)
);

CREATE TABLE video_rating (
  id SERIAL PRIMARY KEY,
  student_id INT REFERENCES student(id),
  video_id INT REFERENCES course_video(id),
  stars INT CHECK (stars BETWEEN 1 AND 5),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE(student_id, video_id)
);


