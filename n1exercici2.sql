CREATE TABLE Customer(
	Customer_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    Customer_name VARCHAR(50),
    Customer_surname VARCHAR(80),
    Street_address VARCHAR(100),
    Postal_code VARCHAR(10),
    City VARCHAR(90),
    County VARCHAR(60),
    Phone VARCHAR(15)
);
ALTER TABLE Customer
AUTO_INCREMENT = 1000;

CREATE TABLE Store(
	Store_ID INT AUTO_INCREMENT PRIMARY KEY,
    Address VARCHAR(100),
    Postal_code VARCHAR(10),
    City VARCHAR(90),
    County VARCHAR(60)
);
CREATE TABLE Employee(
	NIF VARCHAR(15) PRIMARY KEY,
    Employee_name VARCHAR(50),
    Employee_surname VARCHAR(80),
    Phone VARCHAR(15),
    Store_ID INT REFERENCES Store(Store_ID),
    Cook_Delivery BOOLEAN
);
CREATE TABLE Orders(
	Order_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    Date_time DATETIME,
    Pickup_type BOOLEAN,
    Total_price DECIMAL(6, 2),
    Customer_ID BIGINT REFERENCES Customer(Customer_ID)
);
CREATE TABLE Deliveries(
	Order_ID BIGINT REFERENCES Orders(Order_ID),
    Employee VARCHAR(15) REFERENCES Employee(NIF),
    Date_time DATETIME,
    PRIMARY KEY (Order_ID, Employee)
);
CREATE TABLE Products(
	Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_type VARCHAR(10),
    DescriptionP VARCHAR(150),
    Image BLOB,
    Price DECIMAL (4, 2),
    CONSTRAINT Product_type_CK CHECK (Product_type("Pizza", "Hamburguer", "Drink"))
);
ALTER TABLE Products
AUTO_INCREMENT = 100;

CREATE TABLE Order_products(
	Order_ID BIGINT REFERENCES Orders(Order_ID),
    Product_ID INT REFERENCES Products(Product_ID),
    Product_amount INT,
    PRIMARY KEY (Order_ID, Product_ID)
);
CREATE TABLE Pizza_cattegories(
	Cattegory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Cattegory_name VARCHAR(20),
    Product_ID INT REFERENCES Product(Product_ID)
);