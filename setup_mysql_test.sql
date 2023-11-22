db = MySQLdb.connect(
    host='localhost',
    port=3306,
    user='root',
    passwd='your_root_password'
)

cursor = db.cursor()

cursor.execute("CREATE DATABASE IF NOT EXISTS hbnb_test_db")

cursor.execute("CREATE USER IF NOT EXISTS 'hbnb_test'@'localhost' IDENTIFIED BY 'hbnb_test_pwd'")

cursor.execute("GRANT ALL PRIVILEGES ON hbnb_test_db.* TO 'hbnb_test'@'localhost'")

cursor.execute("GRANT SELECT ON performance_schema.* TO 'hbnb_test'@'localhost'")

cursor.execute("FLUSH PRIVILEGES")

cursor.close()
db.close()
