USE master
GO

DROP DATABASE IF EXISTS fnac
GO

CREATE DATABASE fnac
GO

USE FNAC
GO

DROP TABLE IF EXISTS episode;
DROP TABLE IF EXISTS season;
DROP TABLE IF EXISTS show_genre;
DROP TABLE IF EXISTS show;
DROP TABLE IF EXISTS movie_genre;
DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS book_genre;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS bill_product;
DROP TABLE IF EXISTS artiste_product;
DROP TABLE IF EXISTS rent;
DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS buy;
DROP TABLE IF EXISTS bill;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS entreprise;
DROP TABLE IF EXISTS artiste;
DROP TABLE IF EXISTS client;

CREATE TABLE client(
    id INT NOT NULL IDENTITY(1,1),
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(50) NOT NULL,
   
);
ALTER TABLE client ADD  CONSTRAINT client_pk PRIMARY KEY (id);
ALTER TABLE client ADD CONSTRAINT client_email_unique UNIQUE (email);

CREATE TABLE entreprise(
    siret CHAR(14) NOT NULL,
    name VARCHAR(50) NOT NULL,
    adresse VARCHAR(50) NOT NULL,
    cp CHAR(5) NOT NULL,
    CONSTRAINT entreprise_siret_pk PRIMARY KEY (siret),
);

CREATE TABLE bill(
   ref_bill INT NOT NULL IDENTITY (1,1),
   client_id INT NOT NULL,
   CONSTRAINT ref_bill_pk PRIMARY KEY(ref_bill),
);
ALTER TABLE bill ADD CONSTRAINT ref_bill_fk FOREIGN KEY(client_id) REFERENCES client(id);

CREATE TABLE genre(
    id INT NOT NULL IDENTITY(1,1),
    genre VARCHAR(50) NOT NULL,
    CONSTRAINT genre_pk PRIMARY KEY(id),
);
ALTER TABLE genre ADD CONSTRAINT genre_unique UNIQUE (genre);

CREATE TABLE rent(
   ref_bill int NOT NULL,
   date_begin DATETIME NOT NULL,
   date_fin DATETIME NOT NULL,
   CONSTRAINT ref_rent_bill_pk PRIMARY KEY (ref_bill),
   CONSTRAINT ref_rent_bill_fk FOREIGN KEY (ref_bill) REFERENCES bill(ref_bill),
);
ALTER TABLE rent ADD CONSTRAINT rent_check CHECK (date_begin< date_fin);

CREATE TABLE buy(
   ref_bill int NOT NULL,
   date_buy DATETIME NOT NULL,
 
   CONSTRAINT ref_buy_bill_fk FOREIGN KEY(ref_bill) REFERENCES bill(ref_bill),
);

ALTER TABLE buy ADD CONSTRAINT ref_buy_bill_pk PRIMARY KEY(ref_bill);

CREATE TABLE artiste(
   id INT NOT NULL IDENTITY(1,1),
   role VARCHAR(50) NOT NULL,
   name VARCHAR(50) NOT NULL,
   CONSTRAINT id_artiste_pk PRIMARY KEY(id),
);
ALTER TABLE artiste ADD CONSTRAINT artiste_check CHECK (len(name)>2);

CREATE TABLE product(
    ref_product INT NOT NULL IDENTITY(1,1),
    price FLOAT NOT NULL,
    titre VARCHAR(50) NOT NULL,
    siret CHAR(14) NOT NULL,
    CONSTRAINT ref_product_pk PRIMARY KEY(ref_product),
    CONSTRAINT siret_product_fk FOREIGN KEY(siret) REFERENCES entreprise(siret),
);
ALTER TABLE product ADD CONSTRAINT siret_ck CHECK (len(siret)=14);
ALTER TABLE product ADD CONSTRAINT price_check CHECK (price>0);

CREATE TABLE review(
   id INT NOT NULL IDENTITY(1,1),
   note INT NOT NULL,
   review TEXT NOT NULL,
   ref_product INT NOT NULL,
   client_id INT NOT NULL,
   CONSTRAINT review_pk PRIMARY KEY(id),
   CONSTRAINT review_ref_fk FOREIGN KEY(ref_product) REFERENCES product(ref_product),
   CONSTRAINT review_client_id_fk FOREIGN KEY(client_id) REFERENCES client (id),
);
ALTER TABLE review ADD CONSTRAINT note_check CHECK (note BETWEEN 0 AND 5);

CREATE TABLE show(
   ref_product INT NOT NULL,
   CONSTRAINT show_ref_product_fk FOREIGN KEY(ref_product) REFERENCES product(ref_product),
);

ALTER TABLE show ADD CONSTRAINT show_pk PRIMARY KEY(ref_product);

CREATE TABLE book(
   nb_pages INT NOT NULL,
   ref_product INT NOT NULL,
   CONSTRAINT book_pk PRIMARY KEY(ref_product),
   CONSTRAINT book_ref_product_fk FOREIGN KEY(ref_product) REFERENCES product(ref_product),
);

ALTER TABLE book ADD CONSTRAINT nb_pages_check CHECK (nb_pages>0);

CREATE TABLE movie(
   ref_product INT NOT NULL,
   length TIME NOT NULL,
   CONSTRAINT movie_pk PRIMARY KEY( ref_product),
);

ALTER TABLE movie ADD CONSTRAINT movie_ref_product_fk FOREIGN KEY(ref_product) REFERENCES product(ref_product);

CREATE TABLE season(
   id INT NOT NULL IDENTITY(1,1),
   show_id INT NOT NULL,
   titre VARCHAR(50) NOT NULL,
   CONSTRAINT season_show_id_fk FOREIGN KEY(show_id) REFERENCES show (ref_product),
);
ALTER TABLE season ADD CONSTRAINT season_pk PRIMARY KEY(id);

CREATE TABLE episode(
   id INT NOT NULL IDENTITY(1,1),
   titre VARCHAR(50) NOT NULL,
   length TIME NOT NULL,
   season_id INT NOT NULL,
   CONSTRAINT ep_pk PRIMARY KEY(id),
);
ALTER TABLE episode ADD CONSTRAINT ep_season_fk FOREIGN KEY(season_id) REFERENCES season(id);

CREATE TABLE bill_product(
   ref_product INT NOT NULL,
   ref_bill INT NOT NULL,
   CONSTRAINT bill_product_pk PRIMARY KEY(ref_product, ref_bill),
   CONSTRAINT bill_refproduct_fk FOREIGN KEY(ref_product) REFERENCES product(ref_product),
  
);

ALTER TABLE bill_product ADD CONSTRAINT bill_refbill_fk FOREIGN KEY(ref_bill) REFERENCES bill(ref_bill);

CREATE TABLE artiste_product(
   ref_product INT NOT NULL,
   artiste_id INT NOT NULL,
   CONSTRAINT artiste_refproduct_fk FOREIGN KEY(ref_product) REFERENCES product(ref_product),
   CONSTRAINT artisteid_fk FOREIGN KEY(artiste_id) REFERENCES artiste(id),
);

ALTER TABLE artiste_product ADD  CONSTRAINT artiste_product_pk PRIMARY KEY(ref_product, artiste_id);

CREATE TABLE book_genre(
   book_id INT NOT NULL,
   genre_id INT NOT NULL,
   CONSTRAINT book_genre_pk PRIMARY KEY(book_id, genre_id),
   CONSTRAINT bookid_fk FOREIGN KEY(book_id) REFERENCES book(ref_product),
  
);

ALTER TABLE book_genre ADD  CONSTRAINT bookgenre_fk FOREIGN KEY(genre_id) REFERENCES genre(id);

CREATE TABLE movie_genre(
   movie_id INT NOT NULL,
   genre_id INT NOT NULL,
   CONSTRAINT movie_genre_pk PRIMARY KEY(movie_id, genre_id),
   CONSTRAINT moviegenre_fk FOREIGN KEY(genre_id) REFERENCES genre(id),
);

ALTER TABLE movie_genre ADD CONSTRAINT movieid_fk FOREIGN KEY( movie_id) REFERENCES movie(ref_product);

CREATE TABLE show_genre(
   show_id INT NOT NULL,
   genre_id INT NOT NULL,
   CONSTRAINT showid_fk FOREIGN KEY(show_id) REFERENCES show (ref_product),
   CONSTRAINT show_genre_fk FOREIGN KEY(genre_id) REFERENCES genre(id),
);

ALTER TABLE show_genre ADD CONSTRAINT show_genre_pk PRIMARY KEY(show_id, genre_id);

