-- liquibase formatted sql
-- changeset MYAPP:1782896138087 stripComments:false  logicalFilePath:dev_base/myapp/indexes/contracts_player_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/contracts_player_ix.sql:null:b4dba583fb360c1db5697fb9c646a340c0ba1a70:create

create index contracts_player_ix on
    player_contracts (
        player_id
    );

