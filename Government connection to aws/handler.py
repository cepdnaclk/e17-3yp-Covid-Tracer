import pymysql

host = "test.cwjgqq5tbjng.us-east-1.rds.amazonaws.com"
user = "admin"
password = "helloworld"
port = "3306"
database ="COVID_TRACER"

connection = pymysql.connect(host=host, user=user, password=password, db=database)

def lambda_handler(event,context()):
    cursor = connection.cursor()
    cursor.execute('SELECT* FROM LOCAL_COMMUNITY')

    rows = cursor.fetchall()

    for row in rows:
        print("{0} {1} {2} {3}".format(row[0], row[1], row[2], row[3]))


