--изменить оценку абитуриенту
UPDATE etu.grade
SET
    value = $1
    , status = 'final'
WHERE list_id = $2
    AND exam_id = $3;

