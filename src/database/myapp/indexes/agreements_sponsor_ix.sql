create index agreements_sponsor_ix on
    sponsor_agreements (
        sponsor_id
    );


-- sqlcl_snapshot {"hash":"c8ac7794e4a8285ad2acdb94ec04669799242251","type":"INDEX","name":"AGREEMENTS_SPONSOR_IX","schemaName":"MYAPP","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>MYAPP</SCHEMA>\n   <NAME>AGREEMENTS_SPONSOR_IX</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>MYAPP</SCHEMA>\n         <NAME>SPONSOR_AGREEMENTS</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>SPONSOR_ID</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      \n   </TABLE_INDEX>\n</INDEX>"}