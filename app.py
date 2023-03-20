import  mysql.connector
from flask import Flask, render_template

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="",
    database="properties"
)

app = Flask(__name__)

mycursor1 = mydb.cursor()
mycursor1.execute("SELECT * FROM users")
users_vse = mycursor1.fetchall()

mycursor2 = mydb.cursor()
mycursor2.execute("SELECT * FROM activity_log")
activity = mycursor2.fetchall()

mycursor3 = mydb.cursor()
mycursor3.execute("SELECT * FROM addresses")
adresy = mycursor3.fetchall()

mycursor4 = mydb.cursor()
mycursor4.execute("SELECT * FROM `vyhledej_majitele`")
majitele = mycursor4.fetchall()

mycursor5 = mydb.cursor()
mycursor5.execute("SELECT * FROM `pocet_zaznamu_na_tabulku`")
zaznamy = mycursor5.fetchall()

mycursor6 = mydb.cursor()
mycursor6.execute("SELECT * FROM `pocet_nemovitosti_podle_psc`")
nemovitosti_pocet_psc = mycursor6.fetchall()

mycursor7 = mydb.cursor()
mycursor7.execute("SELECT * FROM `types` ")
typy_nemovitosti = mycursor7.fetchall()
    
    
# AHOJKY
@app.route("/")
def table():
    return render_template("table.html", data1 = users_vse, data2 = activity, data3 = adresy, data4 = majitele, data5 = zaznamy, data6 = nemovitosti_pocet_psc, data7 = typy_nemovitosti)

if __name__ == '__main__':
    app.run(debug=True)