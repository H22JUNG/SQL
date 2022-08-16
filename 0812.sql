-- 0812

SELECT * FROM emp;

# where 컬럼 + 연산자 + 비교대상값
#sal 3000 이상인 사원들에 대한 row들을 출력
SELECT * FROM emp WHERE sal >= 3000;

#deptno가 10인 사원들의 정보를 출력
SELECT * FROM emp WHERE deptno = 10;

#sal이 1500이하인 사원의 사원번호, 사원이름, 급여만 출력
SELECT ename, empno, sal FROM emp where sal <= 1500;

#이름이 FORD인 사원의 정보를 출력
SELECT * FROM emp WHERE ename = 'FORD';

#1982/1/1 이후에 입사한 사원을 출력
SELECT * FROM emp WHERE HIREDATE >= '1982/01/01';

#deptno가 10이고 job이 manager인 사원을 출력
SELECT * FROM emp WHERE deptno = 10 AND job = 'manager';

#deptno가 10이 아닌 사원의 정보를 출력
SELECT * FROM emp WHERE NOT deptno = 10;

# and 예제
SELECT
	*
FROM
	emp
WHERE
	deptno = 10
	AND job = 'MANAGER'
	AND empno = 7782;
	
#10번 부서에 소속된 사원이거나 아니면 직급이 MANAGER인 사원의
#사원번호, 사원명, 직책, 부서번호 출력
SELECT
	empno, ename,
	job,
	deptno
FROM
	emp
WHERE
	deptno = 10
	OR job = 'MANAGER';
	
#직급이 MANAGER고 10번부서 혹은 20번부서에 속한 사원의 정보 출력
SELECT
	*
FROM
	emp
WHERE
	job = 'MANAGER'
	AND (deptno = 10 OR deptno = 20);
	
# 급여가 2000이상 3000이하인 사원들을 출력
SELECT * FROM emp
WHERE sal >= 2000 AND sal <= 3000;

SELECT * FROM emp
WHERE sal BETWEEN 2000 AND 3000;

#1987년 1월 1일부터 1987년 12월 31일 사이에 입사한 사원을 출력
SELECT * FROM emp
WHERE hiredate BETWEEN '1987/01/01' AND '1987/12/31';

#comm이 300이거나 500이거나 1400인 사원을 출력
SELECT * FROM emp
WHERE comm = 300 OR comm = 500 OR comm = 1400;

SELECT * FROM emp
WHERE comm IN(300, 500, 1400);

#위의 반대
SELECT * FROM emp
WHERE NOT (comm =300 OR comm =500 OR comm =1400);

SELECT * FROM emp
WHERE comm NOT IN(300, 500, 1400)
OR comm IS NULL;
-- null값은 연산을 시키는 순간 연산 대상에서 제외됨 = 포함이 안됨
-- = 결과값에 안뜸
-- OR comm IS NULL; 널값도 포함시키기

#사원번호가 7521도 아니고 7654도 아니고 7844도 아닌 사원 출력
SELECT * FROM emp
WHERE empno NOT IN(7521, 7654, 7844);

#이름이 F로 시작하는 사원을 출력
SELECT * FROM emp
WHERE ename LIKE 'F__%';
-- % 앞에는 F가 오고 뒤에는 어떤 글자가 몇 개와도 상관없음
-- _ 어떤 문자가 오는지는 모르지만 반드시 하나가 올 것이다

SELECT * FROM emp
WHERE ename LIKE '%F%';
-- 문자열에 F라는 글자가 포함되어 있으면 출력

#사원 이름 중 A를 포함하는 이름 출력
SELECT * FROM emp
WHERE ename LIKE '%A%';

#사원의 이름이 N으로 끝나는 사원을 출력
SELECT * FROM emp
WHERE ename LIKE '%N';

#사원의 이름에 두번째 알파벳이 A인 사원 출력
SELECT * FROM emp
WHERE ename LIKE '_A%';

#사원의 이름에 A가 없는 사원 출력
SELECT * FROM emp
WHERE ename NOT LIKE '%A%';

#comm이 null인 사원들 출력
SELECT * FROM emp
WHERE comm IS NULL;

#comm이 null이 아닌 사원들 출력
SELECT * FROM emp
WHERE comm IS not NULL;

#사원을 sal 기준으로 오름차순 정렬하여 출력하세요
SELECT * FROM emp
ORDER BY sal ASC;
-- asc는 생략 가능

#사원을 sal 기준으로 내림차순 정렬하여 출력하세요
SELECT * FROM emp
ORDER BY sal DESC;

# 입사일이 가장 빠른 사원을 기준으로 정렬하여 출력
SELECT * FROM emp
ORDER BY hiredate DESC;

# sal 기준으로 내림차순 정렬하되 sal가 똑같다면 ename순으로 오름차순 정렬
SELECT * FROM emp
ORDER BY sal DESC, ename ASC;

#위의 쿼리에서 상위 5개만
SELECT * FROM emp
ORDER BY sal DESC, ename
LIMIT 0, 5;
-- 0을 기준으로 5개를 출력해라

-- -------------------------------
#-100의 절대값
SELECT ABS(-100);

#올림, 내림, 반올림
SELECT CEILING(3.7), FLOOR(3.7), ROUND(3.7);

#나머지 값
SELECT MOD(14, 3), 14 % 3, 14 MOD 3;

#제곱, 제곱근
SELECT POW(3,2), SQRT(16);

#랜덤값
SELECT RAND(), FLOOR(1+(RAND()*6));
-- 0부터 1 사이의 랜덤값 출력, 1~6까지의 랜덤정수 출력

#소수점 자리수 기준 버림(숫자함수)
SELECT TRUNCATE(1234.1234, 2), TRUNCATE(1234.1234, -2);
-- 소수점 두자리까지 남기고 버리기, 정수자리 뒤에서 2자리 버리기

#기존 숫자를 2진수 혹은 8진수로 변환
SELECT CONV(100, 10, 2), CONV(100, 10, 8), CONV('ff', 16, 10);
-- 10진수의 100이라는 숫자를 2진수, 8진수로 변환
-- 'ff'라는 16진수를 10진수로 변환

#아스키코드를 숫자로or 숫자를 아스키코드로 변환
SELECT ASCII('A'), CHAR('65');

#글자 길이 출력
#비트의 개수, 문자의 개수, 할당된 byte의 수
SELECT BIT_LENGTH('abc'), CHAR_LENGTH('abc'), LENGTH('abc');
SELECT BIT_LENGTH('가나다'), CHAR_LENGTH('가나다'), LENGTH('가나다');

#단어를 이을 때
SELECT CONCAT('2022', '08', '12');
#구분자를 넣어서 문자를 이을 때
SELECT CONCAT_WS('/', '2022', '08', '12');

#해당 위치의 문자열 반환
SELECT ELT(2, 'a','b','c');
#찾을 문자열의 위치 반환
SELECT FIELD('b', 'a','b','c');
#연속된 문자열 안에서 해당 문자를 찾을 경우(구분자가 있어야함)
SELECT FIND_IN_SET('c','a,b,c,d');
#해당 문자열 안에서 특정 문자의 위치를 찾을 경우(구분자 없는 문자열 내)
SELECT INSTR('abcd','b');
SELECT LOCATE('b', 'abcd');
-- 파라미터 순서만 반대

# 숫자를 특정 소수점 아래 자릿수 까지만 표현(문자함수)
SELECT FORMAT(123.1234, 2);
# 숫자를 2진수 8진수 16진수로 나타내기
SELECT BIN(31), OCT(31), HEX(16);

# 기준 문자열의 위치부터 길이만큼 삽입한 문자열로 변경할 경우
SELECT INSERT('가나다라마', 2, 2, '@@@');

#문자열에서 특정 길이만큼을 왼쪽부터 반환, 오른쪽부터 반환
SELECT LEFT('가나다라마바', 3);
SELECT RIGHT('가나다라마바', 3);

#대문자를 소문자로, 소문자를 대문자로
SELECT LCASE('aBcDe');
SELECT UCASE('aBcDe');

#왼쪽 혹은 오른쪽을 지정한 범위만큼 늘려서 해당하는 문자로 채울 때 사용
SELECT LPAD('가나다', 5, '@@'); #5자리 문자열로 만들어서 왼쪽에 @@
SELECT RPAD('가나다', 10, '@@'); #10자리 문자열, 오른쪽에 @@

#왼쪽, 오른쪽, 양쪽 공백 제거
SELECT LTRIM('    abc    ');
SELECT RTRIM('    abc    ');
SELECT TRIM('    abc    ');

SELECT TRIM(LEADING ' ' FROM '    abc    ');
SELECT TRIM(TRAILING ' ' FROM '    abc    ');
SELECT TRIM(BOTH' ' FROM '    abc    ');

SELECT TRIM(BOTH'a' FROM 'aaababaaa'); #앞뒤로 붙어있는 특정 문자열 제거

#문자열 반복
SELECT repeat('abc', 3); #abc라는 문자열 3번 반복

#문자열 부분 교체
SELECT REPLACE('It is banana', 'banana', 'apple');
-- banana라는 문자열 apple로 교체

#문자열 반전
SELECT REVERSE('가나다');

#공백 생성(잘 안씀)
SELECT CONCAT('ab', SPACE(5), 'cd'); #ab랑 cd사이에 공백 5개 생성

#시작 위치를 기준으로 길이만큼 문자열을 잘라 반환
SELECT SUBSTRING('abcdef', 3, 2); #3번째 자리부터 2개 문자열만 자르기

#date 함수
#기준 날짜에서 특정 일수를 더하거나 뺄 경우
SELECT ADDDATE('2022-01-01', INTERVAL 31 DAY);
SELECT SUBDATE('2022-01-01', INTERVAL 31 DAY);

#특정 시간 더하거나 뺄 경우
SELECT ADDTIME('2022-01-01 21:20:00', '1:0:0');
SELECT SUBTIME('2022-01-01 21:20:00', '1:0:0');

#현재 날짜 시간을 출력
SELECT NOW();
#연 월 일 시 분 초 밀리초
SELECT YEAR(NOW()), month(NOW()), dayofmonth(NOW()), hour(NOW()),
		 MINUTE(NOW()), SECOND(NOW()), microsecond(NOW()); 
		 
#연-월-일, 시-분-초
SELECT DATE(NOW()), TIME(NOW());

#기준일로부터 몇일 남았는가를 출력할 경우
SELECT DATEDIFF('2022-08-15', '2022-08-12');
-- 12일 기준으로 15일까지 며칠 남았나

#기준 시간으로부터 몇시간 남았는가를 출력
SELECT TIMEDIFF('14:30:00', '12:00:00');

#요일, 월의 영어이름, 1년에 며칠이 지났는지
SELECT DAYOFWEEK(NOW()), MONTHNAME(NOW()), DAYOFYEAR(NOW());

#주어진 월의 마지막 날을 반환
SELECT LAST_DAY('2022-08-12');

#시간을 초 단위로 구할 경우(잘 안씀)
SELECT TIME_TO_SEC('10:53:10');

-- 형변환함수 ⭐ 중요 ---------------------------------------

#NOW()를 숫자로 반환
SELECT CAST(NOW() AS SIGNED);
SELECT CONVERT(NOW(), SIGNED);

#NOW()를 문자로 반환
SELECT CAST(NOW() AS CHAR);

#숫자를 DATE로
SELECT CAST(20220812 AS DATE);


-- 제어흐름함수 ---------------------------------------

#IF
SELECT IF(1>3, 'true', 'false');
-- 참이면 앞, 거짓이면 뒤 반환

#nullif
SELECT NULLIF(1,2);
-- 1과 2가 동일하면 null반환, 아니면 앞에있는거 반환


#다중 조건 분기
SELECT case 10
	when 1 then 'a'
	when 5 then 'b'
	when 10 then 'j'
	ELSE '?' #아무것도 아니면 ? 출력
	END;
	
SELECT * FROM dept;

SELECT ename, deptno,
	case when deptno=10 then 'ACCOUNTING'
		  when deptno=20 then 'RESEARCH'
		  when deptno=30 then 'OPERATIONS'
	END AS dname
FROM emp;


-- 날짜 형식을 문자 형태로 변환
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d');
SELECT DATE_FORMAT(NOW(), '%Y년 %c월 %d일');

-- 문자 타입이 날짜 형식으로 변환
SELECT STR_TO_DATE('2022-08-16', '%Y-%m-%d');
SELECT STR_TO_DATE('2022년 08월 16일', '%Y년 %m월 %d일');
-- date 타입이기 때문에 문자열으로 출력 안됨