-- 1. EMP 테이블에서 부서 인원이 4 명보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력하
SELECT deptno, COUNT(*), SUM(sal) FROM emp
GROUP BY deptno HAVING COUNT(*) > 4;

-- 2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력하라
SELECT deptno, COUNT(*) FROM emp
GROUP BY deptno HAVING COUNT(*) >=
ALL(select COUNT(*) from emp GROUP BY deptno);

-- 3. EMP 테이블에서 가장 많은 사원을 갖는 MGR 의 사원번호를 출력하라.

SELECT mgr as empno FROM emp
GROUP BY mgr HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM emp group BY mgr);

SELECT mgr as empno FROM emp
GROUP BY mgr HAVING COUNT(mgr) >=
ALL(SELECT COUNT(mgr) FROM emp GROUP BY mgr);


-- 4. EMP 테이블에서 부서번호가 10 인 사원수와 부서번호가 30 인 사원수를 각각 출력하라.
SELECT 
	(select COUNT(*) FROM emp WHERE deptno=10) cnt10,
	(select COUNT(*) FROM emp WHERE deptno=30) cnt20;


# 5. EMP 테이블에서 사원번호가 7521 인 사원의 직업과 같고
#사원번호가 7934 인 사원의 SAL보다 많은 사원의 사원번호, 이름, 직업, 급여를 출력하라.
SELECT empno, ename, job, sal FROM emp
WHERE job = (SELECT job FROM emp WHERE empno=7521)
AND
sal > (SELECT sal FROM emp WHERE empno=7934);


#6. 직업(JOB)별로 최소 급여를 받는 사원의 사원번호, 이름, 업무, 부서명을 출력하라.
#조건 1 : 직업별로 내림차순 정렬
SELECT empno, ename, job, dname
FROM emp INNER JOIN dept
ON emp.DEPTNO = dept.deptno
GROUP BY job HAVING MIN(sal)
ORDER BY job desc;