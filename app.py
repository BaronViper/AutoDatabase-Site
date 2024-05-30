from flask import Flask, render_template, json, redirect
from flask_mysqldb import MySQL
from flask import request
import os

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'classmysql.engr.oregonstate.edu'
app.config['MYSQL_USER'] = 'cs340_ONID'
app.config['MYSQL_PASSWORD'] = 'XXXX'  #last 4 of onid
app.config['MYSQL_DB'] = 'cs340_ONID'
app.config['MYSQL_CURSORCLASS'] = "DictCursor"

mysql = MySQL(app)


# Routes
@app.route('/')
def root():
    return render_template("index.j2")


@app.route('/transaction-details', methods=["GET", "POST"])
def transaction_details():
    if request.method == "GET":
        query = "SELECT * FROM TransactionDetails"
        query2 = "SELECT * FROM TransactionType"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        details = cursor.fetchall()
        cursor.execute(query2)
        types = cursor.fetchall()
        reference_dict = {}
        for transaction_type in types:
            reference_dict.update({transaction_type["transactionTypeID"]: transaction_type["description"]})
        return render_template("transaction_details.j2", data=details, types=reference_dict)


@app.route('/create-transaction-details', methods=["GET", "POST"])
def create_details():
    if request.method == "GET":
        return render_template("create_transaction_details.j2")
    elif request.method == "POST":
        transaction_id = request.form.get("transactions")
        car_id = request.form.get("cars")
        transaction_type = request.form.get("type")
        unit_price = request.form.get("cost")

        query = ("INSERT INTO TransactionDetails (transactionID, carID, transactionTypeID, unitPrice) VALUES (%s, %s, "
                 "%s, %s)")
        values = (transaction_id, car_id, transaction_type, unit_price)
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(query, values)
            mysql.connection.commit()
            cursor.close()
        except:
            return "Error in Creating New Transaction Detail: " + str(Exception)
        return redirect("/transaction-details")


@app.route('/edit-transaction-details/<int:transactionDetailsID>', methods=["GET", "POST"])
def edit_details(transactionDetailsID):
    if request.method == "GET":
        query = "SELECT * FROM TransactionDetails WHERE transactionDetailsID = %s"
        cursor = mysql.connection.cursor()
        cursor.execute(query, (transactionDetailsID,))
        transaction_detail = cursor.fetchone()
        cursor.close()
        return render_template("edit_transaction_detail.j2", transaction_detail=transaction_detail)
    elif request.method == "POST":
        transaction_details_id = request.form.get("transactionDetailsID")
        transaction_id = request.form.get("transactions")
        car_id = request.form.get("cars")
        transaction_type = request.form.get("type")
        unit_price = request.form.get("cost")
        query = ("UPDATE TransactionDetails SET transactionDetailsID = %s, transactionID = %s, carID = %s, "
                 "transactionTypeID = %s, unitPrice = %s WHERE transactionDetailsID = %s")
        values = (transaction_details_id, transaction_id, car_id, transaction_type, unit_price, transactionDetailsID)
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(query, values)
            mysql.connection.commit()
            cursor.close()
        except:
            return "Error in Editing Transaction Detail: " + str(Exception)
        return redirect("/transaction-details")


@app.route('/delete-transaction-details/<int:transactionDetailsID>', methods=['POST', 'GET'])
def delete_details(transactionDetailsID):
    query = "DELETE FROM TransactionDetails WHERE transactionDetailsID = %s"
    cursor = mysql.connection.cursor()
    cursor.execute(query, (transactionDetailsID,))
    mysql.connection.commit()
    return redirect("/transaction-details")


@app.route('/conditions')
def conditions():
    return render_template("car_conditions.j2")


@app.route('/customers', methods=["GET", "POST"])
def customers():
    if request.method == "GET":
        query = "SELECT * FROM Customers"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        details = cursor.fetchall()
        return render_template("customers.j2", data=details)


@app.route('/create-customers', methods=["GET", "POST"])
def create_customers():
    if request.method == "GET":
        return render_template("create_customers.j2")
    elif request.method == "POST":
        name = request.form.get("name")
        email = request.form.get("email")
        number = request.form.get("number")
        address1 = request.form.get("address1")
        address2 = request.form.get("address2")
        city = request.form.get("city")
        state = request.form.get("state")
        postal = request.form.get("postal")

        query = (
            "INSERT INTO Customers (customerName, emailAddress, phoneNumber, addressLine1, addressLine2, city, state, postalCode) VALUES (%s, %s, "
            "%s, %s, %s, %s, %s, %s)")
        values = (name, email, number, address1, address2, city, state, postal)
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(query, values)
            mysql.connection.commit()
            cursor.close()
        except Exception as e:
            return "Error in Creating New Customer: " + str(e)
        return redirect("/customers")


@app.route('/edit-customers/<int:customerID>', methods=["GET", "POST"])
def edit_customer(customerID):
    if request.method == "GET":
        query = "SELECT * FROM Customers WHERE customerID = %s"
        cursor = mysql.connection.cursor()
        cursor.execute(query, (customerID,))
        customer = cursor.fetchone()
        cursor.close()
        return render_template("edit_customer.j2", customer=customer)
    elif request.method == "POST":
        customer_id = request.form.get("customerID")
        name = request.form.get("name")
        email = request.form.get("email")
        number = request.form.get("number")
        address1 = request.form.get("address1")
        address2 = request.form.get("address2")
        city = request.form.get("city")
        state = request.form.get("state")
        postal = request.form.get("postal")

        query = ("UPDATE Customers SET customerID = %s, customerName = %s, emailAddress = %s, "
                 "phoneNumber = %s, addressLine1 = %s, addressLine2 = %s, city = %s, state = %s, postalCode = %s WHERE "
                 "customerID = %s")
        values = (customer_id, name, email, number, address1, address2, city, state, postal, customerID)
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(query, values)
            mysql.connection.commit()
            cursor.close()
        except Exception as e:
            return "Error in Editing Customer: " + str(e)
        return redirect("/customers")


@app.route('/delete-customers/<int:customerID>', methods=['POST', 'GET'])
def delete_customers(customerID):
    query = "DELETE FROM Customers WHERE customerID = %s"
    cursor = mysql.connection.cursor()
    cursor.execute(query, (customerID,))
    mysql.connection.commit()
    return redirect("/customers")


@app.route('/employees', methods=["GET", "POST"])
def employees():
    if request.method == "GET":
        query = "SELECT * FROM Employees"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        details = cursor.fetchall()
        return render_template("employees.j2", data=details)


@app.route('/create-employees', methods=["GET", "POST"])
def create_employees():
    if request.method == "GET":
        return render_template("create_employees.j2")
    elif request.method == "POST":
        name = request.form.get("name")
        email = request.form.get("email")
        number = request.form.get("number")

        query = (
            "INSERT INTO Employees (employeeName, emailAddress, phoneNumber) VALUES (%s, %s, "
            "%s)")
        values = (name, email, number)
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(query, values)
            mysql.connection.commit()
            cursor.close()
        except Exception as e:
            return "Error in Creating New Employee: " + str(e)
        return redirect("/employees")


@app.route('/edit-employees/<int:employeeID>', methods=["GET", "POST"])
def edit_employee(employeeID):
    if request.method == "GET":
        query = "SELECT * FROM Employees WHERE employeeID = %s"
        cursor = mysql.connection.cursor()
        cursor.execute(query, (employeeID,))
        employee = cursor.fetchone()
        cursor.close()
        return render_template("edit_employee.j2", employee=employee)
    elif request.method == "POST":
        employee_id = request.form.get("employeeID")
        name = request.form.get("name")
        email = request.form.get("email")
        number = request.form.get("number")

        query = ("UPDATE Employees SET employeeID = %s, employeeName = %s, emailAddress = %s, "
                 "phoneNumber = %s WHERE employeeID = %s")
        values = (employee_id, name, email, number, employeeID)
        try:
            cursor = mysql.connection.cursor()
            cursor.execute(query, values)
            mysql.connection.commit()
            cursor.close()
        except Exception as e:
            return "Error in Editing Employee: " + str(e)
        return redirect("/employees")


@app.route('/delete-employees/<int:employeeID>', methods=['POST', 'GET'])
def delete_employees(employeeID):
    query = "DELETE FROM Employees WHERE employeeID = %s"
    cursor = mysql.connection.cursor()
    cursor.execute(query, (employeeID,))
    mysql.connection.commit()
    return redirect("/employees")


@app.route('/transaction-types')
def transaction_types():
    return render_template("transaction_types.j2")


@app.route('/transactions')
def transactions():
    return render_template("transactions.j2")


# Listener
if __name__ == "__main__":
    app.run(port=6837, debug=True)
