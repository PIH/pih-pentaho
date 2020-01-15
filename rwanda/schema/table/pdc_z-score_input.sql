CREATE TABLE `pdc_z_score_input` (
  `R_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `obs_date` text,
  `oedema` int(11) DEFAULT NULL,
  `lh` text,
  `weight` double DEFAULT NULL,
  `clenhei` int(11) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `gestatiol_age_at_birth_in_weeks` text,
  `agedays` int(11) DEFAULT NULL,
  `zwfl` text,
  `zwei` text,
  `zlen` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
