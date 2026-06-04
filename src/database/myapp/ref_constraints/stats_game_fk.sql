alter table player_game_stats
    add constraint stats_game_fk
        foreign key ( game_id )
            references games ( game_id )
        enable;


-- sqlcl_snapshot {"hash":"ea3336858991f87e46c9a17cae208e79d363b7a5","type":"REF_CONSTRAINT","name":"STATS_GAME_FK","schemaName":"MYAPP","sxml":""}