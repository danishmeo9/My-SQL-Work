USE `awesome chocolates`;

-- group by and creating reports
select geoID,sum(amount),sum(Boxes),avg(amount)
from sales
group by geoID;

-- Group sales amounts by salesperson location
SELECT p.Location, SUM(s.Amount) AS TotalAmount
FROM sales s
JOIN people p ON p.SPId = s.SPId
GROUP BY p.Location
ORDER BY TotalAmount DESC;


