create database mydb2;
use mydb2;

-- 문제86			
-- 다음 4개의 테이블을 생성하세요(데이터베이스는 mydb2를 생성하여 사용하시오)			
-- 테이블명 : employee			
-- 열이름		데이터형식		NULL허용	제약조건
-- emp_no	int		
-- emp_name	varchar(20)		
-- salary	int 		
-- birthday	date		
CREATE TABLE employee(
	emp_no INT,
	emp_name	VARCHAR(20),
	salary INT,
	birthday	DATE
);

-- 테이블명 : project			
-- 열이름		데이터형식		NULL허용		제약조건
-- pro_no		int		
-- pro_content	varchar(20)		
-- start_date	date		
-- finish_date	date
CREATE TABLE project(
	pro_no INT,
	pro_content	varchar(20),
	start_date DATE,
	finish_date	DATE
);

-- 테이블명 : specialty			
-- 열이름		데이터형식		NULL허용	제약조건
-- emp_no	  int		
-- specialty  varchar(20)		
CREATE TABLE specialty SELECT emp_no FROM employee;
ALTER TABLE specialty add specialty VARCHAR(20);

-- 테이블명 : assign			
-- 열이름		데이터형식		NULL허용	제약조건
-- emp_no	int		
-- pro_no	int		
CREATE TABLE assign
SELECT emp_no, pro_no FROM employee, project;


-- 제약 조건 추가 문제입니다. alter table을 사용하세요			
-- 문제87			
-- empoyee테이블에 emp_no를 기본키를 추가하고 확인해보시오			
-- 기본키명 : employee_pk	
ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY(emp_no);
-- 문제88			
-- project테이블에 pro_no컬럼을 기본키를 추가하고 확인해보시오			
-- 기본키명 : project_pk
ALTER TABLE project ADD CONSTRAINT project_pk PRIMARY KEY(pro_no);
 			
-- 문제89
-- sepcialty테이블에 기본키를 추가하고 확인해보시오.(emp_no, specialty 2개 컬럼 다 pk지정)			
-- 기본키명 : specialty_pk			
ALTER TABLE specialty ADD CONSTRAINT specialty_pk PRIMARY KEY(emp_no, specialty);
 			
-- 문제90
-- assign테이블에 기본키를 추가하고 확인해보시오.(emp_no, pro_no 2개 컬럼 다 pk로 지정)			
-- 기본키명 : assign_pk	
ALTER TABLE assign ADD CONSTRAINT assign_pk PRIMARY KEY(emp_no, pro_no);
 			
 			
# alter table 테이블이름 add FOREIGN KEY(컬럼명) REFERENCES 참조테이블(참조컬럼)
-- 문제91
-- specialty테이블에 외래키를 추가하고 확인해보시오.(emp_no를 외래키 설정)			
-- 외래키명 : specialty_fk		
ALTER TABLE specialty ADD CONSTRAINT specialty_fk
FOREIGN KEY(emp_no) REFERENCES employee(emp_no);
 		
-- 문제92
-- assign테이블에 외래키를 추가하고 확인해보시오.(pro_no를 외래키 설정)			
-- 외래키명 : assing_project_fk			
ALTER TABLE assign ADD CONSTRAINT assign_project_fk
FOREIGN KEY(pro_no) REFERENCES project(pro_no);

 			
-- 문제93
-- assign테이블에 외래키를 추가하고 확인해보시오.(emp_no를 외래키 설정)			
-- 외래키명 : assign_employee_fk			
ALTER TABLE assign ADD CONSTRAINT assign_employee_fk
FOREIGN KEY(emp_no) REFERENCES employee(emp_no);


-- 문제94
-- dept01 테이블을 생성하시오. 그리고 데이터를 삽입하시오			
-- 열이름		데이터형식		NULL허용	제약조건
-- deptno		int			x	PK설정
-- dname	varchar(14)		x	
-- loc		varchar(13)		x	
-- 10, '경리부', '서울'			
-- 20, '인사부', '인천'			
CREATE TABLE dept01(
	deptno INT NOT NULL PRIMARY KEY,
	dname VARCHAR(14)	NOT NULL,
	loc varchar(13) NOT NULL
);
INSERT INTO dept01 VALUES(10, '경리부', '서울'), (20, '인사부', '인천');
 			
-- 문제95
-- emp01테이블을 생성하시오. 그리고 데이터를 삽입하시오			
-- dept01테이블의 deptno PK와 외래키 관계를 엮으시오.			
-- 열이름		데이터형식	NULL허용	제약조건
-- empno	int			x	PK설정
-- ename	varchar(10)	x	
-- job		varchar(13)	x	unique설정
-- deptno	int				FK설정
-- 1000, '허준', '사원', 10			
-- 1010, '홍길동', '사원', 50	
DROP TABLE emp01;
CREATE TABLE emp01(
	empno	INT NOT NULL PRIMARY KEY,
	ename	varchar(10) NOT NULL,
	job varchar(13) NOT NULL unique,
	deptno INT,
	FOREIGN KEY(deptno) REFERENCES dept01(deptno)
);

INSERT INTO emp01 VALUES(1000, '허준', '사원', 10), (1010, '홍길동', '사원', 50);
-- 1010데이터를 삽입할 때 분명 에러가 발생한다.			
-- 에러 발생 이유가 무엇인가?			
-- 이유 : emp01테이블에 job이 unique제약조건을 가지고 있기에 데이터 삽입 안된다.
-- emp01 부서번호 50이 삽입이 되고 있다.하지만 부모테이블인 dept01에는 부서번호가 50은 없으므로 데이터 삽입이 되질 않는다.			
-- 해결방법은 2가지이다.		
-- 해결 방법을 제시하시오.			
-- 해결방법 :			
-- 1번째 해결방안 : job의 unique제약조건을 삭제한다. 			
-- 2번째 해결방안 : fk 체크 기능을 해제하고 삽입을 할 수도 있느나, emp01삽입을 할때 dept01에
-- 부서번호 50을 추가하여 부모 자식간 관계를 유지하도록 하겠다. 			

-- 문제96			
-- 문제95에서 1번째 해결방법을 쿼리문으로 만들어서 1010데이터 부분을 삽입하시오			
# ALTER TABLE emp01 MODIFY COLUMN job varchar(13);
ALTER TABLE emp01 DROP CONSTRAINT job;

drop index job on emp01; 
-- 문제97			
-- 문제95에서 2번째 해결방법을 쿼리문으로 만들어서 1010데이터부분을 			
-- 삽입하시오
# ALTER TABLE dept01 MODIFY COLUMN dname VARCHAR(14); -- not null 제거하기
INSERT INTO dept01 VALUES(50, '','');


-- 문제98
-- dept01테이블을 제거하시오		
DROP TABLE dept01;
-- 분명 에러가 발생한다.			
-- 에러 이유 :	 emp01테이블의 deptno와 함께 외래키로 묶여있기 때문(부모, 자식 관계)		
-- 해결방법
-- 해결방법 2가지가 있습니다.			
-- 1. emp01의 테이블을 먼저 제거하고 난 후 dept01을 제거하면 된다.
-- 2. emp01의 테이블의 외래키를 삭제를 하면 된다. 			

-- 문제99			
-- 문제98에서 1번째 해결방법으로 쿼리문으로 작성하여 dept01을 제거하시오			
DROP TABLE emp01;
 			
-- 문제100			
-- 문제98에서 2번째 해결방법으로 쿼리문으로 작성하여 dept01을 제거하시오
ALTER TABLE emp01 DROP FOREIGN KEY emp01_ibfk_1;
DROP INDEX deptno ON emp01;