-- 	1.	Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre; 
-- 	2.	Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
-- 	3.	Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona WHERE YEAR(fecha_nacimiento) = 1999 AND tipo = 'alumno';
-- 	4.	Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.
SELECT * FROM persona WHERE telefono IS NULL AND tipo = 'profesor'AND nif LIKE '%k';
-- 	5.	Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura WHERE id_grado = 7 AND cuatrimestre = 1 AND curso = 3;
-- 	6.	Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS 'nombre departamento' FROM persona INNER JOIN profesor ON persona.id = profesor.id_profesor INNER JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY persona.apellido1, persona.apellido2, persona.nombre;
-- 	7.	Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM asignatura INNER JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura INNER JOIN curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar INNER JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id WHERE persona.nif = '26902806M';
-- 	8.	Retorna un llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT departamento.nombre FROM departamento INNER JOIN profesor ON departamento.id = profesor.id_departamento INNER JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor INNER JOIN grado ON grado.id = asignatura.id_grado WHERE grado.id = 4;
-- 	9.	Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT persona.apellido1, persona.apellido2, persona.nombre FROM persona INNER JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id INNER JOIN curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar WHERE curso_escolar.id = 5;
--  Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 	1.	Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT departamento.nombre AS 'nombre departamento', persona.apellido1, persona.apellido2, persona.nombre FROM persona RIGHT JOIN profesor ON profesor.id_profesor = persona.id LEFT JOIN departamento ON departamento.id = profesor.id_departamento ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;
-- 	2.	Retorna un llistat amb els professors que no estan associats a un departament.
SELECT  persona.nombre, persona.apellido1, persona.apellido2 FROM persona RIGHT JOIN profesor ON profesor.id_profesor = persona.id LEFT JOIN departamento ON departamento.id = profesor.id_departamento WHERE departamento.id IS NULL;
-- 	3.	Retorna un llistat amb els departaments que no tenen professors associats.
SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON profesor.id_departamento = departamento.id WHERE profesor.id_departamento IS NULL;
-- 	4.	Retorna un llistat amb els professors que no imparteixen cap assignatura.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona RIGHT JOIN profesor ON profesor.id_profesor = persona.id LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor WHERE asignatura.nombre IS NULL;
-- 	5.	Retorna un llistat amb les assignatures que no tenen un professor assignat.
SELECT asignatura.nombre FROM asignatura LEFT JOIN profesor ON profesor.id_profesor = asignatura.id_profesor WHERE profesor.id_profesor IS NULL;
-- 	6.	Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT departamento.nombre FROM departamento LEFT JOIN profesor ON profesor.id_departamento = departamento.id LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor LEFT JOIN curso_escolar ON curso_escolar.id = asignatura.curso WHERE curso_escolar.id IS NULL;
--  Consultes resum:
-- 	1.	Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(id) AS 'total alumnos' FROM persona WHERE tipo = 'alumno';
-- 	2.	Calcula quants alumnes van néixer en 1999.
SELECT COUNT(id) AS 'total alumnos 1999' FROM persona WHERE YEAR(fecha_nacimiento) = 1999;
-- 	3.	Calcula quants professors hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors associats i haurà d'estar ordenat de major a menor pel nombre de professors.
SELECT departamento.nombre, COUNT(persona.id) AS 'total profesores' FROM persona INNER JOIN profesor ON profesor.id_profesor = persona.id INNER JOIN departamento ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY COUNT(persona.id) DESC;
-- 	4.	Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT departamento.nombre, COUNT(persona.id) AS 'total profesores' FROM persona RIGHT JOIN profesor ON profesor.id_profesor = persona.id RIGHT JOIN departamento ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre;
-- 	5.	Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingui en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d’assignatures.
SELECT grado.nombre, COUNT(asignatura.id_grado) AS 'total asignaturas' FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY COUNT(asignatura.id_grado) DESC;
-- 	6.	Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre, COUNT(asignatura.id_grado) FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.id_grado) > 40;
-- 	7.	Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT grado.nombre, asignatura.tipo AS 'tipos de asignatura', SUM(asignatura.creditos) AS 'total créditos' FROM grado INNER JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo;
-- 	8.	Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT curso_escolar.anyo_inicio AS 'año inicio', COUNT(DISTINCT id_alumno) AS 'alumnos' FROM alumno_se_matricula_asignatura INNER JOIN curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar GROUP BY curso_escolar.anyo_inicio;
-- 	9.	Retorna un llistat amb el nombre d'assignatures que imparteix cada professor. El llistat ha de tenir en compte aquells professors que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d’assignatures.
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id) AS 'total asignaturas' FROM asignatura RIGHT JOIN persona ON persona.id = asignatura.id_profesor WHERE persona.tipo = 'profesor' GROUP BY persona.id ORDER BY COUNT(asignatura.id) DESC;
-- 	10.	Retorna totes les dades de l'alumne més jove.
SELECT * FROM persona WHERE fecha_nacimiento = (SELECT MAX(DATE(fecha_nacimiento)) FROM persona);
-- 	11.	Retorna un llistat amb els professors que tenen un departament associat i que no imparteixen cap assignatura.
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, profesor.id_departamento FROM persona INNER JOIN profesor ON profesor.id_profesor = persona.id LEFT JOIN asignatura ON asignatura.id_profesor = persona.id WHERE asignatura.id_profesor IS NULL;

