CREATE TABLE Supplier (
	NIF VARCHAR(20) PRIMARY KEY,
    Supplier_Name VARCHAR(50),
    Street VARCHAR(100),
    Street_number INT,
    Floor INT,
    Door VARCHAR(8),
    City VARCHAR(90),
    Postal_code VARCHAR(10),
    Country VARCHAR(56),
    Phone VARCHAR(15),
    Fax VARCHAR(10)
);
CREATE TABLE Brand(
	Brand_name VARCHAR(25) PRIMARY KEY,
    Supplier_NIF VARCHAR(20) REFERENCES Supplier(NIF)
);
CREATE TABLE Glasses(
	Brand VARCHAR(25) REFERENCES Brand(Brand_name),
    Graduation_left DECIMAL(2, 2),
    Graduation_right DECIMAL(2, 2),
    Colour_left VARCHAR(15),
    Colour_right VARCHAR(15),
    Frame_type VARCHAR(15),
    Frame_colour VARCHAR(15),
    Price DECIMAL(5, 2),
    Glasses_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    CONSTRAINT CK_FrameType CHECK (Frame_type IN('Floating', "Horn-rimmed", "Metal"))
);
CREATE TABLE Employee(
	Employee_ID INT AUTO_INCREMENT PRIMARY KEY,
    Employee_name VARCHAR(50),
    Hire_date DATE
);
CREATE TABLE Customer(
	Customer_name VARCHAR(50),
    Address VARCHAR(150),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Register_date DATE,
    Customer_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    Referral_ID BIGINT REFERENCES Customer(Customer_ID)
);
CREATE TABLE Purchase(
	Transaction_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    Glasses_ID BIGINT REFERENCES Glasses(Glasses_ID),
    Customer_ID BIGINT REFERENCES Customer(Customer_ID),
    Employee_ID INT REFERENCES Employee(Employee_ID)
);