alter table injury_reports
    add constraint injury_player_fk
        foreign key ( player_id )
            references players ( player_id )
        enable;


-- sqlcl_snapshot {"hash":"5be4ae935facbf60232c3d56acb21b7bcd75aebc","type":"REF_CONSTRAINT","name":"INJURY_PLAYER_FK","schemaName":"MYAPP","sxml":""}