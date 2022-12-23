INSERT INTO Students (sid, sname, phone_num, birth_date)
VALUES
  (1,"Jada Frost","1-280-346-8562","2022-06-22"),
  (2,"Sara Pope","(864) 585-5267","2022-04-05"),
  (3,"Macey Black","1-826-804-5965","2023-06-13"),
  (4,"Justine Mendoza","(222) 678-5773","2023-05-18"),
  (5,"Galvin Munoz","(190) 840-2248","2022-11-13");
  
INSERT INTO Professors (pid, pname, phone_num, office_num)
VALUES
  (1,"Simon Maxwell","1-325-867-4641",544),
  (2,"Orson Russell","1-582-784-5101",514),
  (3,"Ocean Ratliff","(537) 834-7127",679),
  (4,"Ray Benson","(384) 509-3085",426),
  (5,"Myra Joyner","(771) 828-4414",870);

INSERT INTO Courses (cid, cname, credit_num, department)
VALUES
	(198344, "Algorithms", 4, "compsci"),
    (198111, "Intro to CS", 4, "compsci"),
    (198112, "Data Structures", 4, "compsci"),
    (640201, "Calc 1", 4, "math"),
    (160101, "Chem 1", 4, "chem"),
    (160201, "Organic", 4, "chem");

INSERT INTO Departments (dname)
VALUES
	("math"),
    ("compsci"),
    ("chem"),
    ("english");
    
INSERT INTO Sections (cid, section_num, meet_time, semester)
VALUES
	(198344, 1, "2022-08-01 12:00:00", "SU22"),
	(198111, 1, "2022-08-02 12:00:00", "SU22"),
	(198111, 2, "2022-08-02 15:00:00", "SU22"),
	(198112, 1, "2022-08-03 18:00:00", "SU22"),
	(198112, 2, "2022-08-03 12:00:00", "SU22"),
	(640201, 1, "2022-08-03 15:00:00", "SU22"),
	(640201, 2, "2022-08-04 12:00:00", "SU22"),
	(160101, 1, "2022-08-04 15:00:00", "SU22"),
	(160101, 2, "2022-08-04 18:00:00", "SU22"),
	(160201, 1, "2022-08-05 12:00:00", "SU22"),
	(160201, 2, "2022-08-05 15:00:00", "SU22"),
	(160201, 3, "2022-08-05 18:00:00", "SU22");

INSERT INTO Section_Of (cid, section_num)
VALUES
	(198344, 1),
	(198111, 1),
	(198111, 2),
	(198112, 1),
	(198112, 2),
	(640201, 1),
	(640201, 2),
	(160101, 1),
	(160101, 2),
	(160201, 1),
	(160201, 2),
	(160201, 3);

INSERT INTO Teaches (pid, cid)
VALUES 
	(1, 198344),
	(2, 198111),
	(3, 198112),
	(4, 640201),
	(5, 160101),
	(5, 160201);

INSERT INTO Takes (sid, cid, section_num, grade)
VALUES  
	(1, 198344, 1, 'A'),
	(1, 640201, 1, 'A'),
	(2, 198344, 1, 'C'),
	(2, 198111, 1, 'B'),
	(2, 640201, 2, 'C'),
	(3, 198344, 1, 'D'),
	(3, 160101, 1, 'B'),
	(3, 160201, 1, 'A'),
	(4, 198344, 1, 'C'),
	(4, 160101, 2, 'A'),
	(4, 160201, 1, 'A'),
	(5, 198344, 1, 'A'),
	(5, 160201, 2, 'B'),
	(5, 198111, 2, 'B');

INSERT INTO Offers (dname, cid, section_num)
VALUES
	("compsci", 198344, 1),
    ("compsci", 198111, 1),
    ("compsci", 198111, 2),
    ("compsci", 198112, 1),
    ("compsci", 198112, 2),
    ("math", 640201, 1),
    ("math", 640201, 2),
    ("chem", 160101, 1),
    ("chem", 160101, 2),
    ("chem", 160201, 1),
    ("chem", 160201, 2),
    ("chem", 160201, 3);
    
INSERT INTO Prereqs (curr_cid, prereq_cid)
VALUES
	(198112, 198111),
	(160201, 160101),
	(198344, 198111),
	(198344, 198112);
