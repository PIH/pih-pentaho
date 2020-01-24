
CREATE OR REPLACE VIEW omrs_encounter_2018 AS
SELECT * from omrs_encounter where encounter_date >= '2018-01-01' and encounter_date < '2019-01-01';

CREATE OR REPLACE  VIEW omrs_obs_2018 AS
SELECT * from omrs_obs where obs_date >= '2018-01-01' and obs_date < '2019-01-01';

CREATE OR REPLACE  VIEW omrs_encounter_2019 AS
SELECT * from omrs_encounter where encounter_date >= '2019-01-01' and encounter_date < '2020-01-01';

CREATE OR REPLACE  VIEW omrs_obs_2019 AS
SELECT * from omrs_obs where obs_date >= '2019-01-01' and obs_date < '2020-01-01';

CREATE OR REPLACE  VIEW omrs_obs_2020 AS
SELECT * from omrs_obs where obs_date >= '2020-01-01' and obs_date < '2021-01-01';