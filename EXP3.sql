-- 1. Display the printer information whose price is equal to any one of the printers manufactured by IBM.
SELECT * FROM PRINTER WHERE PRICE IN (SELECT PRICE FROM PRINTER P JOIN PRODUCT_INFO PI ON P.MODEL_NO = PI.MODEL_NO WHERE PI.MAKER = 'IBM');

-- 2. List the laptop details whose screen size is equal to the screen size of 'LP114'.
SELECT * FROM LAPTOP WHERE SCREENSIZE = (SELECT SCREENSIZE FROM LAPTOP WHERE MODEL_NO = 'LP114');

-- 3. Give an example for a correlated sub-query.
SELECT P1.* FROM PC P1 WHERE PRICE > (SELECT AVG(P2.PRICE) FROM PC P2 WHERE P2.SPEED = P1.SPEED);

-- 4. List the printer details whose price is greater than any other printer.
SELECT * FROM PRINTER WHERE PRICE > ANY (SELECT PRICE FROM PRINTER);

-- 5. Solve the above query without using ANY or ALL operators.
SELECT *m FROM PRINTER WHERE PRICE > (SELECT MIN(PRICE) FROM PRINTER);

-- 6. For each value of RAM, list the number of PCs.
SELECT RAM, COUNT(*) AS NUMBER_OF_PCS FROM PC GROUP BY RAM;

-- 7. For each value of HD, list the number of PCs.
SELECT HD, COUNT(*) AS NUMBER_OF_PCS FROM PC GROUP BY HD;

-- 8. List the HD values for which the number of PCs is more than 2.
SELECT HD, COUNT(*) AS NUMBER_OF_PCS FROM PC GROUP BY HD HAVING COUNT(*) > 2;

-- 9. List the details of the senior most worker and junior most worker.
SELECT * FROM WORKER WHERE AGE = (SELECT MAX(AGE) FROM WORKER OR AGE = (SELECT MIN(AGE) FROM WORKER);

-- UPDATE OPERATIONS

-- 1(a). Increase price by 12% for InkJet printers.
UPDATE PRINTER SET PRICE = PRICE * 1.12 WHERE TYPE = 'INK';

-- 1(b). Increase price by 14% for Dot Matrix printers.
UPDATE PRINTER SET PRICE = PRICE * 1.14 WHERE TYPE = 'DOT';

-- 1(c). Increase price by 10% for Laser printers.
UPDATE PRINTER SET PRICE = PRICE * 1.10 WHERE TYPE = 'LASER';

-- 1(d). Increase all printer prices using a single UPDATE statement.
UPDATE PRINTER
SET PRICE = CASE WHEN TYPE = 'INK' THEN PRICE * 1.12
        WHEN TYPE = 'DOT' THEN PRICE * 1.14
        WHEN TYPE = 'LASER' THEN PRICE * 1.10
        ELSE PRICE END;

-- 2. Increase laptop price by 12.33% for speed >= 2 and manufactured by HCL or IBM.
UPDATE LAPTOP
SET PRICE = PRICE * 1.1233 WHERE SPEED >= 2
AND MODEL_NO IN (SELECT MODEL_NO FROM PRODUCT_INFO  WHERE MAKER IN ('HCL', 'IBM'));

-- 3. Insert PC rows into LAPTOP with LPxxx model number, screen size 17 and price > 15000.
INSERT INTO LAPTOP
       (MODEL_NO, SPEED, RAM, HD, SCREENSIZE, PRICE)
SELECT REPLACE(MODEL_NO, 'PC', 'LP'), SPEED, RAM, HD, 17,PRICE
FROM PC WHERE PRICE > 15000;


-- 5. Example of UPDATE using a built-in function.
UPDATE PC SET PRICE = ROUND(PRICE * 1.10);

-- JOINS

-- 1. Give an example for a Cartesian join.
SELECT * FROM WORKER CROSS JOIN WORKERSKILL;

-- 2. Give an example for a Cartesian join involving 3 tables.
SELECT * FROM PRODUCT_INFO CROSS JOIN PC CROSS JOIN LAPTOP;

-- 3. List name, age and skill for workers whose age is greater than 30 using equi join.
SELECT W.NAME, W.AGE, WS.SKILL
FROM WORKER W
JOIN WORKERSKILL WS
ON W.NAME = WS.NAME
WHERE W.AGE > 30;

-- 4. Give an example for a non-equi join.
SELECT W.NAME, W.AGE, P.MODEL_NO, P.PRICE
FROM WORKER W
JOIN PC P
ON W.AGE > P.SPEED;

-- 5. List distinct combinations of PC models whose HD capacities are same using self join.
SELECT DISTINCT P1.MODEL_NO AS MODEL1,
                P2.MODEL_NO AS MODEL2
FROM PC P1
JOIN PC P2
ON P1.HD = P2.HD
AND P1.MODEL_NO < P2.MODEL_NO;

-- 6. Display manufacturers of PC along with model and price using inner join.
SELECT PI.MAKER, P.MODEL_NO, P.PRICE
FROM PRODUCT_INFO PI
INNER JOIN PC P
ON PI.MODEL_NO = P.MODEL_NO;

-- 7. List laptop and PC pairs whose price is same.
SELECT P.MODEL_NO AS PC_MODEL,
       L.MODEL_NO AS LAPTOP_MODEL
FROM PC P
INNER JOIN LAPTOP L
ON P.PRICE = L.PRICE;

-- 8(a). Example for LEFT OUTER JOIN.
SELECT PI.MODEL_NO, PI.MAKER, P.PRICE
FROM PRODUCT_INFO PI
LEFT OUTER JOIN PC P
ON PI.MODEL_NO = P.MODEL_NO;

-- 8(b). Example for RIGHT OUTER JOIN.
SELECT PI.MODEL_NO, PI.MAKER, P.PRICE
FROM PRODUCT_INFO PI
RIGHT OUTER JOIN PC P
ON PI.MODEL_NO = P.MODEL_NO;

-- 8(c). Example for FULL OUTER JOIN.
SELECT PI.MODEL_NO, PI.MAKER, P.PRICE
FROM PRODUCT_INFO PI
FULL OUTER JOIN PC P
ON PI.MODEL_NO = P.MODEL_NO;

-- 9. Example of NVL function used effectively in outer join.
SELECT PI.MODEL_NO,
       PI.MAKER,
       NVL(P.PRICE, 0) AS PRICE
FROM PRODUCT_INFO PI
LEFT OUTER JOIN PC P
ON PI.MODEL_NO = P.MODEL_NO;
