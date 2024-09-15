-- дата консультации и экзамена для абитуриента по данному предмету
SELECT
    E.scheduled_at::date AS exam_date
    , C.scheduled_at::date AS consultation_date
FROM etu.applicant A
LEFT JOIN etu.consultation C ON C.stream_id = A.stream_id
LEFT JOIN etu.exam E ON E.stream_id = A.stream_id
WHERE A.applicant_id = $1
    AND (C.subject_id = $2 OR E.subject_id = $2);
