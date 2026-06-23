alter table games
    add constraint games_team_fk
        foreign key ( team_id )
            references teams ( team_id )
        enable;


-- sqlcl_snapshot {"hash":"f98e9a1b1f7d17e3843aa618c07c9210876db13f","type":"REF_CONSTRAINT","name":"GAMES_TEAM_FK","schemaName":"MYAPP","sxml":""}