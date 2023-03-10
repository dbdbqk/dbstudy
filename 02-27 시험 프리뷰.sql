-- 사원번호를 전달하면 해당 사원의 이름을 반환하는 함수 만들기.   ------사용자 함수

CREATE OR REPLACE FUNCTION GET_NAME(EMPNO EMPLOYEE_TBL.EMP_NO%TYPE)
RETURN VARCHAR2
IS
    EMPNAME EMPLOYEE_TBL.NAME%TYPE;
BEGIN
    SELECT NAME
      INTO EMPNAME
      FROM EMPLOYEE_TBL
     WHERE EMP_NO = EMPNO;
    RETURN EMPNAME;
END;

-- 사원명
-- 구창민

SELECT GET_NAME(1001) AS 사원명
  FROM EMPLOYEE_TBL
 WHERE EMP_NO = 1001;
 
 SELECT DISTINCT GET_NAME(1001) AS 사원명 -- DISTINCT는 한번만 보여줘
  FROM EMPLOYEE_TBL;

SELECT GET_NAME(EMP_NO) AS 사원명
  FROM EMPLOYEE_TBL;
  
--------------------------------------트리거

-- 삽입/삭제/수정하면 메시지를 출력하면 메세지 출력 하는 트리거

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER MY_TRIGGER
    AFTER
    INSERT OR DELETE OR UPDATE
    ON DEPARTMENT_TBL
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('하하하하하하');
END;

INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(5, '개발부', '서울');

----------------------- 프로시저
-- 전달된 부서번호의 부서를 삭제하는 프로시저를 작성하시오.
-- 전달된 부서에 근무하는 모든 사원을 함께 삭제하시오.
CREATE OR REPLACE PROCEDURE DELETE_PROC(DEPTNO IN DEPARTMENT_TBL.DEPT_NO%TYPE)
IS
BEGIN
    DELETE 
      FROM EMPLOYEE_TBL
     WHERE DEPART = DEPTNO;
    DELETE
      FROM DEPARTMENT_TBL
     WHERE DEPT_NO = DEPTNO;
    COMMIT;
EXCEPTION
     WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        ROLLBACK;           -- 언제 예외 발생 할 지 모르니 예외 발생 되면 롤백 해야함
END;

EXECUTE DELETE_PROC(1123123);


