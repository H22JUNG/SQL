use sqldb;
-- 1. usertbl에서 이름이 '김경호'인 행을 출력하라.
SELECT * from usertbl
WHERE name ='김경호'; 

-- 2. usertbl에서 출생년도가 1970이고 키가 182이상인 사람의 userid, name을 출력하라.
SELECT userid, NAME from usertbl
WHERE birthyear=1970 AND height >=182;

-- 3. usertbl에서 출생년도가 1970년 이후이거나 키가 182이상인 사람의 userid, name을 출력한다.   
SELECT userid, NAME from usertbl
WHERE birthyear>=1970 AND height >=182;

-- 4. usertbl에서 키가 180이상, 183이하인 사람의 모든 정보를 출력하라
SELECT * from usertbl
WHERE height BETWEEN 180 AND 183;

-- 5. usertbl에서 주소가 '경남','전남','경북','전북' 인 사람들의 모든 정보를 출력하라
SELECT * from usertbl
WHERE addr IN('경남','전남','경북','전북');

-- 6. usertbl에서 주소가 '경남'을 제외한 나머지 사람들의 모든 정보를 출력하라
SELECT * from usertbl
WHERE addr<>'경남';

-- 7. usertbl에서 성이 "김"씨인 사람들의 모든 정보를 출력하라
SELECT * FROM usertbl
WHERE NAME LIKE '김%';
 
-- 8. usertbl에서 이름이 "종신"인 사람들의 모든 정보를 출력하라
SELECT * FROM usertbl
WHERE NAME LIKE '%종신%';

-- 9. usertbl에서 사람들의 모든 정보를 name을 기준으로 오름차순 출력하라
SELECT * FROM usertbl
ORDER BY NAME;

-- 10. usertbl에서 사람들의 모든 정보를 name을 기준으로 내림차순 출력하라
SELECT * FROM usertbl
ORDER BY NAME DESC;

-- 12. usertbl에서 사람들의 모든 정보를 addr을 기준으로 오름차순 출력하라.
-- 같은 주소가 있을 경우 name을 기준으로 오름차순 출력하라.
SELECT * FROM usertbl
ORDER BY addr, NAME;

-- 13. usertbl에서 모든 주소를 출력하되 중복을 제거하고 출력하라
SELECT DISTINCT addr FROM usertbl;