-- +migrate Up
CREATE SCHEMA IF NOT EXISTS etu;

CREATE TABLE IF NOT EXISTS etu.faculty (
    faculty_id UUID                  DEFAULT uuid_generate_v4() PRIMARY KEY
    , name     VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS etu.department (
    department_id UUID                  DEFAULT uuid_generate_v4() PRIMARY KEY
    , name        VARCHAR(255) NOT NULL UNIQUE
    , faculty_id  UUID         NOT NULL REFERENCES etu.faculty(faculty_id)
);

CREATE TABLE IF NOT EXISTS etu.educational_stream (
    stream_id UUID                 DEFAULT uuid_generate_v4() PRIMARY KEY
    , number  VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS etu.group (
    group_id    UUID                 DEFAULT uuid_generate_v4() PRIMARY KEY
    , number    VARCHAR(10) NOT NULL 
    , stream_id UUID        NOT NULL REFERENCES etu.educational_stream(stream_id)

    , CONSTRAINT uniq_group_number_stream_id UNIQUE(number, stream_id)
);

CREATE TABLE IF NOT EXISTS etu.applicant (
    applicant_id    UUID                 DEFAULT uuid_generate_v4() PRIMARY KEY
    , name          VARCHAR(50) NOT NULL
    , surname       VARCHAR(50) NOT NULL
    , fathername    VARCHAR(50)
    , email         VARCHAR(50)          UNIQUE 
    , list_id       UUID        NOT NULL UNIQUE DEFAULT uuid_generate_v4()
    , department_id UUID        NOT NULL REFERENCES etu.department(department_id)
    , faculty_id    UUID        NOT NULL REFERENCES etu.faculty(faculty_id)
    , group_id  UUID NOT NULL REFERENCES etu.group(group_id)
    , stream_id UUID NOT NULL REFERENCES etu.educational_stream(stream_id)

    , CONSTRAINT applicant_email_check CHECK (email ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$') -- html5 spec regexp
);

CREATE TABLE IF NOT EXISTS etu.subject (
    subject_id UUID                 DEFAULT uuid_generate_v4() PRIMARY KEY
    , name     VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS etu.auditorium (
    auditorium_id UUID              DEFAULT uuid_generate_v4() PRIMARY KEY
    , floor     SMALLINT NOT NULL
    , building  SMALLINT NOT NULL
);

CREATE TABLE IF NOT EXISTS etu.consultation (
    consultation_id     UUID               DEFAULT uuid_generate_v4() PRIMARY KEY
    , subject_id        UUID      NOT NULL REFERENCES etu.subject(subject_id)
    , stream_id         UUID      NOT NULL REFERENCES etu.educational_stream(stream_id)
    , auditorium_id       UUID      NOT NULL REFERENCES etu.auditorium(auditorium_id)
    , scheduled_at      TIMESTAMP NOT NULL
    , to_be_finished_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS etu.exam (
    exam_id             UUID               DEFAULT uuid_generate_v4() PRIMARY KEY
    , subject_id        UUID      NOT NULL REFERENCES etu.subject(subject_id)
    , stream_id         UUID      NOT NULL REFERENCES etu.educational_stream(stream_id)
    , auditorium_id       UUID      NOT NULL REFERENCES etu.auditorium(auditorium_id)
    , scheduled_at      TIMESTAMP NOT NULL
    , to_be_finished_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS etu.grade (
    grade_id  UUID              DEFAULT uuid_generate_v4() PRIMARY KEY
    , value   SMALLINT
    , list_id UUID     NOT NULL REFERENCES etu.applicant(list_id)
    , exam_id UUID     NOT NULL REFERENCES etu.exam(exam_id)
    , status TEXT      NOT NULL -- default??

    , CONSTRAINT grade_value_check CHECK (value BETWEEN 2 AND 5)
    , CONSTRAINT grade_status_check CHECK (status = ANY(ARRAY['appeal'::TEXT, 'final'::TEXT, 'pending'::TEXT]))
);

CREATE TABLE IF NOT EXISTS etu.exam_list_exam (
    list_id   UUID NOT NULL REFERENCES etu.applicant(list_id)
    , exam_id UUID NOT NULL REFERENCES etu.exam(exam_id)
    , status  TEXT NOT NULL -- default??

    , PRIMARY KEY (list_id, exam_id)
    , CONSTRAINT exam_list_exam_status_check CHECK (status = ANY(ARRAY['finished'::TEXT, 'eleminated'::TEXT, 'reexamination'::TEXT]))
);

-- +migrate Down
DROP SCHEMA IF EXISTS etu CASCADE;
