create index stats_game_ix on
    player_game_stats (
        game_id
    );


-- sqlcl_snapshot {"hash":"ea59445a90ee2449a4deb82cebfcebf2611f6d66","type":"INDEX","name":"STATS_GAME_IX","schemaName":"MYAPP","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>MYAPP</SCHEMA>\n   <NAME>STATS_GAME_IX</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>MYAPP</SCHEMA>\n         <NAME>PLAYER_GAME_STATS</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>GAME_ID</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      \n   </TABLE_INDEX>\n</INDEX>"}