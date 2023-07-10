CREATE TABLE `coach` (
  `person_id` int NOT NULL,
  `full_name` varchar(20) DEFAULT NULL,
  `first_name` varchar(15) DEFAULT NULL,
  `last_name` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `league` (
  `league_id` smallint NOT NULL,
  `division_id` smallint NOT NULL,
  `league` char(2) DEFAULT NULL,
  `division` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`league_id`,`division_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `team` (
  `team_id` smallint NOT NULL,
  `team_name` varchar(30) DEFAULT NULL,
  `venue` varchar(30) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  `league_id` smallint DEFAULT NULL,
  `division_id` smallint DEFAULT NULL,
  KEY `t_league_id` (`league_id`, `division_id`),
  PRIMARY KEY (`team_id`),
  CONSTRAINT `team_league_id` FOREIGN KEY (`league_id`, `division_id`) REFERENCES `league` (`league_id`, `division_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `player` (
  `player_id` int NOT NULL,
  `season` year DEFAULT NULL,
  `full_name` varchar(20) DEFAULT NULL,
  `first_name` varchar(15) DEFAULT NULL,
  `last_name` varchar(15) DEFAULT NULL,
  `birthDay` date DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  `height` float DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `position_code` varchar(2) DEFAULT NULL,
  `primary_position` varchar(15) DEFAULT NULL,
  `mlbDebutDate` date DEFAULT NULL,
  `pitch_hand` char(2) DEFAULT NULL,
  `batSide` char(2) DEFAULT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `game` (
  `game_id` int NOT NULL,
  `game_date` date DEFAULT NULL,
  `homeTeam` smallint NOT NULL,
  `homeTeamscore` smallint DEFAULT NULL,
  `awayTeam` smallint NOT NULL,
  `awayTeamscore` smallint DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  KEY `homeTeam_idx` (`homeTeam`),
  KEY `awayTeam_idx` (`awayTeam`),
  CONSTRAINT `game_homeTeam` FOREIGN KEY (`homeTeam`) REFERENCES `team` (`team_id`),
  CONSTRAINT `gmae_awayTeam` FOREIGN KEY (`awayTeam`) REFERENCES `team` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `batters_game_record` (
  `game_id` int NOT NULL,
  `player_id` int NOT NULL,
  `appearance` smallint DEFAULT NULL,
  `BB` smallint DEFAULT NULL,
  `hits` smallint DEFAULT NULL,
  `homeRun` smallint DEFAULT NULL,
  `strikeOut` smallint DEFAULT NULL,
  `rbi` smallint DEFAULT NULL,
  `r` smallint DEFAULT NULL,
  `steel` smallint DEFAULT NULL,
  PRIMARY KEY (`game_id`,`player_id`),
  KEY `batters_game_player_id_idx` (`player_id`),
  CONSTRAINT `batters_game_game_id` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`),
  CONSTRAINT `batters_game_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `batters_record` (
  `player_id` int NOT NULL,
  `season` year NOT NULL,
  `team_id` smallint DEFAULT NULL,
  `gamePlayed` smallint DEFAULT NULL,
  `homeRuns` smallint DEFAULT NULL,
  `runs` smallint DEFAULT NULL,
  `strikeOut` smallint DEFAULT NULL,
  `BB` smallint DEFAULT NULL,
  `avg` float DEFAULT NULL,
  `ops` float DEFAULT NULL,
  `rbi` smallint DEFAULT NULL,
  `steel` smallint DEFAULT NULL,
  PRIMARY KEY (`player_id`,`season`),
  KEY `batters_team_id_idx` (`team_id`),
  CONSTRAINT `batters_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`),
  CONSTRAINT `batters_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `coach_affiliation` (
  `year` year NOT NULL,
  `team_id` smallint NOT NULL,
  `person_id` int NOT NULL,
  `job` varchar(10) DEFAULT NULL,
  `job_id` char(4) DEFAULT NULL,
  PRIMARY KEY (`year`,`team_id`,`person_id`),
  KEY `coach_id_idx` (`person_id`),
  KEY `team_id_idx` (`team_id`),
  CONSTRAINT `coach_id` FOREIGN KEY (`person_id`) REFERENCES `coach` (`person_id`),
  CONSTRAINT `coach_team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `pitchers_game_record` (
  `game_id` int NOT NULL,
  `player_id` int NOT NULL,
  `inning` float DEFAULT NULL,
  `BB` smallint DEFAULT NULL,
  `strikeOut` smallint DEFAULT NULL,
  `hits` smallint DEFAULT NULL,
  `homeRuns` smallint DEFAULT NULL,
  PRIMARY KEY (`game_id`,`player_id`),
  KEY `pitchers_game_player_id_idx` (`player_id`),
  CONSTRAINT `pitchers_game_game_id` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`),
  CONSTRAINT `pitchers_game_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `pitchers_record` (
  `player_id` int NOT NULL,
  `season` year NOT NULL,
  `team_id` smallint DEFAULT NULL,
  `gamesPlayed` smallint DEFAULT NULL,
  `homeRuns` smallint DEFAULT NULL,
  `strikeOuts` smallint DEFAULT NULL,
  `BB` smallint DEFAULT NULL,
  `era` float DEFAULT NULL,
  `win` smallint DEFAULT NULL,
  `loss` smallint DEFAULT NULL,
  `save` smallint DEFAULT NULL,
  `hold` smallint DEFAULT NULL,
  `whip` float DEFAULT NULL,
  PRIMARY KEY (`player_id`,`season`),
  KEY `pitchers_team_iid_idx` (`team_id`),
  CONSTRAINT `pitchers_team_iid` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`),
  CONSTRAINT `pitvhers_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ranking` (
  `year` date NOT NULL,
  `team_id` smallint NOT NULL,
  `ranking` smallint DEFAULT NULL,
  `win` smallint DEFAULT NULL,
  `loss` smallint DEFAULT NULL,
  PRIMARY KEY (`year`,`team_id`),
  KEY `team_id_idx` (`team_id`),
  CONSTRAINT `team_ranking` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;