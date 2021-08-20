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
    serial_no CHAR(8) NOT NULL,
    nic CHAR(10) NOT NULL,
    date DATE NOT NULL ,
    arrival_time TIME NOT NULL,
    exit_time TIME NOT NULL,
    temperature DECIMAL(3,1),
    PRIMARY KEY (serial_no, nic, date, arrival_time),
    FOREIGN KEY (nic) REFERENCES LOCAL_COMMUNITY(nic),
    FOREIGN KEY (serial_no) REFERENCES MERCHANT(serial_no) );

/*  ----------------------------- */




/*				  VIEWS, TRIGGERS, STORED PROCEDURES			*/


/*                          VEHICLE OWNER                       */

/*REGISTER NEW VEHICLE OWNER*/
DELIMITER $$
CREATE PROCEDURE REGISTER_VEHICLE_RENTER (IN fn VARCHAR(30), IN mn VARCHAR(30), IN ln VARCHAR(30), IN addr VARCHAR(100),
                                          IN emailin VARCHAR(50), IN bankin VARCHAR(20), IN branchin VARCHAR(20), IN acc_noin VARCHAR(15))
BEGIN

    INSERT INTO VEHICLE_OWNER(f_name, m_name, l_name, address, email, registered_date, bank, branch, acc_no) 
    VALUES (fn, mn, ln, addr, emailin, CURDATE(), bankin, branchin, acc_noin);

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

/* ------------------------------------------------------------------------------- */


/*  POPULATE DATA   */
/*This is for Testing purpose only. Remove this section  if not for testing*/


/* ------------------------------------------------------------------------------- */