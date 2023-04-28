/*3-a*/
where left(first_name,2)='me' and right(last_name,3)='avi'
/*3-b*/
select concat(first_name,last_name);

/***************************************************************/
/*4-a*/
select id,name
from student
where name like 'M%a'

/*4-b*/
select title
from course,section 
where course.course_id = section.course_id and year=2009 and semester='Fall' and dept_name like '%Eng.'


/*4-c*/
select name,title
from takes join student on takes.id=student.id join course on takes.course_id=course.course_id
group by student.id,course.course_id
having count(*)>2

/*4-d*/
select prereq_id, sum(credits)
from course join prereq on course.course_id = prereq.course_id
group by prereq_id
having sum(credits)>4
order by sum desc

/*4-e*/
select room_number
from section join time_slot on section.time_slot_id = time_slot.time_slot_id
where semester='Spring' and year=2008
group by room_number
having sum(end_hr-start_hr)>=2

/*4-f*/
select name, count(*)
from teaches join instructor on teaches.id = instructor.id
where year = 2003
group by instructor.id
having count(*)<((select avg(countinsteach.countteach) from
				( select instructor.id, count(*) as countteach
				 from teaches join instructor on teaches.id = instructor.id
				 where year = 2003
				 group by instructor.id) as countinsteach
				)
			   )
			   
			   
/*4-g*/
select * from section
where year=2007 and building='Taylor' and 
   (select count(*)
    from time_slot
	where section.time_slot_id=time_slot.time_slot_id and start_hr between 8 and 12
   )>=1
   
   
/*4-h*/
select a.name,sum(credits)
from course join takes on course.course_id=takes.course_id join student as a on takes.id=a.id
where grade like 'A%' or grade like 'B%'
group by a.id

/****************************************************************/
/*5-a*/
select dept_name from
(select dept_name, sum(salary) from instructor group by dept_name) as
dept_total(dept_name,value) ,
(select avg(value) from (select dept_name, sum(salary) from instructor group
by dept_name) as dept_total(dept_name,value)) as dept_total_avg(value)
where dept_total.value >= dept_total_avg.value;

/*5-b*/
with AvgInsTeach(_AvgInsTeach) as( select avg(countinsteach.countteach)
from (select instructor.id,count(*) as countteach
from teaches,instructor
where teaches.id=instructor.id and year=2003
group by instructor.id,year) as countinsteach )
select instructor.name,count(*)
from teaches,instructor
where teaches.id=instructor.id and year=2003
group by instructor.id,year
having count(*)>(select _AvgInsTeach from AvgInsTeach)

/***************************************************************/
/*6-a*/
create table uni_data(
"stu_id" varchar(5),
"stu_name" varchar(20),
"stu_dept_name" varchar(255),
"year" numeric(4),
"semester" varchar(6),
"course_name" varchar(50),
"score" int4,
"is_rank" int2
);

/*6-b*/
insert into uni_data
select s."id", s."name",s.dept_name,T."year",T.semester,C.title,
(case
when T.grade = 'A+' then 100
when T.grade = 'A ' then 95
when T.grade = 'A-' then 90
when T.grade = 'B+' then 85
when T.grade = 'B ' then 80
when T.grade = 'B-' then 75
when T.grade = 'C+' then 70
when T.grade = 'C ' then 65
when T.grade = 'C-' then 60 else 0 end ),
( case when T.grade in ( 'A+', 'A ', 'A-', 'B+', 'B ', 'B-' ) then 1 else
0 end )
from takes as T join student as s on T."id" = s."id" join course as C on C.course_id = T.course_id

/*6-c*/
update uni_data
set score = ( case when score < 75 then score + 10 else score + 15 end )
where uni_data.stu_dept_name = 'Physics'

/*6-d*/
delete from uni_data as ud1
where stu_name like 'T%' and 
  score < ( select avg( score ) from uni_data as ud2
  where ud2.stu_dept_name = ud1.stu_dept_name)