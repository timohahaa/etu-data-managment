-- +migrate Up

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA etu TO admin;

GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA etu           TO secretary;
GRANT DELETE                 ON TABLE                etu.applicant TO secretary;

GRANT SELECT         ON ALL TABLES IN SCHEMA etu                TO worker;
GRANT INSERT, UPDATE ON TABLE                etu.applicant      TO worker;
GRANT INSERT         ON TABLE                etu.exam           TO worker;
GRANT INSERT         ON TABLE                etu.exam_list_exam TO worker;
GRANT INSERT         ON TABLE                etu.grade          TO worker;

-- +migrate Down
REVOKE SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA etu FROM admin;

REVOKE SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA etu           FROM secretary;
REVOKE DELETE                 ON TABLE                etu.applicant FROM secretary;

REVOKE SELECT         ON ALL TABLES IN SCHEMA etu                FROM worker;
REVOKE INSERT, UPDATE ON TABLE                etu.applicant      FROM worker;
REVOKE INSERT         ON TABLE                etu.exam           FROM worker;
REVOKE INSERT         ON TABLE                etu.exam_list_exam FROM worker;
REVOKE INSERT         ON TABLE                etu.grade          FROM worker;
