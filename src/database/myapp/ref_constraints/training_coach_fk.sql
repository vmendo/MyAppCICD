alter table training_sessions
    add constraint training_coach_fk
        foreign key ( lead_coach_id )
            references coaches ( coach_id )
        enable;


-- sqlcl_snapshot {"hash":"a6ab1e1dfc347225732ba2f320b63170cc0c8e6b","type":"REF_CONSTRAINT","name":"TRAINING_COACH_FK","schemaName":"MYAPP","sxml":""}