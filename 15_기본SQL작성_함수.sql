-- 오라클 내장 함수

DROP TABLE score;


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



