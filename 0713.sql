SELECT  *
    FROM emp WHERE ename like 'F%'; -- ? * // _ %


-- 사원 이름에 SCOTT 단어가 같은 데이터 출력
SELECT *
    FROM emp
    WHERE UPPER(ename) = UPPER('scott');


-- 사원 이름에 SCOTT 단어가 포함된 데이터 출력
SELECT *
    FROM emp
    WHERE UPPER(ename) LIKE UPPER ('%scott%');



-- 1. 사원의 이름 길이가 5이상인 경우만 출력
SELECT ename, LENGTH(ename)
    FROM emp
    WHERE LENGTH(ename) >= 5;
    
-- * 한글의 경우 글자단위와 바이트 단위가 있음.
SELECT LENGTH('한글'), LENGTHB('한글')
    FROM DUAL;

-- 2. 이름 글자의 일부를 추출하고자 한다.
-- 1) 처음 2글자
-- 2) 3번째에서 2개
-- 3) 5번째 글자만
SELECT SUBSTR(ename,1,2), SUBSTR(ename,3,2), SUBSTR(ename,5)
    FROM emp;
    
-- 특정 문자열 찾기
SELECT INSTR('HELLO ORACLE!', 'L') AS INSTR_1,
       INSTR('HELLO ORACLE!', 'L', 5) AS INSTR_2,
       INSTR('HELLO ORACLE!', 'L', 2,2) AS INSTR_3
    FROM DUAL;
    
-- 특정 문자열 바꾸기
SELECT '010-1234-5678' AS REPLACE_BEFORE,
       REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1,
       REPLACE('010-1234-5678', '-') AS REPLACE_2
    FROM DUAL;
    
-- 특정 문자열 채우기
SELECT
      RPAD('971225-2', 14, '*') AS RPAD_JMNO,
      RPAD('010-1234-', 13, '*') AS RPAD_JMNO
    FROM DUAL;
    
-- 두 열 사이에 : 넣고 연결
SELECT CONCAT(empno, ename),
       CONCAT(empno, CONCAT(':', ename))
    FROM emp
    WHERE ename = 'SCOTT';

-- TRIM 함수로 공백 제거
SELECT '[' || TRIM (' _Oracle_ ') || ']' AS TRIM,
       '[' || LTRIM (' _Oracle_ ') || ']' AS LTRIM,
       '[' || LTRIM ('<_Oracle_ ','_<') || ']' AS LTRIM2,
       '[' || RTRIM (' _Oracle_ ') || ']' AS RTRIM,
       '[' || RTRIM (' <_Oracle_> ','_> ') || ']' AS RTRIM2
    FROM DUAL;
    
-- * 숫자와 관련된 함수
-- ROUND
SELECT ROUND(1234.5678) AS ROUND,
       ROUND(1234.5678, 0) AS ROUND_0,
       ROUND(1234.5678, 1) AS ROUND_1,
       ROUND(1234.5678, 2) AS ROUND_2,
       ROUND(1234.5678, -1) AS ROUND_MINUS1,
       ROUND(1234.5678, -2) AS ROUND_MINUS2
    FROM DUAL;
-- TRUNC : 특정 위치에서 버림한 값
-- CEIL : 지정된 숫자보다 큰 정수 중 가장 작은 정수
-- FLOOR : 지정된 숫자보다 큰 정수 중 가장 큰 정수
-- MOD : 나눈 나머지 값


    
-- * 날짜 표시
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE, 3)
    FROM DUAL;
    
-- 3. 사원들의 입사 10주년이 되는 시점을 출력
SELECT empno, ename, hiredate, ADD_MONTHS(hiredate, 120) AS WORK10YEAR
    FROM emp;
    
-- 현재의 날짜와 시간을 출력
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
    FROM DUAL;
    
-- 월과 요일의 다양한 형식
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM') AS MM,
       TO_CHAR(SYSDATE, 'MON') AS MON,
       TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
       TO_CHAR(SYSDATE, 'DD') AS DD,
       TO_CHAR(SYSDATE, 'DY') AS DY,
       TO_CHAR(SYSDATE, 'DAY') AS DAY
    FROM DUAL;
     