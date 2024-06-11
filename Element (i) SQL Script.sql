--BASIC QUERY------

--BQ1: Creating Database
CREATE DATABASE NaturalGarden --This creates the database with the desired name

USE NaturalGarden -- Use the correct Database

-- BQ2: Create a table called flower with correct attributes
CREATE TABLE Flower ( 
FlwID INT PRIMARY KEY IDENTITY(1,1), -- IDENTITY allows each row to have a unique idenity that goes up by 1
FlwName NVARCHAR(30), -- allows for any charachters up to 30 
FlwColour INT, --stores numbers 
FlwPrice DECIMAL(10,2), --stores decimals of up to 2 places
FlwExpiry DATE, -- only stores the value as a date
)


--BQ3: Insert 10 records of flowers
INSERT INTO Flower VALUES ('Rose',1,10.50,'04/15/2023') --values added the FlwColour 1 is red
INSERT INTO Flower VALUES ('Lotus',2,9.45,'03/23/2023') --values added the FlwColour 2 is green
INSERT INTO Flower VALUES ('Rose',3,10.99,'05/21/2023') --values added the FlwColour 3 is orange
INSERT INTO Flower VALUES ('Jasmine',4,8.50,'06/04/2023') --values added the FlwColour 4 is blue
INSERT INTO Flower VALUES ('Sunflower',5,15.99,'07/01/2023') --values added the FlwColour 5 is yellow
INSERT INTO Flower VALUES ('Daisy',6,10.00,'02/09/2023') --values added the FlwColour 6 is violet
INSERT INTO Flower VALUES ('Tulip',7,7.50,'01/12/2023') --values added the FlwColour 7 is indigo
INSERT INTO Flower VALUES ('Lotus',8,12.99,'12/15/2022') --values added the FlwColour 8 is maroon
INSERT INTO Flower VALUES ('Magnolia',9,5.99,'11/17/2022') --values added the FlwColour 9 is gray
INSERT INTO Flower VALUES ('Lavender',10,19.99,'03/29/2023') --values added the FlwColour 10 is silver

TRUNCATE TABLE NaturalGarden..Flower --Remove all records in flower table

--BQ4: Display all the records in the Flower table
SELECT * FROM Flower



--ECHANCED QUERY-----




USE BikeStores



---EQ1) List all the staff id, first name, phone number who has a manager and has the number 555 in any part of their phone number. You must also list the manager id for each staff.
SELECT staff_id, first_name, phone, manager_id FROM staffs --selects the desired collums from the staff table
WHERE phone LIKE('%555%') AND manager_id >=0 --only shows values with 555 included anywhere in the number and the manager id is above 0






--EQ2) Display the price of the cheapest mountain bike. Name the column as The price of the cheapest mountain bike. You must only use category name (not category id) as the condition of your query.


SELECT MIN(a.list_price) AS [The price of the cheapest mountain bike] -- shows the lowest price, AS means the nickname of the collumn
FROM products a INNER JOIN categories b -- connects product and catagory table 
ON b.category_name= 'Mountain Bikes'-- connects by when the catagory name is 'Mountain Bikes'





--EQ3) Display the average price of all products and how many products are above the average price. You must give the two columns appropriate names.



SELECT (SELECT AVG(list_price) FROM products) AS [Average], COUNT(list_price) AS [Ammount over the average Number] --selects the avg price in a subqueiry so it isnt affected by the rest of the condtions
FROM products -- The count counts the ammount of times
WHERE list_price > ( -- condition is where the price is above the average (subquery)
SELECT AVG(list_price) FROM products
) 





--EQ4) Display which store has the largest (stock) quantity for the product Trek Conduit+ - 2016. You should display the store name, product name and also quantity.


SELECT stor.store_name AS [Store Name], prod.product_name AS [Product Name], quantity  AS [Quantity] --retrives the store name, product name and quaitity 
FROM products prod INNER JOIN stocks stc ON prod.product_id=stc.product_id INNER JOIN stores stor ON stc.store_id=stor.store_id --joins the products to stocks and then the stocks to the stores table
WHERE prod.product_id = 9 -- the condtion is where the product id is exatly 9
ORDER BY stc.quantity DESC -- orders the list by descsending order







--EQ5) List the first name, last name and email of the three staff who made the least number of sales in terms of total number of quantities sold. List the total number of quantities sold right after the email column using the alias Total quantity sold.

/* This was a prior attempt that almost worked
SELECT TOP 3 SUM(quantity) AS [Total Quantity Sold], staff.first_name
FROM orders ord 
INNER JOIN staffs staff ON staff.staff_id=ord.staff_id 
INNER JOIN order_items ordit ON ord.order_id=ordit.order_id
GROUP BY first_name
ORDER BY [Total Quantity Sold] ASC
*/

SELECT TOP 3  staff.first_name AS [First Name], staff.last_name AS [Last Name], staff.email AS Email, SUM(quantity) AS [Total Quantity Sold] --selects the top 3 and also all the collums needed including the SUM which counts the total quanitity
FROM orders ord --retrives from the orders table
INNER JOIN staffs staff ON staff.staff_id=ord.staff_id --joins orders and staff based on staff id
INNER JOIN order_items ordit ON ord.order_id=ordit.order_id -- joins orders and order_items based on order_id
GROUP BY staff.first_name, staff.last_name, staff.email -- allows for the values to be groups by the desired attribtues
ORDER BY [Total Quantity Sold] ASC -- this orders the sum(quaitity) by ascending






