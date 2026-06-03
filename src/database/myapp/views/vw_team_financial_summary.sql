create or replace force editionable view vw_team_financial_summary (
    team_id,
    financial_month,
    revenue_amount,
    expense_amount,
    net_amount
) as
    select
        team_id,
        financial_month,
        sum(revenue_amount)                       as revenue_amount,
        sum(expense_amount)                       as expense_amount,
        sum(revenue_amount) - sum(expense_amount) as net_amount
    from
        (
            select
                team_id,
                trunc(revenue_date, 'MM') as financial_month,
                amount                    as revenue_amount,
                0                         as expense_amount
            from
                revenues
            union all
            select
                team_id,
                trunc(expense_date, 'MM') as financial_month,
                0                         as revenue_amount,
                amount                    as expense_amount
            from
                expenses
        )
    group by
        team_id,
        financial_month;


-- sqlcl_snapshot {"hash":"06678f51e3e28f15f13306e177bcd301d6f7d523","type":"VIEW","name":"VW_TEAM_FINANCIAL_SUMMARY","schemaName":"MYAPP","sxml":""}