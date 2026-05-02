CREATE TABLE matches (
    id INT PRIMARY KEY,
    season VARCHAR(20),
    city VARCHAR(50),
    date DATE,
    match_type VARCHAR(50),
    player_of_match VARCHAR(50),
    venue VARCHAR(100),
    team1 VARCHAR(50),
    team2 VARCHAR(50),
    toss_winner VARCHAR(50),
    toss_decision VARCHAR(10),
    winner VARCHAR(50),
    result VARCHAR(50),
    result_margin VARCHAR(20),
    target_runs VARCHAR(20),
    target_overs VARCHAR(20),
    super_over VARCHAR(5),
    method VARCHAR(20),
    umpire1 VARCHAR(50),
    umpire2 VARCHAR(50)
);
CREATE TABLE deliveries (
    match_id INT,
    inning INT,
    batting_team VARCHAR(50),
    bowling_team VARCHAR(50),
    over INT,
    ball INT,
    batter VARCHAR(50),
    bowler VARCHAR(50),
    non_striker VARCHAR(50),
    batsman_runs INT,
    extra_runs INT,
    total_runs INT,
    extras_type VARCHAR(20),
    is_wicket INT,
    player_dismissed VARCHAR(50),
    dismissal_kind VARCHAR(50),
    fielder VARCHAR(50)
);
SELECT COUNT(*) FROM matches;
SELECT COUNT(*) FROM deliveries;

--MOST WINNING TEAMS--
SELECT winner, COUNT(*) AS total_wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY total_wins DESC;

--TOP 10 RUN SCORERS--
SELECT batter, SUM(batsman_runs) AS total_runs
FROM deliveries
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;

--TOP 10 WICKET TAKERS--
SELECT bowler, COUNT(*) AS total_wickets
FROM deliveries
WHERE is_wicket = 1
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;

--TOSS IMPACT--
SELECT
COUNT(*) AS total_matches,
SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS toss_winner_won,
ROUND(SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS win_percentage
FROM matches;

--PLAYER OF THE MATCH AWARD--
SELECT player_of_match, COUNT(*) AS awards
FROM matches
WHERE player_of_match IS NOT NULL
GROUP BY player_of_match
ORDER BY awards DESC
LIMIT 10;

--TEAM WON MORE TOSSES--
SELECT toss_winner, COUNT(*) AS tosses_won
FROM matches
GROUP BY toss_winner
ORDER BY tosses_won DESC;

--BOWLER WITH MOST DOT BALLS--
SELECT bowler, COUNT(*) AS dot_balls
FROM deliveries
WHERE total_runs = 0
GROUP BY bowler
ORDER BY dot_balls DESC
LIMIT 10;

--BATSMAN WHO HITS MOST SIXES--
SELECT batter, COUNT(*) AS total_sixes
FROM deliveries
WHERE batsman_runs = 6
GROUP BY batter
ORDER BY total_sixes DESC
LIMIT 10;

--BATSMAN WHO HITS MOST FOURS--
SELECT batter, COUNT(*) AS total_fours
FROM deliveries
WHERE batsman_runs = 4
GROUP BY batter
ORDER BY total_fours DESC
LIMIT 10;

--SEASON WISE TOTAL MATCHES--
SELECT season, COUNT(*) AS total_matches
FROM matches
GROUP BY season
ORDER BY season;

--MOST POPULAR VENUES--
SELECT venue, COUNT(*) AS matches_played
FROM matches
GROUP BY venue
ORDER BY matches_played DESC
LIMIT 10;