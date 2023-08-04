/*  02. SQL문 기본
 
 01.
 select 문 
  범용언어에서 for와 if를 합쳐놓았다고 봐도 좋다. 
  테이블을 조회하는 역할 
 
 
 
 select [DISTINCT] {*, column[alias]...} from table_name;
 
 slection - 전체 테이블에서 특정 row를 선택하는 것을 의미. 
 projection - 전체 테이블에서 특정 column을 선택하는 것을 의미
 [DISTINCT] - 중복되면 중복을 제거해라. 대가로에 있는 인자는 생략가능 
 
 
>>>> 산술연산자

모든 산술연산이 가능 (node처럼 실수연산 / 할 때 주의 . 정수연산이 기본인 java와 다름.)*/


--select
--from
--where
-- odrer by 

select * from dept;

--select *  >> select 절 
--  from dept;  >> from 절 


-- 모든 row을 selection할 때 
select * 
  from dept;
  
  
 -- 모든 row에서 deptno 컬럼만  projection할 때 (특정데이터만 볼 때는 컬럼명을 주면 된다.)
select deptno
  from dept;
  
select *
  from emp;

-- 여러 개의 컬럼을 함께 불러올 수 있다.  
select empno,ename,sal
  from emp;
  
--deptno 컬럼만 테이블에서 불러오기. 정보는 중복될 수 있다. 
select deptno
  from emp;
 
-- 같은 컬럼을 중복하여 불러올 수 있다. 이 때 결과테이블에는 컬럼명이 자동으 넘버링된다. >>deptno,deptno-1   
select deptno,deptno
  from emp;  
  
 -- 결과테이블에 컬럼명이 중복될 때 as 명령어를 써서 컬럼명에 별칭을 줄 수 있다. >> deptno, no 
select deptno,deptno as no
  from emp;  

 -- as를 생략하고 space를 주고 별칭을 써도 되고,
select deptno,deptno  no
  from emp;
 
 -- 별칭은 한글도 가능
 select deptno,deptno as 숫자
  from emp;
  
-- " " 쌍따옴표로도 가능하다.(주로 별칭 철자를 space로 구분할 때 " a n y")
select deptno,deptno as "n   o"
  from emp;  
 
 -- 위의 명령문에서 정보의 중복이 많은데, 중복을 피하고 싶을 때는 distinct. 
 -- 회사에는 4개의 부서가 있는데, 직원들은 어디에 소속되어 있지? >> 그냥 조회하면 직원이 다 나온다.(부서 중복) >> distinct를 사용하면 중복을 피해서 소속된 부서만 나타남. 
select distinct deptno,deptno
  from emp; 
  
 -- from이 먼저 수행되고 다음에 select절이 수행되는데, 이 때 *10이 수행된다.  
select deptno,deptno*10
  from dept;  
  
  -- 다양한 연산을 수행할 수 있다. 이 때 컬럼명은 expression대로 표현된다. >>deptno+10 | deptno-10
select deptno, 
       deptno+10,
       deptno-10,
       deptno*10,
       deptno/3
from dept; 
  
  -- 별칭을 써서 컬럼명을 다르게 표현할 수 있다. 결과창에만 나타날 뿐 db컬럼명이 바뀌는 것은 아니다. 
  -- add,mul... 은 keyword여서 숫자를 붙여서 별칭으로 기능하게 함. 
select deptno,
       deptno+10 as add2,
       deptno-10 as sub2,
       deptno*10 as mul2,
       deptno/3 as div2
from dept;  

-- 직원연봉구하기 월급에 *12해서 결과창에 annual 컬럼에 출력 
select ename, sal,sal*12 as annual
  from emp;

-- 직원 중 영업직은 sal*12에 커미션을 더해야 연봉 
-- 하지만 직원 중 커미션(comm)값이 null인 경우도 있다.
-- db에서 연산결과로써 null은 NaN과 같다. (연산 안됨.)  
-- 범용언어에서는 if문을 쓰면 되지만 sql엔 없으므로 함수를 써야 한다. 
select ename, sal, comm, sal*12 + comm as annual
  from emp;
  
-- 단순계산용으로 daul. select를 쓸 때는 꼭 from과 테이블명이 와야 하는데, 실제 데이터테이블을 테스트용으로 쓸 수 없으므로
-- 이럴 때 dual table를 쓰면 된다.
-- dual은 그냥 dummy형태이기 때문에 그냥 쓰면 된다. 
select * 
  from dual;
  
  --vnl()함수 : nvl(null값인지 확인할 컬럼인자, null대신 들어갈 값) >> 함수는 표준이 아니라서 디비 프로그램마다 다르다. sql문은 표준.
 select 10+10,
        10*10,
        10-10, 
      nvl(null,100),
      nvl(9,100)
  from dual; 
  
-- select from문의 작동방식 : for(row : tables)  
-- nvl()의 작동방식 : if (comm==null){comm=0}
--if (comm==null){comm=0} 알고리즘을 삽입해서 정확한 연산결과를 도출하기 위해
--vnl()함수를 사용함. nvl(null값인지 확인할 컬럼인자, null대신 들어갈 값)
 select ename, sal, comm, sal*12 +nvl(comm,0) as annual
  from emp; 
  
 
 
 -- java에서의 random()을 구현해봄. 
 -- random패키지의 random() normal() value()를 호출함. 
 -- random.value()가 java의 random()과 가장 유사.
 select dbms_random.random,
        dbms_random.normal,
        dbms_random.value(1,5),
        dbms_random.value(0,1)
   from dual;

-- java에서 random() : dbms_random.value(0,1) >> 0.0~0.9사이의 실수 출력
select  dbms_random.value(0,1)
  from dual;
  
-- java에서처럼 rondom()으로 line구현.
select dbms_random.value(0,1)*20 + 1
  from dual;  

-- trunc()를 사용하여 소수부 잘라냄  
select trunc(dbms_random.value(0,1)*20 + 1) 
  from dual; 
  
 -- line, column,fg,bg,ch 구현(자바에서 VT100 필드요소 구현) 
select trunc(dbms_random.value(0,1)*20 + 1) as line,
       trunc(dbms_random.value(0,1)*40 + 1) as col,
       trunc(dbms_random.value(0,1)*8 + 30) as fg,
       trunc(dbms_random.value(0,1)*8 + 40) as bg,
      dbms_random.string('u',1)
from dual; 

--dbms_random.string('u',10) 에서 뒤의 숫자가 출력되는 알파벳 숫자임을 확인함. 10개의 알파벳 출력됨. 
select trunc(dbms_random.value(0,1)*20 + 1) as line,
       trunc(dbms_random.value(0,1)*40 + 1) as col,
       trunc(dbms_random.value(0,1)*8 + 30) as fg,
       trunc(dbms_random.value(0,1)*8 + 40) as bg,
      dbms_random.string('u',10)
from dual; 
 
-- 기존에 있던 alpha 테이블을 제거하고
 drop table alpha;
 
 -- 새로운 alpha 테이블을 생성(VT100을 구현함.)
 create table alpha(
    line number(2),
    col  number(2),
    fg   number(2),
    bg   number(2),
    ch   char(1)
 );  
 
 insert into alpha 
 values(
    trunc(dbms_random.value(0,1)*20 + 1),
    trunc(dbms_random.value(0,1)*40 + 1),
    trunc(dbms_random.value(0,1)*8 + 30),
    trunc(dbms_random.value(0,1)*8 + 40),
    dbms_random.string('u',1)
 );
 
select * from alpha;

select line,col
  from alpha;
  
 select count(*)
   from alpha;
   
select distinct line,col
  from alpha;   

commit;

-- 여러 개의 데이터를 연결해서 출력할 때 '||' 로 연결. 하나의 컬럼에 나타난다. 컬럼명을 바꿀 때는 AS 컬럼명 
select '['||line ||', '||col||', '||fg||', '||bg||', '||ch||']' as alpha
  from alpha;
  
-- select * [] from 테이블명 where 조건절 : 참이 되는 row만 결과값으로 가져옴. 
-- 실행순서는 1>from 테이블명 2> where 조건절 3> select * []

-- deptno가 10인 직원만 추출
select * 
  from emp
  where deptno =10;

-- alpha 테이블에서 ch가 'A'만 추출   
select * 
  from alpha
  where ch ='A';
  
select *
  from alpha
  where line=6 and col=8;
 
select *
  from alpha
  where line<10;  
 
 --where절에서 논리연산자 and 
 select empno, ename, job
   from emp 
   where gender='M' and sal>500;

----where절에서 논리연산자 or
select * 
  from emp
  where deptno=10 or job='과장';

--where절에서 논리연산자 not(!=)   
select * 
  from emp
  where not deptno=10;
  
select * 
  from emp
  where deptno != 10;

-- 커미션이 없는(null) 직원들을 추출하려는데, where comm =null;>> 이건 안 된다. 해도 결과값은 false  
-- db에서의 null은 NaN의 의미가 강하기 때문에 comm==null의 표현으로는 null을 판별해낼 수 없다. 
-- 범용 언어에서처럼 comm== null 식으로 생각하면 안 된다. 


-- select * 
--   from emp
--   where comm =null;

-- 커미션이 없는(comm이 null) 직원들을 추출
select * 
  from emp
  where comm is null;
 
 -- 커미션을 받는 직원(comm이 null이 아닌) 추출 
select * 
  from emp
  where comm is not null;  
  
  
  -- where절 'in' keyword
select *
  from emp
--  where deptno=10 or deptno=30;
   where deptno in (10,30);


-- like 연산자 : 문자열에 대해서 조회할 때 
-- 데이터를 조회할 때 정확한 문자열을 조건으로 주어야 하는데,
-- 근사치의 조건을 주게 될 때는 like를 쓰면 된다. 
-- '_' 자리수를 의미해서 '_n%'라고 표현하면 n앞에 1자리는 꼭 와야 한다. 
-- '%'는 자리수에 상관없이 n이 포함되면 다 추출하라는 의미이다.  
select *
 from country
-- where name = 'Brazil'
-- where name like '%orea%';
 where name  like '_n%';
 
 --sal를 기준으로 asc 정렬 
 select *
  from emp
  order by sal;
  
 -- sal 기준으로 desc 정렬  
  select *
  from emp
  order by sal desc; 
  
  --line 기준으로 정렬 
  select *
    from alpha
    order by line;
    
  -- 1차 정렬결과에 중복이 많을 때 2차 기준으로 정렬 
  
    select *
    from alpha
    order by line, col desc;