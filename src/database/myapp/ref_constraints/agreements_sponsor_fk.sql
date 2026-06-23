alter table sponsor_agreements
    add constraint agreements_sponsor_fk
        foreign key ( sponsor_id )
            references sponsors ( sponsor_id )
        enable;


-- sqlcl_snapshot {"hash":"d6e6767aac61d141665511c3007a2182e7fd7000","type":"REF_CONSTRAINT","name":"AGREEMENTS_SPONSOR_FK","schemaName":"MYAPP","sxml":""}