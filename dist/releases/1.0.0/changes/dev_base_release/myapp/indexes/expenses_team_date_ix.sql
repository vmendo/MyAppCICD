-- liquibase formatted sql
-- changeset MYAPP:1782295130221 stripComments:false  logicalFilePath:dev_base_release/myapp/indexes/expenses_team_date_ix.sql
-- sqlcl_snapshot src/database/myapp/indexes/expenses_team_date_ix.sql:null:896d222bee876bcc0465ca7f51b67c5adbdc0bf4:create

create index expenses_team_date_ix on
    expenses (
        team_id,
        expense_date
    );

