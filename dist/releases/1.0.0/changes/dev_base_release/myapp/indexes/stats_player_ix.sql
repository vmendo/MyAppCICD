-- liquibase formatted sql
-- changeset MYAPP:1781168125140 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/stats_player_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/stats_player_ix.sql:null:d2f3697ef56c9990c31f1d45d86e2344b2b3dd08:create

create index stats_player_ix on
    player_game_stats (
        player_id
    );

