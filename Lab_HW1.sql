CREATE TABLE Departments
(
	Name varchar(20) NOT NULL,
	ID char(5) PRIMARY KEY,
	Budget numeric(12,2),
	Category varchar(15) Check (Category in ('Engineering','Science'))
	);
CREATE TABLE Teachers
(
	FirstName varchar(20) NOT NULL,
	LastName varchar(30) NOT NULL,
	ID char(5),
	BirthYear int,
	DepartmentID char(5),
	Salary numeric(7,2) Default 10000.00,
	PRIMARY KEY (ID),
	FOREIGN KEY (DepartmentID) REFERENCES Departments (ID),
	);
CREATE TABLE Students
(
	FirstName varchar(20) NOT NULL,
	LastName varchar(30) NOT NULL,
	StudentNumber char(7) PRIMARY KEY,
	BirthYear int,
	DepartmentID char(5),
	AdvisorID char(5),
	FOREIGN KEY (DepartmentID) REFERENCES Departments (ID),
	FOREIGN KEY (AdvisorID) REFERENCES Teachers (ID),

	);

ALTER TABLE Students
ADD PassedCourses int

CREATE TABLE Courses
(
	ID char(5) PRIMARY KEY,
	Title varchar(50),
	Credits int not null,
	DepartmentID char(5),
	FOREIGN KEY (DepartmentID) REFERENCES Departments (ID),
	);

CREATE TABLE Available_Courses
(
	CourseID char(5),
	Semester varchar(20) check (Semester in ('spring' , 'fall')),
	Year int,
	ID char(5) PRIMARY KEY,
	TeacherID char(5),
	FOREIGN KEY (CourseID) REFERENCES Courses (ID),
	FOREIGN KEY (TeacherID) REFERENCES Teachers (ID),
	);

CREATE TABLE Taken_Courses
(
	StudentID char(7),
	CourseID char(5),
	Semester varchar(20),
	Year int,
	Grade int,
	PRIMARY KEY (StudentID,CourseID,Semester,Year),
	FOREIGN KEY (CourseID) REFERENCES Courses (ID),
	FOREIGN KEY (StudentID) REFERENCES Students (StudentNumber),
	);

Create table Prerequisites
(
	CourseId char(5),
	PrereqID char(5),
	FOREIGN KEY (CourseId) REFERENCES Courses (ID),
	);


insert into Departments (Name,ID,Budget,Category) values
	('a','1','1444','Engineering')

insert into Teachers(FirstName,LastName,ID) VALUES
	('TEACHER1','TL1','1')

INSERT INTO Students (FirstName,LastName,StudentNumber,BirthYear,DepartmentID,AdvisorID) VALUES 
	('Atefeh','kazemi','123','1999','1','1')

INSERT INTO Students (FirstName,LastName,StudentNumber,BirthYear,DepartmentID,AdvisorID) VALUES 
	('a','k','333','1999','1','1')


insert into Courses (ID, Title, Credits, DepartmentID) values 
	('1','db',20,'1')

insert into Courses (ID, Title, Credits, DepartmentID) values 
	('2','micro',17,'1')

insert into Courses (ID, Title, Credits, DepartmentID) values 
	('3','os',16,'1')

insert into Available_Courses (CourseID,Semester,Year,ID ,TeacherID) values 
	('1','fall',1398,'1','1')

insert into Available_Courses (CourseID,Semester,Year,ID ,TeacherID) values 
	('2','spring',1399,'2','1')

insert into Available_Courses (CourseID,Semester,Year,ID ,TeacherID) values 
	('3','spring',1390,'3','1')

insert into Taken_Courses (StudentID,CourseID,Semester,Year,Grade) values 
	('123','1','fall',1398,20)

insert into Taken_Courses (StudentID,CourseID,Semester,Year,Grade) values 
	('123','2','spring',1399,19)

insert into Taken_Courses (StudentID,CourseID,Semester,Year,Grade) values 
	('333','2','spring',1399,12)


SELECT Departments.Name, Departments.ID, Departments.Budget, Departments.Category
FROM Departments join Students On ( Students.DepartmentID = Departments.ID)
where StudentNumber  = '123'

UPDATE Taken_Courses 
SET Grade = Grade+1
WHERE Grade <> 20

select Taken_Courses.StudentID
from Taken_Courses join Courses on (Taken_Courses.CourseID=Courses.ID)
where Courses.Title <> 'db'

