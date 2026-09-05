-- 1. Create Customers Dimension
CREATE TABLE Customers (
    CustomerID VARCHAR(50) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Segment VARCHAR(50) NOT NULL
);

-- 2. Create Locations Dimension
CREATE TABLE Locations (
    LocationID INT IDENTITY(1,1) PRIMARY KEY,
    PostalCode VARCHAR(20) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Region VARCHAR(50) NOT NULL,
    CONSTRAINT UQ_Location UNIQUE (PostalCode, City, State, Region)
);

-- 3. Create Products Dimension
CREATE TABLE Products (
    ProductID VARCHAR(50) PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    SubCategory VARCHAR(50) NOT NULL
);

-- 4. Create Orders Fact Table (Header Level)
CREATE TABLE Orders (
    OrderID VARCHAR(50) PRIMARY KEY,
    CustomerID VARCHAR(50) NOT NULL,
    LocationID INT NOT NULL,
    OrderDate DATE NOT NULL,
    ShipDate DATE NOT NULL,
    ShipMode VARCHAR(50) NOT NULL,
    ShippingDays INT NOT NULL,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    CONSTRAINT FK_Orders_Locations FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- 5. Create OrderDetails Fact Table (Line-Item Level)
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID VARCHAR(50) NOT NULL,
    ProductID VARCHAR(50) NOT NULL,
    Sales DECIMAL(18, 4) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


