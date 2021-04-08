-- 시퀀스
-- 1. 일련번호 생성 객체이다.
-- 2. 주로 기본키(인공키)에서 사용한다.
-- 3. currval : 시퀀스가 생성해서 사용한 현재 번호
-- 4. nextnal : 시퀀스가 생성해아 할 다음 번호

-- 시퀀스 생성
create sequence employee_seq
increment by 1   -- 번호가 1씩 증가한다.
start with 1000  -- 번호 시작이 1000이다.
nomaxvalue       -- 최대값 없음 (MAXVALUE 999999)
nominvalue       -- 최소값 없음
nocycle          -- 번호 순환이 없다.
nocache;         -- 메모리에 캐시하지 않는다. => 항상 유지!

-- employee3 테이블에 행 삽입
--emp_no는 시퀸즈로 입력
insert into employee3
     (emp_no, name, depart, position, gender, hire_date, salary)
values
    (employee_seq.nextval, '구창민', 1, '과장', 'M', '95-05-01', '500000');
    
    
-- 시퀀즈 값 확인
select employee_seq.currval
  from dual;
  
  
-- 시퀀스 목록 확인
select *
  from user_sequences;
  
  
-- ROWNUM : 가상 행 번호
-- BOWID : 데이터가 저장된 물리적 위치 정보

select rownum
     , rowid
     , emp_no
     , name
  from employee;
  
-- 최고 빠른 검색 : rowid를 이용한 검색.
select emp_no
     , name
  from employee
 where rowID = 'AAAFCWAABAAALDRAAD';
 
-- 그 다음 빠른 검색 : INDEX를 이용한 검색 (휴먼의 검색 방식)
select emp_no
     , name
  from employee
 where emp_no = 1003;
  
  
-- ROWNUM의 WHERE절 사용
-- 주의. 
-- 1. 1을 포함하는 검색만 가능하다.
-- 2. 순서대로 몇 건을 추출하기 위한 목적이다. 
-- 3. 특정 위치를 지정한 검색은 불가능하다.
select emp_no
     , name
  from employee
 where rownum = 1;  -- 가능하다. 
 
 
select emp_no
     , name
  from employee
 where rownum = 2;  -- 검색이 되지 않는다.
 
 
select emp_no
     , name
  from employee
 where rownum between 1 and 3;  -- (1을 포함하였기 때문에) 가능하다.
  
  
select emp_no
     , name
  from employee
 where rownum between 4 and 5;  -- (1이 포함되지 않았기 때문에) 불가능하다.
 
-- ** 반드시, 1이 포함되어야 한다 **
-- 이를 보완하기 위해서 ↓↓
-- 모든 ROWNUM을 사용하기 위해서는 
-- ROWNUM에 별명을 주고 별명을 사용한다.

/*변경전 오류 상태*/
select rownum as rn -- 실행순서 3
     , emp_no
     , name
  from employee     -- 실행순서 1  (from절에 ROWNUM의 별명을 선언해주어야 한다.)
 where rn = 2;      -- 실행순서 2  --> 오류!

/*from절에 rownum의 별명 선언 방법.*/
select e.emp_no
     , e.name
  from (select rownum as rn
             , emp_no
             , name
          from employee) e  -- 실행순서 1 (여기서 rn이 만들어진다.)
 where e.rn = 2;            -- 실행순서 2
 


------------------------------------------------------------------------------------------

-- 연습문제
-- 1. 다음 테이블을 생성한다.
--  게시판 (글번호, 글제목, 글 내용, 글작성자, 작성일자)
--  회원 (회원번호, 아이디, 이름, 가입일자)
create table member
(
    member_no number(6),
    m_id varchar2(20),
    m_name varchar2(20),
    m_hire_date date
);  

create table board
( 
    board_no number,
    b_title varchar2(20),
    b_content varchar2(100),
    member_no number,
    b_date date
);

-- 2. 각 테이블에서 사용할 시퀀스를 생성한다.
-- 시퀀스 생성

--  게시판시퀀스 (1~무제한)
create sequence board_seq
increment by 1
start with 1
nomaxvalue
nominvalue
nocycle
nocache;
--  회원시퀀스(100000 ~ 999999) : 6자리
create sequence member_seq
increment by 1
start with 100000
maxvalue 999999
nominvalue
nocycle
nocache;


-- 3. 각 테이블에 적절한 기본키, 외래키, 데이터(5개)를 추가한다.
--PK
alter table member add constraint member_pk primary key(member_no);
alter table board add CONSTRAINT board_pk primary key(board_no);
-- FK
alter table board add constraint board_member_fk foreign key(member_no) REFERENCES member(member_no);
-- insert
insert into member (member_no, m_id, m_name, m_hire_date) values (member_seq.nextval, 'aaa', 'james', SYSDATE);
insert into member (member_no, m_id, m_name, m_hire_date) values (member_seq.nextval, 'bbb', 'alice', SYSDATE);
insert into member (member_no, m_id, m_name, m_hire_date) values (member_seq.nextval, 'ccc', 'brown', SYSDATE);
insert into member (member_no, m_id, m_name, m_hire_date) values (member_seq.nextval, 'ddd', 'jadu', SYSDATE);
insert into member (member_no, m_id, m_name, m_hire_date) values (member_seq.nextval, 'eee', 'crown', SYSDATE);

insert into board (board_no, b_title, b_content, member_no, b_date) values (board_seq.nextval, '어린왕자', '어느날...', 100001, SYSDATE);
insert into board (board_no, b_title, b_content, member_no, b_date) values (board_seq.nextval, 'ㄱ제목2', '내용2', 100004, SYSDATE);
insert into board (board_no, b_title, b_content, member_no, b_date) values (board_seq.nextval, 'ㄴ제목3', '내용3', 100002, SYSDATE);
insert into board (board_no, b_title, b_content, member_no, b_date) values (board_seq.nextval, 'ㄷ제목4', '내용4', 100004, SYSDATE);
insert into board (board_no, b_title, b_content, member_no, b_date) values (board_seq.nextval, 'ㄹ제목5', '내용5', 100003, SYSDATE);

select * from board;
select * from member;


-- 제약조건 삭제
alter table board drop CONSTRAINT board_member_fk;
alter table board drop constraint board_pk;
drop table board;

-- 4. 게시판을 글제목의 가나다 순으로 정렬하고 첫 번째글을 조회한다.
select b.board_no
     , b.b_title
     , b.b_content
     , b.member_no
     , b.b_date
  from (select *
          from board
         order by b_title) b
 where rownum = 1;


-- 5. 게시판을 글번호의 가나다 순으로 정렬하고 1 ~ 3 번째 글을 조회한다.
select b.board_no
     , b.b_title
     , b.b_content
     , b.member_no
     , b.b_date
  from (select board_no
             , b_title
             , b_content
             , member_no
             , b_date
          from board
         order by board_no) b
 where rownum <= 3;



-- 6. 게시판을 최근 작성일자 순으로 정렬하고 3 ~ 5번째 글을 조회한다.  // 여러번 만들어보기.
--    1) [정렬]먼저. 최근 작성일자 순으로 정렬
--    2) [rownum] 임시번호생성
--    3) 3 ~ 5번째 글을 조회
select a.*
  from (select b.board_no
             , b.b_title
             , b.b_content
             , b.member_no
             , b.b_date
             , rownum as rn
          from (select board_no
                     , b_title
                     , b_content
                     , member_no
                     , b_date
                  from board
                 order by b_date desc) b) a
 where a.rn between 3 and 5;



-- 7. 가장 먼저 가입한 회원을 조회한다.




-- 8. 3번째로 가입한 가입한 회원을 조회한다.
-- 9. 가장 나중에 가입한 회원을 조회한다.




    
 
 
 
 
 
 
 
  
  
  
  
  
  
  
  