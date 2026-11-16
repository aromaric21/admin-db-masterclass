CREATE database BDD_2

ALTER DATABASE BDD  Modify Name = Peterpan ;  
GO

--- Je crée ma table Profile avec chp Nom et Prénom
use BDD
GO
create table Profile(Nom varchar(200), prenom varchar(200))

--- Insertion d'une valeur simple dans la table

insert into Profile values('Peter','Pan')


insert into Profile values('Peter','Pan2')

--- et si je veux inserer deux lignes 
insert into Profile values
('Le roi', 'Lion'),
('Garnier', 'Clément')


SELECT * FROM Profile

--- Création de la table Etudiant avec trois colonne : 
--- Nom avec varchar(200), Prénom varchar(200) et Âge int.
USE BDD
GO

CREATE TABLE etudiant (
    nom varchar(200),
	prenom varchar(200),
	age    int
);

---Insertion
INSERT INTO etudiant values
  ('Marchand', 'Elisabeth', 18)

INSERT INTO etudiant values
  ('Trouchon', 'Melanie', 16),
  ('Teslu', 'Sandrine', 18),
  ('Portail', 'Bruno', 23),
  ('Virenque', 'Michel', 22)


  SELECT * FROM etudiant;


USE BDD
GO

SELECT * FROM etudiant

-- Création de la table contact 
create table contact(Nom varchar(200), prenom varchar(200), age int, sexe char, date_de_naissance date)

insert into contact values
('Marchand','Elisabeth',18,'F','04-08-1976'),
('Truchon','Melanie',16,'F','04-08-1978'),
('Teslu','Sandrine',17,'F','02-05-1987'),
('Portail','Bruno',23,'M','06-05-1970'),
('Virenque','Michel',22,'M','02-08-1983'),
('Dutruel','Pascal',22,'M','02-08-1983'),-- meme age que Virenque michel
('Virenque','Micheline',37,'M','02-08-1975'),
('Fournillet','Alain',22,'M','01-01-1983'),
('Faurnillet','Pascal',48,'M','12-06-1960'),
('Boutin','Ludivine',47,'F','22-01-1965'),
('Delors','Valerie',28,'M','24-09-1978'),
('Thuillier','olivier',41,'M','12-08-1976'),
('Chuillier','olivier',41,'M','12-08-1976'),
('Meilhac','Amelie',34,'F','08-05-1983'),
('Boutin','Ludivine',47,'F','22-01-1965')-- deux fois la meme valeur dans la table, c'est un doublon

-- Que donne le SELECT 

SELECT *
FROM Contact 

-- Si je veux renommer le nom de ma colonne Nom par Surnom ? 

select nom as surnom from contact

-- Et si je veux renommer le nom de toutes les colonnes ? 

select nom as Last_name, prenom as First_name, age as Age,sexe as Sexe, date_de_naissance as Date_naiss from contact

-- on voit bien que toutes les colonnes ont été renommés :)

SELECT * FROM contact WHERE nom LIKE '%U%'

-- Le TOP : Spécifie que seul le premier ensemble de ligne sera renvoyé par la réquête.
SELECT TOP (1) * FROM etudiant
SELECT TOP (5) * FROM etudiant

SELECT DISTINCT nom from contact WHERE nom='Virenque' 

-- Copier toutes les lignes de la table contact vers la table contact_2
SELECT * INTO contact_2 FROM contact

SELECT * FROM contact_2

-- Copié juste quelques données
SELECT * INTO contact_3 FROM contact WHERE nom='Virenque'

SELECT * FROM contact_3

/******************************************************************************
********************************   Exercice TSQL Partie 1         *************
*******************************************************************************/
USE [BDD]
GO

--  1 / Enlevez moi les doublons dans la colonne âge.

select distinct age  from contact

-- Que donne le select sans le distinct ? 

select * from contact

-- 2 / Sélectionnez moi les dates de naissance commençant par 1976, en renommant la colonne  Année_1976.

select nom,prenom,sexe,date_de_naissance  as Année_1976  from contact where date_de_naissance like '1976%'

-- 3 / Selectionnez moi les personnes qui sont nées le 1er janvier

select * from contact where date_de_naissance like '%01-01%'

-- 4 / Selectionnez moi les prenoms qui finissent par la lettre E

select * from contact where prenom like '%E'

-- 5 / Une requête sortant juste les femmes(de  2 façons différentes).

select * from contact where sexe not in ('M')
-- ou 
select * from contact where sexe <> ('M')

--6 / Sélectionnez moi dans la requête les personnes qui ont 17 ans et moins de 17 ans.

select * from contact where age <= 17

-- 7 / selectionnez juste les personnes qui n'ont pas 17 ans et 48 ans

select * from contact where age  in (17,48)

--- 8 / selectionnez moi les 7 premieres lignes de la table 

select top 7 * from contact

--- 9 / copiez moi juste la ligne de Mr portail Bruno dans une autre table s'appelant Contact_Portail

select * into  contact_portail from contact where nom='portail'

-- Que donne le SELECT dans la nouvelle table ? 

select * from contact_portail

-- 10 / selectionnez juste les personnes qui ne sont pas nées en 1976

select * from contact where year(date_de_naissance) <>  1976
--ou 
select * from contact where year(date_de_naissance) != 1976

-- 11 / selectionnez juste les personnes qui ne sont pas nées au mois d'aout ? 

select * from contact where month (date_de_naissance) <> 08
-- ou 
select * from contact where month(date_de_naissance) != 08

SELECT COUNT(DISTINCT prenom) FROM contact

-- Compter le nombre de personnes dont le prénom est Ludivine
SELECT COUNT(*) AS Total FROM contact WHERE prenom = 'Ludivine'

-- Vérification
SELECT * FROM contact WHERE prenom = 'Ludivine'

--  Somme des femmes qui sont nées en 1983
SELECT SUM(1) FROM contact WHERE year(date_de_naissance) = 1983

-- Compter le nombre de femme qui ont entre 20 ans et 45 ans dont le nombre est supérieur à 1 en classant l'age 
-- par ordre décroissant
SELECT COUNT(*) sexe, age FROM contact 
WHERE age BETWEEN 20 AND 45
GROUP BY sexe, age
HAVING COUNT(*) > 1
ORDER BY age DESC

-- Compter les lignes distinctes dans la colonne sexe
SELECT COUNT(DISTINCT sexe) FROM contact

-- Inserer deux lignes dans la table contact et imprimer les résultats
INSERT INTO contact VALUES('Peronin', 'Denis', 43, 'M', '1974-06-02')
print 'Insertion de M. Peronin OK'

INSERT INTO contact VALUES('Galtier', 'Sophie', 26, 'F', '1988-02-01')
print 'Insertion de Mme Galtier OK'

-- Selectionner les personnes qui n'ont pas entre 20 et 27 ans
SELECT * FROM contact WHERE age NOT BETWEEN 20 AND 27

-- Compter les personnes qui ont la lettre A dans leur prénom, qui ont entre 18 ans et 40 ans, de sexe masculin
-- et dont le total est superieur à 1
SELECT COUNT(*) AS Nb_pers, age, sexe 
FROM contact
WHERE age BETWEEN 18 AND 40 AND prenom LIKE '%a%' AND sexe = 'M'
GROUP BY age, sexe
HAVING COUNT(*)  > 1
