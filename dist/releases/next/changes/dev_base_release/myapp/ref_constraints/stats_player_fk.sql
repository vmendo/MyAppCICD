-- liquibase formatted sql
-- changeset MYAPP:1780574505775 stripComments:false  logicalFilePath:dev_base_release/myapp/ref_constraints/stats_player_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/stats_player_fk.sql:null:807a73cb0e5d652e8223f57c817158064d8e6215:create

alter table player_game_stats
    add constraint stats_player_fk
        foreign key ( player_id )
            references players ( player_id )
        enable;

