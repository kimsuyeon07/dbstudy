DROP TABLE BUYS;
DROP TABLE USERS;

-- 사용자(USERS) 테이블 생성
CREATE TABLE USERS (
    USER_NO NUMBER,  -- 사용자번호
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,  -- 아이디
    USER_NAME VARCHAR2(20),  -- 이름
    USER_YEAR NUMBER(4),  -- 태어난년도
    USER_ADDR VARCHAR2(100),  -- 주소
    USER_MOBILE1 VARCHAR2(3),  -- 010, 011 등
    USER_MOBILE2 VARCHAR2(8),  -- 12345678, 11111111 등
    USER_REGDATE DATE  -- 가입일
);

-- 구매(BUYS) 테이블 생성
CREATE TABLE BUYS (
    BUY_NO NUMBER,  -- 구매번호
    USER_ID VARCHAR2(20),  -- 구매자아이디
    PROD_NAME VARCHAR2(20),  -- 제품명
    PROD_CATEGORY VARCHAR2(20),  -- 제품카테고리
    PROD_PRICE NUMBER,  -- 제품가격
    BUY_AMOUNT NUMBER  -- 구매수량
);

1. 적절한 기본키와 외래키를 지정하시오.
alter table USERS add constraint users_pk primary key(USER_NO);
alter table BUYS add constraint buys_pk primary key(BUY_NO);
alter table BUYS add constraint buys_users_fk foreign key(USER_ID) references USERS(USER_ID);

2. 아래 INSERT문에서 사용되고 있는 사용자번호와 구매번호 대신 사용할 시퀀스를 생성하고 이를 INSERT문에 적용한 뒤 INSERT문을 실행하시오.
drop sequence users_seq;
drop sequence buys_seq;

create sequence users_seq
increment by 1
start with 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence buys_seq
increment by 1
start with 1001
nomaxvalue
nominvalue
nocycle
nocache;

-- USERS 테이블에 레코드(행, ROW) 삽입하기
INSERT INTO USERS VALUES (users_seq.nextval, 'YJS', '유재석', 1972, '서울', '010', '11111111', '08/08/08');
INSERT INTO USERS VALUES (users_seq.nextval, 'KHD', '강호동', 1970, '경북', '011', '22222222', '07/07/07');
INSERT INTO USERS VALUES (users_seq.nextval, 'KKJ', '김국진', 1965, '서울', '019', '33333333', '09/09/09');
INSERT INTO USERS VALUES (users_seq.nextval, 'KYM', '김용만', 1967, '서울', '010', '44444444', '15/05/05');
INSERT INTO USERS VALUES (users_seq.nextval, 'KJD', '김제동', 1974, '경남', NULL, NULL, '13/03/03');
INSERT INTO USERS VALUES (users_seq.nextval, 'NHS', '남희석', 1971, '충남', '016', '55555555', '14/04/04');
INSERT INTO USERS VALUES (users_seq.nextval, 'SDY', '신동엽', 1971, '경기', NULL, NULL, '08/10/10');
INSERT INTO USERS VALUES (users_seq.nextval, 'LHJ', '이휘재', 1972, '경기', '011', '66666666', '06/04/04');
INSERT INTO USERS VALUES (users_seq.nextval, 'LKK', '이경규', 1960, '경남', '018', '77777777', '04/12/12');
INSERT INTO USERS VALUES (users_seq.nextval, 'PSH', '박수홍', 1970, '서울', '010', '88888888', '12/05/05');

-- BUYS 테이블에 레코드(행, ROW) 삽입하기
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KHD', '운동화', '신발', 30, 2);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KHD', '노트북', '전자', 1000, 1);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KYM', '모니터', '전자', 200, 1);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'PSH', '모니터', '전자', 200, 5);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KHD', '청바지', '의류', 50, 3);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'PSH', '메모리', '전자', 80, 10);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KJD', '책', '의류', 15, 5);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'LHJ', '책', '서적', 15, 2);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'LHJ', '청바지', '의류', 50, 1);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'PSH', '운동화', '신발', 30, 2);

-- 3. 제품명이 '책'인데 제품카테고리가 '서적'이 아닌 구매 목록을 찾아서 제품카테고리를 '서적'으로 수정하시오.
update BUYS set PROD_CATEGORY = '서적' where PROD_NAME='책';

-- 4. 연락처1이 '011'인 사용자의 연락처1을 '010'으로 수정하시오.

-- 5. 구매 테이블에서 사용자번호가 5인 사용자의 구매 정보를 삭제하시오.

-- 6. 연락처1이 없는 사용자를 조회하시오.

-- 7. 연락처2가 '5'로 시작하는 사용자를 조회하시오.

-- 8. 구매 이력이 있는 사용자들의 이름, 제품명, 제품가격, 구매수량을 조회하시오.

-- 9. 제품카테고리별로 그룹화하여 제품카테고리, 구매횟수, 총구매수량을 조회하시오.

-- 10. 구매 이력이 있는 고객을 대상으로 어떤 고객이 어떤 제품을 구매했는지 알 수 있도록 고객명, 구매제품을 조회하시오.

-- 11. 제품을 구매한 이력이 있는 고객아이디, 고객명, 총구매횟수를 조회하시오.

-- 12. 제품을 구매한 이력이 있는 고객명과 총 구매액을 조회하시오.

-- 13. 구매 이력과 상관 없이 고객별 구매횟수를 조회하시오. 구매 이력이 없으면 구매횟수는 0으로 조회하시오.

-- 14. 구매 이력에 상관 없이 고객별 총 구매액을 조회하시오. 구매 이력이 없으면 총 구매액은 0으로 조회하시오.

-- 15. 카테고리가 '전자'인 제품을 구매한 고객명과 총 구매액을 조회하시오.

-- 16. 구매횟수가 2회 이상인 고객명과 구매횟수를 조회하시오.

-- 17. USERS 테이블과 BUYS 테이블 각각 종속 관계를 확인하고 필요하다면 정규화하시오.

