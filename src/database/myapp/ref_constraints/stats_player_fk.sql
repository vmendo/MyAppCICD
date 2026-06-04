alter table player_game_stats
    add constraint stats_player_fk
        foreign key ( player_id )
            references players ( player_id )
        enable;


-- sqlcl_snapshot {"hash":"807a73cb0e5d652e8223f57c817158064d8e6215","type":"REF_CONSTRAINT","name":"STATS_PLAYER_FK","schemaName":"MYAPP","sxml":""}