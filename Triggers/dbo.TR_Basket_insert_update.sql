/*  Если в таблицу dbo.Basket за раз добавляются 2 и более записей одного ID_SKU, 
то значение в поле DiscountValue, для этого ID_SKU рассчитывается по формуле Value * 5%, иначе DiscountValue = 0   */
IF OBJECT_ID('TR_Basket_insert_update') IS NOT NULL  
    DROP TRIGGER TR_Basket_insert_update;  
GO  

CREATE OR ALTER  TRIGGER TR_Basket_insert_update 

   ON  dbo.Basket

   Instead OF INSERT

AS

BEGIN

INSERT INTO Basket

 SELECT i.ID_SKU,

        i.Id_Family,

             i.Quantity,

             i.[Value],

             i.PurchaseDate,

        IIF(((SELECT COUNT(1) FROM INSERTED i2 WHERE i2.ID_SKU = i.ID_SKU) > 1),Value*0.05,0)

 FROM Inserted i;

END
