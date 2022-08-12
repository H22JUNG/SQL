-- 1. 부서테이블의 모든 데이터를 출력하라.
SELECT * FROM dept;

-- 2. EMP 테이블에서 각 사원의 직업, 사원번호, 이름, 입사일을 출력하라.
SELECT job, empno, ename, HIREDATE FROM emp;

-- 3.EMP테이블에서 직업을 출력하되, 각 항목이 중복되지 않게 출력하라.
SELECT distinct job FROM emp;

-- 4. 급여가 2850이상인 사원의 이름 및 급여를 출력하라.
SELECT ename, sal FROM emp
WHERE sal >= 2850;

-- 5. 사원번호가 7566인 사원의 이름 및 부서번호를 출력하라.
SELECT ename, empno FROM emp
WHERE empno = 7566;

-- 6. 급여가 1500이상 2850이하 범위에 속하지 않는 모든 사원의 
-- 이름 및 급여를 출력하라.
SELECT ename, sal FROM emp
WHERE not sal >= 1500 AND sal <= 2850;

-- 7. 1981년 2월20일 ~ 1981년 5월1일에 입사한 사원의 이름,직업 및 입사일을
-- 출력하라. 입사일 기준으로 오름차순으로 정렬하다.
SELECT ename, job, HIREDATE FROM emp
WHERE HIREDATE BETWEEN '1981-02-20' and '1981-05-01';


-- 8. 10번 및 30번 부서에 속하는 모든 사원의 이름과 부서 번호를 출력하되, 이름을ALTER
-- 알파벳순으로 정렬하여 출력하라.
SELECT ename AS 'ALTER', deptno FROM emp
WHERE deptno=10 OR deptno=30
ORDER BY ename ASC;

-- 9. 10번 및 30번 부서에 속하는 모든 사원 중 급여가 1500을 넘는 사원의 이름
-- 및 급여를 출력할라. 단 컬럼명을 각각 EMPLOYEE 및 MONTHLY SALARY로 지정하라.
SELECT ename AS 'EMPLOYEE', sal AS 'MONTHLY SALARY' FROM emp
WHERE sal >= 1500 AND deptno IN(10, 30);


-- 10. 관리자가 없는 모든 사원의 이름 및 직위를 출력하라.
SELECT ename, job FROM emp
WHERE mgr IS NULL;

-- 11. 커미션을 받는 모든 사원의 이름, 급여 및 커미션을 출력하되, 급여를 기준으로
-- 내림차순으로 정렬하여 출력하라.
SELECT ename, sal, comm FROM emp
ORDER BY sal DESC;


-- 12. 이름의 세 번째 문자가 A인 모든 사원의 이름을 출력하라.
SELECT ename FROM emp
WHERE ename LIKE '__A%';

-- 13. 이름에 L이 두 번 들어가며 부서 30에 속해있는 사원의 이름을 출력하라.
SELECT ename FROM emp
WHERE ename LIKE '%L%L%' AND deptno=30;

-- 14. 직업이 Cleck 또는 Analyst이면서 급여가 1000, 3000, 5000 이 아닌
-- 모든 사원의 이름, 직업 및 급여를 출력하라.
SELECT ename, job, sal FROM emp
WHERE job='Clerk' or job='Analyst' AND sal NOT IN(1000,3000,5000);

-- 15. 사원번호, 이름, 급여 그리고 15% 인상된 급여를 정수로 표시하되
-- 컬럼명을 New Salary로 지정하여 출력하여라.
SELECT empno, ename, sal, FLOOR(sal*1.15) AS 'New Salary' FROM emp;


-- 16. 15번 문제와 동일한 데이터에서 급여 인상분(새 급여에서 이전 급여를 뺀 값)을
-- 추가해서 출력하라. 컬럼명은 Increase로 하라.
SELECT empno, ename, sal, FLOOR(sal*1.15) AS 'New Salary'
, FLOOR((sal*1.15)-sal) 'Increase' FROM emp;

-- 17. 모든 사원의 이름 길이를 표시하는 쿼리를 작성하고
-- 컬럼 별칭은 적당히 넣어서 출력하라.
SELECT ename, CHAR_LENGTH(ename) 'name_length' FROM emp;

-- 18. 사원 이름과 커미션을 출력하되, 커미션이 책정되지 않은 사원의 
-- 커미션은 'no commission'으로 출력하라.
SELECT ename,
	if(comm is null or comm = 0, 'no commission', comm) AS 'comm' FROM emp;