-- liquibase formatted sql
-- changeset MYAPP:1780416737484 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/contracts_status_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/contracts_status_ix.sql:null:90087b79187a097c3efceddeab51c7fc4b237397:create

create index contracts_status_ix on
    player_contracts (
        contract_status
    );

