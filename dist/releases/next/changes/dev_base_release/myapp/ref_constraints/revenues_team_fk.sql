-- liquibase formatted sql
-- changeset MYAPP:1782225971812 stripComments:false  logicalFilePath:dev_base_release/myapp/ref_constraints/revenues_team_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/revenues_team_fk.sql:null:a655fa3a93a82c6777caea28bd2711983a3b20c8:create

alter table revenues
    add constraint revenues_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;

