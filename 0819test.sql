drop database if exists mydb;

create DATABASE mydb;

use mydb;
CREATE TABLE DEPT(
	deptno INT NOT NULL PRIMARY KEY,
	dname VARCHAR(14),
	loc VARCHAR(13) NOT null
);

INSERT INTO dept VALUES(10, '경리부', '서울'),
(20, '인사부', '인천'),(30, '영업부', '용인'),
(40, '전산부', '수원');

CREATE TABLE emp(
	empno INT NOT NULL PRIMARY KEY,
	ename VARCHAR(20) NOT NULL,
	job VARCHAR(8) NOT NULL,
	mgr VARCHAR(10),
	hiredate DATE NOT null,
	sal INT NOT null,
	comm INT,
	deptno INT NOT NULL,
	CONSTRAINT emp_deptno_fk FOREIGN KEY(deptno) REFERENCES dept(deptno)
);

INSERT INTO emp VALUES
(1001, '김사랑', '사원', 1013, '2007-03-01', 300, NULL, 20),
(1002, '한예슬', '대리', 1005, '2008-10-01', 250,  80, 30), 
(1003, '오지호', '과장', 1005,'2005-02-10', 500,  100, 30),
(1004, '이병헌', '부장', 1008, '2003-09-02', 600, NULL, 20),
(1005, '신동협', '과장', 1005, '2010-02-09', 450,  200, 30),
(1006, '장동건', '부장', 1008, '2003-10-09', 480, NULL, 30),
(1007, '이문세', '부장', 1008, '2004-01-08', 520, NULL, 10),
(1008, '감우성', '차장', 1003, '2004-03-08', 500,  0, 30),
(1009, '안성기', '사장', NULL, '1996-10-04', 1000, NULL, 20),
(1010, '이병헌', '과장', 1003, '2005-04-07', 500, NULL, 10),
(1011, '조향기', '사원', 1007, '2007-03-01', 280, NULL, 30),  
(1012, '강혜정', '사원', 1006, '2007-08-09', 300, NULL, 20),
(1013, '박중훈', '부장', 1003, '2002-10-09', 560, NULL, 20),
(1014, '조인성', '사원', 1006, '2007-11-09', 250, NULL, 10);

CREATE table salgrader(
	grade INT PRIMARY KEY AUTO_INCREMENT,
	losal INT,
	hisal INT
);

INSERT INTO salgrader VALUES(null, 700, 1200),      
(null, 1200, 1400),
(null, 1700, 2000),
(null, 2000, 3000),
(null, 3000, 9999);

-- 문제1
-- dept테이블을 이용하여 사원의 이름과 급여와 입사일자, 부서명을 출력하시오.
SELECT ename, e.sal, e.hiredate, d.dname
FROM emp e INNER JOIN dept d
ON d.deptno = e.deptno;
 

-- 문제2
-- dept테이블의 컬럼 중 deptno를 “부서번호”,  dname을 “부서명”으로 출력하는 SQL문을 작성하시오.
SELECT deptno 부서번호, dname 부서명 FROM dept;


-- 문제3
-- emp테이블의 직책이 중복되지 않고 한 번씩 나열하는 SQL문 작성하시오.
SELECT job FROM emp
GROUP BY job;
 

-- 문제4
-- emp테이블을 이용하여 급여가 300 이하인 사원의 사원번호, 사원 이름, 급여를 출력하시오.
SELECT empno, ename, sal FROM emp
WHERE sal <= 300;


-- 문제5
-- emp테이블을 이용하여 이름이 '오지호'인 사원의 사원번호, 사원명, 급여를 출력하세요
SELECT empno, ename, sal FROM emp
WHERE ename='오지호';


-- 문제6
-- 급여가 250이거나 300이거나 500인 사원들의 사원 번호와 사원명과 급여를 출력하세요.
-- 단, 2가지 방법으로 다 표현하세요. in()이용과 관계연산자를 이용하는 방법으로 하세요
SELECT empno, ename, sal FROM emp
WHERE sal IN(250, 300, 500);
 
SELECT empno, ename, sal FROM emp
WHERE sal=250 OR sal=300 or sal=500;
 
 
-- 문제7
-- 급여가 250, 300, 500이 아닌 사원들을 출력하세요
-- 단, 2가지 방법으로 다 표현하세요. not in()이용과 관계연산자를 이용하는 방법으로 하세요
SELECT empno, ename, sal FROM emp
WHERE sal not IN(250, 300, 500);
 
SELECT empno, ename, sal FROM emp
WHERE sal!=250 AND sal!=300 and sal!=500;

-- 문제8
-- 사원들 중에서 이름이 '김'으로 시작하는 사람이거나 이름 중에 '기'를 포함하는 사원의 사원번호와 사원이름을 출력하세요
SELECT empno, ename FROM emp
WHERE ename LIKE '%기%' OR ename like '김%';


-- 문제9
-- 상관이 없는 사원(사장이 되겠지요!)을 출력하세요.
SELECT * FROM emp
WHERE mgr IS NULL;
 

-- 문제10
-- emp테이블에서 급여가 500이 초과되는 사원의 모든 정보를 출력하는 쿼리문을 작성하시오.
SELECT * FROM emp WHERE sal>500;

-- 문제11
-- emp를 이용하여 서브쿼리를 이용해서 ‘이문세’와 동일한 직급을 가진 사원을 출력하는
-- SQL문을 완성하시오.
SELECT * FROM emp
WHERE job = (SELECT job FROM emp WHERE ename='이문세'); 


-- 문제12
-- 서브쿼리를 이용하여 ‘이문세’의 급여와 동일하거나 더 많이 받는 사원명과 급여를
-- 출력하는 SQL문을 작성하시오.
SELECT ename, sal FROM emp
WHERE sal >=  (SELECT sal FROM emp WHERE ename='이문세'); 
 

-- 문제13
-- 서브쿼리를 이용하여 ‘인천’에서 근무하는 사원의 이름, 부서 번호를 출력하는 SQL문을 작성하시오.
SELECT ename, deptno FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE loc='인천');


-- 문제14
-- 급여가 500을 초과하는 사원과 같은 부서에 근무하는 사원의 이름, 월급, 부서번호를 출력하시오
-- (서브쿼리에 중복된 값이 나올 수 있으니 distinct 를 이용하자)
SELECT distinct ename, sal, deptno FROM emp
WHERE deptno = any(SELECT distinct deptno from emp where sal > 500);


-- 문제15
-- 서브쿼리를 이용하여 30번 부서의 최대급여보다 많은 급여를 받는 사원의 이름과 월급을 출력하시오
SELECT ename, sal FROM emp
WHERE sal > ALL(SELECT sal FROM emp WHERE deptno=30); 


-- 문제16
-- 30번 부서의 최소급여보다 많은 급여를 받는 사원의 이름과 월급을 출력하시오
SELECT ename, sal FROM emp
WHERE sal > ANY(SELECT sal FROM emp WHERE deptno=30);


-- 문제17
-- emp테이블을 이용하여 급여 최고액, 최저액, 총액 및 평균 급여 출력하시오.
-- 반드시 alias를 통해 '급여 최고액', '최저액', '급여 총액', '평균 급여'가
-- 컬럼으로 나와야 합니다.
SELECT MAX(sal) '급여 최고액', MIN(sal) '최저액', sum(sal) '급여 총액', AVG(sal) '평균 급여'
FROM emp;
 

-- 문제18
-- emp테이블에서 부서 유형별로 급여 최고액, 최저액, 총액 및 평균 급여 출력하시오.
SELECT MAX(sal) '급여 최고액', MIN(sal) '최저액', sum(sal) '급여 총액', AVG(sal) '평균 급여'
FROM emp
GROUP BY deptno;


-- 문제19
-- emp테이블에서 직급별 명수 출력하세요.
SELECT job, COUNT(*) FROM emp
GROUP BY job;
 

-- 문제20
-- emp테이블에서 과장의 수 출력하세요.
SELECT job, COUNT(*) FROM emp
WHERE job = '과장';


-- 문제21
-- emp테이블에서 급여 최고액, 급여 최저액의 차액 출력하세요
SELECT MAX(sal)-MIN(sal) 차액 FROM emp;

-- 문제22
-- emp테이블에서 직급별 사원의 최저 급여를 내림차순 출력하세요.
SELECT job, MIN(sal) FROM emp
GROUP BY job
ORDER BY MIN(sal) DESC;
 

-- 문제23
-- emp테이블에서 부서별 사원수, 평균 급여를 부서별로 오름차순 출력하세요
SELECT deptno, COUNT(*), AVG(sal) FROM emp
GROUP BY deptno
ORDER BY deptno;


-- 문제24
-- emp테이블에서 소속 부서별 최대급여와 최소급여 구하여 출력하시오
-- 반드시 alias를 통해 '최대급여'와 '최소급여'가 컬럼으로 나와야 합니다.
SELECT deptno, MAX(sal) 최대급여, MIN(sal) 최소급여 FROM emp
GROUP BY deptno;
 

-- 문제25
-- emp테이블에서 부서별 사원수와 부서별 커미션(comm)을 받는 사원들의 수를 출력하시오.
SELECT deptno, COUNT(*) 사원수, COUNT(comm) '커미션 받는 사원' FROM emp
GROUP BY deptno;


-- 문제26
-- emp테이블에서 부서별 평균 급여가 500이상인 부서의 번호와 평균급여를 구하여 출력하시오.
SELECT deptno, AVG(sal) FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 500;
 
 
-- 문제27
-- emp테이블에서 부서별 최대급여가 500을 초과하는 부서에서 최대급여와 최소급여를 출력하시오.
-- 반드시 alias를 통해 '최대급여'와 '최소급여'가 컬럼으로 나와야 합니다.
SELECT deptno, MAX(sal) 최대급여, MIN(sal) 최소급여 FROM emp
GROUP BY deptno
HAVING MAX(sal) > 500;


-- 문제28
-- emp테이블에서 부서별 급여총액을 중간합계로 출력하고 사원전체에 대한 총합계를 출력하시오
SELECT ifnull(deptno, '사원 전체 급여 합계') 부서, SUM(sal) FROM emp
GROUP BY deptno, job WITH ROLLUP;


-- 문제29
-- emp테이블에서 부서별 급여 총액을 구하되 부서 내 다시 직급별로 급여총액을 구하여 출력하시오
SELECT ifnull(deptno, 'TOTLA') 부서, ifnull(job, '부서별 급여총액') 직급, SUM(sal) '직급별 급여총액' FROM emp
GROUP BY deptno, job WITH ROLLUP; 


-- 문제 30
-- 경리부 부서 소속사원의 이름과 입사일을 출력하시오.(emp, dept테이블 활용.)
SELECT ename, hiredate
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE dname = '경리부';


-- 문제 31
-- 직급이 과장인 사원의 이름, 부서명을 출력하시오.
SELECT ename, dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE job = '과장';
 


-- 문제 32
-- 사원이름과 부서이름을 출력하세요.                  
SELECT ename, dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno;
 

-- 문제 33
-- 인천에서 근무하는 사원의 이름과 급여를 출력하시오
SELECT ename, sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE loc = '인천';


-- 문제 34
-- emp이용하여 모든 사원의 매니저가 누구인지 다 출력하세요(셀프조인)
-- 반드시 alias를 통해 '사원명'와 '매니저'가 컬럼으로 나와야 합니다.
SELECT e1.ename 사원명, e2.ename 매니저
FROM emp e1 INNER JOIN emp e2
ON e1.mgr = e2.empno;
 

-- 문제 35
-- 이문세의 부서명을 조회하여 출력하시요.
-- 반드시 alias를 통해 '사원명'와 '부서명'이 컬럼으로 나와야 합니다.
SELECT ename 사원명, dname 부서명
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE ename='이문세';
 

-- 문제 36
-- 부서명, 지역명, 사원수, 부서 내의 모든 사원의 평균 급여를 출력하시오(emp, dept테이블 이용)
-- 반드시 alias를 통해 '부서명', '지역명', '사원수', '부서'가 컬럼으로 나와야 합니다.
SELECT dname 부서명, loc 지역명, COUNT(*) 사원수, AVG(sal) 부서
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
GROUP BY d.deptno;
 
-- 문제 37
-- case문을 이용하여 emp테이블에서 직급에 따라 직급이 '부장'인 사원은 5%, '과장'인                  
-- 사원은 10%, '대리'인 사원은 15%, '사원'인 사원은 20% 급여를                  
-- 인상하는 SQL문을 작성하시오.                
-- (단, 컬럼은 empno, ename, job, sal을 같이 출력한다.)
SELECT empno, ename, job,
case when job='부장' then sal*1.05
	  when job='과장' then sal*1.1
	  when job='대리' then sal*1.15
	  when job='사원' then sal*1.2
	  END AS sal
FROM emp;
