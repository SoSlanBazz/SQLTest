/*������� �������� (@FamilySurName varchar(255)) ���� �� �������� ��������� SurName ������� dbo.Family
��������� ��� ������ ��������� ������ � ������� dbo.Family � ���� BudgetValue �� ������
      1. dbo.Family.BudgetValue - sum(dbo.Basket.Value), ��� dbo.Basket.Value ������� ��� ���������� � ��������� �����
      2. ��� �������� ��������������� dbo.Family.SurName ������������ �������� ������, ��� ����� ����� ���    */

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
PRINT '����� ����� ���'
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