DELETE FROM video_rating;
DELETE FROM teacher_rating;
DELETE FROM course_rating;
DELETE FROM course_review;
DELETE FROM enrollment;
DELETE FROM course_video;
DELETE FROM course;
DELETE FROM teacher;
DELETE FROM student;
DELETE FROM "user";

ALTER SEQUENCE user_id_seq RESTART WITH 1;
ALTER SEQUENCE course_id_seq RESTART WITH 1;
ALTER SEQUENCE teacher_rating_id_seq RESTART WITH 1;
ALTER SEQUENCE course_video_id_seq RESTART WITH 1;
ALTER SEQUENCE course_rating_id_seq RESTART WITH 1;
ALTER SEQUENCE course_review_id_seq RESTART WITH 1;







INSERT INTO "user" (email, password_hash, created_at) VALUES
('alice.chan@example.com', 'pw1', NOW()),
('bob.moe@example.com', 'pw2', NOW()),
('charlie.win@example.com', 'pw3', NOW()),
('david.lee@example.com', 'pw4', NOW()),
('emily.tan@example.com', 'pw5', NOW()),
('frank.wong@example.com', 'pw6', NOW()),
('grace.lin@example.com', 'pw7', NOW()),
('henry.z@example.com', 'pw8', NOW()),
('irene.cho@example.com', 'pw9', NOW()),
('jack.han@example.com', 'pw10', NOW()),
('karen.wei@example.com', 'pw11', NOW()),
('leo.park@example.com', 'pw12', NOW()),
('mia.g@example.com', 'pw13', NOW()),
('nathan.ong@example.com', 'pw14', NOW()),
('olivia.bo@example.com', 'pw15', NOW()),
('peter.khin@example.com', 'pw16', NOW()),
('queenie.lang@example.com', 'pw17', NOW()),
('ryan.d@example.com', 'pw18', NOW()),
('samantha.lim@example.com', 'pw19', NOW()),
('thomas.yee@example.com', 'pw20', NOW()),

('smith@example.com',  'pw_t1', NOW()),
('tan@example.com',    'pw_t2', NOW()),
('johnson@example.com','pw_t3', NOW()),
('patel@example.com',  'pw_t4', NOW()),
('lee@example.com',    'pw_t5', NOW()),
('gomez@example.com',  'pw_t6', NOW()),
('clark@example.com',  'pw_t7', NOW()),
('kim@example.com',    'pw_t8', NOW()),
('brown@example.com',  'pw_t9', NOW()),
('park@example.com',   'pw_t10', NOW());


INSERT INTO student (id, name, profile_image) VALUES
(1, 'Alice Chan', 'profile.img'),
(2, 'Bob Moe', 'profile.img'),
(3, 'Charlie Win', 'profile.img'),
(4, 'David Lee', 'profile.img'),
(5, 'Emily Tan', 'profile.img'),
(6, 'Frank Wong', 'profile.img'),
(7, 'Grace Lin', 'profile.img'),
(8, 'Henry Zhao', 'profile.img'),
(9, 'Irene Cho', 'profile.img'),
(10, 'Jack Han', 'profile.img'),
(11, 'Karen Wei', 'profile.img'),
(12, 'Leo Park', 'profile.img'),
(13, 'Mia Gupta', 'profile.img'),
(14, 'Nathan Ong', 'profile.img'),
(15, 'Olivia Bo', 'profile.img'),
(16, 'Peter Khin', 'profile.img'),
(17, 'Queenie Lang', 'profile.img'),
(18, 'Ryan Doe', 'profile.img'),
(19, 'Samantha Lim', 'profile.img'),
(20, 'Thomas Yee', 'profile.img');

INSERT INTO teacher (id, name, title, description, profile_image) VALUES
(21, 'Mr. Smith', 'Math Teacher', 'Experienced math instructor specializing in algebra and geometry.', 'smith.png'),
(22, 'Ms. Tan', 'Science Teacher', 'Teaches biology and chemistry with hands-on learning.', 'tan.png'),
(23, 'Mr. Johnson', 'English Teacher', 'Focuses on writing, grammar, and literature studies.', 'johnson.png'),
(24, 'Ms. Patel', 'Physics Teacher', 'Expert in physics with a focus on problem-solving skills.', 'patel.png'),
(25, 'Mr. Lee', 'Computer Science Teacher', 'Teaches programming, algorithms, and databases.', 'lee.png'),
(26, 'Ms. Gomez', 'History Teacher', 'Specializes in world history and critical analysis.', 'gomez.png'),
(27, 'Mr. Clark', 'Economics Teacher', 'Experienced in microeconomics and financial literacy.', 'clark.png'),
(28, 'Ms. Kim', 'Art Teacher', 'Passionate about painting, design, and creative expression.', 'kim.png'),
(29, 'Mr. Brown', 'Music Teacher', 'Teaches instruments, music theory, and composition.', 'brown.png'),
(30, 'Ms. Park', 'Language Teacher', 'Specializes in teaching foreign languages with immersion.', 'park.png');


INSERT INTO course (title, description, teacher_id, price, img_url) VALUES
('Intro to Programming', 'Beginner-friendly coding basics.', 21, 100, 'course.img'),
('Data Structures', 'Core CS foundations.', 21, 200, 'course.img'),
('English Conversation', 'Improve speaking skills.', 22, 300, 'course.img'),
('Calculus I', 'Differential calculus concepts.', 23, 150, 'course.img'),
('Web Development', 'Build real websites.', 24, 224, 'course.img'),
('Machine Learning', 'Learn ML algorithms.', 25, 120, 'course.img'),
('Database Systems', 'SQL, NoSQL, indexing.', 26, 140, 'course.img'),
('Cybersecurity Basics', 'Security fundamentals.', 27, 870, 'course.img'),
('Mobile App Development', 'Create iOS/Android apps.', 28, 650, 'course.img'),
('Creative Writing', 'Writing skills improvement.', 29, 12, 'course.img');



INSERT INTO course_video (course_id, title, description, url) VALUES
(1, 'Variables', 'Intro to variables.', 'https://v.com/1'),
(1, 'Loops', 'Iteration basics.', 'https://v.com/2'),
(2, 'Arrays', 'Understanding arrays.', 'https://v.com/3'),
(2, 'Linked Lists', 'Intro to linked lists.', 'https://v.com/4'),
(3, 'Daily Phrases', 'Useful daily English.', 'https://v.com/5'),
(3, 'Pronunciation Tips', 'Improve accent.', 'https://v.com/6'),
(4, 'Limits', 'Understanding limits.', 'https://v.com/7'),
(4, 'Derivatives', 'Derivative rules.', 'https://v.com/8'),
(5, 'HTML Basics', 'Intro to HTML.', 'https://v.com/9'),
(5, 'CSS Basics', 'Styling pages.', 'https://v.com/10'),
(6, 'Linear Regression', 'Basic ML algorithm.', 'https://v.com/11'),
(6, 'Decision Trees', 'Tree-based models.', 'https://v.com/12'),
(7, 'SQL Basics', 'Introduction to SQL.', 'https://v.com/13'),
(7, 'Indexing', 'Database indexing.', 'https://v.com/14'),
(8, 'Threat Models', 'Cybersecurity attacks.', 'https://v.com/15'),
(8, 'Network Security', 'Network protection.', 'https://v.com/16'),
(9, 'Kotlin Basics', 'Kotlin intro.', 'https://v.com/17'),
(9, 'React Native Intro', 'Cross-platform apps.', 'https://v.com/18'),
(10, 'Story Structure', 'Writing structure.', 'https://v.com/19'),
(10, 'Character Building', 'Create characters.', 'https://v.com/20');



INSERT INTO enrollment (student_id, course_id, created_at) VALUES
(1,1,NOW()), (1,2,NOW()),
(2,1,NOW()), (2,3,NOW()),
(3,4,NOW()), (3,5,NOW()),
(4,2,NOW()), (4,6,NOW()),
(5,3,NOW()), (5,7,NOW()),
(6,1,NOW()), (6,8,NOW()),
(7,3,NOW()), (7,9,NOW()),
(8,4,NOW()), (8,10,NOW()),
(9,2,NOW()), (9,3,NOW()),
(10,1,NOW()), (10,5,NOW()),
(11,6,NOW()), (11,9,NOW()),
(12,7,NOW()), (12,8,NOW()),
(13,2,NOW()), (13,10,NOW()),
(14,1,NOW()), (14,4,NOW()),
(15,3,NOW()), (15,6,NOW()),
(16,5,NOW()), (16,8,NOW()),
(17,9,NOW()), (17,10,NOW()),
(18,7,NOW()), (18,3,NOW()),
(19,4,NOW()), (19,6,NOW()),
(20,8,NOW()), (20,2,NOW());



INSERT INTO course_review (course_id, student_id, review) VALUES
(1,1,'Very clear course!'),
(2,1,'Challenging but good.'),
(3,2,'Helped improve my English.'),
(4,3,'Math is tough but teacher is great.'),
(5,3,'Web dev is fun!'),
(6,4,'ML is hard but interesting.'),
(7,5,'Useful SQL lessons.'),
(8,6,'Cybersecurity basics were helpful.'),
(9,7,'Kotlin is easy to learn.'),
(10,8,'Loved writing activities.'),
(1,9,'Solid intro.'),
(2,10,'Data structures well explained.'),
(3,11,'Very practical English exercises.'),
(4,12,'Good explanations.'),
(5,13,'HTML/CSS basics well taught.');




INSERT INTO course_rating (student_id, course_id, stars) VALUES
(1,1,5),(1,2,4),
(2,3,4),
(3,4,5),(3,5,5),
(4,6,4),
(5,7,5),
(6,8,4),
(7,9,5),
(8,10,5),
(9,1,4),
(10,2,5),
(11,3,5),
(12,4,4),
(13,5,5);



INSERT INTO teacher_rating (student_id, teacher_id, stars) VALUES
(1,21,5), (1,22,4),
(2,22,4),
(3,23,5),(3,24,5),
(4,25,4),
(5,26,5),
(6,27,4),
(7,28,5),
(8,29,5),
(9,21,4),
(10,21,5),
(11,22,5),
(12,23,4),
(13,24,5);



INSERT INTO video_rating (student_id, video_id, stars) VALUES
(1,1,5),
(1,3,4),
(2,5,4),
(3,7,5),
(3,9,5),
(4,11,4),
(5,13,5),
(6,15,4),
(7,17,5),
(8,19,5),
(9,1,4),
(10,3,5),
(11,5,5),
(12,7,4),
(13,9,5);