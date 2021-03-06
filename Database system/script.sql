/*				COVID TRACER PHYSICAL MODEL			*/
/*				DATABASE DEVELOPMENT SCRIPT			*/


CREATE DATABASE COVID_TRACER;
USE COVID_TRACER;


/*  LOCAL_COMMUNITY RELATION    */

CREATE TABLE LOCAL_COMMUNITY (
    nic CHAR(12) NOT NULL,
    full_name VARCHAR(100),
    sex CHAR(1),
    address VARCHAR(100),
    PRIMARY KEY (nic) );

/*  ----------------------------- */


/*  USER RELATION   */

CREATE TABLE USER (
    username VARCHAR(30) NOT NULL,
    nic CHAR(12) NOT NULL,
    password VARCHAR(30) NOT NULL,
    contact_number CHAR(9),
    email VARCHAR(50),
    joined_date DATETIME,
    PRIMARY KEY (username),
    FOREIGN KEY (nic) REFERENCES LOCAL_COMMUNITY(nic) );

/*  ----------------------------- */


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
    FOREIGN KEY (nic) REFERENCES LOCAL_COMMUNITY(nic),
    FOREIGN KEY (serial_no) REFERENCES MERCHANT(serial_no) );

/*  ----------------------------- */


/*  UNDER_QUARANTINE RELATION   */

CREATE TABLE UNDER_QUARANTINE (
    CONTACT INT(1) NOT NULL,
    start_date DATE NOT NULL,
    nic CHAR(12) NOT NULL,
    update_time_stamp DATETIME NOT NULL,
    PRIMARY KEY (start_date,nic,update_time_stamp),
    FOREIGN KEY (nic) REFERENCES LOCAL_COMMUNITY(nic)     );

/*  ----------------------------- */


/*  INFECT RELATION   */

CREATE TABLE INFECT (
    update_time_stamp DATETIME NOT NULL,
    variant VARCHAR(20) NOT NULL,
    tested_date Date NOT NULL,
    nic CHAR(12) NOT NULL,
    PRIMARY KEY (update_time_stamp,tested_date,nic) ,
    FOREIGN KEY (nic) REFERENCES LOCAL_COMMUNITY(nic)     );

/*  ----------------------------- */


SELECT serial_no, date,arrival_time FROM TRACE WHERE nic = "123456789123" GROUP BY serial_no;





INSERT INTO LOCAL_COMMUNITY VALUES 
("123456789123","Nimal Perera","M","sdsfd gfdgfgfh"),
("123456789124","Sandun Perera","M","sdfgfghj gfdgfgfh"),
("123456789125","Nihal Perera","M","sdfgfghjyy gfdgfgfh"),
("123456789126","Danuth Perera","M","sdfgftyghj gfdgfgfh");


INSERT INTO MERCHANT VALUES
    ("bbb12323","Foodcity","Gampaha"),
    ("bbb12324","Nolimit","Nugegoda"),
    ("bbb12325","FashionBug","Ja-Ela");

INSERT INTO TRACE VALUES
    ('2021-09-17','10:00:00',"bbb12324", "123456789124", 36.5),
    ('2021-09-17','10:00:00',"bbb12325", "123456789123", 36.5),
    ('2021-09-17','10:20:00',"bbb12324", "123456789123", 36.5),
    ('2021-09-17','10:50:00',"bbb12325", "123456789124", 36.5),
    ('2021-09-18','10:50:00',"bbb12324", "123456789124", 36.5),
    ('2021-09-18','11:00:00',"bbb12324", "123456789123", 36.5),
    ('2021-09-19','12:00:00',"bbb12324", "123456789125", 36.5),
    ('2021-09-19','13:00:00',"bbb12324", "123456789126", 36.5);


INSERT INTO UNDER_QUARANTINE VALUES
    (1,'2021-09-17',"123456789124",CURDATE());

INSERT INTO INFECT VALUES
    (CURDATE(),"beeta",'2021-09-17',"123456789124"),
    (CURDATE(),"beeta",'2021-09-18',"123456789123");


/*DELIMITER $$
CREATE PROCEDURE PERCENTAGE_CALC (IN nic_no CHAR(12))
BEGIN
SELECT location, percentage FROM(
SELECT A.serial_no,infect_count,total, (infect_count / total)*100 AS percentage
FROM(
    SELECT TRACE.serial_no,COUNT(DISTINCT nic) AS total FROM TRACE JOIN (SELECT* FROM (SELECT serial_no, date,arrival_time FROM TRACE WHERE nic = nic_no ORDER BY date ASC, arrival_time ASC) AS sub GROUP BY serial_no) s
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
(SELECT serial_no, location FROM MERCHANT) AS T2 ON T2.serial_no = T1.serial_no;

END$$
DELIMITER ;

*/


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


drop procedure percentage_calc;





/* Top 10 Places of the user's area */

select SUBSTRING_INDEX(address, ',', -1) as UserLocation from LocalCommunity where nic = "123456789123"
select serial_no,SUBSTRING_INDEX(location, ',', -1) as MerchantLocation from MERCHANT 
select serial_no from MERCHANT where 

/* Select places located in the users area  */
SELECT serial_no 
FROM ( select SUBSTRING_INDEX(address, ',', -1) as UserLocation from LocalCommunity where nic = "123456789123") AS A
JOIN (select serial_no,SUBSTRING_INDEX(location, ',', -1) as MerchantLocation from MERCHANT) AS B
ON A.UserLocation=B.MerchantLocation

/* Select places located in the users area  */
SELECT serial_no, nic FROM TRACE GROUP BY serial_no, nic HAVING COUNT(*) >= 1

/* Select visted nic of places located in user's area  */
SELECT UniquePairs.serial_no, nic FROM(
    SELECT serial_no 
    FROM ( select SUBSTRING_INDEX(address, ',', -1) as UserLocation from LocalCommunity where nic = "123456789123") AS A
    JOIN (select serial_no,SUBSTRING_INDEX(location, ',', -1) as MerchantLocation from MERCHANT) AS B
    ON A.UserLocation=B.MerchantLocation 
) AS UserAreaPlaces
JOIN (SELECT serial_no, nic FROM TRACE GROUP BY serial_no, nic HAVING COUNT(*) >= 1) AS UniquePairs
ON UserAreaPlaces.serial_no = UniquePairs.serial_no ;

/* Select toal count of nic for each place in user's area*/

SELECT UniquePairs.serial_no, COUNT(nic) AS total FROM(
    SELECT serial_no 
    FROM ( select SUBSTRING_INDEX(address, ',', -1) as UserLocation from LocalCommunity where nic = "623456789656") AS A
    JOIN (select serial_no,SUBSTRING_INDEX(location, ',', -1) as MerchantLocation from MERCHANT) AS B
    ON A.UserLocation=B.MerchantLocation 
) AS UserAreaPlaces
JOIN (SELECT serial_no, nic FROM TRACE GROUP BY serial_no, nic HAVING COUNT(*) >= 1) AS UniquePairs
ON UserAreaPlaces.serial_no = UniquePairs.serial_no GROUP BY UniquePairs.serial_no;

/* infects and underquarantine union */
SELECT nic FROM (
    SELECT nic FROM INFECT
    UNION 
    SELECT nic FROM UNDER_QUARANTINE
) a WHERE nic IN (SELECT nic FROM LocalCommunity);

/* get infect count for each of the places near the user */
SELECT VisitedNics.serial_no, COUNT(VisitedNics.nic) AS infect_count FROM(
    SELECT UniquePairs.serial_no, nic FROM(
    SELECT serial_no 
    FROM ( select SUBSTRING_INDEX(address, ',', -1) as UserLocation from LocalCommunity where nic = "623456789656") AS A
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
) As Infects ON VisitedNics.nic = Infects.nic GROUP BY VisitedNics.serial_no;


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


CALL TOP_INFECTED_PLACES_IN_USER_AREA("623456789656");







/*    */

select serial_no,name,SUBSTRING_INDEX(location, ',', -1) as MerchantLocation from MERCHANT where name = "Nolimit" AND SUBSTRING_INDEX(location, ',', -1) = "Nugegoda";

/* visited nics for the searched place */
SELECT serial_no, nic FROM TRACE WHERE serial_no = (
    select serial_no from MERCHANT where name = "Nolimit" AND SUBSTRING_INDEX(location, ',', -1) = "Nugegoda"    
) GROUP BY serial_no, nic HAVING COUNT(*) >= 1;

/* total visited nics for the searched place */
SELECT serial_no, COUNT(DISTINCT nic) AS total FROM TRACE WHERE serial_no = (
    select serial_no from MERCHANT where name = "Nolimit" AND SUBSTRING_INDEX(location, ',', -1) = "Nugegoda"    
) GROUP BY serial_no;

/* infects count for that particular place */

SELECT A.serial_no, COUNT(A.nic) AS infect_count FROM(
   SELECT serial_no, nic FROM TRACE WHERE serial_no = (
   select serial_no from MERCHANT where name = "Nolimit" AND SUBSTRING_INDEX(location, ',', -1) = "Nugegoda"    
   ) GROUP BY serial_no, nic HAVING COUNT(*) >= 1
) AS A
JOIN(
    SELECT nic FROM (
    SELECT nic FROM INFECT
    UNION 
    SELECT nic FROM UNDER_QUARANTINE
    ) a WHERE nic IN (SELECT nic FROM LocalCommunity)
) AS B ON A.nic = B.nic GROUP BY A.serial_no;


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



/*  VIEWS, TRIGGERS, STORED PROCEDURES  */

/*GET LATEST STATISTICS*/
DELIMITER $$
CREATE PROCEDURE GET_LATEST_VEHICLE_STAT ()
BEGIN

    SELECT * FROM GovernmentUpdates ORDER BY update_timestamp DESC LIMIT 1;

END$$
DELIMITER ;

/* ------------------------------------------------------------------------------- */


/*                             VEHICLE                         */

/*REGISTER NEW VEHICLE*/
DELIMITER $$
CREATE PROCEDURE REGISTER_VEHICLE (IN license_plate VARCHAR(11), IN engine CHAR(10), IN cat CHAR(2), IN namein VARCHAR(12), IN totkm INT,
                                   IN gps VARCHAR(150), IN max INT, IN owner CHAR(5))
BEGIN

    INSERT INTO VEHICLE(license_plate_no, engine_serial_no, category, name, total_kms, last_service_date, last_service_kms,
                        gps_link, max_passengers, owner_id, registered_date, availability)
    VALUES (license_plate, engine, cat, namein, totkm, CURDATE(), totkm, gps, max, owner, CURDATE(), TRUE);

END$$
DELIMITER ;

/* ------------------------------------------------------------------------------- */


/*                              CUSTOMER                        */

/*REGISTER NEW CUSTOMER*/
DELIMITER $$
CREATE PROCEDURE REGISTER_CUSTOMER (IN nicno CHAR(10), IN fn VARCHAR(30), IN mn VARCHAR(30), IN ln VARCHAR(30), IN addr VARCHAR(100),
                                    IN em VARCHAR(50), IN drive CHAR(8))
BEGIN

    INSERT INTO CUSTOMER 
    VALUES (nicno, fn, mn, ln, addr, em, drive, CURDATE());

END$$
DELIMITER ;

/* ------------------------------------------------------------------------------- */


/*                              BOOKING                            */

/*MAKE NEW BOOKING*/
DELIMITER $$
CREATE PROCEDURE MAKE_BOOKING(IN vehicle CHAR(5), IN customer CHAR(10), IN bookdate DATE, IN returndate DATE)
BEGIN

    DECLARE pack CHAR(7);
    SET pack =  (SELECT pack_id FROM PACKAGE 
                WHERE PACKAGE.vehicle_category = (SELECT category FROM VEHICLE WHERE id = vehicle)
                AND pack_name LIKE 
                CASE WHEN DATEDIFF(returndate, bookdate) < 5 THEN '%Daily'
                      WHEN DATEDIFF(returndate, bookdate) >=5 AND  DATEDIFF(returndate, bookdate) < 21 THEN '%Weekly'
                      ELSE '%Monthly' END );
    

    INSERT INTO BOOKING(booking_done_date, packID, vehicleID, customerNIC, booked_date, return_date, completed)
    VALUES (CURDATE(), pack, vehicle, customer, bookdate, returndate, 'N');

END$$
DELIMITER ;


/*VIEW DETAILS OF A BOOKING*/
DELIMITER //
CREATE PROCEDURE VIEW_BOOKING (IN book_id CHAR(10))
BEGIN

    SELECT booking_id  AS 'BOOKING ID', customerNIC AS 'CUSTOMER NIC', booking_done_date AS 'BOOKING DONE DATE', 
    pack_name AS PACKAGE, VEHICLE.id AS 'VEHICLE ID', name AS VEHICLE, license_plate_no AS 'NUMBER PLATE', booked_date AS 'BOOKED DATE',
    return_date AS 'RETURN DATE', key_money AS 'KEY MONEY'
    FROM BOOKING, PACKAGE, VEHICLE
    WHERE BOOKING.packID = PACKAGE.pack_id AND BOOKING.vehicleID = VEHICLE.id
    AND BOOKING.booking_id = book_id;
    
END//
DELIMITER ;

/* ------------------------------------------------------------------------------- */


/*                              TRANSACTION                         */

/*RENT A VEHICLE ON A BOOKING*/
DELIMITER $$
CREATE PROCEDURE RENT_VEHICLE (IN booking CHAR(10), IN keymoney DECIMAL(7,2))
BEGIN

    SET @v = (SELECT total_kms FROM VEHICLE WHERE id = (SELECT vehicleID FROM BOOKING WHERE booking_id=booking) );
    INSERT INTO TRANSACTION(booking_id, start_meter_reading, paid_key_money)
    VALUES (booking, @v, keymoney);

END$$
DELIMITER ;


/*UPDATE TRANSACTION AFTER BOOING IS COMPLETED*/
DELIMITER $$
CREATE PROCEDURE RETURN_VEHICLE (IN book CHAR(10), IN meter_read INT, IN dam DECIMAL(7,2), IN descr VARCHAR(100))
BEGIN

    SET @pack = (SELECT packID FROM BOOKING WHERE booking_id = book);
    SET @maxi = (SELECT max_kms FROM PACKAGE WHERE pack_id = @pack);
    SET @dailyrent = (SELECT rent FROM PACKAGE WHERE pack_id = @pack);
    SET @maxrent = (SELECT charge_per_extra_km FROM PACKAGE WHERE pack_id = @pack);
    SET @date = (SELECT booked_date FROM BOOKING WHERE booking_id = book);

    UPDATE TRANSACTION 
    SET end_meter_reading = meter_read,

    extra_kms = (CASE 
                WHEN (end_meter_reading-start_meter_reading)> (@maxi * (1 + DATEDIFF(CURDATE(), @date)))
                THEN (end_meter_reading - (@maxi * (1 + DATEDIFF(CURDATE(), @date))) )
                ELSE 0 END),

    total_rent = @dailyrent * (1 + DATEDIFF(CURDATE(), @date)) + extra_kms * @maxrent,

    damage = dam,
    to_pay = total_rent + damage - paid_key_money, 
    return_description = descr, 
    owner_commision = total_rent * 0.7

    WHERE booking_id = book;

END$$
DELIMITER ;


/*AUTO UPDATE BOOKING completed TRIGGER*/
DELIMITER $$
CREATE TRIGGER UPDATE_BOOKING_ON_COMPLETION
AFTER UPDATE ON TRANSACTION
FOR EACH ROW
BEGIN

    UPDATE BOOKING
    SET BOOKING.completed = 'Y'
    WHERE BOOKING.booking_id = NEW.booking_id;

END$$
DELIMITER ;


/*AUTO UPDATE VEHICLE kms TRIGGER*/
DELIMITER $$
CREATE TRIGGER UPDATE_VEHICLE_ON_COMPLETION
AFTER UPDATE ON TRANSACTION
FOR EACH ROW
BEGIN

    UPDATE VEHICLE
    SET total_kms = NEW.end_meter_reading
    WHERE VEHICLE.id = (SELECT VehicleID FROM BOOKING WHERE BOOKING.booking_id = NEW.booking_id);

END$$
DELIMITER ;


/*Get a View of a Transaction*/
DELIMITER $$
CREATE PROCEDURE VIEW_TRANSACTION (IN book CHAR(10))
BEGIN

    SELECT booking_id AS 'BOOKING ID', paid_key_money AS 'KEY MONEY PAID', start_meter_reading AS 'START METER READING', end_meter_reading AS 'END METER READING', 
    extra_kms AS 'EXTRA KMS', total_rent AS 'TOTAL RENT', damage AS 'DAMAGE', to_pay AS 'AMOUNT TO BE PAID', 
    return_description AS 'DESCRIPTION'
    FROM TRANSACTION WHERE booking_id = book;

END$$
DELIMITER ;
