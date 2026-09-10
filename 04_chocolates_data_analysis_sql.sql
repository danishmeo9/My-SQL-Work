USE `awesome chocolates`;
select* from sales;
select *from people;
select * from products;
select * from geo;


-- -----------------------------------------
-- Data Analysis On Chocolates Data
-- -----------------------------------------

-- 1.Data Overview
select count(*) as total_orders from sales;  -- Total Orders
select min(saleDate) as start_date,max(saleDate) as end_date from sales;   -- Start and end Dates
select count(distinct spid) as total_sales_person from sales;   -- Total Sales Person
select count(distinct pid) as total_products from sales;  -- Totalproducts
select count(distinct GeoID) as total_geos from sales;   -- geographics

-- 2.Overall KPIs
select
	sum(amount) as total_revenue,
    sum(Boxes) as  total_boxes,
    sum(customers) as total_customers,
    count(*) as total_transactions,
    round(sum(amount)*1.0/count(*),2) as avg_amount_per_txn,
    round(sum(amount)*1.0/nullif(sum(boxes),0),2) as avg_price_per_box
from sales;

-- 3.profit calculation

SELECT
    p.product,
    SUM(s.Boxes) AS total_boxes,
    SUM(s.amount) AS total_revenue,
    SUM(s.Boxes * p.Cost_per_box) AS total_cost,
    SUM(s.amount) - SUM(s.Boxes * p.Cost_per_box) AS total_profit,
    ROUND((SUM(s.amount) - SUM(s.Boxes * p.Cost_per_box)) * 100.0 / NULLIF(SUM(s.amount), 0), 2) AS profit_margin_pct
FROM sales s
JOIN products p ON s.PID = p.PID
GROUP BY p.product
ORDER BY total_profit DESC;


-- 4.Sales Person Performance
select
	pe.SalesPerson,
    pe.Team,
    pe.Location,
    sum(s.amount) as total_revenue,
    sum(s.Boxes) as total_boxes,
    sum(s.customers) as total_cutomers,
    rank() over(order by sum(s.amount) DESC) as sales_rank
from sales  s
join people pe on s.SPID=pe.SPID
group by pe.SalesPerson,pe.Team,pe.Location
order by total_revenue DESC;


-- 5.Top 10 Sales People
select* from(
	select
	pe.SalesPerson,
    pe.Team,
    sum(s.amount) as total_revenue
    from sales  s
join people pe on s.SPID=pe.SPID
group by pe.SalesPerson,pe.Team
)t
order by total_revenue DESC
limit 10;


-- 6. Top 5 Selling Products
-- Top 5 Selling Products by revenue
SELECT * FROM (
    SELECT
        p.product,
        p.Category,
        SUM(s.amount) AS total_revenue,
        SUM(s.Boxes) AS total_boxes
    FROM sales s
    JOIN products p ON s.PID = p.PID
    JOIN people pe ON s.SPID = pe.SPID
    GROUP BY p.product, p.Category
) t
ORDER BY total_revenue DESC
LIMIT 5;


-- 7.Sales Trend Over Time (Monthly)

SELECT DATE_FORMAT(s.SaleDate, '%Y-%m') AS month,
       SUM(s.amount) AS monthly_revenue,
       SUM(s.Boxes) AS monthly_boxes
FROM sales s
GROUP BY DATE_FORMAT(s.SaleDate, '%Y-%m')
ORDER BY month DESC;

-- 8. Sales Performance Gap: Which Location Needs Improvement?
SELECT p.Location, 
       SUM(s.amount) AS total_revenue,
       SUM(s.Boxes) AS total_boxes,
       ROUND(AVG(s.amount), 2) AS avg_sale_value,
       COUNT(*) AS number_of_sales
FROM sales s
JOIN people p ON s.SPID = p.SPID
GROUP BY p.Location
ORDER BY total_revenue ASC;


-- -------------------------------------------------------------
-- Enough for this Data
-- --------------------------------------------------------------