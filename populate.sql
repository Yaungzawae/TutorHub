DELETE FROM post_like;
DELETE FROM post_comment;
DELETE FROM post;
DELETE FROM course_review;
DELETE FROM enrollment;
DELETE FROM course_video;
DELETE FROM course;
DELETE FROM teacher;
DELETE FROM student;


INSERT INTO student (name, email, password_hash, created_at) VALUES
('Alice Chan', 'alice.chan@example.com', 'pw1', NOW()),
('Bob Moe', 'bob.moe@example.com', 'pw2', NOW()),
('Charlie Win', 'charlie.win@example.com', 'pw3', NOW()),
('David Lee', 'david.lee@example.com', 'pw4', NOW()),
('Emily Tan', 'emily.tan@example.com', 'pw5', NOW()),
('Frank Wong', 'frank.wong@example.com', 'pw6', NOW()),
('Grace Lin', 'grace.lin@example.com', 'pw7', NOW()),
('Henry Zhao', 'henry.z@example.com', 'pw8', NOW()),
('Irene Cho', 'irene.cho@example.com', 'pw9', NOW()),
('Jack Han', 'jack.han@example.com', 'pw10', NOW()),
('Karen Wei', 'karen.wei@example.com', 'pw11', NOW()),
('Leo Park', 'leo.park@example.com', 'pw12', NOW()),
('Mia Gupta', 'mia.g@example.com', 'pw13', NOW()),
('Nathan Ong', 'nathan.ong@example.com', 'pw14', NOW()),
('Olivia Bo', 'olivia.bo@example.com', 'pw15', NOW()),
('Peter Khin', 'peter.khin@example.com', 'pw16', NOW()),
('Queenie Lang', 'queenie.lang@example.com', 'pw17', NOW()),
('Ryan Doe', 'ryan.d@example.com', 'pw18', NOW()),
('Samantha Lim', 'samantha.lim@example.com', 'pw19', NOW()),
('Thomas Yee', 'thomas.yee@example.com', 'pw20', NOW());


INSERT INTO teacher (name, email, password_hash, created_at) VALUES
('Mr. Smith', 'smith@example.com', 'pw_t1', NOW()),
('Ms. Tan', 'tan@example.com', 'pw_t2', NOW()),
('Mr. Johnson', 'johnson@example.com', 'pw_t3', NOW()),
('Ms. Patel', 'patel@example.com', 'pw_t4', NOW()),
('Mr. Lee', 'lee@example.com', 'pw_t5', NOW()),
('Ms. Gomez', 'gomez@example.com', 'pw_t6', NOW()),
('Mr. Clark', 'clark@example.com', 'pw_t7', NOW()),
('Ms. Kim', 'kim@example.com', 'pw_t8', NOW()),
('Mr. Brown', 'brown@example.com', 'pw_t9', NOW()),
('Ms. Park', 'park@example.com', 'pw_t10', NOW());



INSERT INTO course (title, description, teacher_id) VALUES
('Intro to Programming', 'Beginner-friendly coding basics.', 1),
('Data Structures', 'Core CS foundations.', 1),
('English Conversation', 'Improve speaking skills.', 2),
('Calculus I', 'Differential calculus concepts.', 3),
('Web Development', 'Build real websites.', 4),
('Machine Learning', 'Learn ML algorithms.', 5),
('Database Systems', 'SQL, NoSQL, indexing.', 6),
('Cybersecurity Basics', 'Security fundamentals.', 7),
('Mobile App Development', 'Create iOS/Android apps.', 8),
('Creative Writing', 'Writing skills improvement.', 9);



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




INSERT INTO post (teacher_id, title, description) VALUES
(1,'Welcome to Programming','Let’s start coding!'),
(1,'Arrays vs Lists','What’s the difference?'),
(2,'English Tips','Practice daily!'),
(3,'Calculus Tricks','Quick derivative methods.'),
(4,'Start Web Dev','Roadmap to web dev.'),
(5,'ML Advice','Study math first.'),
(6,'SQL Tips','Best SQL practices.'),
(7,'Cybersecurity Warning','Be careful online.'),
(8,'Mobile Dev Tips','Start with React Native.'),
(9,'Writing Advice','Write every day.'),
(10,'Grammar Tips','Most common mistakes.'),
(2,'Conversation Hacks','How to sound natural.'),
(4,'Frontend vs Backend','Which to choose?'),
(6,'Database Indexing','Speed up your queries.'),
(8,'iOS vs Android','Which is easier?');



INSERT INTO post_comment (student_id, post_id, comment, created_at) VALUES
(1,1,'Excited to start!',NOW()),
(2,1,'Looks great!',NOW()),
(3,2,'Helpful tips.',NOW()),
(4,3,'Thanks teacher!',NOW()),
(5,4,'Love these tricks.',NOW()),
(6,5,'Very useful.',NOW()),
(7,6,'Thanks for SQL tips!',NOW()),
(8,7,'Good warning.',NOW()),
(9,8,'Thanks!',NOW()),
(10,9,'Very helpful.',NOW()),
(11,10,'Great advice!',NOW()),
(12,11,'Useful grammar points.',NOW()),
(13,12,'This helped a lot.',NOW()),
(14,13,'Nice explanation!',NOW()),
(15,14,'Very technical.',NOW()),
(16,15,'Good comparison!',NOW()),
(17,3,'Interesting!',NOW()),
(18,4,'Nice examples.',NOW()),
(19,5,'Thanks for sharing.',NOW()),
(20,6,'Wow great info.',NOW()),
(1,7,'Good read.',NOW()),
(2,8,'Useful content.',NOW()),
(3,9,'Appreciate it.',NOW()),
(4,10,'Nice post.',NOW()),
(5,11,'Helpful advice!',NOW()),
(6,12,'Great hacks!',NOW()),
(7,13,'I agree!',NOW()),
(8,14,'Very clear.',NOW()),
(9,15,'Thanks teacher!',NOW());



INSERT INTO post_like (student_id, post_id, created_at) VALUES
(1,1,NOW()), (2,1,NOW()), (3,1,NOW()),
(4,2,NOW()), (5,2,NOW()), (6,2,NOW()),
(7,3,NOW()), (8,3,NOW()), (9,3,NOW()),
(10,4,NOW()), (11,4,NOW()), (12,4,NOW()),
(13,5,NOW()), (14,5,NOW()), (15,5,NOW()),
(16,6,NOW()), (17,6,NOW()), (18,6,NOW()),
(19,7,NOW()), (20,7,NOW()),
(1,8,NOW()), (2,8,NOW()), (3,8,NOW()),
(4,9,NOW()), (5,9,NOW()), (6,9,NOW()),
(7,10,NOW()), (8,10,NOW()), (9,10,NOW()),
(10,11,NOW()), (11,11,NOW()), (12,11,NOW()),
(13,12,NOW()), (14,12,NOW()), (15,12,NOW()),
(16,13,NOW()), (17,13,NOW()), (18,13,NOW());


-- Course ratings
INSERT INTO rating (student_id, target_type, target_id, stars)
VALUES
(1, 'course', 101, 5),
(2, 'course', 101, 4),
(3, 'course', 102, 5),
(1, 'course', 103, 3);

-- Teacher ratings
INSERT INTO rating (student_id, target_type, target_id, stars)
VALUES
(1, 'teacher', 11, 5),
(2, 'teacher', 11, 4),
(3, 'teacher', 12, 5);

-- Video ratings
INSERT INTO rating (student_id, target_type, target_id, stars)
VALUES
(1, 'video', 501, 4),
(2, 'video', 502, 5),
(3, 'video', 503, 3);

