USE TestDb;
IF OBJECT_ID('dbo.SKU', 'U') IS NOT NULL DROP TABLE dbo.SKU;
IF OBJECT_ID('dbo.Family', 'U') IS NOT NULL DROP TABLE dbo.Family;
IF OBJECT_ID('dbo.Basket', 'U') IS NOT NULL DROP TABLE dbo.Basket;

CREATE TABLE dbo.SKU
(
ID INT NOT NULL IDENTITY,
CONSTRAINT PR_SKU PRIMARY KEY(ID),
Name VARCHAR(255) 
);

CREATE TABLE dbo.Family
(
ID INT NOT NULL IDENTITY,
CONSTRAINT PR_Family PRIMARY KEY(ID),
SurName VARCHAR(255),
BudgetValue INT NOT NULL
);

CREATE TABLE dbo.Basket
(
ID INT NOT NULL IDENTITY,
ID_SKU INT,
ID_Family INT,
CONSTRAINT FK_BASKET_SKU FOREIGN KEY(ID_SKU) REFERENCES dbo.SKU (ID),
CONSTRAINT FK_BASKET_Family FOREIGN KEY(ID_Family) REFERENCES dbo.Family (ID),
Quantity INT, 
Value INT, 
CHECK (Quantity >= 0),
CHECK (Value >= 0),
PurchaseDate DATE DEFAULT(SYSDATETIME()), 
DiscountValue INT
);

INSERT INTO dbo.SKU(Name)
VALUES('123');

INSERT INTO dbo.Family(SurName, BudgetValue)
VALUES('123', 5);

INSERT INTO dbo.Basket(ID_SKU, ID_Family, Quantity, Value, DiscountValue)
VALUES(1, 1, 10, 100, 5);

DELETE FROM Basket;
DELETE FROM Family;
DELETE FROM SKU;

SELECT * FROM dbo.SKU;
SELECT * FROM dbo.Family;
SELECT * FROM dbo.Basket;