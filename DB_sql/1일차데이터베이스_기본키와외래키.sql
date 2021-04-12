-- 고객 릴레이션 (부모테이블)
    -- NVARCHAR2(30) : 30글자
    -- VARCHAR2(30) : 30바이트의 용량
    -- VARCHAR2 (값이 변하는 값)
    -- CHAR(1) : 1글자의 단어 (변하지 않는 값)
create table 고객
(
    고객아이디 VARCHAR2(30) PRIMARY KEY,
    고객이름 VARCHAR2(30),
    나이 NUMBER(3),
    등급 CHAR(1),
    직업 VARCHAR2(5),
    적립금 NUMBER(7)
);
    
    
-- 주문 릴레이션 (자식테이블)
CREATE TABLE 주문
(
    주문번호 NUMBER PRIMARY KEY,
    주문고객 VARCHAR2(30) REFERENCES 고객(고객아이디), --외래키(고객테이블의 고객아이디 칼럼을 참조), FOREIGN KEY(FK)
    주문제품 VARCHAR2(20),
    수량 NUMBER,
    단가 NUMBER,
    주문일자 DATE
);

drop table 고객;