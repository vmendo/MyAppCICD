-- liquibase formatted sql
-- changeset MYAPP:1782226853700 stripComments:false  logicalFilePath:dev_v1/myapp/tables/players.sql
-- sqlcl_snapshot src/database/myapp/tables/players.sql:1f995ddb0b9cec0f110c827eaec20d83626009f7:a406ca948d98df6dba4211cb3c58f7261d953177:alter

alter table players add (
    social_media_handle varchar2(80)
)
/

