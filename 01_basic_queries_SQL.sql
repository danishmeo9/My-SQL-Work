select * from sales;

select saleDate,Amount,Customers from sales

--  /*This will selcet the Specific data*/
select Amount,Customers, GeoID from sales;


-- This will select the specific data
SELECT saleDate, Amount, Customers FROM sales;

-- Selects sale date, amount, boxes sold, and calculates price per box (Amount divided by Boxes)
SELECT SaleDate, Amount, Boxes, Amount/Boxes AS PricePerBox
FROM sales;

-- Impose Condition select amount greater than 10000
select * from sales
where amount>10000
order by amount desc;


select * from sales
where GeoID ='G1'
order by PID,Amount desc;

-- values greater than 10000 and year is 2022
select * from sales
where amount>10000 and SaleDate>='2022-01-01';



-- Top 3 dates with the highest total number of customers
SELECT SaleDate, SUM(Customers) AS TotalCustomers
FROM sales
GROUP BY SaleDate
ORDER BY TotalCustomers DESC
LIMIT 3;

-- boxes between 0 and 50
select * from sales
where boxes>0 and boxes<50
order by amount,SaleDate;


-- Another way
select * from sales
where boxes between 0 and 50;

select SaleDate,Amount,Customers,Boxes,weekday(SaleDate) AS 'Day of week'  from sales
where  weekday(SaleDate)='4';

-- let's use another table 
select * from people
where team='Delish' or team='jucies'
