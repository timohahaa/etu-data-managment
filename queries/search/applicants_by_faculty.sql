-- список абитуриентов на заданный факультет
SELECT 
    name
    , surname
    , fathername
    , email
    , list_id
    , department_id
FROM etu.applicant
WHERE faculty_id = $1;
