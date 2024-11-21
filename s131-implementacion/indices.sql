--PARA SENTENCIAS QUE TRABAJAN CON EL CAMPO NOMBRE
CREATE INDEX IDX_LAST_NAME ON EMPLOYEES(LAST_NAME);

--PARA FILTRAR CON EL CAMPO NOMBRE Y EL CAMPO APELLIDO
CREATE INDEX IDX_FULL_NAME 
ON EMPLOYEES(FIRST_NAME, LAST_NAME);

--PARA ELIMINAR UN INDICE
DROP INDEX IDX_LAST_NAME;


--1) CREACION DE LA TABLA DE PRUEBA
CREATE TABLE TABLA_PRUEBA(
	VALOR1 NUMERIC,
	VALOR2 NUMERIC
);

--2) INSERCION DE DATOS
DO $$
BEGIN
	--REALIZAREMOS 500,000 INSERCIONES
	FOR X IN 1..500000 LOOP
		--GENERAMOS VALORES ALEATORIOS ENTRE 1 Y 100,000,000
		INSERT INTO TABLA_PRUEBA VALUES(floor(1 + random() * 100000000), 
									    floor(1 + random() * 100000000));
	END LOOP;
END; $$


--3) PARA CONTRASTAR RESULTADOS UTILIZAMOS "EXPLAIN"
--OBTENDREMOS EL PLAN DE EJECUCION
EXPLAIN ANALYZE
SELECT * FROM TABLA_PRUEBA
WHERE VALOR1 BETWEEN 100 AND 85655;

--4) CREAMOS EL INDICE EN LA TABLA
CREATE INDEX IX_TP_C1 ON TABLA_PRUEBA(VALOR1);

--OBSERVEMOS QUE, SI SE APLICA UNA FUNCION SOBRE EL CAMPO
--EL INDICE NO SE APLICA
EXPLAIN ANALYZE
SELECT * FROM TABLA_PRUEBA
WHERE ROUND(VALOR1) BETWEEN 100 AND 85655;

--PODEMOS CREAR UN INDICE UTILIZANDO 2 CAMPOS DE LA TABLA
CREATE INDEX IX_TP_C2C1 ON TABLA_PRUEBA(VALOR2, VALOR1);

--NOS PERMITIRA OPTIMIZAR LA SIGUIENTE CONSULTA
EXPLAIN ANALYZE
SELECT * FROM TABLA_PRUEBA
WHERE VALOR2 BETWEEN  100 AND 85655
AND VALOR1 BETWEEN 1000 AND 10000;