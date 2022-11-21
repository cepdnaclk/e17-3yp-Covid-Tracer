/*				COVID TRACER TEST SCRIPT	        */
/*                      QUERIES                     */


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


/*  merchant location  */
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

/* ------------------------------------------------------------------------------- */
