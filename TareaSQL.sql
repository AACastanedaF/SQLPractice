/*1. Obtenga el nombre de los productos y unidades en Stock de los productos que se encuentran descontinuados. 
Muestre los primeros 5 registros ordenados de mayor a menor por Stock.*/
SELECT ProductName As Nombre_Producto, UnitsInStock As Unidades_Stock
FROM Product
WHERE Discontinued = 1
Order BY UnitsInStock DESC
LIMIT 5

/*2. Calcule el total de ventas donde la venta es igual a: (Precio Unitario-Descuento)*Cantidad*/ 
SELECT sum((UnitPrice-(UnitPrice*Discount))*Quantity) As Total_Ventas
FROM OrderDetail

/*3. Muestre el total de ventas por país de origen del cliente.*/
SELECT Country As Pais, sum((UnitPrice-Discount)*Quantity) As Total_Ventas
FROM Customer
INNER JOIN 'Order'
ON 'Order'.CustomerId = Customer.Id
INNER JOIN OrderDetail
ON OrderDetail.OrderId = 'Order'.Id
group By Country

/*4. Calcule el total de descuento por categoría de producto y ordénelo de manera descendente.*/
SELECT CategoryId As Id_Categoria, sum(Discount) As Descuento_Total
FROM OrderDetail
INNER JOIN Product
ON Product.Id = OrderDetail.ProductId
GROUP BY CategoryId

/*5. Los proveedores de España solicitan conocer la demanda de sus productos a través de los meses.
La información que se compartirá corresponde a la cantidad de producto vendido de acuerdo a su fecha de pedido. 
Muestre la información de manera gráfica.*/
SELECT strftime('%Y-%m',OrderDate) As Fecha, ProductName As Nombre_Producto, sum(Quantity) As Cantidad
FROM Supplier
INNER JOIN Product
ON Product.SupplierId = Supplier.Id
INNER JOIN OrderDetail
ON OrderDetail.ProductId = Product.Id
INNER JOIN 'Order'
ON 'Order'.Id = OrderDetail.OrderId
Where Supplier.Country = "Spain"
GROUP BY Fecha, ProductName