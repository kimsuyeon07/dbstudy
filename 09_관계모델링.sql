
--DROP TABLE STUDENT;    
--DROP TABLE SCHOOL;

--테이블 생성 순서 : 부모(PK) -> 자식(FK)
CREATE TABLE SCHOOL 
(
    SCHOOL_CODE NUMBER(3) PRIMARY KEY,
    SCHOOL_NAME VARCHAR2(20)
);


CREATE TABLE STUDENT
(
    SCHOOL_CODE NUMBER(3) REFERENCES SCHOOL(SCHOOL_CODE),
    STUDENT_NAME VARCHAR2(20)
);
----------------------------------------------------------------



CREATE TABLE student
( 
    student_no VARCHAR2(5) PRIMARY KEY,
    student_name VARCHAR2(15),
    student_age NUMBER(3)
);

CREATE TABLE subject
(
    subject_code VARCHAR2(1) PRIMARY KEY,
    subject_name VARCHAR2(12),
    subject_prof VARCHAR2(15)
);
    
CREATE TABLE enroll
(
    enroll_no NUMBER PRIMARY KEY,
    student_no VARCHAR2(5) REFERENCES student(student_no),
    subject_code VARCHAR2(1) REFERENCES subject(subject_code)
);


DROP TABLE enroll;
DROP TABLE subject;
DROP TABLE student;



