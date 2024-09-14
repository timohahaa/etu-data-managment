-- полученные оценки для абитуриента
SELECT 
    S.name AS subject_name
    , G.value AS grade
FROM etu.applicant A
JOIN etu.grade G ON G.list_id = A.list_id
JOIN etu.exam E ON E.exam_id = G.exam_id
JOIN etu.subject S ON E.subject_id = S.subject_id
WHERE A.applicant_id = $1;
