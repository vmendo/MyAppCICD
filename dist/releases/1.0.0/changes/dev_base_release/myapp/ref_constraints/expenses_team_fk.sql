-- liquibase formatted sql
-- changeset MYAPP:1782225971731 stripComments:false  logicalFilePath:dev_base_release/myapp/ref_constraints/expenses_team_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/expenses_team_fk.sql:null:1d6559ea4246b11217269e74c6956eb25012e39b:create

alter table expenses
    add constraint expenses_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;

