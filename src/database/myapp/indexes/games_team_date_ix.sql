create index games_team_date_ix on
    games (
        team_id,
        game_date
    );


-- sqlcl_snapshot {"hash":"b5ddc1e0dd1dd18e3f7d1cf6d6f59ca33f44ca47","type":"INDEX","name":"GAMES_TEAM_DATE_IX","schemaName":"MYAPP","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>MYAPP</SCHEMA>\n   <NAME>GAMES_TEAM_DATE_IX</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>MYAPP</SCHEMA>\n         <NAME>GAMES</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>TEAM_ID</NAME>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>GAME_DATE</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      \n   </TABLE_INDEX>\n</INDEX>"}