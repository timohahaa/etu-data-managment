--ввести информацию о новом абитуриенте
INSERT INTO etu.applicant (
    name
    , surname
    , fathername
    , email
    , faculty_id
    , group_id
    , stream_id
) VALUES (
    $1, $2, $3, $4, $5, $6, $7
);

-- если не создан факультет
INSERT INTO etu.faculty (name) VALUES ($1);

-- если не создана кафедра
INSERT INTO etu.department (name, faculty_id) VALUES ($1, $2);

-- если не создан поток
INSERT INTO etu.educational_stream (number) VALUES ($1);

-- если не создана группа
INSERT INTO etu.group (number, stream_id) VALUES ($1, $2);
