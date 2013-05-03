DECLARE
productFound NUMBER;
bFound BOOLEAN;

BEGIN
select count(*) INTO productFound from ott_vodproductcontent where productid=4001;
bFound :=(productFound > 0);

IF productFound= 0  THEN
	DBMS_OUTPUT.PUT_LINE('v_index=');
ELSE
	DBMS_OUTPUT.PUT_LINE('1111');
END IF;

IF (bFound) THEN DBMS_OUTPUT.PUT_LINE('found!');
ELSE DBMS_OUTPUT.PUT_LINE('Nothing!');
END IF;

END;