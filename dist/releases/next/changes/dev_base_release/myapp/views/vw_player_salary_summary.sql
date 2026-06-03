-- liquibase formatted sql
-- changeset MYAPP:1780473747791 stripComments:false  logicalFilePath:dev_base_release/myapp/views/vw_player_salary_summary.sql
-- sqlcl_snapshot src/database/myapp/views/vw_player_salary_summary.sql:null:785ce4226f169f6c1ebe673e43328144a9a5859a:create

create or replace force editionable view vw_player_salary_summary (
    player_id,
    team_id,
    jersey_number,
    player_name,
    player_position,
    roster_status,
    contract_count,
    active_salary_amount,
    active_bonus_amount
) as
    select
        p.player_id,
        p.team_id,
        p.jersey_number,
        p.first_name
        || ' '
        || p.last_name        as player_name,
        p.player_position,
        p.roster_status,
        count(pc.contract_id) as contract_count,
        sum(
            case
                when pc.contract_status = 'ACTIVE' then
                    pc.salary_amount
                else
                    0
            end
        )                     as active_salary_amount,
        sum(
            case
                when pc.contract_status = 'ACTIVE' then
                    pc.bonus_amount
                else
                    0
            end
        )                     as active_bonus_amount
    from
        players          p
        left join player_contracts pc on pc.player_id = p.player_id
    group by
        p.player_id,
        p.team_id,
        p.jersey_number,
        p.first_name,
        p.last_name,
        p.player_position,
        p.roster_status;

