import pymysql

host = "test.cwjgqq5tbjng.us-east-1.rds.amazonaws.com"
user = "admin"
password = "helloworld"
port = "3306"
database ="COVID_TRACER"

connection = pymysql.connect(host=host, user=user, password=password, db=database)

def lambda_handler(event,context):
    cursor = connection.cursor()
    cursor.execute('SELECT* FROM LOCAL_COMMUNITY')

    rows = cursor.fetchall()

    for row in rows:
        print("{0} {1} {2} {3}".format(row[0], row[1], row[2], row[3]))


lambda_handler()




import pymysql
import logging
import sys
import json
import boto3


host = "test.cwjgqq5tbjng.us-east-1.rds.amazonaws.com"
user = "admin"
password = "helloworld"
port = 3306
database ="COVID_TRACER"


logger = logging.getLogger()
logger.setLevel(logging.INFO)

#connection = pymysql.connect(host=host, user=user, password=password, db=database)
'''
def lambda_handler(event,context):
    cursor = connection.cursor()
    cursor.execute('SELECT* FROM LOCAL_COMMUNITY')

    rows = cursor.fetchall()

    for row in rows:
        print("{0} {1} {2} {3}".format(row[0], row[1], row[2], row[3]))

'''
try:
    connection = pymysql.connect(host=host, user=user,
                           passwd=password, db=database, connect_timeout=5)
except:
    logger.error("ERROR: Unexpected error: Could not connect to MySql instance.")
    sys.exit()

logger.info("SUCCESS: Connection to RDS mysql instance succeeded")

def lambda_handler(event, context):
    cursor = connection.cursor()
    cursor.execute('SELECT* FROM LOCAL_COMMUNITY where nic=%s',event['nic'])

    rows = cursor.fetchall()
    #return rows

    try:
        iot = boto3.client('iot-data', endpoint_url='a19bj16u0p5w28-ats.iot.us-east-1.amazonaws.com')
        topic = 'test/testing'
        payload = rows
 
        iot.publish(topic=topic,qos=0,payload=json.dumps(payload, ensure_ascii=False))    

    except:
        logger.error("ERROR: Unexpected error: Could not connect to iot core instance.")
        sys.exit()
    

    '''message = 'Hello {} {}!'.format(event['first_name'], event['last_name'])  
    return { 
        'message' : message
    }'''