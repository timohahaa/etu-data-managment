-- +migrate Up

-- +migrate StatementBegin
DO $$
    BEGIN
        CREATE USER secretary WITH PASSWORD 'password' LOGIN;
        EXCEPTION WHEN DUPLICATE_OBJECT THEN
            RAISE NOTICE 'not creating role secretary -- it already exists';
    END
$$;
-- +migrate StatementEnd

-- +migrate StatementBegin
DO $$
    BEGIN
        CREATE USER worker WITH PASSWORD 'password' LOGIN;
        EXCEPTION WHEN DUPLICATE_OBJECT THEN
            RAISE NOTICE 'not creating role worker -- it already exists';
    END
$$;
-- +migrate StatementEnd

-- +migrate Down
