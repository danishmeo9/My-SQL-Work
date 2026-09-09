
USE `awesome chocolates`;


-- using in cluase
select * from people
where team in ('Delish','yummies');

-- pattern Matching
select * from people
where Salesperson like 'D%';  -- this show me the names which starts with 'D'.
 select * from people where Salesperson like '%d';   -- this will show the name which ends with deallocate prepare
 
 -- creating new column
 select * from sales
select saleDate, Amount,
		case    when Amount < 1000 then 'under1k'
				when  Amount < 5000 then 'under5k'
				when  Amount < 10000 then  'under10k'
			else '10k or more'
	end as 'amount category'
from sales;


-- joining two tables
select * from sales;
select * from people;

select s.saleDate,s.amount,p.Salesperson,s.spid,p.SPId
from sales s
join people p on p.SPID,s.spid;


-- Joining sales and people tables on Salesperson ID
SELECT s.SaleDate, s.Amount, p.Salesperson, s.SPId, p.SPId
FROM sales s
JOIN people p ON p.SPId = s.SPId;

-- left join
SELECT s.SaleDate, s.Amount, p.Salesperson, s.SPId
FROM sales s
LEFT JOIN people p ON p.SPId = s.SPId;