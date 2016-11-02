-- Time dimension
-- TODO: Loading in this way is inefficient, since there are only 24 x 60 possible values in this table
-- TODO: We should really just iterate and load them in

DROP TABLE IF EXISTS dim_time;

create table dim_time (
  time_id INT AUTO_INCREMENT PRIMARY KEY,
  hour INT,
  minute INT
);

DELIMITER //
CREATE PROCEDURE insert_time()
  BEGIN
    DECLARE hr int DEFAULT 0;
    DECLARE min int DEFAULT 0;
    WHILE hr < 24 DO
      WHILE min < 60 DO
        INSERT INTO dim_time (hour, minute) VALUES (hr, min);
        SET min = min + 1;
      END WHILE;
      SET min = 0;
      SET hr = hr + 1;
    END WHILE;
  END
//

CALL insert_time();

DROP PROCEDURE insert_time;
