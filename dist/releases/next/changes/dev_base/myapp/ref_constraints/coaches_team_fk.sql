-- liquibase formatted sql
-- changeset MYAPP:1782896138338 stripComments:false  logicalFilePath:dev_base/myapp/ref_constraints/coaches_team_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/coaches_team_fk.sql:null:a7c50a26919032acfc097da01c1f9b65b9337c7e:create

alter table coaches
    add constraint coaches_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;

