use sqldb;
-- 1. 이름이 '김경호'인 사람보다 키가 큰 사람들의 이름과 키를 출력하라
SELECT NAME, height FROM usertbl
WHERE height > ANY(SELECT height FROM usertbl WHERE NAME = '김경호'); 


-- 2. 주소가 "경남" 인 사람들의 최소 키보다 큰 사람들에 대한 이름과 키를 출력하라
SELECT NAME, height FROM usertbl
WHERE height > (SELECT min(height) FROM usertbl WHERE addr='경남');


-- 3. 주소가 "경남" 인 모든 사람들의 키보다 큰 사람들에 대한 이름과 키를 출력하라
SELECT NAME, height FROM usertbl
WHERE height > ALL(SELECT height FROM usertbl WHERE addr='경남');


-- 4. userid를 기준으로 해당 회원의 id, name, prodname, addr, 연락처를 출력하라
SELECT usertbl.userid, NAME, prodname, addr, mobile1, mobile2
FROM usertbl INNER JOIN buytbl
ON usertbl.userid = buytbl.userid;

