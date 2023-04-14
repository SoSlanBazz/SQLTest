/*������� �������� (@FamilySurName varchar(255)) ���� �� �������� ��������� SurName ������� dbo.Family
��������� ��� ������ ��������� ������ � ������� dbo.Family � ���� BudgetValue �� ������
      1. dbo.Family.BudgetValue - sum(dbo.Basket.Value), ��� dbo.Basket.Value ������� ��� ���������� � ��������� �����
      2. ��� �������� ��������������� dbo.Family.SurName ������������ �������� ������, ��� ����� ����� ���    */

IF OBJECT_ID('MakeFamily') IS NOT NULL
DROP PROCEDURE MakeFamily;
GO

CREATE OR ALTER PROCEDURE MakeFamily
(@FamilySurName  AS varchar(255)) AS
IF(EXISTS (SELECT BudgetValue  FROM Family AS F
WHERE F.SurName LIKE @FamilySurName))
BEGIN 
UPDATE Family
SET BudgetValue = (SELECT (F.BudgetValue - SUM(B.Value)) AS Budget FROM Family AS F
JOIN Basket AS B
ON F.ID = B.ID_Family
WHERE F.SurName LIKE @FamilySurName
GROUP BY F.BudgetValue) WHERE @FamilySurName LIKE SurName
END

ELSE
BEGIN
PRINT '����� ����� ���'
END;
GO


EXEC MakeFamily '1234';
GO

SELECT * FROM Family;
GO