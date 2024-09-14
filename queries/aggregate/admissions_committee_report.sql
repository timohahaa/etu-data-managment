--отчета о работе приемной комиссии факультета:
--количество поступающих: на какие кафедры и сколько, 
--количество абитуриентов в каждой группе, 
--в какие дни и где проводятся экзамены,
--сколько сдало на оценки 2, 3, 4 и 5 по предметам

-- applicant count by department
SELECT
    D.name AS department_name
    , COUNT(*) AS applicant_count
FROM etu.applicant A
JOIN etu.department D ON A.department_id = D.department_id
GROUP BY D.department_id;

-- applicant count by group
SELECT
    G.number AS group_number
    , COUNT(*) AS applicant_count
FROM etu.applicant A
JOIN etu.group G ON A.group_id = G.group_id
GROUP BY G.group_id;

-- exams
SELECT 
    S.name AS subject
    , E.scheduled_at::date AS exam_date
    , A.number AS auditorium_number
FROM etu.exam E
JOIN etu.subject S ON E.subject_id = S.subject_id
JOIN etu.auditorium A ON E.auditorium_id = A.auditorium_id;

-- grades by exam
SELECT 
    S.name AS subject
    , COUNT(*) FILTER (WHERE G.value = 2) AS two
    , COUNT(*) FILTER (WHERE G.value = 3) AS three
    , COUNT(*) FILTER (WHERE G.value = 4) AS four
    , COUNT(*) FILTER (WHERE G.value = 5) AS five
FROM etu.grade G
JOIN etu.exam E ON G.exam_id = E.exam_id
JOIN etu.subject S ON E.subject_id = S.subject_id
GROUP BY S.name;
