-- 11. 기본SQL 작성하기 DDL활용

drop table schedule;
drop table player;
drop table event;
drop table nation;


-- 1. 국가(nation) 테이블
create table nation 
(
    nation_code number(3),
    nation_name varchar2(30),
    nation_prev_rank number,
    nation_curr_rank number,
    nation_parti_person number,
    nation_parti_event number
);

-- 종목(event) 테이블
create table event 
(
    event_code number(5),
    event_name varchar2(30),
    event_info varchar2(1000),
    event_first_year number(4)
);

-- 선수(player) 테이블
create table player 
(
    player_code number(5),
    nation_code number(3),
    event_code number(5),
    player_name varchar2(30),
    player_age number(3),
    player_rank number
);

-- 일정(schedule) 테이블
create table schedule
(
    nation_code number(3),
    event_code number(5),
    schedule_info varchar2(1000),
    schedule_begin date,
    schedule_end date
);



-- 각 테이블에 기본키를 추가하기
alter table nation add constraint nation_pk Primary key(nation_code);
alter table event add constraint event_pk primary key(event_code);
alter table player add constraint player_pk primary key(player_code);
alter table schedule add constraint schedule_pk primary key(nation_code, event_code);



-- 각 테이블에 외래키 추가하기
alter table player add constraint player_nation_fk foreign key(nation_code) references nation(nation_code);  
alter table player add constraint player_event_fk foreign key(event_code) references event(event_code);
alter table schedule add constraint schedule_nation_fk foreign key(nation_code) references nation(nation_code);
alter table schedule add constraint schedule_event_fk foreign key(event_code) references event(event_code);


-- * 제약조건의 삭제
-- 외래키가 들어있는 자식테이블 먼저 제약조건을 삭제해야 한다.
-- ALTER TABLE 테이블 DROP CONSTRAINT 제약조건;
alter table player drop constraint player_nation_fk;
alter table schedule drop constraint schedule_nation_fk;
alter table nation drop constraint nation_pk;  -- nation_pk를 참조하는 외래키를 먼저 지워야 한다.

alter table player drop constraint player_event_fk;
alter table schedule drop constraint schedule_event_fk;
alter table event drop constraint event_pk;  -- event_pk를 참조하는 외래키를 먼저 지워야 한다.

alter table player drop constraint player_pk;
alter table schedule drop constraint schedule_pk;


-- **제약조건의 확인 : DESC
-- 제약조건을 저장하고 있는 DD(Data Dictionary) : USER_CONSTRAINTS
DESC user_constraints;  --구조 확인

select constraint_name, table_name from user_constraints;
select constraint_name, table_name from user_constraints where table_name = 'PLAYER';
    -- (내용이 없이 결과보여준다) ? : where table_name = 'player' (X) : palyer => 대문자로 작성



-- 제약조건의 비활성화 : ALTER, DISABLE
alter table player disable constraint player_nation_fk;

-- 제약조건의 활성화 : ALTER ENABLE
alter table player enable constraint player_nation_fk;








