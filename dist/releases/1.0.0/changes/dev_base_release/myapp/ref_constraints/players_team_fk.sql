-- liquibase formatted sql
-- changeset MYAPP:1780574505635 stripComments:false  logicalFilePath:dev_base_release/myapp/ref_constraints/players_team_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/players_team_fk.sql:null:b0a25fd89617b81b8f42296861dcd22d77f8440f:create

alter table players
    add constraint players_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;

