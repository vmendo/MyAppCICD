-- liquibase formatted sql
-- changeset MYAPP:1780576002706 stripComments:false  logicalFilePath:dev_version12/myapp/ref_constraints/injury_player_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/injury_player_fk.sql:null:5be4ae935facbf60232c3d56acb21b7bcd75aebc:create

alter table injury_reports
    add constraint injury_player_fk
        foreign key ( player_id )
            references players ( player_id )
        enable;

