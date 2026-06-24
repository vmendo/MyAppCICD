create index agreements_team_ix on
    sponsor_agreements (
        team_id
    );


-- sqlcl_snapshot {"hash":"0add3170606c5f4e29527f5c2e9affe48347209a","type":"INDEX","name":"AGREEMENTS_TEAM_IX","schemaName":"MYAPP","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>MYAPP</SCHEMA>\n   <NAME>AGREEMENTS_TEAM_IX</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>MYAPP</SCHEMA>\n         <NAME>SPONSOR_AGREEMENTS</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>TEAM_ID</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      \n   </TABLE_INDEX>\n</INDEX>"}