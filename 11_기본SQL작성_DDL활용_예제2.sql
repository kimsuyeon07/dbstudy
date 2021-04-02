-- 예제 2

drop table lecture;
drop table enroll;
drop table course;
drop table student;
drop table professor;

-- 테이블 생성
-- 1. 테이블 : professor
create table professor
(
    prof_no number,
    prof_name varchar2(20),
    prof_major varchar2(20)
);

-- 2. 테이블 : student
create table student 
(
    student_no number,
    student_name varchar2(20),
    student_address varchar2(50),
    student_year number,
    prof_no number
);

-- 3. 테이블 : course
create table course
(
    course_no number,
    course_title varchar2(20),
    credit number
);

-- 4. 테이블 : enroll
create table enroll
(
    enroll_no number,
    student_no number,
    course_no number,
    enroll_date date
);

 -- 5. 테이블 : lecture
create table lecture
(
    lect_no number,
    prof_no number,
    enroll_no number,
    lect_title varchar2(20),
    lect_room number
);


-- 제약 조건
-- 기본키
alter table professor add constraint prof_pk primary key(prof_no);
alter table student add constraint student_pk primary key(student_no);
alter table course add constraint course_pk primary key(course_no);
alter table enroll add constraint enroll_pk primary key(enroll_no);
alter table lecture add constraint lect_pk primary key(lect_no);
-- 외래키
alter table student add constraint student_prof_fk foreign key(prof_no) references professor(prof_no);
alter table enroll add constraint enroll_student_fk foreign key(student_no) references student(student_no);
alter table enroll add constraint enroll_course_fk foreign key(course_no) references course(course_no);
alter table lecture add constraint lect_prof_fk foreign key(prof_no) references professor(prof_no);
alter table lecture add constraint lect_enroll_fk foreign key(enroll_no) references enroll(enroll_no);


-- INSERT
insert into professor values (101, '교수1','수학');
insert into professor values (102, '교수2','국어');
insert into professor values (103, '교수3','사회');

insert into student values (2101, '학생1', '서울', 1, 101);
insert into student values (2102, '학생2', '부산', 2, 103);
insert into student values (2103, '학생3', '인천', 4, 102);

insert into course values (301, '사회', 60);
insert into course values (302, '수학', 50);
insert into course values (303, '국어', 80);

insert into enroll values (401, 2102, 302, SYSDATE);
insert into enroll values (402, 2101, 301, SYSDATE);
insert into enroll values (403, 2103, 303, SYSDATE);

insert into lecture values (501, 103, 401, '수학공부', 1);
insert into lecture values (502, 101, 402, '사회공부', 2);
insert into lecture values (503, 102, 403, '국어공부', 3);


SELECT * FROM lecture;

commit;



















