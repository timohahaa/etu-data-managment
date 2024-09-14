--номера аудиторий, где будут экзамены у заданной группы
SELECT
    S.name AS subject
    , A.number AS auditorium
    , A.floor
    , A.building
FROM etu.auditorium A
JOIN etu.exam E ON A.auditorium_id = E.auditorium_id
JOIN etu.subject S ON E.subject_id = S.subject_id
JOIN etu.educational_stream ES ON E.stream_id = ES.stream_id
JOIN etu.group G ON ES.stream_id = G.stream_id
WHERE G.group_id = $1;
