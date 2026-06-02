-- liquibase formatted sql
-- changeset MYAPP:1780411661945 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/players_status_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/players_status_ix.sql:null:bff8e3adc54d3498ad17e931752e203a2f95603d:create

create index players_status_ix on
    players (
        roster_status
    );

