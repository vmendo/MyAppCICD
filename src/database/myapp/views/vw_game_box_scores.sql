create or replace force editionable view vw_game_box_scores (
    game_id,
    team_id,
    opponent_name,
    game_date,
    venue_type,
    team_score,
    opponent_score,
    players_with_stats,
    total_player_points,
    total_rebounds,
    total_assists,
    total_turnovers
) as
    select
        g.game_id,
        g.team_id,
        g.opponent_name,
        g.game_date,
        g.venue_type,
        g.team_score,
        g.opponent_score,
        count(s.stat_id) as players_with_stats,
        sum(s.points)    as total_player_points,
        sum(s.rebounds)  as total_rebounds,
        sum(s.assists)   as total_assists,
        sum(s.turnovers) as total_turnovers
    from
        games             g
        left join player_game_stats s on s.game_id = g.game_id
    group by
        g.game_id,
        g.team_id,
        g.opponent_name,
        g.game_date,
        g.venue_type,
        g.team_score,
        g.opponent_score;


-- sqlcl_snapshot {"hash":"8cec7be6e9e7c343806b9ce55a9750af8d88b7be","type":"VIEW","name":"VW_GAME_BOX_SCORES","schemaName":"MYAPP","sxml":""}