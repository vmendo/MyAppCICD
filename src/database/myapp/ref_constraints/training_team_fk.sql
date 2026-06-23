alter table training_sessions
    add constraint training_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;


-- sqlcl_snapshot {"hash":"52fae3ecc5ce98e215a2bb04c270eea0391ef52d","type":"REF_CONSTRAINT","name":"TRAINING_TEAM_FK","schemaName":"MYAPP","sxml":""}