# ddl
# emp01 : empno, ename, sal로 이루어진 테이블

CREATE TABLE emp01(
	empno DECIMAL(4),
	ename VARCHAR(20), # 대소문자 1바이트, 한글 2바이트
	sal DECIMAL(7,2) # 7개의 숫자를 받는데 그 중 두자리는 소수점
);

# 기존 emp 테이블과 동일한 구조의 테이블을 생성할 경우(정보도 함께 복사)
CREATE TABLE emp02
AS
SELECT * FROM emp;

# 기존 emp 테이블과 동일한 구조의 테이블만 생성할 경우(구조만 복사)
CREATE TABLE emp03
AS
SELECT * FROM emp WHERE 1=0;
-- 1=0 : 모든 row에 대한 조건식을 false로 = row 생성 안됨


# empno ename만 들어있는 테이블을 생성, 데이터는 복제
CREATE TABLE emp04
AS
SELECT empno, ename FROM emp;

# 사원번호, 사원이름, 급여 컬럼으로 구성된 테이블 생성
CREATE TABLE emp05
AS
SELECT empno, ename, sal FROM emp;

# 컬럼 추가
ALTER TABLE emp01 ADD job VARCHAR(9);

# 컬럼의 길이 변경
ALTER TABLE emp01 MODIFY job VARCHAR(30);

# 컬럼 삭제
ALTER TABLE emp01 DROP COLUMN job;

# 테이블 삭제
DROP TABLE emp01;

# 테이블의 모든 row 제거
TRUNCATE TABLE emp02;

# 테이블 rename
RENAME TABLE emp02 TO test;

-- ---------------------------------------
DROP TABLE dept01;

CREATE TABLE dept01
AS
SELECT * FROM dept WHERE 0=1;

# dept01에 dept=10, dname=accounting, loc='NEW YORK'
INSERT INTO dept01(deptno, dname, loc)
VALUES(10, 'ACCOUNTING', 'NEW YORK');
-- 반드시 values와 컬럼개수와 일치해야함, 컬럼name이나 데이터타입 틀리면 에러

INSERT INTO dept01
VALUES(20, 'RESEARCH', 'DALLAS');
-- dept01테이블의 모든 컬럼에 값을 넣을 경우에는 컬럼명 생략 가능

INSERT INTO dept01(deptno, dname)
VALUES(30, 'SALES'); -- loc 넣지 않으면 디폴트로 null값 입력

INSERT INTO dept01
VALUES(40, 'OPERATIONS', NULL); -- 명시적으로 null값 입력 

-- --------------------------------------------
DROP TABLE dept02;
CREATE TABLE dept02
AS
SELECT * FROM dept WHERE 1=0;

# 다른 테이블의 데이터 통째로 가져오기
INSERT INTO dept02
SELECT * FROM dept;

INSERT INTO dept02
SELECT * FROM dept WHERE deptno = 10; -- 조건부 가져오기

# sam01 테이블 생성 : empno, ename, job, sal
CREATE TABLE sam01
AS
SELECT empno, ename, job, sal FROM emp WHERE 1=0;
-- emp의 특정 컬럼만 가져오고 row는 안가져옴

# sam01 테이블에
# 1000 apple police 10000
# 1010 banana nurse 15000
# 1020 orange doctor 25000
INSERT INTO sam01 VALUES(1000, 'apple', 'police', 10000),
(1010, 'banana', 'nurse', 15000),
(1020, 'orange', 'doctor', 25000);

-- UPDATE--------------------------------------------
-- update 테이블명 set where : 테이블에 저장된 데이터 수정
CREATE TABLE emp01
AS
SELECT * FROM emp;

#모든 테이블의 부서 번호를 30번으로 수정 
UPDATE emp01 SET deptno=30;

#모든 사원의 급여를 10% 인상
UPDATE emp01 SET sal = floor(sal*1.1);

-- ------------------------------
DROP TABLE emp01;
CREATE TABLE emp01
AS
SELECT * FROM emp;
-- ------------------------------

#부서번호가 10번인 사원의 부서번호를 30번으로 수정하세요
SELECT COUNT(*) FROM emp WHERE deptno=10; -- 먼저 색인한 후 
UPDATE emp01 SET deptno=30 WHERE deptno=10; -- 업데이트하기

# 급여가 3000 이상인 사원만 급여를 10% 인상
UPDATE emp01 SET sal = floor(sal*1.1) WHERE sal>=3000;

# scott 사원의 부서번호는 10번, 직급은 MANAGER로 변경
UPDATE emp01 SET deptno=10, job='MANAGER' WHERE ename='scott';

# scott 사원의 입사일자는 오늘로, 급여를 50으로, 커미션을 4000으로 수정
UPDATE emp01 SET hiredate=NOW(), sal=50, comm=4000 WHERE ename='scott'; 

# update 서브쿼리형(40번 부서의 지역명을 20번 부서의 지역명으로 변경)
UPDATE dept01 SET loc=(SELECT loc FROM dept01 WHERE deptno=20)
WHERE deptno = 40;

# 30번 부서의 부서명과 loc을/ 20번 부서의 부서명과 loc로 변경
UPDATE dept01 SET
dname = (SELECT dname FROM dept01 WHERE deptno=20),
loc = (SELECT loc FROM dept01 WHERE deptno=20)
WHERE deptno = 30;

UPDATE dept01 SET (dname, loc) =
(SELECT dname, loc FROM dept01 WHERE deptno=20)
WHERE deptno = 30;


-- delete--------------------------------------------
-- DELETE FROM 테이블명 WHERE 

SELECT * FROM dept01;
DELETE FROM dept01;

INSERT INTO dept01 SELECT * FROM dept;

DELETE FROM dept01 WHERE deptno=30;
-- delete는 가급적 조건 쓰지X, 기본키를 기준으로 지우는 것이 좋음

-- -----------------------------------
SELECT @@autocommit;
SET @@autocommit = 0;
-- -----------------------------------
-- 하나의 트랜잭션은 All-OR-Nothing 방식, 전부 실행되거나 전부 취소되거나

DELETE FROM dept01 WHERE deptno=40;
-- 임시로 지워짐, commit 해야 영구삭제
ROLLBACK;
-- commit하기 직전 상태로 돌아감
COMMIT;
-- 실제 데이터 변경, ROLLBACK해도 돌아가지 않음
