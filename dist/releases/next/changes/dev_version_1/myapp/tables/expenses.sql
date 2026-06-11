-- liquibase formatted sql
-- changeset MYAPP:1781168881823 stripComments:false  logicalFilePath:dev_version_1/myapp/tables/expenses.sql
-- sqlcl_snapshot src/database/myapp/tables/expenses.sql:91c21f59a8667a31f5ccbd11bb047a63f944c088:e680059e416d6a3c057761e17d276cde309caba0:alter

-- Demo adjustment:
-- SQLcl generated a cautious add/drop pattern for VENDOR_NAME -> PAYEE_NAME.
-- The intended migration is a column rename so existing values are preserved.

ALTER TABLE expenses RENAME COLUMN vendor_name TO payee_name
/
