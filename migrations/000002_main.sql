-- +migrate Up
CREATE SCHEMA IF NOT EXISTS etu;

CREATE TABLE IF NOT EXISTS etu.faculty (
    faculty_id UUID                  DEFAULT uuid_generate_v4() PRIMARY KEY
    , name     VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS etu.department (
    department_id UUID                  DEFAULT uuid_generate_v4() PRIMARY KEY
    , name        VARCHAR(255) NOT NULL
    , faculty_id  UUID         NOT NULL REFERENCES etu.faculty(faculty_id)
);

CREATE TABLE IF NOT EXISTS etu.educational_stream (
    stream_id UUID                 DEFAULT uuid_generate_v4() PRIMARY KEY
    , number  VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS etu.group (
    group_id    UUID                 DEFAULT uuid_generate_v4() PRIMARY KEY
    , number    VARCHAR(10) NOT NULL
    , stream_id UUID        NOT NULL REFERENCES etu.educational_stream(stream_id)
);

CREATE TABLE IF NOT EXISTS etu.exam_list (
    list_id    UUID          DEFAULT uuid_generate_v4() PRIMARY KEY
    , group_id UUID NOT NULL REFERENCES etu.group(group_id)
);

CREATE TABLE IF NOT EXISTS etu.applicant (
    applicant_id    UUID                 DEFAULT uuid_generate_v4() PRIMARY KEY
    , name          VARCHAR(50) NOT NULL
    , surname       VARCHAR(50) NOT NULL
    , fathername    VARCHAR(50)
    , email         VARCHAR(50)
    , list_id       UUID        NOT NULL REFERENCES etu.exam_list(list_id)
    , department_id UUID        NOT NULL REFERENCES etu.department(department_id)
    , faculty_id    UUID        NOT NULL REFERENCES etu.faculty(faculty_id)
);

CREATE TABLE IF NOT EXISTS etu.subject (
    subject_id UUID                 DEFAULT uuid_generate_v4() PRIMARY KEY
    , name     VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS etu.auditory (
    auditory_id UUID              DEFAULT uuid_generate_v4() PRIMARY KEY
    , floor     SMALLINT NOT NULL
    , building  SMALLINT NOT NULL
);

CREATE TABLE IF NOT EXISTS etu.consultation (
    consultation_id     UUID               DEFAULT uuid_generate_v4() PRIMARY KEY
    , subject_id        UUID      NOT NULL REFERENCES etu.subject(subject_id)
    , stream_id         UUID      NOT NULL REFERENCES etu.educational_stream(stream_id)
    , auditory_id       UUID      NOT NULL REFERENCES etu.auditory(auditory_id)
    , scheduled_at      TIMESTAMP NOT NULL
    , to_be_finished_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS etu.exam (
    exam_id             UUID               DEFAULT uuid_generate_v4() PRIMARY KEY
    , subject_id        UUID      NOT NULL REFERENCES etu.subject(subject_id)
    , stream_id         UUID      NOT NULL REFERENCES etu.educational_stream(stream_id)
    , auditory_id       UUID      NOT NULL REFERENCES etu.auditory(auditory_id)
    , scheduled_at      TIMESTAMP NOT NULL
    , to_be_finished_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS etu.grade (
    grade_id  UUID              DEFAULT uuid_generate_v4() PRIMARY KEY
    , value   SMALLINT
    , list_id UUID     NOT NULL REFERENCES etu.exam_list(list_id)
    , exam_id UUID     NOT NULL REFERENCES etu.exam(exam_id)
    , status TEXT      NOT NULL -- default??
);

CREATE TABLE IF NOT EXISTS etu.exam_list_exam (
    list_id   UUID NOT NULL REFERENCES etu.exam_list(list_id)
    , exam_id UUID NOT NULL REFERENCES etu.exam(exam_id)
    , status  TEXT NOT NULL -- default??

    , PRIMARY KEY (list_id, exam_id)
);

-- +migrate Down
DROP SCHEMA IF EXISTS etu CASCADE;
