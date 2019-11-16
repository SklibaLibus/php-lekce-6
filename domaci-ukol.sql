/* 1. Vypište všechny učitele kteří neučí žádný předmět */

SELECT teacher.name AS ucitel
FROM teacher
LEFT JOIN class_subject ON class_subject.teacher_id = teacher.id
LEFT JOIN subject ON subject.id = class_subject.subject_id
WHERE subject.name IS NULL
GROUP BY teacher.name;

/* 2. Vypište všechny žáky, kteří mají alespoň jednu 5 a zároveň vypište kolik jich mají */

/*SELECT pupil.name, grade, COUNT(*)
FROM pupil
JOIN pupil_subject ON pupil_subject.pupil_id = pupil.id
WHERE grade = 5
GROUP BY name*/

SELECT pupil.name, COUNT(*)
FROM pupil
JOIN pupil_subject ON pupil_subject.pupil_id = pupil.id
WHERE grade = 5
GROUP BY name;

/* 3. Vypište průměr pro každou třídu */

SELECT class.name, AVG(grade) FROM class
JOIN pupil ON pupil.class_id = class.id
JOIN pupil_subject ON pupil_subject.pupil_id = pupil.id
GROUP BY class.id;

/* 4. Vypiště průměr pro každý ročník */

SELECT year AS rocnik, AVG(grade) AS prumer_znamek FROM class
JOIN pupil ON pupil.class_id = class.id
JOIN pupil_subject ON pupil_subject.pupil_id = pupil.id
GROUP BY year;

/* 5. Vypište všechny učitele, kteří učí svojí třídu alespoň na jeden předmět */

SELECT homeroom_teacher_id, class_id, s.id AS id_predmetu, t.id AS id_ucitele, t.name
FROM teacher t
JOIN class_subject cs ON cs.teacher_id = t.id
JOIN subject s ON cs.subject_id = s.id
JOIN class c ON cs.class_id = c.id
WHERE homeroom_teacher_id = t.id; /* původně jsem tu měla: GROUP BY id_ucitele, snažila jsem se z té tabulky zjistit
                                     jak určit učitele podle zadání, vůbec mi nedošlo, žs stačí, porovnat ty dvě hodnoty */

/* 6. Vypište průměrnou známku pro každý předmět a ročník */

SELECT s.name AS subject, c.year, AVG(ps.grade) AS avg_grade
FROM class c
JOIN pupil p ON p.class_id = c.id
JOIN pupil_subject ps ON ps.pupil_id = p.id
JOIN subject s ON s.id = ps.subject_id
GROUP BY c.year, s.id
ORDER BY subject, year;

SELECT subject.name, AVG(grade) FROM class /* průměr pro každý předmět, špatně jsem si vyložila zadání úkolu */
JOIN class_subject ON class_subject.class_id = class.id
JOIN subject ON subject.id = class_subject.subject_id
JOIN pupil_subject ON pupil_subject.subject_id = subject.id
GROUP BY subject.name;

/* 7. Vypište hitpárádu 5 lidumilů a 5 drsňáků, tj. 5 učitelů s nejlepší průměrem známek na předmětech,
      které učí a 5 učitelů s nejhorším průměrem známek), tento úkol jsem vůbec neměla */

SELECT t.name AS teacher, AVG(ps.grade) AS avg_grade
FROM teacher t
JOIN class_subject cs ON cs.teacher_id = t.id
JOIN subject s ON s.id = cs.subject_id
JOIN pupil_subject ps ON ps.subject_id = s.id
GROUP BY t.id
ORDER BY avg_grade
LIMIT 5;

SELECT t.name AS teacher, AVG(ps.grade) AS avg_grade
FROM teacher t
JOIN class_subject cs ON cs.teacher_id = t.id
JOIN subject s ON s.id = cs.subject_id
JOIN pupil_subject ps ON ps.subject_id = s.id
GROUP BY t.id
ORDER BY avg_grade DESC
LIMIT 5;