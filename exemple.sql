1.La liste des bureaux (adresse et ville) triés par pays décroissant puis par état
SELECT city, addressLine1, addressLine2
FROM offices
ORDER BY state DESC, country

2.La liste des avions (code et nom) triés par vendeur et par quantité en stock décroissants
SELECT productCode, productName
FROM products
WHERE productline= 'Planes'
ORDER BY productVendor DESC, quantityInStock DESC

3.La liste des produits (nom, vendeur et prix de vente) qui sont vendus au moins 132$ triés par nom du produit
SELECT productName, productVendor, MSRP
FROM products
WHERE MSRP >=100 
ORDER BY productName

4.La liste des produits (code, nom, échelle et quantité) qui ont une échelle soit de 1:10, soit de 1:18 triés par quantité en stock décroissante
SELECT productCode, productName, productScale, quantityInStock
FROM products
WHERE productScale In ("1:10","1:18")
ORDER BY quantityInStock DESC 

5.La liste des produits (code, nom et prix dachat) des produits achetés au moins 60$ au plus 90$ triés par prix dachat
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice BETWEEN 60 AND 90 
ORDER BY buyPrice

6.La liste des motos (nom, vendeur, quantité et marge) triés par marge décroissante
SELECT productName, productVendor, quantityInStock, MSRP-buyPrice AS marge
FROM products 
WHERE productline ="Motorcycles"
ORDER BY marge

7.La liste des commandes (numéro de commande, date de commande, date dexpédition, écart en jours entre la date de commande et la date dexpédition, statut de la commande) soit qui sont en cours de traitement, soit qui ont été expédiées plus de 10 jours après la date de commande triés par écart décroissant puis par date de commande 
SELECT orderNumber, orderDate, shippedDate, shippedDate-orderDate AS ecart, status 
FROM orders 
WHERE status="Shipped" OR status="In Process" OR shippedDate-orderDate >10 
ORDER BY ecart DESC, orderDate DESC

8.La liste des produits (nom et valeur du stock à la vente) des années 1960
SELECT productName, quantityInStock * MSRP AS stockValue
FROM products
WHERE productName LIKE "196%"

9.Le prix moyen vendu par chaque vendeur triés par prix moyen décroissant AVG est prédéfinie pour indiquer le prix moyen
SELECT productVendor, AVG (buyPrice) AS PrixMoyen
FROM products
GROUP BY productVendor
ORDER BY PrixMoyen DESC

10.#Le nombre de produits pour chaque ligne de produit
SELECT productLine, COUNT(productCode) AS NBR
FROM products
GROUP BY productLine

11.Le total du stock et le total de la valeur du stock à la vente de chaque ligne de produit pour les produits vendus plus de 100$ trié par total de la valeur du stock à la vente
SELECT productLine, SUM(quantityInStock) AS totalStock, SUM(quantityInStock * MSRP) AS totalStockValue
FROM products
WHERE MSRP > 100
GROUP BY productLine 
ORDER BY totalStockValue

12.La quantité du produit le plus en stock de chaque vendeur trié par vendeur
SELECT productVendor, MAX(quantityInStock) AS maxInStock
FROM products
GROUP BY productVendor
ORDER BY productVendor

13.Le prix de lavion qui coûte le moins cher à lachat
SELECT MIN(buyPrice) AS cheapestPricePlane
FROM products
WHERE productLine = 'Planes'

14.Le crédit des clients qui ont payé plus de 20000$ durant lannée 2004 trié par crédit décroissant
SELECT customerNumber, SUM(amount) AS totalCredit
FROM payments 
WHERE paymentDate BETWEEN '2004-01-01' AND '2004-12-31'
GROUP BY customerNumber
HAVING totalCredit>20000
ORDER BY totalCredit DESC

15.La liste des employés (nom, prénom et fonction) et des bureaux (adresse et ville) dans lequel ils travaillent
SELECT lastName, firstName, jobTitle, addressLine1, addressLine2, city
FROM employees
INNER JOIN offices ON offices.officeCode=employees.officeCode

16.La liste des clients français ou américains (nom du client, nom, prénom du contact et pays) et de leur commercial dédié (nom et prénom) triés par nom et prénom du contact
SELECT customerName, contactLastName, contactFirstName, country, lastName, firstName
FROM customers
INNER JOIN employees ON employees.employeeNumber=customers.salesRepEmployeeNumber
WHERE country IN ('France', 'USA')
ORDER BY contactLastName, contactFirstName

17.La liste des lignes de commande (numéro de commande, code, nom et ligne de produit) et la remise appliquée aux voitures ou motos commandées triées par numéro de commande puis par remise décroissante
SELECT orderNumber, orderdetails.productCode, productName, productLine, (MSRP-priceEach) AS discount
FROM products
INNER JOIN orderdetails ON orderdetails.productCode=products.productCode
WHERE productLine IN ('Classic Cars', 'Vintage Cars', 'Motorcycles')
ORDER BY orderNumber, discount DESC

18.Le total des paiements effectués de chaque client (numéro, nom et pays) américain, allemand ou français de plus de 50000$ trié par pays puis par total des paiements décroissant
SELECT customers.customerNumber, customerName, country, SUM(amount) AS totalPayment
FROM customers
INNER JOIN payments ON payments.customerNumber = customers.customerNumber
WHERE country IN ('France', 'Germany', 'USA')
GROUP BY customers.customerNumber, customerName, country
HAVING totalPayment > 50000
ORDER BY country, totalPayment DESC

19.Le montant total de chaque commande (numéro et date) des clients New-Yorkais (nom) trié par nom du client puis par date de commande
SELECT orders.orderNumber, orderDate, SUM(quantityOrdered * priceEach) AS montantTotal
FROM customers
INNER JOIN orders ON orders.customerNumber = customers.customerNumber
INNER JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
WHERE city = 'NYC'
GROUP BY orderNumber
ORDER BY customerName, orderDate


//jointure interne inner join on, jointure externe right join on.