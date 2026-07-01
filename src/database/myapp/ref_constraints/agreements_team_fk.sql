alter table sponsor_agreements
    add constraint agreements_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;


-- sqlcl_snapshot {"hash":"53cdfb5848d37237f5afa3d4d61da77c4b34a851","type":"REF_CONSTRAINT","name":"AGREEMENTS_TEAM_FK","schemaName":"MYAPP","sxml":""}