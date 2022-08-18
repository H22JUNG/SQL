# json
CREATE TABLE employees(
	id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	name VARCHAR(200),
	profile json
);

INSERT INTO employees(name, profile)
VALUES('홍길동', '{"age":30, "gender":"man", "부서":"개발"}'),
('김철수', '{"age":43, "gender":"man", "부서":"재무"}'),
('박영희', '{"age":37, "gender":"woman", "부서":"회계"}');

# 배열 형태로 입력
INSERT INTO employees(NAME, PROFILE)
VALUES('김갑수', '[35, "man", "인사"]');


# JSON_OBJECT
# json 데이터 타입으로 넣기
INSERT INTO employees(NAME, PROFILE)
VALUES('신상일', JSON_OBJECT('age',28,'gender','man','부서','연구'));
-- 키, 값, 키, 값

INSERT INTO employees(NAME, PROFILE)
VALUES('은연수', JSON_OBJECT('age',29,'gender','woman','부서','개발','자격증',JSON_ARRAY('CISA','PMP','CISSP')));


# JSON_EXTRACT
# json 데이터에 있는 내용 가져오기
SELECT id, NAME, JSON_EXTRACT(PROFILE, '$.부서') FROM employees;
-- 프로필 안에 "부서"의 값 가져오기

# 나이가 35 이상인 사원의 id와 이름과 나이 출력
SELECT id, NAME, JSON_EXTRACT(PROFILE, '$.age')
FROM employees
WHERE JSON_EXTRACT(PROFILE, '$.age') >= 35;


# JSON_REPLACE
# profile에 있는 age를 전부 30으로 변경하여 출력
SELECT id, NAME, JSON_REPLACE(PROFILE, '$.age', 30) FROM employees;
-- 기존 데이터 치환, 데이터의 값을 바꾸는게 아니라 출력되는 값만 바꿈

# age와 gender 필드의 값을 각각 30과 '남여'로 표시
SELECT id, NAME, JSON_REPLACE(PROFILE, '$.age', 30, '$.gender', '남여') FROM employees;


# 모든 직원의 age를 +1 하여 출력
SELECT id, NAME, JSON_REPLACE(PROFILE, '$.age', JSON_EXTRACT(PROFILE, '$.age')+1) FROM employees;

COMMIT;

-- ----------------------------------------------------------------------
# 제약 조건을 확인하는 명령어
DESC information_schema.table_constraints;

SELECT * FROM information_schema.table_constraints;
-- ----------------------------------------------------------------------

DROP TABLE emp01;

CREATE TABLE emp01(
	empno DECIMAL(4),
	ename VARCHAR(10) NOT NULL,
	job VARCHAR(9),
	deptno DECIMAL(2)
);

ALTER TABLE emp01 MODIFY COLUMN empno DECIMAL(4) NOT NULL;
-- 데이터 제약조건 설정할 때에는 그 전에
-- 해당 컬럼의 null값을 모두 제거해야 수정 가능

INSERT INTO emp01
VALUES(NULL, NULL, 'salesman', 10);
-- ename이 not null이라서 오류

-- ---------------------------------------------------------
CREATE TABLE emp02(
	empno DECIMAL(4) UNIQUE, # 중복값 허용 X
	ename VARCHAR(10) NOT NULL,
	job VARCHAR(9),
	deptno DECIMAL(2)
);

INSERT INTO emp02
VALUES(7499, 'ALLEN', 'salesman', 30);

INSERT INTO emp02
-- VALUES(7499, 'JONES', 'MANAGER', 20); -- empno가 unique, 때문에 중복값 삽입 안됨
VALUES(null, 'JONES', 'MANAGER', 20); -- unique는 null을 방어하지는 않음
-- null값 허용하지 않기 위해서는 not null과 unique 같이 써야함

-- ---------------------------------------------------------
DROP TABLE emp03;

CREATE TABLE emp03(
	empno DECIMAL(4),
	ename VARCHAR(10) NOT NULL,
	job VARCHAR(9),
	deptno DECIMAL(2),
	CONSTRAINT UNIQUE emp03_empno_uk(empno)
	-- 컬럼 레벨의 제약조건 명시 : 테이블명_컬럼명_제약조건
);
-- ---------------------------------------------------------
# unique + not null = PRIMARY KEY
DROP TABLE emp04;

CREATE TABLE emp04(
	#empno DECIMAL(4) PRIMARY KEY,
	empno DECIMAL(4),
	ename VARCHAR(10) NOT NULL,
	job VARCHAR(9),
	deptno DECIMAL(2),
	PRIMARY KEY(empno)
);

INSERT INTO emp04
VALUES(7499, 'JONES', 'MANAGER', 20);

INSERT INTO emp04
VALUES(7499, 'ALLEN', 'salesman', 30); -- 에러

INSERT INTO emp04
VALUES(null, 'JONES', 'MANAGER', 20); -- 에러

-- ---------------------------------------------------------

DROP TABLE emp05;
CREATE TABLE emp05(
	empno INT UNSIGNED AUTO_INCREMENT,
	ename VARCHAR(10) NOT NULL,
	job VARCHAR(9),
	deptno DECIMAL(2),
	PRIMARY KEY(empno)
);
INSERT INTO emp05
VALUES(null, 'ALLEN', 'SALESMAN', 30); 

INSERT INTO emp05
VALUES(null, 'JONES', 'MANAGER', 20);
# AUTO_INCREMENT 순번 자동증가

SELECT * FROM emp05;

SHOW TABLE STATUS WHERE NAME='emp05';
-- 현재 인덱스 최대값=rows, AUTO_INCREMENT=다음에 올 인덱스 번호

ALTER TABLE emp05 AUTO_INCREMENT = 100;
-- 다음 순번 바꾸기

INSERT INTO emp05
VALUES(null, 'SCOTT', 'MANAGER', 20);
-- empno 100으로 출력


SELECT * FROM information_schema.table_constraints
WHERE TABLE_NAME IN ('emp', 'dept');
-- 키 확인하기
-- ---------------------------------------------------------
CREATE TABLE emp06(
	empno DECIMAL(4) PRIMARY KEY,
	ename VARCHAR(10) NOT NULL,
	job VARCHAR(9),
	deptno INT,
	# FOREIGN KEY(deptno) references dept(deptno)
	CONSTRAINT emp06_deptno_fk FOREIGN KEY(deptno) REFERENCES dept(deptno)
	# CONSTRAINT 외래키명 FOREIGN KEY(컬럼) REFERENCES 참조테이블(참조컬럼)
	# 컬럼과 참조컬럼 데이터타입 일치
);

INSERT INTO emp06
# VALUES(7566, 'SCOTT', 'MANAGER', 100);
-- 참조하는 테이블의 범위가 40까지, 그 범위 벗어난 100이라서 오류
VALUES(7566, 'SCOTT', 'MANAGER', NULL);
-- null값은 허용, FOREIGN KEY이나 null값인 경우 : 약한 연결관계를 가짐
-- not null일 경우 : 강한 연결관계를 가짐(참조컬럼에서 무조건 하나는 가져와야함)

-- -----------------CHECK : 제약의 용도-----------------------------------
-- 국소한 범위의 데이터를 넣고자 할 때 사용
DROP TABLE emp07;
CREATE TABLE emp07(
	empno DECIMAL(4) PRIMARY KEY,
	ename VARCHAR(10) NOT NULL,
	sal DECIMAL(7,2) DEFAULT 500,  # 참고 : 디폴트 제약조건
	CONSTRAINT emp07_sal_ck CHECK(sal BETWEEN 500 AND 5000),
	gender VARCHAR(1),
	CONSTRAINT emp07_gender_ck CHECK(gender IN('M','F'))
);
INSERT INTO emp07
VALUES(7566,'SCOTT', 7000, 'A'); -- 에러 : 제약조건 안에 들지 못함

INSERT INTO emp07(empno, ename, gender)
VALUES(7566,'SCOTT', 'M'); -- sal에 기본값 500이 들어감


# 제약조건 추가하기---------------------------------------------------------
ALTER TABLE emp01 ADD CONSTRAINT PRIMARY KEY(empno); 


ALTER TABLE emp01 ADD CONSTRAINT emp01_deptno_fk
FOREIGN KEY(deptno) REFERENCES dept(deptno);

ALTER TABLE emp01 MODIFY COLUMN job VARCHAR(9) NOT NULL;

# 제약조건 제거하기---------------------------------------------------------
ALTER TABLE emp01 DROP PRIMARY KEY;

ALTER TABLE emp01 DROP FOREIGN KEY emp01_deptno_fk;
-- 외래키는 삭제할 키명을 반드시 써야함

DROP INDEX job ON emp01;
-- 외래키 인덱스 드랍

-- dept01테이블을 제거하시오
-- 에러 : emp01테이블의 deptno와 함께 외래키로 묶여있기 때문(부모, 자식 관계)		

-- 해결방법 2가지가 있습니다.			
-- 1. emp01의 테이블을 먼저 제거하고 난 후 dept01을 제거하면 된다.
-- 2. emp01의 테이블의 외래키를 삭제를 하면 된다. 	
-- 3. EMP01의 근무하는 사원의 부서번호 삭제한 후 해당 부서를 삭제




