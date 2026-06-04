-- liquibase formatted sql
-- changeset MYAPP:1780575305957 stripComments:false  logicalFilePath:dev_version11/myapp/tables/expenses.sql
-- sqlcl_snapshot src/database/myapp/tables/expenses.sql:91c21f59a8667a31f5ccbd11bb047a63f944c088:e680059e416d6a3c057761e17d276cde309caba0:alter

/* This script might contain a rename case instead of a drop/add, please review and edit this file to avoid data loss */

alter table expenses add (
    payee_name varchar2(120)
)
/

/*  Uncomment drop statement after ensuring it is performing the correct actions
ALTER TABLE "EXPENSES" DROP ("VENDOR_NAME")
/
*/

