-- liquibase formatted sql
-- changeset MYAPP:1780416737662 stripComments:false  logicalFilePath:dev_base_release/myapp/ref_constraints/agreements_sponsor_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/agreements_sponsor_fk.sql:null:d6e6767aac61d141665511c3007a2182e7fd7000:create

alter table sponsor_agreements
    add constraint agreements_sponsor_fk
        foreign key ( sponsor_id )
            references sponsors ( sponsor_id )
        enable;

