-- liquibase formatted sql
-- changeset MYAPP:1780576002633 stripComments:false  logicalFilePath:dev_version12/myapp/indexes/injury_player_date_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/injury_player_date_ix.sql:null:c3e9605b2feb745dc030317f7e44d8bc4966c8c0:create

create index injury_player_date_ix on
    injury_reports (
        player_id,
        reported_date
    );

