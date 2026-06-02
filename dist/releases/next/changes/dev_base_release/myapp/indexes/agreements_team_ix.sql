-- liquibase formatted sql
-- changeset MYAPP:1780411661793 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/agreements_team_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/agreements_team_ix.sql:null:0add3170606c5f4e29527f5c2e9affe48347209a:create

create index agreements_team_ix on
    sponsor_agreements (
        team_id
    );

