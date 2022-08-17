-- 1. EMP 테이블에서 부서 인원이 4 명보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력하
SELECT deptno, COUNT(*), SUM(sal) FROM emp
GROUP BY deptno HAVING COUNT(*) > 4;

-- 2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력하라
SELECT deptno, COUNT(*) FROM emp
GROUP BY deptno HAVING COUNT(*) >=
ALL(select COUNT(*) from emp GROUP BY deptno);


-- 3. EMP 테이블에서 가장 많은 사원을 갖는 MGR 의 사원번호를 출력하라.

SELECT mgr as empno FROM emp
GROUP BY mgr HAVING COUNT(*) >=
ALL(SELECT COUNT(*) FROM emp group BY mgr);

SELECT mgr as empno FROM emp
GROUP BY mgr HAVING COUNT(mgr) >=
ALL(SELECT COUNT(mgr) FROM emp GROUP BY mgr);


-- 4. EMP 테이블에서 부서번호가 10 인 사원수와 부서번호가 30 인 사원수를 각각 출력하라.
SELECT
	(select COUNT(*) FROM emp WHERE deptno=10) cnt10,
	(select COUNT(*) FROM emp WHERE deptno=30) cnt20;
	
select 
count(case deptno when 10 then 1 else null end) CNT10, 
count(case deptno when 30 then 1 else null end) CNT30 
from emp;

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
where sal = ANY(select min(sal) FROM emp group by job)
ORDER BY job DESC;

SELECT e.empno, e.ename, e.job, d.dname
from emp e INNER join dept d
on e.deptno = d.deptno
and sal IN(select min(sal) from emp group by job)
order by job DESC;
# sal이 겹쳐서 2개씩 뜨는거


-- 7. 각 사원 별 시급을 계산하여 부서번호, 사원이름, 시급을 출력하라.
-- 조건 1. 한달 근무일수는 20 일, 하루 근무시간은 8 시간이다.
-- 조건 2. 시급은 소수 두 번째 자리에서 반올림한다.
-- 조건 3. 부서별로 오름차순 정렬
-- 조건 4. 시급이 많은 순으로 출력
SELECT deptno, ename, ROUND(sal/20/8, 1) '시급' FROM emp
-- GROUP BY deptno, ename
ORDER BY deptno, ROUND(sal/20/8, 1) DESC;


-- 8. 각 사원 별 커미션이 0 또는 NULL 이고 부서위치가 ‘GO’로 끝나는
-- 사원의 정보를 사원번호, 사원이름, 커미션, 부서번호, 부서명, 부서위치를 출력하라.
-- 조건 1. 보너스가 NULL 이면 0 으로 출력
SELECT empno, ename, ifnull(comm, 0) comm, emp.deptno, dname, loc
from emp INNER JOIN dept
ON emp.DEPTNO = dept.DEPTNO
WHERE 
comm=0 or comm is null AND loc LIKE '%GO';

-- 9. 각 부서 별 평균 급여가 2000 이상이면 초과, 그렇지 않으면 미만을 출력하라.
SELECT deptno, if(avg(sal)>=2000, '초과', '미만') 평균급여
FROM emp GROUP BY deptno;

-- 10. 각 부서 별 입사일이 가장 오래된 사원을 한 명씩 선별해
-- 사원번호, 사원명, 부서번호, 입사일을 출력
SELECT empno, ename, e.deptno, hiredate FROM
emp e inner JOIN dept d
ON e.DEPTNO = d.deptno
GROUP BY e.deptno
HAVING MIN(hiredate);



# 11. 1980 년~1980 년 사이에 입사된 각 부서별 사원수를
# 부서번호, 부서명, 입사 1980, 입사 1981, 입사 1982 로 출력하라.
SELECT d.deptno, dname,
COUNT(case DATE_FORMAT(e.hiredate, '%Y') when '1980' then '1980' ELSE NULL END) '입사 1980',
count(case DATE_FORMAT(e.hiredate, '%Y') when '1981' then '1981' ELSE NULL end) '입사 1981',
count(case when DATE_FORMAT(e.hiredate, '%Y')='1982' then '1982' ELSE NULL END) '입사 1982'
FROM dept d INNER JOIN emp e
ON d.deptno = e.deptno
GROUP BY deptno, dname;

# 12. 1981 년 5 월 31 일 이후 입사자 중 커미션이 NULL 이거나 0 인 사원의 커미션은 500 으로
# 그렇지 않으면 기존 커미션을 출력하라.
SELECT ename, (case when comm IS NULL OR comm=0 then 500 ELSE comm END) comm FROM emp
WHERE hiredate > '1981/05/31';

select ename, case when comm is NULL then '500' when comm = 0 then '500' else cast(comm as varchar(5)) 
end as COMM 
from emp 
where hiredate> cast('1981-05-31' as date);

-- 13. 1981 년 6 월 1 일 ~ 1981 년 12 월 31 일 입사자 중 부서명이 SALES 인 사원의
-- 부서번호, 사원명, 직업, 입사일을 출력하라.
-- 조건 1. 입사일 오름차순 정렬
SELECT e.deptno, dname, ename, job, DATE_FORMAT(hiredate, '%Y-%m-%d') hiredate
FROM emp e inner JOIN dept d
ON e.DEPTNO = d.deptno
WHERE (hiredate BETWEEN '1981/06/01' AND '1981/12/31') AND dname='sales'
ORDER BY hiredate asc;

select e.deptno, d.dname, e.ename, e.job, e.hiredate
from emp e INNER join dept d 
ON e.deptno = d.deptno 
and e.hiredate>=cast('1981-06-01' as date) 
and e.hiredate<=cast('1981-12-31' as date) 
and d.dname = 'SALES' 
order by hiredate ASC;

-- 14. 현재 시간과 현재 시간으로부터 한 시간 후의 시간을 출력하라.
-- 조건 1. 현재시간 포맷은 ‘4 자리년-2 자일월-2 자리일 24 시:2 자리분:2 자리초’로 출력
-- 조건 1. 한시간후 포맷은 ‘4 자리년-2 자일월-2 자리일 24 시:2 자리분:2 자리초’로 출력
SELECT NOW() 현재시간, ADDTIME(NOW(), '1:0:0') 한시간후;


-- 15. 각 부서별 사원수를 출력하라.
-- 조건 1. 부서별 사원수가 없더라도 부서번호, 부서명은 출력
-- 조건 2. 부서별 사원수가 0 인 경우 ‘없음’ 출력
-- 조건 3. 부서번호 오름차순 정렬
SELECT d.deptno, dname, if(COUNT(ename)=0, '없음', COUNT(ename)) 사원수
from emp e RIGHT outer join dept d 
ON e.deptno = d.deptno
GROUP BY deptno, dname
order BY deptno;

SELECT d.deptno, dname,
case when COUNT(ename)=0 then '없음' else COUNT(ename) END  사원수
from emp e RIGHT outer join dept d 
ON e.deptno = d.deptno
GROUP BY deptno, dname
order BY deptno;

-- 16. 사원 테이블에서 각 사원의 사원번호, 사원명, 매니저번호, 매니저명을 출력하라.
-- 조건 1. 각 사원의 급여(SAL)는 매니저 급여보다 많거나 같다.
SELECT e1.empno 사원번호, e1.ename 사원명, e1.mgr 매니저사원번호, e2.ename 매니저명
FROM emp e1 INNER JOIN emp e2
ON e1.mgr = e2.empno
WHERE e1.sal >= e2.sal;


# 18. 사원명의 첫 글자가 ‘A’이고, 처음과 끝 사이에 ‘LL’이 들어가는 사원의 커미션이 COMM2 일때,
# 모든 사원의 커미션에 COMM2 를 더한 결과를 사원명, COMM, COMM2, COMM+COMM2 로 출력하라.
SELECT ifnull(comm, 0) 'COMM',
(SELECT comm FROM emp WHERE ename LIKE 'A%LL%') 'COMM2',
ifnull(comm, 0) + (SELECT comm FROM emp WHERE ename LIKE 'A%LL%') 'COMM + COMM2'
FROM emp
order by COMM + COMM2;


-- 19. 각 부서별로 1981 년 5 월 31 일 이후 입사자의 부서번호, 부서명, 사원번호, 사원명, 입사일을 출력하시오.
-- 조건 1. 부서별 사원정보가 없더라도 부서번호, 부서명은 출력
-- 조건 2. 부서번호 오름차순 정렬
-- 조건 3. 입사일 오름차순 정렬

SELECT d.deptno, dname, empno, ename, hiredate
from emp e RIGHT outer join dept d 
using(deptno)
where e.hiredate > '1981/05/31' OR hiredate IS NULL
ORDER BY d.deptno, hiredate;

select d.deptno, d.dname, e.empno, e.ename, e.hiredate 
from emp e RIGHT OUTER JOIN dept d 
ON e.deptno = d.deptno 
and DATE_FORMAT(e.hiredate, '%Y-%m-%d')> cast('19810531' as date) 
order by d.deptno, e.hiredate;

-- 20. 입사일로부터 지금까지 근무년수가 40 년 미만인 사원의 사원번호, 사원명, 입사일, 근무년수를 출력하라.
-- 조건 1. 근무년수는 월을 기준으로 버림 (예:30.4 년 = 30 년, 30.7 년=30 년)
SELECT empno, ename, hiredate, FLOOR((DATEDIFF(NOW(), hiredate))/365) "근무년수"
FROM emp
WHERE FLOOR((DATEDIFF(NOW(), hiredate))/365) < 40;

