-- liquibase formatted sql
-- changeset MYAPP:1780416737618 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/stats_game_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/stats_game_ix.sql:null:ea59445a90ee2449a4deb82cebfcebf2611f6d66:create

create index stats_game_ix on
    player_game_stats (
        game_id
    );

