create index expenses_team_date_ix on
    expenses (
        team_id,
        expense_date
    );


-- sqlcl_snapshot {"hash":"896d222bee876bcc0465ca7f51b67c5adbdc0bf4","type":"INDEX","name":"EXPENSES_TEAM_DATE_IX","schemaName":"MYAPP","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>MYAPP</SCHEMA>\n   <NAME>EXPENSES_TEAM_DATE_IX</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>MYAPP</SCHEMA>\n         <NAME>EXPENSES</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>TEAM_ID</NAME>\n         </COL_LIST_ITEM>\n         <COL_LIST_ITEM>\n            <NAME>EXPENSE_DATE</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      \n   </TABLE_INDEX>\n</INDEX>"}