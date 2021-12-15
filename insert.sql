-- clients

INSERT INTO client (username, password, email) VALUES
    ('colin', '123', 'colin@yahoo.com'),
    ('jade', '123', 'jade@gmail.com'),
    ('pacome', '123', 'pacome@hotmail.com'),
    ('rayane', '123', 'rayane@free.fr');

-- entreprise

INSERT INTO entreprise (siret, name, adresse, cp) VALUES
    ('12345678901234', 'hbo', '18 rue lyon', '69000'),
    ('43210987654321', 'oss', '10 rue de paris', '71000'),
    ('78901234654321', 'netfix', '10 rue de paris', '33000');

-- genre

INSERT INTO genre (genre) VALUES
    ('action'),
    ('thriller'),
    ('classic'),
    ('Science-fiction');

-- products

INSERT INTO product (price, titre, siret) VALUES
    (10, 'hard boiled', '12345678901234'),
    (20, '1984', '43210987654321'),
    (5, 'fatal bazooka director''s cut', '43210987654321'),
    (15.5, 'futurama', '78901234654321'),
    (25, 'cowboy bebop', '12345678901234');
--movies
INSERT INTO movie (ref_product, length) VALUES
    (1, '02:30:00'),
    (3, '01:30:00');

INSERT INTO movie_genre (movie_id, genre_id) VALUES
    (1, 1),
    (1, 2),
    (3, 3);

-- shows

INSERT INTO show (ref_product) VALUES
    (4),
    (5);

INSERT INTO show_genre (show_id, genre_id) VALUES
    (4, 3),
    (4, 4),
    (5, 3),
    (5, 4);

INSERT INTO season (show_id, titre) VALUES
    (4, 'saison 1'),
    (5, 'saison 6 l''aventure'),
    (5, 'saison 7 la finale');

INSERT INTO episode (titre, length, season_id) VALUES
    ('le début de l''aventure', '01:30:14', 1),
    ('le retour', '00:20:00', 2),
    ('le lassitude', '00:13:00', 2),
    ('la finale', '00:40:30', 3);


--books
INSERT INTO book (ref_product, nb_pages) VALUES
(2, 365);

INSERT INTO book_genre (book_id, genre_id) VALUES
(2,3),
(2,4);

--review

INSERT INTO review (note,review, ref_product, client_id) VALUES
    ( 5, 'J''ai adoré ce film, le réalisateur a bien mélangé humour,
    absurdité et génie. Fatal Bazooka est le précédeur de Eminem,
    Freeze Corleone ou encore Patrick Sebastien',
    3, 1),
    (4, 'Le livre m''évoque mon passée nostalgique, d''une part ses descriptions des paysages approfondies;
    d''une autre part le developpement du personnage principal! je recommande! ;)',
    2, 4),
    (3, ' Série qui perd de son charme à partir de la deuxième saison, ne recommande que la 1ère saison',
    4, 3),
    (2, ' Un navet',
    1, 2),
    (1, ' je ne recommande pas cette série qui ne porte aucun intêret',
    5, 3);
--artiste
INSERT INTO artiste (role, name) VALUES
    ('Réalisateur', 'John Woo'),
    ('Auteur', 'George Orwell'),
    ('Réalisateur', 'Michaël Youn'),
    ('Créateur', ' Matt Groening'),
    ('Réalisateur', 'Shinichirō Watanabe');

--artiste_product
INSERT INTO artiste_product (ref_product, artiste_id) VALUES
    (1,1),
    (2,2),
    (3,3),
    (4,4),
    (5,5);

--bill
INSERT INTO bill (client_id) VALUES
    (3),
    (4),
    (2),
    (1);

INSERT INTO bill_product (ref_product, ref_bill) VALUES
    (5, 1),
    (2, 2),
    (3, 2),
    (4, 3),
    (1, 4);

INSERT INTO buy (ref_bill, date_buy) VALUES
    (1, '01/12/2018'),
    (2, '05/05/2004');

INSERT INTO rent (ref_bill, date_begin, date_fin) VALUES
    (3, '05/12/2018', '01/12/2019'),
    (4, '12/06/2017', '08/05/2020');