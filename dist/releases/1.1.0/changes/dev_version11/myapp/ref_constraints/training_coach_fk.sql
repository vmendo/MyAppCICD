-- liquibase formatted sql
-- changeset MYAPP:1780575304767 stripComments:false  logicalFilePath:dev_version11/myapp/ref_constraints/training_coach_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/training_coach_fk.sql:null:a6ab1e1dfc347225732ba2f320b63170cc0c8e6b:create

alter table training_sessions
    add constraint training_coach_fk
        foreign key ( lead_coach_id )
            references coaches ( coach_id )
        enable;

