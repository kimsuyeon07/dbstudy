DROP TABLE score;


-- 오라클 내장 함수


-- 1. 집계 함수
CREATE TABLE score 
(
    kor NUMBER(3),
    eng NUMBER(3),
    mat NUMBER(3)
);

INSERT INTO score VALUES (10, 10, 10);
INSERT INTO score VALUES (20, 20, 20);
INSERT INTO score VALUES (30, 30, 30);
INSERT INTO score VALUES (90, 90, 90);
INSERT INTO score VALUES (100, 100, 100);

-- 1) 국어(kor) 점수의 합계 구하기
SELECT SUM(kor) FROM score;  --칼럼이 1개인 테이블로 보여진다.
SELECT SUM(kor) 합계 FROM score;  --칼럼의 이름이 '합계'이다
SELECT SUM(kor) AS 국어점수합계 FROM score;  --칼럼의 이름이 '국어점수합계'이다

-- 2) 모든 점수의 합계를 구해라
SELECT SUM(kor, eng, mat)  FROM score; -- 칼럼은 1개만 지정할 수 있다.
SELECT SUM(kor) + SUM(eng) + SUM(mat) AS 전체점수합계 FROM score;

-- 3) 국어(kor) 점수의 평균을 구한다
SELECT SUM(kor)/5 AS 국어점수평균 FROM score;

-- 4) 영어(eng) 점수의 최댓값을 구한다.
SELECT MAX(eng) AS 가장높은영어점수 FROM score;

-- 5) 수학(mat) 점수의 최솟값을 구한다.
SELECT MIN(mat) AS 가장낮은수학점수 FROM score;


-- 'name'칼럼을 추가하고, 적당한 이름을 삽입하시오.
ALTER TABLE score ADD NAME VARCHAR2(20);
UPDATE score SET name = 'JADU    ' WHERE kor = 10;
UPDATE score SET name = '   jjhangu   ' WHERE kor = 20;
UPDATE score SET name = 'Wulik    ' WHERE kor = 30;
UPDATE score SET name = '    James' WHERE kor = 90;
UPDATE score SET name = 'Smith   ' WHERE kor = 100;

-- 국어점수 중 임의로 2개를 null로 수정하시오.
UPDATE score SET kor=NULL WHERE NAME='JADU';
UPDATE score SET kor=NULL WHERE NAME='Wulik';


-- 6) 이름의 개수를 구하시오
SELECT COUNT (NAME) FROM score;
-- 7) 국어점수의 개수
SELECT COUNT(kor) FROM score;
-- 8) 학생이 몇명이냐
SELECT COUNT(*) FROM score;  -- *는 전체 칼럼을 의미한다.
                             -- 어떤 칼럼이든 하나라도 데이터가 포함되어있으면 개수를 구한다.
       
--------------------------------------------------------------------------

-- 2. 문자 I함수
-- 1) 대소문자 관련 함수
SELECT initcap(name) FROM score;  -- 첫 글자만 대문자, 나머지는 소문자
SELECT UPPER(name) FROM score;    -- 모두 대문자
SELECT LOWER(name) FROM score;    -- 모두 소문자

-- 2) 문자열의 길이 반환 함수
SELECT LENGTH(name) FROM score;

-- 3) 문자열의 일부 반환 함수
SELECT substr(name, 2, 3) FROM score;  -- 시작이 1입니다. (2번째글자부터 3글자를 반환한다.)

-- 4) 문자열에서 특정 문자의 포함된 위치 반환 함수
SELECT instr(name, 'J') FROM score;  -- 'j'가 아닌 'J'를 찾는것. : 없으면 0을 반환한다.
SELECT instr(UPPER(name), 'J') FROM score;

-- 5) 왼쪽 패딩
SELECT lpad(name, 10, '*') FROM score;
-- 6) 오른쪽 패딩
SELECT Rpad(name, 10, '*') FROM score;

-- 모든 name을 "오른쪽 맞춤"해서 출력
SELECT lpad(name, 10, ' ') FROM score;  -- 왼쪽에 여백을 줘서 진행

-- 모든 name을 다음과 같이 출력
-- JADU : JA**
-- jjangu : jj****
-- Wilk : Wi**
    -- 두글자만 출력 : SUBSTR(name,1,2)
    -- 각각의 name의 길이 출력 : length(name)
SELECT rpad (SUBSTR(name,1,2), LENGTH(name), '*') FROM score;


-- 7) ** 문자열 연결 함수 **
-- 연산자 || 는 or이 아니라, 연결 연산자이다.
-- 출력 방식 : JADU 10 10 10
SELECT name || ' ' || kor || ' ' || eng || ' ' || mat FROM score;

SELECT CONCAT(name, ' ') FROM score;  -- 이름 뒤에 공백 붙이기
--select concat(name, ' ', kor) from score; -> 오류 : contact은 인수가 무조건 2개여야 한다.
SELECT CONCAT(CONCAT(name, ' '), kor) FROM score;


-- 8) 불필요한 문자열 제거 함수 (좌우만 가능하고, 중간에 포함된 건 불가능)
-- 공백 제거 위주로 본다.
SELECT LENGTH(name) FROM score;
SELECT LTRIM(name) FROM score;          --왼쪽공백을 제거
SELECT LENGTH(LTRIM(name)) FROM score;  -- 왼쪽 공백을 제거 후 글자수 세기
SELECT RTRIM(NAME) FROM score;          -- 오른쪽 공백을 제거
SELECT LENGTH(RTRIM(name)) FROM score;  -- 오른쪽 공백을 제거 후 글자수 세기
SELECT TRIM(name) FROM score;           -- 양쪽의 공백을 제거


-- 다음 데이터를 삽입한다.
-- 80, 80, 80, james bond
insert into score values (80, 80, 80, 'james bond');
-- 아래와 같이 출력한다.
-- first_name    last_name
-- james          bond
select 
    substr(name, 1, instr(name, ' ')-1) as first_name,
    substr(name, instr(name, ' ')+1) as last_name 
from 
    score;
-- instr(name, ' ')-1 : 공백의 위치를 알려주는 함수 사용. (공백 전 글자까지 출력하겠다) 


---------------------------------------------------------------------------


-- 3. 숫자 함수

-- 테이블을 사용하지 않는 SELECT문에서는 DUAL 테이블을 사용합니다.
desc dual;
select dummy from dual;  -- 어떠한 정보를 빼내오기 위해서 사용하는 것이 아니라 select문만 필요할 때 사용한다.

-- 1) 반올림 함수
-- ROUND (값, 자릿수 : 소수 자릿수 의미) 
--            자릿수 : [ 2 => 소수 자릿수 2자리로 반올림 ]
select round(123.4567 , 2) from dual;   --  123.46 (소수 자릿수 2자리로 반올림)
select round(123.4567 , 1) from dual;   --  123.5  (소수 자릿수 1자리로 반올림)
select round(123.4567 , 0) from dual;   --  123    (정수로 반올림)
select round(123.4567) from dual;       --  ** 정수로 반올림하는 것이 기본동작! (123)
select round(123.4567 , -1) from dual;  --  120    (십의 자리로 반올림)
select round(123.4567 , -2) from dual;  --  100    (백의 자리로 반올림)


-- 2) 올림 함수
-- CEIL(값) : '정수'로 올림
-- 자릿수 조정을 계산을 통해서 처리합니다.
select ceil(123.4567) from dual;  -- 124 (CEIL : 무조건 올린다.)
-- 2-1) 소수 자릿수 2자리로 올림
-- 100을 곱한다 -> CEIL() 처리한다 -> 100으로 나눈다.
select ceil(123.4567 * 100)/ 100 from dual;

-- 2-2) 소수 자릿수 1자리로 올림
-- 10을 곱한다. -> CEIL() 처리한다. -> 10으로 나눈다.
select ceil(123.4567 * 10) / 10 from dual;

-- 2-3) 십의 자리로 올림
-- 10의 -1제곱을 곱한다. -> CEIL() 처리한다. -> 10의 -1제곱으로 나눈다.
select ceil(123.4567 * 0.1) / 0.1 from dual;

-- 2-4) 백의 자리로 올림
-- 10의 -2제곱(0.01)을 곱한다. -> CEIL() 처리한다. -> 10의 -2제곱(0.01)으로 나눈다.
select ceil(123.4567 * 0.01) / 0.01 from dual;


-- 3) 내림 함수
-- FLOOR(값) : '정수'로 내림
-- CEIT()와 같은 방식으로 사용합니다.
select floor(567.8989 *100) / 100 from dual;
select floor(567.8989 *10) / 10 from dual;
select floor(567.8989) from dual;
select floor(567.8989 * 1) / 1 from dual;
select floor(567.8989 *0.1) / 0.1 from dual;
select floor(567.8989 *0.01) / 0.01 from dual;


-- 4) 절사 함수: DDL의 한 종류. (TRUNCATE)
-- TRUNC(값, 자릿수)
select trunc(567.8989, 2) from dual;   -- 소수 2자리로 자른다.
select trunc(567.8989, 1) from dual;   -- 소수 1자리로 절사
select trunc(567.8989, 0) from dual;   -- 정수로 절사
select trunc(567.8989) from dual;      -- 정수로 절사
select trunc(567.8989, -1) from dual;  -- 십의 자리로 자른다.
select trunc(567.8989, -2) from dual;  -- 백의 자리로 자른다.

-- 내림과 절사의 차이는 있다.
-- '음수'에서 차이가 발생한다. (양수에서는 차이가 없다.)
select floor(-1.5) from dual;  -- -1.5보다 작은 정수 : [-2] : (내림함수 : 작은 정수로 만든다)
select trunc(-1.5) from dual; -- -1.5의 .5를 절사 : [-1]

-- 2-5) 절대값
-- ABS(값)
select abs(-5) from dual;

-- 2-6) 부호 판별
-- SIGN (값)
-- 값이 양수이면 1
-- 값이 음수이면 -1
-- 값이 0이면 0
select sign(5) from dual;
select sign(-5) from dual;
select sign(0) from dual;

-- 2-7) 나머지
-- MOD(a, b) : 제수, 피제수 : a를 b로 나눈 나머지
select mod(7, 2) from dual;

-- 2-8) 제곱
-- POWER(a, b) : a의 b제곱
select power(10, 2) from dual;    -- 100
select power(10, 1) from dual;    -- 10
select power(10, 0) from dual;    -- 1
select power(10, -1) from dual;   -- 0.0
select power(10, -2) from dual;   -- 0.01



-- 4. 날짜 함수
-- 1) 현재 날짜 (타입이 DATE)
-- SYSDATE
select sysdate from dual;
-- 2) 현재 날짜 (타입이 TIMESTAMP)
-- SYSTIMESTAMP
select systimestamp from dual;
-- 3) 년/월/일/시/분/초 추출
-- EXTRACT
SELECT EXTRACT (YEAR FROM SYSDATE) AS 현재년도,
       EXTRACT (MONTH FROM SYSDATE) AS 현재월,
       EXTRACT (DAY FROM SYSDATE) AS 현재일,
       EXTRACT (HOUR FROM SYSTIMESTAMP) AS 현재시간,
       EXTRACT (MINUTE FROM SYSTIMESTAMP) AS 현재분,
       EXTRACT (SECOND FROM SYSTIMESTAMP) AS 현재초
  FROM DUAL;
  -- 4) 날짜 연산 (이전, 이후)
  -- 1일 : 숫자 1
  -- 12시간 : 숫자 0.5
SELECT SYSDATE + 1 AS 내일,
       SYSDATE - 1 AS 어제,
       SYSDATE + 0.5 AS 열두시간후,
       SYSTIMESTAMP + 0.5 AS 열두시간후
FROM DUAL;
-- 5) 개월 연산
-- ADD_MONTHS(날짜, N) : N개월 후
SELECT ADD_MONTHS(SYSDATE, 3) AS 삼개월후,
       ADD_MONTHS(SYSDATE, -3) AS 삼개월전
  FROM DUAL;
-- MONTHS_BETWEEN(날짜1, 날짜2) : 두 날짜 사이 경과한 개월 수
-- MINTHS_BETWEEN(최근날짜, 이전날짜)
SELECT MONTHS_BETWEEN (SYSDATE, TO_DATE('2021-01-01'))
  FROM DUAL;



-- 5. 형 변환 함수
-- 1) 날짜 변환 함수
-- TO_DATE(문자열, [형식])
--  형식
-- YYYY, YY
-- MM, M
-- DD, D
-- HH, H
-- MI
-- SS
SELECT TO_DATE ('2021-04-01'),
       TO_DATE ('2021/04/01'),
       TO_DATE ('2021/01/04', 'YYYY/DD/MM'),
       TO_DATE ('20210401', 'YYYYMMDD'),
       TO_DATE ('0401, 21', 'MMDD, YY')
  FROM DUAL;
-- 2) 숫자 변환 함수
-- TO_NUMBER(문자열)
SELECT TO_NUMBER('100') FROM DUAL;

SELECT name, kor
  FROM score
WHERE kor >= '50';  -- 내부적으로 WHERE kor >= TO_NUMBER('50') 처리됩니다.
-- 3) 문자열 변환 함수
-- TO_CHAR(값, [형식])
-- 3-1) 숫자형식 : String기반.
SELECT to_char(123),  -- 문자열 '123'
       to_char(123, '999999'),  -- 문자열 '   123'
       to_char(123, '000000'),  -- 문자열 '000123'
       to_char(1234, '9,999'),  -- 문자열 '1,234' : 천단위로 구분
       to_char(12345, '9,999'), -- ##### (자리수가 부족해서 오류! : 형식이 숫자보다 작은 경우.) **자리수를 맞춰줘야 한다.!
       to_char(12345, '99,999'), -- 문자열 '12,345'
       to_char(3.14, '9.999'),  -- 문자열 '3.140'
       to_char(3.14, '9.99'),   -- 문자열 '3.14'
       to_char(3.14, '9.9'),    -- 문자열 '3.1'
       to_char(3.14, '9'),      -- 문자열 '3'
       to_char(3.5, '9')        -- 문자열 '4' : (반올림)
  FROM dual;
-- 3-2) 날짜 형식
select to_char(sysdate, 'YYYY.mm.dd'),
       to_char(sysdate, 'year month day'),
       to_char(sysdate, 'hh:mm:ss')
  from dual;

-- 6. 기타함수

select * from score;
update score set kor=null where  trim(name) = 'JADU';  -- JADU 점수 : null 10 10
update score set eng=null where trim(name) = 'Wulik';  -- Wulik 점수 : 30 null 30

-- 1-1) NULL 처리 함수
-- NBL (값, 값이 null일 때 사용할 값)
select kor, NVL(kor, 0) from score;  -- NVL(kor, 0) => null값 대신 0을 사용한다.
-- 집계함수 (SUM, AVG, NAX, MIN, COUNT 등) 들은 NULL값을 무시합니다. : 연산 과정에 빼고 진행
SELECT AVG(kor) as 평균1,
       avg(nvl(kor, 0)) as 평균2
 FROM score;
-- 1-2) NVL2(값, 값이 null일 때, null이 아닐 때)
select nvl2(kor, kor+eng+mat, eng+mat) as 총점 from score;


-- 2) 분기 함수
-- DECODE(표현식, 조건1, 결과1, 조건2, 결과2, ..., 기본값)
-- 동등비교만 가능
SELECT DECODE( '봄',  -- 표현식(칼럼을 이용한 식)
               '봄', '꽃놀이',      -- 포현식이 '봄'이면 '꽃놀이'가 결과이다.
               '여름', '물놀이',    -- 포현식이 '여름'이면 '물놀이'가 결과이다.
               '가을', '단풍놀이',  -- 포현식이 '가을'이면 '단풍놀이'가 결과이다.
               '겨울','눈싸움'      -- 포현식이 '겨울'이면 '눈싸움'이 결과이다.
               ) as 계절별놀이
  FROM DUAL;


-- 3) 분기
-- CASE 표현식
--   WHEN 비교식 THEN 결과값  (반복 가능)
-- ...
-- ELSE 나머지 경우
-- end;

-- CASE 계절
--   WHEN '봄' THEN '꽃놀이' (가능/)

-- CASE 평균
--   WHEN >=90 THEN 'A학점'
select name,
    (NVL(kor, 0) + eng + mat) / 3 as 평균,
    (CASE 
        WHEN (NVL(kor, 0) + eng + mat) / 3 >= 90 THEN 'A학점'
        WHEN (NVL(kor, 0) + eng + mat) / 3 >= 80 THEN 'B학점'
        WHEN (NVL(kor, 0) + eng + mat) / 3 >= 70 THEN 'C학점'
        WHEN (NVL(kor, 0) + eng + mat) / 3 >= 60 THEN 'D학점'
        ELSE 'F학점'
    END) as 학점
  FROM score;
        


