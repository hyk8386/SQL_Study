-- * byte 단위로 계산할 때
-- EUC_KR은 한글 2byte
-- UTF-8은 한글 3byte

SELECT LENGTH('한글'), LENGTHB('한글')
    FROM DUAL;
    
SELECT LENGTHB(CONVERT('한글', 'KO16MSWIN949')) AS LENGTHB_1,
       LENGTHB(CONVERT('한글 KOREAN', 'KO16MSWIN949')) AS LENGTHB_2
    FROM DUAL;
    
-- 날짜 표시 형식
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"') FROM DUAL;

-- 여러가지 언어로 날짜(월) 출력 -> 홈페이지 다국어 지원
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'MM') AS MM,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE=KOREAN') AS MON_KOR,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE=JAPANESE') AS MON_JPN,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE=ENGLISH') AS MON_ENG,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE=KOREAN') AS MONTH_KOR,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE=JAPANESE') AS MONTH_JPN,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE=ENGLISH') AS MONTH_ENG
 FROM DUAL;
 
 -- 여러가지 숫자 형식 사용하여 급여 출력하기
 SELECT sal,
        TO_CHAR(sal, '$999,999') AS sal_$,
        TO_CHAR(sal, 'L999,999') AS sal_L,
        TO_CHAR(sal, '$999,999.00') AS sal_1,
        TO_CHAR(sal, '$000999999.99') AS sal_2,
        TO_CHAR(sal, '$999,999,00') AS sal_3 
    FROM emp;

-- 1. 1981년 6월 1일 이후에 입사한 사원의 정보 출력
SELECT *
    FROM emp
    WHERE hiredate > TO_DATE('1981/06/01', 'YYYY/MM/DD');
    
-- * null은 계산을 하면 결과는 null이 된다.
-- 그래서 null을 계산할 때는 NVL과 NVL2를 사용하는데, 대부분 NVL을 사용함

-- NVL
SELECT empno, ename, sal, comm, sal+comm,
       NVL(comm, 0),
       sal+NVL(comm, 0)
    FROM emp;
    
-- NVL2
SELECT empno, ename, comm,
       NVL2(comm, 'o', 'x'),
       NVL2(comm, sal*12+comm, sal*12) AS ANNSAL
    FROM emp;
    
-- * DECODE 함수와 CASE문이 있는데 DECODE를 권함 - CASE는 Oracle 전용.

-- DECODE함수
SELECT empno, ename, job, sal,
    DECODE(job, 
        'MANAGER', sal*1.1,
        'SALESMAN', sal*1.05,
        'ANAYST', sal,
        sal*1.03) AS UPSAL
    FROM emp;
    
-- EMP 테이블 보너스 데이터 갯수
SELECT COUNT(comm)
    FROM emp;

-- 부서 번호가 30인 직원 수
SELECT COUNT(*)
    FROM emp
    WHERE deptno = 30;
    
-- 추가 수당 행의 갯수
SELECT COUNT(comm)
    FROM emp
    WHERE comm IS NOT NULL;

-- 부서번호가 20인 사원의 입사일 중 제일 최근 입사일
SELECT MAX(hiredate)
    FROM emp
    WHERE deptno = 20;

-- * GROUP BY 절과 HAVING 절
-- SELECT
-- FROM
-- WHERE
-- GROUP BY
-- HAVING
-- ORDER BY

-- WHERE절과 HAVING절의 차이
SELECT deptno, job, AVG(sal)
    FROM emp
GROUP BY deptno, job
    HAVING AVG(sal) >= 2000
ORDER BY deptno, job;
-- WHERE절을 사용하면 GROUP BY절보다 우선 처리함
SELECT deptno, job, AVG(sal)
    FROM emp
WHERE sal <= 3000
GROUP BY deptno, job
    HAVING AVG(sal) >= 2000
ORDER BY deptno, job;

-- PIVOT 함수 사용
SELECT *
    FROM(SELECT deptno, job, sal
            FROM emp)
    PIVOT(MAX(sal)
            FOR deptno IN(10,20,30)
        )
ORDER BY job;

-- JOIN
SELECT e.empno, e.ename, d.deptno, d.dname, d.loc -- 3. 출력할 데이터
    FROM emp e, dept d -- 1. 어떤 테이블을 join할지 정하기
    WHERE e.deptno = d.deptno  -- 2. 속성이 일치해야함
    ORDER BY d.deptno, e.empno;
    
-- * 서브쿼리
-- 서브쿼리로 JONES의 급여보다 높은 급여를 받는 사원 정보 출력
SELECT *
    FROM emp
    WHERE sal > (SELECT sal
                    FROM emp
                    WHERE ename = 'JONES');
                    
-- 실무형 쿼리 - 조인과 서브쿼리를 같이 사용
SELECT e.empno, e.ename, d.deptno, d.dname, d.loc 
    FROM emp e, dept d 
    WHERE e.deptno = d.deptno 
      AND e.deptno = 20
      AND e.sal > (SELECT AVG(sal)
                        FROM emp);
    