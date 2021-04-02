--------------------------------------------------------------
-- 제약조건추가 (PK, FK)
-- 테이블의 생성 순서 조정
-- 칼럼 수정 (칼럼명, 칼럼타입)
-- 테이블 삭제 순서

-- 1.회원 테이블
CREATE TABLE MEMBER
( 
    MEMBER_NO number,              -- 회원번호  member_no == memberNo \\ m_no == mNp
    MEMBER_ID varchar2(30),        -- 회원아이디
    MEMBER_PASSWORD varchar2(30),  -- 회원비밀번호
    MEMBER_NAME varchar2(15),      -- 회원이름
    MEMBER_EMAIL varchar2(50),     -- 회원이메일
    MEMBER_PHONE varchar2(15),     -- 회원전화번호
    MEMBER_DATE date,              -- 회원가입일자
    primary key (MEMBER_NO)
);

-- 2.게시판 테이블
create table BOARD 
(
    BOARD_NO number,   -- 게시글번호
    BOARD_TITLE varchar2(1000),    -- 제목
    BOARD_CONTENT varchar2(4000),  -- 내용   -- varchar2타입의 MAX값은 4000
    BOARD_HIT number,              -- 조회수
    MEMBER_NO number,              -- 작성자(member테이블의 member_no참조하는 외래키)
    BOARD_DATE date ,              -- 작성일
    primary key (BOARD_NO),
    foreign key(MEMBER_NO) references member(MEMBER_NO)
);


-- 5.제조사 테이블
CREATE TABLE manufacturer
(
    manufacturer_no VARCHAR2(12),            -- 사업자번호
    manufacturer_name VARCHAR2(100) UNIQUE,  -- 제조사명
    manufacturer_phone VARCHAR2(15),         -- 연락처
    PRIMARY KEY (manufacturer_no)
);

-- 6.창고테이블
create table warehouse
(
    warehouse_no number,               -- 창고번호 
    warehouse_name varchar2(5),        -- 창고이름
    warehouse_location varchar2(100),  -- 창고위치
    warehouse_used varchar2(1),        -- 창고사용여부
    primary key (warehouse_no)
);



-- 8.택배사테이블
CREATE TABLE delivery_service
(
    delivery_service_no VARCHAR2(12),       -- 택배업체사업자번호
    delivery_service_name VARCHAR2(20),     -- 택배업체명
    delivery_service_phone VARCHAR2(15),    -- 택배업체연락처 
    delivery_service_address VARCHAR2(100), -- 택배업체주소
    PRIMARY KEY (delivery_service_no)
);



-- 7.배송테이블
CREATE TABLE delivery
(
    delivery_no NUMBER,                -- 배송번호
    delivery_service_no VARCHAR2(12),  -- 택배업체
    delivery_pirce NUMBER,             -- 배송가격
    delivery_date DATE,                -- 배송날짜
    PRIMARY KEY (delivery_no),
    FOREIGN KEY(delivery_service_no) REFERENCES delivery_service(delivery_service_no)
);



-- 3.주문 테이블
CREATE TABLE orders
(
    orders_no NUMBER,             -- 주문번호
    member_no NUMBER,             -- 주문회원
    delivery_no NUMBER,           -- 배송번호
    orders_pay VARCHAR2(10),      -- 결제방법
    orders_date DATE,             -- 주문일자
    PRIMARY KEY (orders_no),
    FOREIGN KEY(member_no) REFERENCES MEMBER(member_no),
    FOREIGN KEY(delivery_no) REFERENCES delivery(delivery_no)
    
    
);




-- 4.제품 테이블
CREATE TABLE product 
(
    product_code VARCHAR2(10),           -- 제품코드
    product_name VARCHAR2(50),           -- 제품명
    product_price NUMBER,                -- 가격
    prodcut_category VARCHAR2(15),       -- 카테고리
    orders_no NUMBER,                    -- 주문번호
    manufacturer_no VARCHAR2(12) REFERENCES manufacturer(manufacturer_no), -- 제조사
    warehouse_no NUMBER REFERENCES warehouse(warehouse_no),                -- 창고번호
    PRIMARY KEY (product_code),
    FOREIGN KEY(orders_no) REFERENCES orders(orders_no),
    FOREIGN KEY(manufacturer_no) REFERENCES manufacturer(manufacturer_no),
    FOREIGN KEY(warehouse_no) REFERENCES warehouse(warehouse_no)
    
);


DROP TABLE product;             -- 8.제품 테이블
DROP TABLE warehouse;           -- 7.창고테이블
DROP TABLE manufacturer;        -- 6.제조사 테이블
DROP TABLE orders;              -- 5.주문 테이블
DROP TABLE delivery;            -- 4.배송테이블
DROP TABLE delivery_service;    -- 3.택배사테이블
DROP TABLE board;               -- 2.게시판 테이블
DROP TABLE MEMBER;              -- 1.회원 테이블









