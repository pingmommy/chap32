/* set.sql 파일을 통해서 작성된 sql문은 scott 유저로 오라클서버로 전달됨.  */

--14명
select * 
  from group_star;

--7명  
select * 
  from single_star;
  
-- group_star, single_star 결과 합치기 : union
--21명이 아닌 17명이 결과값으로 나온다. (자동으로 중복처리됨.)
select * from group_star
union
select * from single_star;


--중복을 제거하고 싶지 않을 때 
-- 결과값으로 21명이 나온다. 
select * from group_star
union all
select * from single_star;

-- 두 테이블의 교집합만 추출할 때 
select * from group_star
intersect
select * from single_star;

-- 차집합 추출하기(그룹활동만 하는사람) 
select * from group_star
minus
select *from single_star;

--차집합 추출(싱글활동만 하는 사람)
select * from single_star
minus 
select * from group_star;