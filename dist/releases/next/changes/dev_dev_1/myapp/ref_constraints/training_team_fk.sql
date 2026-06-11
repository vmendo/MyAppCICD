-- liquibase formatted sql
-- changeset MYAPP:1781172401773 stripComments:false  logicalFilePath:dev_dev_1/myapp/ref_constraints/training_team_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/training_team_fk.sql:null:52fae3ecc5ce98e215a2bb04c270eea0391ef52d:create

alter table training_sessions
    add constraint training_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;

