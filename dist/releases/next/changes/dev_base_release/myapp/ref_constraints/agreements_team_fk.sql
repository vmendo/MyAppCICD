-- liquibase formatted sql
-- changeset MYAPP:1781252835008 stripComments:false  logicalFilePath:dev_base_release/myapp/ref_constraints/agreements_team_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/agreements_team_fk.sql:null:53cdfb5848d37237f5afa3d4d61da77c4b34a851:create

alter table sponsor_agreements
    add constraint agreements_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;

