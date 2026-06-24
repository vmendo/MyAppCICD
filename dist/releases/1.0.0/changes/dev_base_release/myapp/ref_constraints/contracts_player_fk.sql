-- liquibase formatted sql
-- changeset MYAPP:1782295130508 stripComments:false  logicalFilePath:dev_base_release/myapp/ref_constraints/contracts_player_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/contracts_player_fk.sql:null:9ab0eb40da8f1342f8dd4b275baf28300859b05c:create

alter table player_contracts
    add constraint contracts_player_fk
        foreign key ( player_id )
            references players ( player_id )
        enable;

