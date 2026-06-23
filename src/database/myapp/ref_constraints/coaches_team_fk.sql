alter table coaches
    add constraint coaches_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;


-- sqlcl_snapshot {"hash":"a7c50a26919032acfc097da01c1f9b65b9337c7e","type":"REF_CONSTRAINT","name":"COACHES_TEAM_FK","schemaName":"MYAPP","sxml":""}