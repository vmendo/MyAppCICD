-- liquibase formatted sql
-- changeset MYAPP:1782225971476 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/games_team_date_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/games_team_date_ix.sql:null:b5ddc1e0dd1dd18e3f7d1cf6d6f59ca33f44ca47:create

create index games_team_date_ix on
    games (
        team_id,
        game_date
    );

