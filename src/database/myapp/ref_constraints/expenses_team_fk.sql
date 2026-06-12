alter table expenses
    add constraint expenses_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;


-- sqlcl_snapshot {"hash":"1d6559ea4246b11217269e74c6956eb25012e39b","type":"REF_CONSTRAINT","name":"EXPENSES_TEAM_FK","schemaName":"MYAPP","sxml":""}