-- 1. 다음 설명을 읽고 적절한 테이블을 생성하되, 기본키/외래키는 별도로 설정하지 마시오.

-- 1) BOOK 테이블
--    (1) BOOK_ID : 책 아이디, 숫자 (최대 11자리), 필수
--    (2) BOOK_NAME : 책 이름, 가변 길이 문자 (최대 100)
--    (3) PUBLISHER : 출판사, 가변 길이 문자 (최대 50)
--    (4) PRICE : 가격, 숫자 (최대 6자리)
create table BOOK
(
    book_id number(11) NOT NULL,
    book_name varchar2(100),
    publisher varchar2(50),
    price number(6)
);



-- 2) CUSTOMER 테이블
--    (1) CUSTOMER_ID : 고객 아이디, 숫자 (최대 11자리), 필수
--    (2) CUSTOMER_NAME : 고객 이름, 가변 길이 문자 (최대 20)
--    (3) ADDRESS : 고객 주소, 가변 길이 문자 (최대 50)
--    (4) PHONE : 고객 전화, 가변 길이 문자 (최대 20)
create table CUSTOMER
(
    customer_id number(11) NOT NULL,
    customer_name varchar2(20),
    address varchar2(50),
    phone varchar2(20)
);

-- 3) ORDERS 테이블
--    (1) ORDER_ID : 주문 아이디, 숫자 (최대 11자리), 필수
--    (2) CUSTOMER_ID : 고객 아이디, 숫자 (최대 11자리)
--    (3) BOOK_ID : 책 아이디, 숫자 (최대 11자리)
--    (4) SALES_PRICE : 판매 가격, 숫자 (최대 6자리)
--    (5) ORDER_DATE : 주문일, 날짜
create table ORDERS
(
    ORDER_ID number(11) NOT NULL,
    customer_id number(11),
    book_id number(11),
    sales_price number(6),
    order_date date
);




drop table orders;
drop table customer;
drop table book;



-- 4) 아래 INSERT 문은 변경 없이 그대로 사용한다.
INSERT ALL
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (1, '축구의역사', '굿스포츠', 7000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (2, '축구아는 여자', '나무수', 13000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (3, '축구의 이해', '대한미디어', 22000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (4, '골프 바이블', '대한미디어', 35000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (5, '피겨 교본', '굿스포츠', 6000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (6, '역도 단계별 기술', '굿스포츠', 6000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (7, '야구의 추억', '이상미디어', 20000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (8, '야구를 부탁해', '이상미디어', 13000)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (9, '올림픽 이야기', '삼성당', 7500)
    INTO BOOK(BOOK_ID, BOOK_NAME, PUBLISHER, PRICE) VALUES (10,'올림픽 챔피언', '피어슨', 13000)
SELECT * FROM DUAL;

INSERT ALL
    INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001')
    INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (2, '김연아', '대한민국 서울', '000-6000-0001')
    INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001')
    INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (4, '추신수', '미국 텍사스', '000-8000-0001')
    INTO CUSTOMER(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, PHONE) VALUES (5, '박세리', '대한민국 대전', NULL)
SELECT * FROM DUAL;

INSERT ALL 
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (1, 1, 1, 6000, '2014-07-01')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (2, 1, 3, 21000, '2014-07-03')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (3, 2, 5, 8000, '2014-07-03')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (4, 3, 6, 6000, '2014-07-04')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (5, 4, 7, 20000, '2014-07-05')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (6, 1, 2, 12000, '2014-07-07')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (7, 4, 8, 13000, '2014-07-07')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (8, 3, 10, 12000, '2014-07-08')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (9, 2, 10, 7000, '2014-07-09')
    INTO ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, SALES_PRICE, ORDER_DATE) VALUES (10, 3, 8, 13000, '2014-07-10')
SELECT * FROM DUAL;

-- 2. BOOK, CUSTOMER, ORDERS 테이블들의 적절한 칼럼에 기본키를 추가하시오.
alter table BOOK add constraint book_pk primary key(book_id);
alter table CUSTOMER add constraint customer_pk primary key(customer_id);
alter table ORDERS add constraint orders_pk primary key(order_id);

-- 3. 외래키가 필요한 테이블을 선정하고 적절한 칼럼에 외래키를 추가하시오.
alter table ORDERS add constraint orders_book_fk foreign key(book_id) references BOOK(book_id);
alter table ORDERS add constraint orders_customer_fk foreign key(customer_id) references CUSTOMER(customer_id);


-- 4. 2014년 7월 4일부터 7월 7일 사이에 주문 받은 도서를 제외하고 나머지 모든 주문 정보를 조회하시오.
select ORDER_ID  
     , CUSTOMER_ID 
     , BOOK_ID 
     , SALES_PRICE 
     , ORDER_DATE 
  from ORDERS
 where order_date NOT between '2014-07-04' and '2014-07-07';
 
 
select ORDER_ID  
     , CUSTOMER_NAME 
     , BOOK_name
     , SALES_PRICE 
     , ORDER_DATE 
  from ORDERS o, BOOK b, CUSTOMER c
 where o.book_id = b.book_id
   and o.book_id = c.customer_id
   and order_date NOT between '2014-07-04' and '2014-07-07';



-- 5. 박지성의 총 구매액(SALE_PRICE)을 조회하시오.
-- 박지성 customer_id 구하기
select customer_name
     , customer_id
  from CUSTOMER
 where customer_name = '박지성';

select c.customer_name
     , sum(o.sales_price) as 총구매액
  from customer c inner join orders o
    on c.customer_id = o.customer_id
 where c.customer_name = '박지성'
 group by c.customer_name;

-- 2) 서브쿼리
-- 박지성의 구매내역만을 인라인 뷰(FROM 절)로 가져와서 처리
select p.customer_name
     , sum(p.sales_price)
  from (select o.sales_price
             , c.customer_name
          from customer c, orders o
         where c.customer_id = o.customer_id
           and c.customer_name = '박지성') p
 group by customer_name;
 
-- 3) 서브쿼리
-- 박지성 구매내역의 합계를 스칼라 서브쿼리로 처리
select c.customer_name
     , (select sum(o.sales_price)
          from orders o
         where c.customer_id = o.customer_id) as 총구매액
  from customer c
 where c.customer_name = '박지성';



-- 6. 박지성이 구매한 도서의 수를 조회하시오.
select c.customer_name
     , count(o.order_id) as 구매도서수
  from orders o inner join customer c
    on o.customer_id = c.customer_id
 where c.customer_name = '박지성'
 group by c.customer_name;




select count(*) as 구매도서수
  from ORDERS 
 where customer_id = (select customer_id
                        from CUSTOMER
                       where customer_name = '박지성');

-- 7. 박지성이 구매한 도서를 발간한 출판사(PUBLISHER)의 수를 조회하시오.
-- 박지성 : customer_name
-- 구매한 도서 : book_id
-- 발간한 출판사 : publisher
-- 출판사(PUBLISHER) 조회 : 중복제거

select c.customer_name
     , count( DISTINCT b.publisher ) as 구매한도서의출판사수
  from book b, customer c, orders o
 where b.book_id = o.book_id
   and c.customer_id = o.customer_id
   and customer_name = '박지성'
 group by customer_name;
 
 
select c.customer_name
     , count( DISTINCT b.publisher ) as 구매한도서의출판사수
  from customer c inner join orders o
    on c.customer_id = o.customer_id inner join book b
    on b.book_id = o.book_id
 where customer_name = '박지성'
 group by customer_name; 
 -- 1) 카운트하기 위해서는 그룹화가 필요합니다. 
 -- 2) 그룹화는 보여주고자하는 칼럼으로 만들어주는 것입니다.
 



-- 8. 고객별로 분류하여 각 고객의 이름과 각 고객별 총 구매액을 조회하시오.
select customer_name
     , NVL(sum(sales_price), 0) as 도서구매액
  from customer c inner join orders o
    on c.customer_id = o.customer_id
 group by customer_name;
 
 
select customer_name
     , NVL(sum(sales_price), 0) as 도서구매액
  from customer c left outer join orders o
    on c.customer_id = o.customer_id
 group by customer_name;
 
 
select customer_name
     , NVL(sum(sales_price), 0) as 도서구매액
  from customer c, orders o
 where c.customer_id = o.customer_id(+)
 group by customer_name;



-- 9. 주문한 이력이 없는 고객의 이름을 조회하시오.
-- select from customer_id not in (주문한 customer_id);
select DISTINCT c.customer_name
  from customer c right outer join orders o
    on c.customer_id = o.customer_id;
    
select c.customer_name
  from customer c 
 where c.customer_id NOT IN (select distinct o.customer_id
                               from orders o);



-- 10. 고객별로 총 구매횟수를 조회하시오.
select c.customer_name
     , count(o.order_id) as 총구매횟수
  from customer c inner join orders o
    on c.customer_id = o.customer_id
 group by customer_name;


select c.customer_name
     , count(o.order_id) as 총구매횟수
  from customer c left outer join orders o
    on c.customer_id = o.customer_id
 group by customer_name;
 
 
select c.customer_name
     , c.customer_id
     , count(o.order_id) as 총구매횟수
  from customer c, orders o
 where c.customer_id = o.customer_id(+)
 group by c.customer_name, c.customer_id;




