
DROP TABLE CUSTOMER;
DROP TABLE BANK;

-- 제약조건 입력 (primary key, unique, foreign key, checkS() ...)
-- 제약조건에 이름을 주는 방법 < constraint 이름 ... >
    -- : (primary key) => CONSTRAINT 테이블명_PK  ((( 처럼

create table bank 
(
    bank_code varchar2(20),
    bank_name varchar2(30)
);

create table customer
(
    no number,
    name varchar2(30) not null,
    phone varchar2(30),
    age number,
    bank_code varchar2(20)
);



-- 테이블 구조 확인
desc bank;
desc customer;



-- 테이블 변경
-- ALTER TABLE 테이블 (ADD, DROP, MCDIFY 등)

-- 제약조건의 추가
ALTER TABLE bank ADD CONSTRAINT bank_pk PRIMARY KEY(bank_code);
alter table customer add constraint coustomer_pk primary key(no);
alter table customer add constraint coustomer_phone_uq unique(phone);
alter table customer add constraint coustomer_age_ck check(age between 0 and 100);
alter table customer add constraint coustomer_bank_fk foreign key(bank_code) references bank(bank_code);


-- 칼럼의 추가
-- ALTER TABLE 테이블 ADD 칼럼명 타입 [제약조건];
-- 1. bank 테이블에 bank_phone 칼럼을 추가한다.
alter table bank add bank_phone varchar2(15);

-- 칼럼의 수정
-- ALTER TABLE 테이블 MODIFY 칼럼명 타입;
-- 1. bank 테이블의 bank_name 칼럼을 varchar2(15)로 수정한다.
alter table bank modify bank_name varchar2(15);
-- 2. customer 테이블의 age 칼럼을 number(3)으로 수정한다.
alter table customer modify age number(3);

-- 3. customer 테이블의 phone 칼럼을 NOT NULL로 수정한다.
alter table customer modify phone varchar2(30) not null;
-- 4. customer 테이블의 phone 칼럼을 NULL로 수정한다.
    -- alter table customer modify phone varchar2(30); (X)  : null을 같이 넣어줘야 한다.
alter table customer modify phone varchar2(30) NULL;


-- 칼럼의 삭제
-- ALTER TABLE 테이블 DROP COLUMN 칼럼명;
-- 1. bank 테이블의 bank_phone 칼럼을 삭제한다.
alter table bank drop column bank_phone;


-- 칼럼의 이름 변경
-- ALTER TABLE 테이블 RENAME COLUMN 기존칼럼명 TO 신규칼럼명;
-- 1. customer 테이블의 phone 칼럼명을 contact으로 수정한다.
alter table customer rename column phone to contact;


-- 