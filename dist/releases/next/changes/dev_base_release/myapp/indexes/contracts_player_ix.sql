-- liquibase formatted sql
-- changeset MYAPP:1781252834790 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/contracts_player_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/contracts_player_ix.sql:null:b4dba583fb360c1db5697fb9c646a340c0ba1a70:create

create index contracts_player_ix on
    player_contracts (
        player_id
    );

