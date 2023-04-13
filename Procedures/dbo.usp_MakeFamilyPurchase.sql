/*Входной параметр (@FamilySurName varchar(255)) одно из значений аттрибута SurName таблицы dbo.Family
Процедура при вызове обновляет данные в таблицы dbo.Family в поле BudgetValue по логике
      1. dbo.Family.BudgetValue - sum(dbo.Basket.Value), где dbo.Basket.Value покупки для переданной в процедуру семьи
      2. При передаче несуществующего dbo.Family.SurName пользователю выдается ошибка, что такой семьи нет    */

IF OBJECT_ID('MakeFamily') IS NOT NULL
DROP PROCEDURE MakeFamily;
GO

CREATE PROCEDURE MakeFamily
(@FamilySurName  AS varchar(255)) AS
BEGIN TRY
UPDATE Family
SET BudgetValue = 
(SELECT (F.BudgetValue - SUM(B.Value)) AS Budget FROM Family AS F
JOIN Basket AS B
ON F.ID = B.ID_Family
WHERE F.SurName LIKE @FamilySurName
GROUP BY F.BudgetValue) 
END TRY

BEGIN CATCH
PRINT 'Такой семьи нет'
END CATCH;
GO

EXEC MakeFamily '123';
GO

SELECT * FROM Family;
GO

SELECT (F.BudgetValue - SUM(B.Value)) AS Budget FROM Family AS F
JOIN Basket AS B
ON F.ID = B.ID_Family
WHERE F.SurName LIKE '123'
GROUP BY F.BudgetValue