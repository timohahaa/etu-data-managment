--список групп, которые будут заниматься в заданной аудитории в заданное время

-- consultations
SELECT 
    G.number AS group_number
    , ES.number AS educational_stream_number
    , C.consultation_id AS event_id
    , C.scheduled_at AS scheduled_at
    , C.to_be_finished_at AS to_be_finished_at
FROM etu.auditorium A
JOIN etu.consultation C ON A.auditorium_id = C.auditorium_id
JOIN etu.educational_stream ES ON C.stream_id = ES.stream_id
JOIN etu.group G ON ES.stream_id = G.stream_id
WHERE A.auditorium_id = $1
    AND C.scheduled_at <= $2
    AND C.to_be_finished_at > $2
UNION ALL
-- exams
SELECT 
    G.number AS group_number
    , ES.number AS educational_stream_number
    , E.exam_id AS event_id
    , E.scheduled_at AS scheduled_at
    , E.to_be_finished_at AS to_be_finished_at
FROM etu.auditorium A
JOIN etu.exam E ON A.auditorium_id = E.auditorium_id
JOIN etu.educational_stream ES ON E.stream_id = ES.stream_id
JOIN etu.group G ON ES.stream_id = G.stream_id
WHERE A.auditorium_id = $1
    AND E.scheduled_at <= $2
    AND E.to_be_finished_at > $2;
