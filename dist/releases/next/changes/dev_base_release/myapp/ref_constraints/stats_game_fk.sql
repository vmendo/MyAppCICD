-- liquibase formatted sql
-- changeset MYAPP:1780473746827 stripComments:false  logicalFilePath:dev_base_release/myapp/ref_constraints/stats_game_fk.sql
-- sqlcl_snapshot src/database/myapp/ref_constraints/stats_game_fk.sql:null:ea3336858991f87e46c9a17cae208e79d363b7a5:create

alter table player_game_stats
    add constraint stats_game_fk
        foreign key ( game_id )
            references games ( game_id )
        enable;

