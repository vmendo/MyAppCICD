-- liquibase formatted sql
-- changeset MYAPP:1782295130556 stripComments:false  logicalFilePath:dev_base_release/myapp/ref_constraints/games_team_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/games_team_fk.sql:null:f98e9a1b1f7d17e3843aa618c07c9210876db13f:create

alter table games
    add constraint games_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;

