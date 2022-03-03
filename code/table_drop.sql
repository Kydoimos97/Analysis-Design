---------------------------------------------------------------------------
-- execute the following statements to drop the tables
---------------------------------------------------------------------------

-- Definition Table
DROP TABLE sport
DROP TABLE event_type

-- Main Tables
DROP TABLE athlete;
DROP TABLE team;
DROP TABLE employee;
DROP TABLE income;
DROP TABLE event;
DROP TABLE ranking;
DROP TABLE equipment;

--  3NF M to M tables
DROP TABLE employee_team;
DROP TABLE event_income;
DROP TABLE event_ranking;
DROP TABLE team_equipment;
DROP TABLE athlete_equipment;
