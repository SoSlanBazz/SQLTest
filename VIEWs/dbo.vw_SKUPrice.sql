/* Возвращает все атрибуты продуктов из таблицы dbo.SKU и расчетный атрибут со стоимостью одного продукта (используя функцию dbo.udf_GetSKUPrice)  */

CREATE VIEW SKUPrice (ID, NAME, Price) AS
SELECT ID, NAME, dbo.udf_GetSKUPrice(ID) FROM SKU;
GO

SELECT * FROM SKUPrice;