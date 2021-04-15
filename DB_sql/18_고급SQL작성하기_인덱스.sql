select * from employee;

-- 인덱스
-- 1. 빠른 검색을 위해서 특정 칼럼에 설정하는 색인
-- 2. 검색 속도를 높이지만, 삽입/갱신/삭제 시 인덱스의 갱신때문에 성능이 떨어진다.
-- 3. 기본키(PK)와 UNIQUE 칼럼은 자동으로 인덱스가 설정된다.
-- 4. WHERE절에서 자주 사용되는 칼럼은 인덱스로 설정하는 것이 좋다.

-- 고유 인덱스
-- department테이블의 depat_name칼럼에 고유인덱스 idx_depatname을 설정한다.

create unique index idx_dept_name ON department(dept_name);

-- 비고유인덱스 생성 (인덱스 부착 칼럼에 중복을 허용)
-- employee테이블의 name칼럼에 비고유인 idx_name을 설정한다.
create index idx_name on employee(name);


-- 인덱스 조회
-- 사용자가 작성한 인덱스 목록 : user_indexs
desc user_indexes;

select index_name, uniqueness
  from user_indexes
 where table_name = 'DEPARTMENT';



select index_name, uniqueness
  from user_indexes
 where table_name = 'EMPLOYEE';




-- 인덱스 삭제 
drop index idx_name;
drop index idx_dept_name;