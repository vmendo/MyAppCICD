-- liquibase formatted sql
-- changeset MYAPP:1782896138068 stripComments:false  logicalFilePath:dev_base/myapp/indexes/coaches_team_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/coaches_team_ix.sql:null:acb66b14e63de36b98a05d8a7edcfa58b2390051:create

create index coaches_team_ix on
    coaches (
        team_id
    );

