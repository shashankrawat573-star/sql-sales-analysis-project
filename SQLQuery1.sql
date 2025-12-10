USE SalesAnalysisDB;
GO

Monthly Sales
Select MONTH(PaymentDate) AS month, SUM(AmountPaid) AS Sales from payments
Group by MONTH(PaymentDate);

Top Customers
Select CustomerName, Sum(AmountPaid) as totalpayment from customers
join orders on customers.CustomerID= orders.CustomerID
join payments on payments.OrderID= orders.OrderID
group by CustomerName
order by totalpayment DESC


Top customers without group
Select CustomerName, AmountPaid from customers
join orders on customers.CustomerID= orders.CustomerID
join payments on payments.OrderID= orders.OrderID

Best Selling product

Select products.ProductName, SUM(Quantity) as totalqty from products
join orders on products.ProductID = orders.ProductID
group by products.ProductName;


Revenue City wise
Select City, SUM(AmountPaid) as Revenue from customers
join orders on orders.CustomerID = customers.CustomerID
join payments on payments.OrderID = orders.OrderID
group by City
order by Revenue desc

List all customers from Delhi.
Select CustomerName, City from customers
where City = 'Delhi'

Show all products in the "Electronics" category
Select ProductName, Category from products
where Category = 'Electronics'

Find all orders made in February 2024.
Select OrderID,OrderDate,
       DATENAME(MONTH, OrderDate) AS MonthName from orders
	   where DATENAME(MONTH, OrderDate) = 'February' and YEAR(OrderDate) = '2024'

Display all payments made via “Credit Card”.
Select CustomerName, PaymentID, PaymentMode from customers
join orders on orders.CustomerID = customers.CustomerID
join payments on payments.OrderID = orders.OrderID
where PaymentMode = 'Credit Card'

Display all the consumer residing in delhi and name Contains Letter R
Select CustomerName, City from customers
Where CustomerName like '%R%' And City = 'Mumbai'

List customer names and their cities
Select CustomerName, City from customers

Aggregation & Grouping
Total quantity sold for each product.
Select ProductName, Sum(Quantity) As totalQuantity from products
Join orders on orders.ProductID = products.ProductID
group by ProductName
order by Sum(Quantity) DESC

Total sales (AmountPaid) for eachmonth in Desecending_order
Select DATENAME(MONTH, PaymentDate) as MN, SUM(AmountPaid) as TS from payments
group by DATENAME(MONTH, PaymentDate)
order by MN DESC

Total revenue from each city.
Select City, SUM(AmountPaid) as revenue from customers
	join orders on orders.CustomerID = customers.CustomerID
	join payments on payments.OrderID = orders.OrderID
group by City
order by revenue Desc, City Desc

Total revenue by city using a CTE

with Cityrevenue as (Select City, SUM(AmountPaid) as revenue from customers
	join orders on orders.CustomerID = customers.CustomerID
	join payments on payments.OrderID = orders.OrderID
group by City
) Select * from Cityrevenue
where revenue between 20000 and 60000
ORDER BY revenue DESC;

Rank cities by revenue

with Cityrevenue as (Select City, SUM(AmountPaid) as revenue from customers
	join orders on orders.CustomerID = customers.CustomerID
	join payments on payments.OrderID = orders.OrderID
group by City
),
cityranked as (Select City, revenue, ROW_NUMBER() over (order by revenue Desc) as rank
from Cityrevenue)
Select * from cityranked
where rank = 1
