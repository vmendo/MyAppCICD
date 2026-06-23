-- liquibase formatted sql
-- changeset MYAPP:1782225971315 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/agreements_sponsor_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/agreements_sponsor_ix.sql:null:c8ac7794e4a8285ad2acdb94ec04669799242251:create

create index agreements_sponsor_ix on
    sponsor_agreements (
        sponsor_id
    );

