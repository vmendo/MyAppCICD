-- liquibase formatted sql
-- changeset MYAPP:1781171199463 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/coaches_team_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/coaches_team_ix.sql:null:acb66b14e63de36b98a05d8a7edcfa58b2390051:create

create index coaches_team_ix on
    coaches (
        team_id
    );

