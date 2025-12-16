USE SalesAnalysisDB;
GO

Insert Column :-

Alter table dbo.customers
add Country varchar(50)

Update Particular Column of Null Values :-

UPDATE dbo.customers
SET Country = 'India'
WHERE Country IS NULL;

Remove Entire column :-

BEGIN TRAN;

Delete from customers
where Country = 'India'

ROLLBACK TRANSACTION;

Monthly Sales:-

SELECT
YEAR(PaymentDate) AS SalesYear,
MONTH(PaymentDate) AS SalesMonth,
SUM(AmountPaid) AS Sales
FROM payments
GROUP BY YEAR(PaymentDate), MONTH(PaymentDate)
ORDER BY SalesYear, SalesMonth;


Top Customers (by total amount paid):-

Select CustomerName, Sum(AmountPaid) as totalpayment from customers
join orders on customers.CustomerID= orders.CustomerID
join payments on payments.OrderID= orders.OrderID
group by CustomerName
order by totalpayment DESC;


Best Selling Products (by quantity):-

Select products.ProductName, SUM(Quantity) as totalqty from products
join orders on products.ProductID = orders.ProductID
group by products.ProductName
order by totalqty desc;


Revenue City wise:-

Select City, SUM(AmountPaid) as Revenue from customers
join orders on orders.CustomerID = customers.CustomerID
join payments on payments.OrderID = orders.OrderID
group by City
order by Revenue desc

List all customers from Delhi:-

Select CustomerName, City from customers
where City = 'Delhi'

Show all products in the "Electronics" category:-

Select ProductName, Category from products
where Category = 'Electronics'

Find all orders made in February 2024.
Select top 2 OrderID,OrderDate,MONTH(orderdate) as Oder_Month,YEAR(orderdate) as Order_Year  from orders
where OrderDate between '2024-02-01' and '2024-03-01';

Select OrderID,OrderDate,
       DATENAME(MONTH, OrderDate) AS MonthName from orders
	   where DATENAME(MONTH, OrderDate) = 'February' and YEAR(OrderDate) = '2024'

Display all payments made via “CreditCard”:-

Select CustomerName, PaymentID, PaymentMode from customers
join orders on orders.CustomerID = customers.CustomerID
join payments on payments.OrderID = orders.OrderID
where PaymentMode = 'Credit Card'

Display all the consumer residing in delhi and name Contains Letter R:-

Select CustomerName, City from customers
Where CustomerName like '%R%' And City = 'Mumbai'

List customer names and their cities:-

Select CustomerName, City from customers

Aggregation & Grouping:-

Total quantity sold for each product:-

Select ProductName, Sum(Quantity) As Total_Quantity from products
Join orders on orders.ProductID = products.ProductID
group by ProductName
order by Total_Quantity DESC;

Total sales (AmountPaid) for eachmonth in Desecending_order:-

Select DATENAME(MONTH, PaymentDate) as MN, SUM(AmountPaid) as TS from payments
group by DATENAME(MONTH, PaymentDate)
order by MN DESC;

Total revenue from each city:-

Select City, SUM(AmountPaid) as revenue from customers
	join orders on orders.CustomerID = customers.CustomerID
	join payments on payments.OrderID = orders.OrderID
group by City
order by revenue Desc;

Total revenue by city using a CTE:-

with Cityrevenue as (Select City, SUM(AmountPaid) as revenue from customers
	join orders on orders.CustomerID = customers.CustomerID
	join payments on payments.OrderID = orders.OrderID
group by City
) Select * from Cityrevenue
ORDER BY revenue DESC;

Highest revenue generated city:-

with Cityrevenue as (Select City, SUM(AmountPaid) as revenue from customers
	join orders on orders.CustomerID = customers.CustomerID
	join payments on payments.OrderID = orders.OrderID
group by City),
cityranked as (Select City, revenue, ROW_NUMBER() over (order by revenue Desc) as rank
from Cityrevenue)
Select * from cityranked
where rank = 1


Advance SQL Query Queries:-

Top Customers by Amount Paid by Rownumber(as data has unique amountpaid) :--

with Base as (Select Distinct(customers.CustomerID), Sum(AmountPaid) as totalpayment
	from customers
	JOIN orders ON customers.CustomerID = orders.CustomerID
    JOIN payments ON payments.OrderID = orders.OrderID
	GROUP BY customers.CustomerID),
		CustRank as 
		(Select Base.CustomerID, 
		Base.totalpayment, 
		ROW_NUMBER() over (order by CustomerID asc, totalpayment Desc ) as rank
from Base)
SELECT Top 3 CustomerID, totalpayment, rank
FROM CustRank
order by rank;

Rank Customers based on Amount paid :--

with Base as (Select customers.CustomerName, customers.CustomerID, Sum(AmountPaid) as totalpayment
	from customers
	JOIN orders ON customers.CustomerID = orders.CustomerID
    JOIN payments ON payments.OrderID = orders.OrderID
	GROUP BY customers.CustomerName, customers.CustomerID),
		CustRank as 
		(Select base.CustomerName,Base.CustomerID, 
		Base.totalpayment, 
		Dense_Rank() over (order by totalpayment Desc ) as rank
from Base)
SELECT Top 3 CustomerName, CustomerID, totalpayment, rank
FROM CustRank
order by rank;

Monthly sales and a year-wise running total of sales:-

WITH MonthlySales AS (
    SELECT
        YEAR(PaymentDate)  AS SalesYear,
        MONTH(PaymentDate) AS SalesMonth,
        SUM(AmountPaid)    AS MonthlySales
    FROM payments
    GROUP BY YEAR(PaymentDate), MONTH(PaymentDate)
)
SELECT *,
       SUM(MonthlySales) OVER (PARTITION BY Salesmonth ORDER BY SalesMonth
       ) AS RunningTotal
FROM MonthlySales;
 
    
	
















