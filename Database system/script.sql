/*				COVID TRACER PHYSICAL MODEL			*/
/*				DATABASE DEVELOPMENT SCRIPT			*/


CREATE DATABASE COVID_TRACER;
USE COVID_TRACER;


/*  MERCHANT RELATION   */

CREATE TABLE MERCHANT (
    serial_no CHAR(8) NOT NULL,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL,
    PRIMARY KEY (serial_no) );

/*  ----------------------------- */


/*  TRACE RELATION    */

CREATE TABLE TRACE (
    date DATE NOT NULL ,
    arrival_time TIME NOT NULL,
    serial_no CHAR(8) NOT NULL,
    nic CHAR(12) NOT NULL,
    temperature DECIMAL(3,1),
    PRIMARY KEY (serial_no, nic, date, arrival_time),
    FOREIGN KEY (nic) REFERENCES localCommunity(nic),
    FOREIGN KEY (serial_no) REFERENCES MERCHANT(serial_no) );

/*  ----------------------------- */


/*  UNDER_QUARANTINE RELATION   */

CREATE TABLE UNDER_QUARANTINE (
    CONTACT INT(1) NOT NULL,
    start_date DATE NOT NULL,
    nic CHAR(12) NOT NULL,
    update_time_stamp DATETIME NOT NULL,
    PRIMARY KEY (start_date,nic,update_time_stamp),
    FOREIGN KEY (nic) REFERENCES localCommunity(nic)     );

/*  ----------------------------- */


/*  INFECT RELATION   */

CREATE TABLE INFECT (
    update_time_stamp DATETIME NOT NULL,
    variant VARCHAR(20) NOT NULL,
    tested_date Date NOT NULL,
    nic CHAR(12) NOT NULL,
    PRIMARY KEY (update_time_stamp,tested_date,nic) ,
    FOREIGN KEY (nic) REFERENCES localCommunity(nic)     );


/*  GOVERNMENT UPDATES RELATION   */

CREATE TABLE GovernmentUpdates (
    new_deaths INT,
    new_cases INT,
    cumulative_deaths INT,
    cumulative_cases INT,
    update_timestamp DATETIME    );

/*  ----------------------------- */



/*  VIEWS, TRIGGERS, STORED PROCEDURES  */


/* Trace Locations visited */

DELIMITER $$
CREATE PROCEDURE PERCENTAGE_CALC (IN nic_no CHAR(12))
BEGIN
SELECT name,location, percentage,T1.temperature,T1.date,T1.arrival_time FROM(
SELECT A.temperature,A.date,A.arrival_time,A.serial_no,infect_count,total, (infect_count / total)*100 AS percentage
FROM(
    SELECT s.temperature,s.date,s.arrival_time,TRACE.serial_no,COUNT(DISTINCT nic) AS total FROM TRACE JOIN (SELECT* FROM (SELECT serial_no, date,arrival_time,temperature FROM TRACE WHERE nic = nic_no ORDER BY date ASC, arrival_time ASC) AS sub GROUP BY serial_no) s
    ON TRACE.serial_no=s.serial_no WHERE s.date<TRACE.date OR (s.date=TRACE.date AND s.arrival_time<=TRACE.arrival_time) GROUP BY TRACE.serial_no ) AS A
JOIN 
(SELECT TRACE.serial_no,COUNT(DISTINCT nic) AS infect_count FROM TRACE JOIN (SELECT* FROM (SELECT serial_no, date,arrival_time FROM TRACE WHERE nic = nic_no ORDER BY date ASC, arrival_time ASC) AS sub GROUP BY serial_no) s
    ON TRACE.serial_no=s.serial_no WHERE (s.date<TRACE.date OR (s.date=TRACE.date AND s.arrival_time<=TRACE.arrival_time)) AND nic IN

(SELECT nic FROM (
    SELECT nic FROM INFECT
    UNION 
    SELECT nic FROM UNDER_QUARANTINE
) a WHERE nic IN (SELECT DISTINCT nic FROM TRACE JOIN (SELECT* FROM (SELECT serial_no, date,arrival_time FROM TRACE WHERE nic = nic_no ORDER BY date ASC, arrival_time ASC) AS sub GROUP BY serial_no) s
    ON TRACE.serial_no=s.serial_no WHERE s.date<TRACE.date OR (s.date=TRACE.date AND s.arrival_time<=TRACE.arrival_time)
)) GROUP BY TRACE.serial_no) AS B ON A.serial_no = B.serial_no) AS T1

JOIN
(SELECT serial_no, name, location FROM MERCHANT) AS T2 ON T2.serial_no = T1.serial_no;

END$$
DELIMITER ;


/*  TOP 10 Places near the user area */

DELIMITER $$
CREATE PROCEDURE TOP_INFECTED_PLACES_IN_USER_AREA (IN nic_no CHAR(12))
BEGIN

SELECT Place.name,Place.location,percentage FROM(
    SELECT serial_no,name,location from MERCHANT
) AS Place
JOIN (
SELECT InfectsCount.serial_no, (infect_count / total)*100 AS percentage
FROM(
    SELECT VisitedNics.serial_no, COUNT(VisitedNics.nic) AS infect_count FROM(
    SELECT UniquePairs.serial_no, nic FROM(
    SELECT serial_no 
    FROM ( select SUBSTRING_INDEX(address, ',', -1) as UserLocation from LocalCommunity where nic = nic_no) AS A
    JOIN (select serial_no,SUBSTRING_INDEX(location, ',', -1) as MerchantLocation from MERCHANT) AS B
    ON A.UserLocation=B.MerchantLocation 
    ) AS UserAreaPlaces
    JOIN (SELECT serial_no, nic FROM TRACE GROUP BY serial_no, nic HAVING COUNT(*) >= 1) AS UniquePairs
    ON UserAreaPlaces.serial_no = UniquePairs.serial_no 
) AS VisitedNics
JOIN(SELECT nic FROM (
    SELECT nic FROM INFECT
    UNION 
    SELECT nic FROM UNDER_QUARANTINE
) a WHERE nic IN (SELECT nic FROM LocalCommunity)
) As Infects ON VisitedNics.nic = Infects.nic GROUP BY VisitedNics.serial_no
) AS InfectsCount
JOIN(
    SELECT UniquePairs.serial_no, COUNT(nic) AS total FROM(
    SELECT serial_no 
    FROM ( select SUBSTRING_INDEX(address, ',', -1) as UserLocation from LocalCommunity where nic = nic_no) AS A
    JOIN (select serial_no,SUBSTRING_INDEX(location, ',', -1) as MerchantLocation from MERCHANT) AS B
    ON A.UserLocation=B.MerchantLocation 
) AS UserAreaPlaces
JOIN (SELECT serial_no, nic FROM TRACE GROUP BY serial_no, nic HAVING COUNT(*) >= 1) AS UniquePairs
ON UserAreaPlaces.serial_no = UniquePairs.serial_no GROUP BY UniquePairs.serial_no
) AS TotalCount ON TotalCount.serial_no = InfectsCount.serial_no ORDER BY percentage DESC
) AS InfectedPercent ON Place.serial_no = InfectedPercent.serial_no ;

END$$
DELIMITER ;


/* infects percentage for that particular place */

DELIMITER $$
CREATE PROCEDURE SEARCH_INFECT_PERCENTAGE (IN name_in VARCHAR(50), IN location_in VARCHAR(100))
BEGIN
SELECT InfectsCount.serial_no, (infect_count / total)*100 AS percentage FROM(
    SELECT A.serial_no, COUNT(A.nic) AS infect_count FROM(
   SELECT serial_no, nic FROM TRACE WHERE serial_no = (
   select serial_no from MERCHANT where name = name_in AND SUBSTRING_INDEX(location, ',', -1) = location_in    
   ) GROUP BY serial_no, nic HAVING COUNT(*) >= 1
) AS A
JOIN(
    SELECT nic FROM (
    SELECT nic FROM INFECT
    UNION 
    SELECT nic FROM UNDER_QUARANTINE
    ) a WHERE nic IN (SELECT nic FROM LocalCommunity)
) AS B ON A.nic = B.nic GROUP BY A.serial_no
  
) AS InfectsCount
JOIN(
    SELECT serial_no, COUNT(DISTINCT nic) AS total FROM TRACE WHERE serial_no = (
    select serial_no from MERCHANT where name = name_in AND SUBSTRING_INDEX(location, ',', -1) = location_in   
) GROUP BY serial_no

) AS TotalCount ON TotalCount.serial_no = InfectsCount.serial_no;

END$$
DELIMITER ;
