-- liquibase formatted sql
-- changeset MYAPP:1781168880768 stripComments:false  logicalFilePath:dev_version_1/myapp/indexes/training_team_date_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/training_team_date_ix.sql:null:bc0cc71930fee1481e4639c7c2d7ead1f106b951:create

create index training_team_date_ix on
    training_sessions (
        team_id,
        session_date
    );

