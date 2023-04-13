USE TestDb;
IF OBJECT_ID('dbo.udf_GetSKUPrice') IS NOT NULL
DROP FUNCTION dbo.udf_GetSKUPrice;
GO

CREATE FUNCTION dbo.udf_GetSKUPrice
(@ID_SKU AS INT) RETURNS DECIMAL(18,2)
AS
BEGIN
Declare @A1 Decimal(25,15) 
SET @A1 = (SELECT (SUM(Value) / SUM(Quantity)) AS AllSum FROM dbo.Basket
WHERE ID_SKU = @ID_SKU )
RETURN @A1
END ;
GO

SELECT dbo.udf_GetSKUPrice(ID) AS GetSKUPrice FROM SKU;




