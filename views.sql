-- 1 vue sur les "book" dans product
DROP VIEW IF EXISTS vue_book
GO
CREATE VIEW vue_book AS
SELECT	product.ref_product, price, titre, siret
FROM product, book
WHERE product.ref_product=book.ref_product
GO
--2 vue sur les "movie" dans product
DROP VIEW IF EXISTS vue_movie
GO
CREATE VIEW vue_movie AS
SELECT	product.ref_product, price, titre, siret
FROM product, movie
WHERE product.ref_product=movie.ref_product
GO
--3 vue sur les "show" dans product
DROP VIEW IF EXISTS vue_show
GO
CREATE VIEW vue_show AS
SELECT product.ref_product, price, titre, siret
FROM product, show
WHERE product.ref_product=show.ref_product
GO



-- 4 --5 --6 --7
DROP VIEW IF EXISTS vue_genre
GO
CREATE VIEW vue_genre AS

SELECT DISTINCT product.titre, genre.genre,product.price,
CASE
	WHEN movie_genre.movie_id IS NOT NULL THEN 'FILM'
END 'TYPE'
FROM genre, movie, movie_genre, product
WHERE genre.id=movie_genre.genre_id and movie.ref_product=product.ref_product and movie_genre.movie_id=movie.ref_product
UNION 
SELECT DISTINCT product.titre, genre.genre,product.price,
CASE
	WHEN book_genre.book_id IS NOT NULL THEN 'BOOK'
END
FROM genre, product, book, book_genre
WHERE genre.id=book_genre.genre_id and book.ref_product=product.ref_product and book_genre.book_id=book.ref_product

UNION
SELECT DISTINCT product.titre, genre.genre,product.price,
CASE
	WHEN show_genre.show_id IS NOT NULL THEN 'SHOW'
END
FROM genre, product, show, show_genre
WHERE genre.id=show_genre.genre_id and show.ref_product=product.ref_product and show_genre.show_id=show.ref_product
GO

DROP VIEW IF EXISTS vue_genre_action
GO
CREATE VIEW vue_genre_action AS
SELECT *
FROM vue_genre
WHERE genre='action'
GO

DROP VIEW IF EXISTS vue_genre_classic
GO
CREATE VIEW vue_genre_classic AS
SELECT *
FROM vue_genre
WHERE genre='classic'
GO

DROP VIEW IF EXISTS vue_genre_Sciencefiction
GO
CREATE VIEW vue_genre_Sciencefiction AS
SELECT *
FROM vue_genre
WHERE genre='Science-fiction'
GO

DROP VIEW IF EXISTS vue_genre_thriller
GO
CREATE VIEW vue_genre_thriller AS
SELECT *
FROM vue_genre
WHERE genre='thriller'
GO

--6 vue sur client sans les password
DROP VIEW IF EXISTS vue_client
GO
CREATE VIEW
vue_client
AS
SELECT client.username, client.email
FROM client
GO

--7 vue buy and rent
DROP VIEW IF EXISTS vue_rent_buy_client
GO
CREATE VIEW vue_rent_buy_client AS
SELECT DISTINCT client.username, client.email,CASE WHEN rent.ref_bill IS NOT NULL THEN 'LOCATION' END 'ACHAT/LOCATION',NULL AS 'date_buy' ,date_begin, date_fin,titre, price
FROM client, bill, rent, bill_product,product
WHERE client.id=bill.client_id and bill.ref_bill=rent.ref_bill and bill_product.ref_bill=bill.ref_bill
and bill_product.ref_product=product.ref_product
UNION
SELECT DISTINCT client.username, client.email,CASE WHEN buy.ref_bill IS NOT NULL THEN 'ACHAT' END 'ACHAT/LOCATION',date_buy,NULL AS 'date_begin',NULL AS 'date_fin',titre,price
FROM client, bill, buy, bill_product,product
WHERE client.id=bill.client_id and bill.ref_bill=buy.ref_bill and bill_product.ref_bill=bill.ref_bill
and bill_product.ref_product=product.ref_product
GO

--vue review_product
DROP VIEW IF EXISTS vue_review_product
GO
CREATE VIEW vue_review_product
AS
SELECT  client.username, review.note, review.review, product.titre, product.price 
FROM review
INNER JOIN product ON product.ref_product = review.ref_product
INNER JOIN client ON client.id = review.client_id
GO
-- artiste vue
DROP VIEW IF EXISTS vue_artiste
GO
CREATE VIEW vue_artiste
AS
SELECT  product.titre, product.price, artiste.name , artiste.role, entreprise.name as Nom_entreprise
FROM artiste_product
INNER JOIN artiste ON artiste.id = artiste_product.artiste_id
INNER JOIN product ON product.ref_product = artiste_product.ref_product
INNER JOIN entreprise ON product.siret = entreprise.siret
GO

--vue show_season_episode
DROP VIEW IF EXISTS vue_show_info
GO
CREATE VIEW vue_show_info
AS
SELECT DISTINCT product.titre as nom_série , season.titre as titre_saison, episode.titre  as nom_episode, episode.length
FROM show
INNER JOIN product ON show.ref_product = product.ref_product
INNER JOIN season ON show.ref_product = season.show_id
INNER JOIN episode ON episode.season_id = season.id
INNER JOIN show_genre ON show.ref_product = show_genre.show_id
GO


