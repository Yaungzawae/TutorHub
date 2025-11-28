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
  student_id INTEGER NOT NULL REFERENCES student(id),
  course_id INTEGER NOT NULL REFERENCES course(id),
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(student_id, course_id)
);

CREATE TABLE course_review (
  id SERIAL PRIMARY KEY,
  course_id INTEGER NOT NULL REFERENCES course(id),
  student_id INTEGER NOT NULL REFERENCES student(id),
  review TEXT
);

-- Posts

CREATE TABLE post (
  id SERIAL PRIMARY KEY,
  teacher_id INTEGER NOT NULL REFERENCES teacher(id),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE post_comment (
  id SERIAL PRIMARY KEY,
  student_id INTEGER NOT NULL REFERENCES student(id),
  post_id INTEGER NOT NULL REFERENCES post(id) ON DELETE CASCADE,
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE post_like (
  id SERIAL PRIMARY KEY,
  student_id INTEGER NOT NULL REFERENCES student(id),
  post_id INTEGER NOT NULL REFERENCES post(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(student_id, post_id)
);

-- Ratings

CREATE TABLE teacher_rating (
  id SERIAL PRIMARY KEY,
  teacher_id INTEGER NOT NULL REFERENCES teacher(id),
  student_id INTEGER NOT NULL REFERENCES student(id),
  stars INTEGER CHECK (stars BETWEEN 1 AND 5),
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(teacher_id, student_id)
);

CREATE TABLE course_rating (
  id SERIAL PRIMARY KEY,
  student_id INTEGER NOT NULL REFERENCES student(id),
  course_id INTEGER NOT NULL REFERENCES course(id),
  stars INTEGER CHECK (stars BETWEEN 1 AND 5),
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(student_id, course_id)
);

CREATE TABLE video_rating (
  id SERIAL PRIMARY KEY,
  student_id INTEGER NOT NULL REFERENCES student(id),
  video_id INTEGER NOT NULL REFERENCES course_video(id) ON DELETE CASCADE,
  stars INTEGER CHECK (stars BETWEEN 1 AND 5),
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(student_id, video_id)
);
