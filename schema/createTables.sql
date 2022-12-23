DROP DATABASE testUniDB;
CREATE DATABASE IF NOT EXISTS `testUniDB`;
USE `testUniDB`;

CREATE TABLE Students (
	sid int,
    sname varchar(50),
    phone_num varchar(50),
    birth_date date,
    primary key (sid)
);

create table Professors (
 pid int,
 pname varchar(50),
 phone_num varchar(50),
 office_num int,
 primary key (pid)
);

 create table Departments (
   dname varchar(50),
   primary key (dname)
);

 create table Courses (
   cid int,
   cname varchar(50),
   credit_num int,
   department varchar(50),
   primary key (cid)
);

create table Sections (
   cid int,
   section_num int, 
   meet_time datetime,
   semester varchar(50),
   primary key (cid, section_num),
   Foreign key (cid) references Courses(cid)
);

create table Section_Of (
	cid int,
    section_num int,
    primary key (cid, section_num),
    foreign key (cid) references Courses(cid),
    foreign key (cid, section_num) references Sections(cid, section_num)
);

 create table Prereqs (
   curr_cid int,
   prereq_cid int,
   primary key (curr_cid, prereq_cid),
   foreign key(curr_cid) references Courses(cid),
   foreign key(prereq_cid) references Courses(cid)
);
   
 create table Teaches (
   pid int,
   cid int, 
   primary key(pid, cid),
   foreign key(pid) references Professors(pid),
   foreign key(cid) references Courses(cid)
);

 create table Takes (
   sid int,
   cid int,
   section_num int,
   grade varchar(1),
   primary key(sid, cid, section_num),
   foreign key(sid) references Students(sid),
   foreign key(cid, section_num) references Sections(cid, section_num)
);
   
 create table Offers(
     dname varchar(50),
     cid int,
     section_num int,
     primary key (dname, cid, section_num),
     foreign key (dname) references Departments(dname),
     foreign key (cid, section_num) references Sections(cid, section_num)
);