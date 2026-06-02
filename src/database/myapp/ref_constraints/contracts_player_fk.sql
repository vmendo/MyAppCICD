alter table player_contracts
    add constraint contracts_player_fk
        foreign key ( player_id )
            references players ( player_id )
        enable;


-- sqlcl_snapshot {"hash":"9ab0eb40da8f1342f8dd4b275baf28300859b05c","type":"REF_CONSTRAINT","name":"CONTRACTS_PLAYER_FK","schemaName":"MYAPP","sxml":""}