#그룹 함수
#emp 테이블의 모든 사원의 sal의 총합을 구하세요
SELECT SUM(sal) FROM emp;
-- 테이블에 null값이 있으면 제외하고 계산

# 평균값
SELECT AVG(sal) FROM emp;
-- TRUNCATE이나 floor, round 등으로 소수점 아래 버리기

# 최대값, 최소값
SELECT MAX(sal), MIN(sal) FROM emp;

# 각 부서별 최고 연봉 출력
SELECT deptno, MAX(sal) FROM emp;
-- 모든 테이블 중 가장 많은 급여를 받는 사람만 뜸, 오답
SELECT deptno, MAX(sal) FROM emp
GROUP BY deptno;
-- GROUP BY : deptno를 기준으로 묶어서 최고 연봉 출력
-- group by로 어떤걸 기준으로 출력할 때, 그게 select에도 포함되면 좋음
-- ex) deptno를 기준으로 출력할 때 select에도 deptno넣기

# 부서별 직책마다 가장 높은 연봉 출력
SELECT deptno, job, MAX(sal) FROM emp
GROUP BY deptno, job;
-- 복수 기준 적용

# 가장 최근에 입사한 사원의 입사일, 가장 오래된 사원의 입사일
SELECT MAX(hiredate), MIN(hiredate) FROM emp;

# row 개수(몇 줄)
SELECT COUNT(*) FROM emp;
SELECT COUNT(comm) FROM emp; -- null값은 count에서 제외됨

#해당 컬럼에 있는 내용 가지수
SELECT COUNT(DISTINCT job) '업무수' FROM emp; -- 직업의 종류가 몇 개인지

#  부서별 전체 사원 수와 커미션을 받는 사원의 수
SELECT deptno, COUNT(*), COUNT(comm) FROM emp
GROUP BY deptno;

# 조건이 그룹함수가 아닐 경우 where절, 그룹함수가 조건으로 쓰일 때 having 사용
-- select from group by having

# 평균 급여가 2000이상인 부서 출력
SELECT deptno, AVG(sal) FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;

# 부서별 연봉 최대값, 최소값을 구하되 최대 급여가 2900이상인 부서만 출력
SELECT deptno, MAX(sal), MIN(sal) FROM emp
GROUP BY deptno
HAVING MAX(sal) >=2900;

# 각 부서별 직책마다 sal의 총 합을 구하는데 중간 집계를 나타내라
SELECT deptno, job, sum(sal) FROM emp
GROUP BY deptno, job WITH ROLLUP;
-- null값 : 해당 부서별 합계, 맨 밑에는 모든 row의 총 sum값
-- WITH ROLLUP : 중간집계함수

SELECT IFNULL(deptno, 'total'), IFNULL(job, 'total job'), sum(sal) FROM emp
GROUP BY deptno, job WITH ROLLUP;

-- -----------------------------------------------------------------
# JOIN : 각각의 테이블 중 연관된 컬럼을 통해 맵핑하는 것

# empno, ename, dname 출력
SELECT empno, ename, dname
FROM emp INNER JOIN dept #두 테이블 엮기, 동등한 조건 지닐 때 INNER JOIN
-- 두개의 테이블 사이에 join이 발생
ON emp.DEPTNO = dept.deptno; #공통되는 컬럼으로 엮기

# CROSS JOIN
SELECT COUNT(*) FROM emp;
SELECT COUNT(*) FROM dept;

SELECT *
FROM emp CROSS JOIN dept;
-- 그냥 붙이기, 새로운 테이블 생성, 딱히 안씀

# 모든 사원의 사원번호와 이름과 업무지역을 출력
SELECT empno, ename, loc
FROM emp INNER JOIN dept
ON emp.DEPTNO = dept.deptno;

# 사원 이름이 smith인 사원의 사원번호, 사원명, 부서번호, 부서이름을 출력
SELECT empno, ename, dept.deptno, dname
FROM emp INNER JOIN dept
ON emp.DEPTNO = dept.deptno
WHERE ename LIKE '%SMITH%';
-- 불분명한 컬럼이 있을 때 어느 테이블인지 명시할 것 = emp.deptno
-- where 대신 having 써도 되지만 성능저하
# 테이블 이름 간결하게 치환
SELECT empno, ename, d.deptno, dname
FROM emp e INNER JOIN dept d
ON e.DEPTNO = d.deptno
WHERE ename LIKE '%SMITH%';

#뉴욕에서 근무하는 사원의 이름과 급여 출력
SELECT loc, ename, sal
FROM emp INNER JOIN dept
ON emp.DEPTNO = dept.deptno
WHERE loc = 'NEW YORK';

# ACCOUNTING 부서 소속 사원의 이름과 입사일 출력
SELECT dname, ename, HIREDATE
FROM emp INNER JOIN dept
ON emp.DEPTNO = dept.deptno
WHERE dname = 'ACCOUNTING';

# 직급이 manager인 사원의 이름, 부서명 출력
SELECT job, ename, dname
FROM emp INNER JOIN dept
ON emp.DEPTNO = dept.deptno
WHERE job = 'manager';

#non-equi join
# 각 사원의 사원번호, 이름, sal, sal 등급 출력
SELECT empno, ename, sal, grade
FROM emp e INNER JOIN salgrade s
# ON e.SAL >= s.losal AND e.sal <= s.HISAL;
ON e.sal BETWEEN losal AND hisal;


#self join
# 각 사원의 매니저
SELECT e1.ename, e2.ename
FROM emp e1 INNER JOIN emp e2
ON e1.MGR = e2.EMPNO;

#Outer join : 맵핑당하는 테이블의 내용이 null이어도 최소한 한번은 출력됨
SELECT e1.ename, e2.ename
FROM emp e1 LEFT OUTER JOIN emp e2
ON e1.MGR = e2.EMPNO;
-- null값도 출력


#table 생성
CREATE TABLE dept01(
	deptno INT(2),
	dname VARCHAR(14)
);
INSERT INTO dept01 VALUES(10, 'ACCOUNGTING');
INSERT INTO dept01 VALUES(20, 'RESEARCH');

CREATE TABLE dept02(
	deptno INT(2),
	dname VARCHAR(14)
);
INSERT INTO dept02 VALUES(10, 'ACCOUNGTING');
INSERT INTO dept02 VALUES(30, 'SALES');

SELECT * FROM dept01;
SELECT * FROM dept02;

SELECT *
FROM dept01 RIGHT OUTER JOIN dept02
ON dept01.deptno = dept02.deptno;
-- RIGHT, left 기준으로 기본테이블 정해짐

SELECT *
FROM dept01 LEFT OUTER JOIN dept02
USING(deptno);
-- using : on의 컬럼이 동일할 때 사용, 중복 제거

SELECT *
FROM dept01 LEFT OUTER JOIN dept02
USING(deptno)
UNION
SELECT *
FROM dept01 RIGHT OUTER JOIN dept02
USING(deptno);
-- union : 2개의 연속된 쿼리를 하나로 사용, 중복 제거

SELECT *
FROM dept01 LEFT OUTER JOIN dept02
USING(deptno)
UNION All
SELECT *
FROM dept01 RIGHT OUTER JOIN dept02
USING(deptno);
-- union all : 중복된 열까지 전부 출력, 속도저하
-- 유니온은 컬럼이 동일한 이름으로 존재해야 사용 가능


# 서브쿼리
SELECT *
FROM dept
INNER JOIN (SELECT deptno, COUNT(*) cnt FROM emp GROUP BY deptno) i
ON dept.DEPTNO = i.deptno;

# smith와 같은 부서에서 근무하는 사원의 이름과 부서번호 출력
SELECT ename, deptno
FROM emp
WHERE deptno = (SELECT deptno	FROM EMP WHERE ename='SMITH');

#평균 급여보다 많이 받는 사원의 이름과 sal 출력
SELECT ename, sal FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);
-- 서브쿼리에 그룹함수도 사용 가능

# 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는
# 사원의 이름, 급여, 부서번호를 출력
SELECT ename, sal, deptno FROM emp
WHERE deptno IN(SELECT DISTINCT deptno FROM emp WHERE sal>=3000);
-- in : 메인쿼리의 조건과 서브쿼리의 조건이 하나라도 일치하면 참
-- (소속된, 000을 포함한~)


# 30번 소속 사원들 중에서 급여를 가장 많이 받는 사원보다 더 많은
# 급여를 받는 사람의 이름, 급여 출력

SELECT ename, sal FROM emp
WHERE sal > (SELECT max(sal) FROM emp WHERE deptno=30);

SELECT ename, sal FROM emp
WHERE sal > ALL(SELECT sal FROM emp WHERE deptno = 30);
-- all : 둘다 만족
-- (~면서 ~인, ~중에서)

# 30번 소속 사원들 중에서 급여를 가장 적게 받는 사원보다 더 많은
# 급여를 받는 사람의 이름, 급여 출력
SELECT ename, sal FROM emp
WHERE sal > ANY(SELECT sal FROM emp WHERE deptno = 30);
-- any : 그 중 하나이상이 일치하면 참


# 부서별로 가장 급여를 많이 받는 사원의 정보
SELECT empno, ename, sal, deptno FROM emp
WHERE sal IN(SELECT MAX(sal) FROM emp GROUP BY deptno);

SELECT empno, ename, sal, deptno FROM emp
WHERE sal > any(SELECT MAX(sal) FROM emp GROUP BY deptno);

# 직급(job)이 manager인 사람이 속한 부서의 부서번호, 부서명, 지역 출력
SELECT deptno, dname, loc FROM dept
WHERE deptno IN(SELECT DISTINCT deptno from emp where job = 'manager');

SELECT deptno, dname, loc FROM dept
WHERE deptno = any(SELECT DISTINCT deptno from emp where job = 'manager');
