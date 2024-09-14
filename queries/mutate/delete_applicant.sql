--удалить запись об абитуриенте
DELETE FROM etu.applicant
WHERE applicant_id = $1;
