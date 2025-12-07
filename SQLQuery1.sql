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



