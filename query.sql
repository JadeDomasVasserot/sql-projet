-- 1
CREATE VIEW vue_book 
AS
SELECT    product.ref_product, price, titre, siret
FROM product, book
WHERE product.ref_product=book.ref_product
--2
CREATE VIEW vue_movie 
AS
SELECT    product.ref_product, price, titre, siret
FROM product, movie
WHERE product.ref_product=movie.ref_product
--3
CREATE VIEW vue_show 
AS
SELECT product.ref_product, price, titre, siret
FROM product, show
WHERE product.ref_product=show.ref_product





CREATE VIEW vue_client 
AS 
SELECT bill.ref_bill, product.titre, review, client.username, client.password, client.email
FROM bill, rent, buy, client, product, review
WHERE client.username=;

CREATE VIEW vue_buy
AS
SELECT client.id, buy.ref_bill, buy.date_buy
FROM client
WHERE buy.ref_bill = 

