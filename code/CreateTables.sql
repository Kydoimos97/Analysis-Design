
---------------------------------------------------------------------------
-- execute the following statements to create tables
---------------------------------------------------------------------------
CREATE TABLE sport (
  sport_id NUMBER(6,0) NOT NULL,
  sport_name VARCHAR2(100) NOT NULL,
  sport_desc VARCHAR2(1000) NULL,
CONSTRAINT sport_pk PRIMARY KEY (sport_id)
);

CREATE TABLE athlete (
    athlete_id NUMBER(6,0) NOT NULL ,
    athlete_first_name VARCHAR2(50) NOT NULL ,
    athlete_middle_init CHAR(1) NULL,
    athlete_last_name VARCHAR2(100) NOT NULL,
    sport_id NUMBER(6,0) NULL,
    gender VARCHAR2(1) NULL,
    scholarship NUMBER(11,2) NOT NULL ,
    team_id NUMBER (6,0) NOT NULL,
CONSTRAINT athlete_pk PRIMARY KEY (athlete_id), -- We should make a sport table likely same for gender.
CONSTRAINT athlete_fk_1 FOREIGN KEY (team_id) REFERENCES team (team_id), -- Newly Added
CONSTRAINT athlete_fk_2 FOREIGN KEY (sport_id) REFERENCES sport (sport_id)
);

CREATE TABLE team (
    team_id NUMBER(6,0) NOT NULL,
    team_name VARCHAR2(100) NOT NULL,
    sport_id NUMBER(6,0) NULL,
    gender VARCHAR2(1) NULL,
    league VARCHAR2(100) NULL,
    team_budget NUMBER(11,2) NULL,
CONSTRAINT team_pk PRIMARY KEY (team_id),
CONSTRAINT team_fk FOREIGN KEY (sport_id) REFERENCES sport (sport_id)
);

CREATE TABLE employee (
	employee_id NUMBER(6,0) NOT NULL,
    employee_first_name VARCHAR2(50) NOT NULL,
	employee_middle_initial CHAR(1) NULL,
	employee_last_name VARCHAR2(100) NOT NULL,
	job_role VARCHAR2(100) NOT NULL,
	job_level NUMBER(2,0) NOT NULL,
	report_to NUMBER(6,0) NOT NULL, -- This is the employee ID check if referenced correctly
	department varchar2(100) NOT NULL,
	salary NUMBER(15,2) NOT NULL,
CONSTRAINT employee_pk PRIMARY KEY (employee_id),
CONSTRAINT employee_fk FOREIGN KEY (report_to) REFERENCES employee (employee_id)
);

CREATE TABLE income (
    income_id NUMBER(6,0) NOT NULL,
    team_id NUMBER(6,0) NOT NULL,
    income_amount Number(15,2) NOT NULL,
    income_datetime TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
CONSTRAINT income_pk PRIMARY KEY (income_id), --This is weird since the income_id already identifies, team_ID should be a foreign key I think.
CONSTRAINT income_fk FOREIGN KEY (team_id) REFERENCES team (team_id)
);

CREATE TABLE event (
    team_id NUMBER(6,0) NOT NULL,
    opponent_id NUMBER(6,0) NOT NULL,
    event_time TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    event_type NUMBER(3,0) NOT NULL,
    event_cost NUMBER(10,2) NOT NULL,
CONSTRAINT event_pk PRIMARY KEY (team_id, opponent_id, event_time),
CONSTRAINT event_fk_1 FOREIGN KEY (team_id) REFERENCES team (team_id),
CONSTRAINT event_fk_2 FOREIGN KEY (event_type) REFERENCES event_type (event_type)
);

CREATE TABLE event_type (
    event_type NUMBER(3,0),
    event_desc VARCHAR2(100),
CONSTRAINT event_type_pk PRIMARY KEY (event_type),
CONSTRAINT event_type_fk FOREIGN KEY (event_type) REFERENCES event (event_type)
);

CREATE TABLE ranking (
    team_id NUMBER(6,0) NOT NULL,
    ranking_date TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    rank NUMBER(6,0) NULL,
    ranking_entity VARCHAR2(100) NULL,
CONSTRAINT ranking_pk PRIMARY KEY (team_id, ranking_date),
CONSTRAINT team_id_fk FOREIGN KEY (team_id) REFERENCES team (team_id)
);

CREATE TABLE equipment(
    equipment_id NUMBER(6,0) NOT NULL,
    equipment_type NUMBER(3,0) NOT NULL,
    equipment_name VARCHAR2(100) NULL,
    equipment_cost NUMBER(10,2) NULL,
CONSTRAINT equipment_pk PRIMARY KEY (equipment_id)
);

---------------------------------------------------------------------------
-- 3NF TABLES
---------------------------------------------------------------------------

CREATE TABLE employee_team (
    employee_id Number(6,0) NOT NULL,
    team_id NUMBER (6,0) NOT NULL,
constraint employee_team_pk primary key (employee_id, team_id),
constraint employee_team_fk_1 foreign key (employee_id) REFERENCES employee (employee_id),
constraint employee_team_fk_2 foreign key (team_id) REFERENCES team (team_id)
);

CREATE TABLE event_income (
    income_id NUMBER(6,0) NOT NULL,
    team_id NUMBER(6,0) NOT NULL,
    opponent_id NUMBER(6,0) NOT NULL,
    event_time TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
CONSTRAINT event_income_pk PRIMARY KEY (income_id, team_id, opponent_id, event_time),
constraint event_income_fk_1 FOREIGN KEY (income_id) REFERENCES income (income_id),
CONSTRAINT event_income_fk_2 FOREIGN KEY (team_id, opponent_id, event_time) REFERENCES  event (team_id, opponent_id, event_time)
);

CREATE TABLE event_ranking (
    team_id NUMBER(6,0) NOT NULL,
    opponent_id NUMBER(6,0) NOT NULL,
    event_time TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    ranking_date TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
CONSTRAINT event_ranking_pk PRIMARY KEY (team_id,opponent_id,event_time,ranking_date),
CONSTRAINT event_ranking_fk_1 FOREIGN KEY (team_id, opponent_id, event_time) REFERENCES event (team_id, opponent_id, event_time),
CONSTRAINT event_ranking_fk_2 FOREIGN KEY (ranking_date) REFERENCES ranking (ranking_date)
);

CREATE TABLE team_equipment (
    team_id NUMBER(6,0) NOT NULL,
    equipment_id NUMBER(6,0) NOT NULL,
constraint team_equipment_pk PRIMARY KEY (team_id,equipment_id),
CONSTRAINT team_equipment_fk_1 FOREIGN KEY (team_id) REFERENCES team (team_id),
CONSTRAINT team_equipment_fk_2 FOREIGN KEY (equipment_id) REFERENCES equipment (equipment_id)
);

CREATE TABLE athlete_equipment (
    athlete_id NUMBER(6,0) NOT NULL ,
    equipment_id NUMBER(6,0) NOT NULL,
CONSTRAINT athlete_equipment_pk PRIMARY KEY (athlete_id, equipment_id),
CONSTRAINT athlete_equipment_fk_2 FOREIGN KEY (athlete_id) REFERENCES athlete (athlete_id),
CONSTRAINT athlete_equipment_fk_1 FOREIGN KEY (equipment_id) REFERENCES equipment (equipment_id)
);

