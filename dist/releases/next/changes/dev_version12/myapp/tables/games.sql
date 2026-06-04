-- liquibase formatted sql
-- changeset MYAPP:1780576003451 stripComments:false  logicalFilePath:dev_version12/myapp/tables/games.sql
-- sqlcl_snapshot src/database/myapp/tables/games.sql:cfe0aaa7f3b7e5bf44b2f83efbe626d080f491fd:4bb0763bd974686eff4a95db28c78b4e589759a8:alter

alter table games add (
    attendance number(7, 0)
)
/

alter table games add (
    ticket_revenue_amount number(12, 2)
)
/

alter table games
    add constraint games_attendance_ck
        check ( attendance is null
                or attendance >= 0 ) enable
/

alter table games
    add constraint games_ticket_rev_ck
        check ( ticket_revenue_amount is null
                or ticket_revenue_amount >= 0 ) enable
/

