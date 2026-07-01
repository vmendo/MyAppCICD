-- liquibase formatted sql
-- changeset MYAPP:1782896138207 stripComments:false  logicalFilePath:dev_base/myapp/indexes/players_team_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/players_team_ix.sql:null:3615e71fcd9f771f1366afd7708775f037f77b62:create

create index players_team_ix on
    players (
        team_id
    );

