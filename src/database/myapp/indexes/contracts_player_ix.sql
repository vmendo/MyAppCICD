create index contracts_player_ix on
    player_contracts (
        player_id
    );


-- sqlcl_snapshot {"hash":"b4dba583fb360c1db5697fb9c646a340c0ba1a70","type":"INDEX","name":"CONTRACTS_PLAYER_IX","schemaName":"MYAPP","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>MYAPP</SCHEMA>\n   <NAME>CONTRACTS_PLAYER_IX</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>MYAPP</SCHEMA>\n         <NAME>PLAYER_CONTRACTS</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>PLAYER_ID</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      \n   </TABLE_INDEX>\n</INDEX>"}