-- liquibase formatted sql
-- changeset MYAPP:1780473746582 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/revenues_team_date_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/revenues_team_date_ix.sql:null:e38aa6d0eaade00f7b188fc80940932e200eb7da:create

create index revenues_team_date_ix on
    revenues (
        team_id,
        revenue_date
    );

