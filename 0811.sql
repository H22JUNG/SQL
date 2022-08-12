-- 스키마 정보를 알려주는 쿼리
SHOW DATABASES;

-- 스키마를 어떤걸 사용할지 결정하는 쿼리
USE scott;

#해당 스키마의 테이블을 보고싶다면
SHOW TABLES;

#해당 테이블에 대한 정보 알아보기
#컬럼=테이블에서 제공하는 속성들:필드
DESC emp;
#DESC dept;

#emp 테이블의 모든 데이터를 색인하는 쿼리
SELECT * FROM emp;
#emp 테이블의 사원번호와 사원 이름을 색인하는 쿼리
SELECT empno, ename FROM emp;
#emp 테이블의 사원 이름, 급여, 보너스를 색인하는 쿼리
SELECT ename, sal, comm FROM emp;

#emp 테이블의 sal+comm의 합계를 출력하는 쿼리
SELECT sal + comm FROM emp;
-- 좌변이나 우변 중 하나라도 null이면 연산한 값도 null이 됨
-- null = undifiend랑 비슷하다고 보면 됨
-- ⭐연산, 할당, 비교 불가능⭐

#IFNULL : 만약에 null값이 있으면 comm을 0으로 치환해라
SELECT sal+IFNULL(comm,0) FROM emp;

#emp 테이블의 sal+comm의 합계를 출력하는 쿼리 with alias name sum
-- 별칭 지정
SELECT sal+IFNULL(comm,0) as sum FROM emp;
-- as 생략 가능
SELECT sal+IFNULL(comm,0) sum FROM emp;

#alias는 한글도 가능(잘 쓰진 않음)
SELECT sal+IFNULL(comm,0) "합계" FROM emp;

#""를 alias에서 사용 시 한글 뿐만이 아니라 영문 대소문자, 특수문자, 스페이스  사용 가능
SELECT sal+IFNULL(comm,0) "A n n s a l" FROM emp;

#부서번호 중복데이터 제거하는 키워드 Distinct
SELECT distinct deptno FROM emp;
