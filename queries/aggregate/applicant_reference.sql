--справка о том, что данный
--абитуриент поступает в институт на факультет
SELECT
    A.name AS applicant_name
    , A.surname AS applicant_surname
    , COALESCE(A.fathername, 'no-fathername') AS applicant_fathername
    , F.name AS faculty_name
FROM etu.applicant A
JOIN etu.faculty F ON A.faculty_id = F.faculty_id
WHERE A.applicant_id = $1;
