alter table players
    add constraint players_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;


-- sqlcl_snapshot {"hash":"b0a25fd89617b81b8f42296861dcd22d77f8440f","type":"REF_CONSTRAINT","name":"PLAYERS_TEAM_FK","schemaName":"MYAPP","sxml":""}