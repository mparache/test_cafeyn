/*------------------------------------------------------------*/
/*--------------------Création des tables---------------------*/
/*------------------------------------------------------------*/


CREATE TABLE issue_consumption(
    id_user INTEGER, 
    id_issue INTEGER, 
    id_magazine INTEGER
);

CREATE TABLE article_consumption(
    id_user INTEGER,
    id_article INTEGER,
    id_issue INTEGER, 
    id_magazine INTEGER
);

CREATE TABLE user_session(
    id_user INTEGER,
    session_login DATETIME,
    session_logout DATETIME
);



/*------------------------------------------------------------------*/
/*--------------------Insertion dans les tables---------------------*/
/*------------------------------------------------------------------*/


INSERT INTO issue_consumption VALUES ('123','456','789');
INSERT INTO issue_consumption VALUES ('-1','25','12');
INSERT INTO issue_consumption VALUES ('123','69','701889');
INSERT INTO issue_consumption VALUES ('25','456','789');
INSERT INTO issue_consumption VALUES ('49','48','789');
INSERT INTO issue_consumption VALUES ('-1','48','2');
INSERT INTO issue_consumption VALUES ('-1','24','49');
INSERT INTO issue_consumption VALUES ('26','49','85');
INSERT INTO issue_consumption VALUES ('46','14','369');
INSERT INTO issue_consumption VALUES ('51','84','16');
INSERT INTO issue_consumption VALUES ('-1','23','4');

INSERT INTO article_consumption VALUES ('123','23','456','789');
INSERT INTO article_consumption VALUES ('-1','59','25','12');
INSERT INTO article_consumption VALUES ('123','24','69','701889');
INSERT INTO article_consumption VALUES ('25','789','456','789');
INSERT INTO article_consumption VALUES ('49','1','48','789');
INSERT INTO article_consumption VALUES ('-1','15','48','2');

INSERT INTO user_session VALUES ('123','2020-08-01 13:51:22','2020-08-01 14:48:48');
INSERT INTO user_session VALUES ('-1','2020-08-01 14:12:14','2020-08-01 14:28:16');
INSERT INTO user_session VALUES ('25','2020-08-01 14:39:29','2020-08-01 14:59:48');
INSERT INTO user_session VALUES ('123','2020-08-01 16:41:08','2020-08-01 17:17:16');
INSERT INTO user_session VALUES ('-1','2020-08-01 17:01:02','2020-08-01 17:08:08');
INSERT INTO user_session VALUES ('49','2020-08-01 17:02:42','2020-08-01 17:26:24');
INSERT INTO user_session VALUES ('26','2020-08-01 17:42:02','2020-08-01 19:06:51');
INSERT INTO user_session VALUES ('46','2020-08-02 06:15:32','2020-08-02 08:16:00');
INSERT INTO user_session VALUES ('-1','2020-08-02 09:43:15','2020-08-02 11:04:57');
INSERT INTO user_session VALUES ('51','2020-08-02 15:43:11','2020-08-02 17:01:31');
INSERT INTO user_session VALUES ('-1','2020-08-03 04:12:16','2020-08-03 04:15:47');



/*--------------------------------------------------*/
/*--------------------Questions---------------------*/
/*--------------------------------------------------*/


-- Describe in a few words what you have understood about these tables

/*
La table 'issue_consumption' répertorie les utilisateurs qui ont lu un exemplaire d'un magazine. On y trouve les ids de l'utilisateur, du magazine et de l'expemplaire.
La table 'article_consumption' répertorie les utilisateurs qui ont lu un article d'un magazine. On y trouve les ids de l'utilisateur, de l'article, du magazine et de l'exemplaire du magazine
La table 'user_session' répertorie toutes les sessions des différents utilisateurs (anonymes ou non) avec les heures auxquelles il s'est connecté et déconnecté
*/

-- On average, how much time does a user session last?

SELECT AVG(DATEDIFF(minute,s.session_login,s.session_logout)) AS temps_moyen_session FROM user_session s;

-- Calculate the duration of longest session ever

SELECT MAX(DATEDIFF(minute,s.session_login,s.session_logout)) AS temps_maximum_session FROM user_session s;

-- Extract the list of unique non anonymous users that have read an issue but have never read any article

SELECT DISTINCT i.id_user AS logged_issue_no_article FROM issue_consumption i LEFT JOIN article_consumption a ON i.id_magazine = a.id_magazine WHERE (i.id_user != -1) and a.id_magazine IS NULL;

-- How many article does a non-anonymous user read on average

SELECT AVG(c.cnt) AS moyenne_article_lu FROM (SELECT COUNT(a.id_article) AS cnt FROM article_consumption a WHERE (a.id_user !=-1) GROUP BY a.id_user) c;

-- In total, how many issues have been read by anonymous users and logged users respectively

SELECT 
    COUNT(CASE WHEN issue_consumption.id_user = -1 THEN 1 END) AS nb_issue_lu_anon,
    COUNT(CASE WHEN issue_consumption.id_user != -1 THEN 1 END) AS nb_issue_lu_logged 
FROM issue_consumption;

-- The maximum num of articles read by a user, the maxium number of times a user has read the same article

SELECT 
    MAX(c.cnt) AS max_article,
    MAX(d.cnt) AS max_same_article
FROM 
    (SELECT COUNT(a.id_article) AS cnt FROM article_consumption a GROUP BY a.id_user) c,
    (SELECT COUNT(*) AS cnt FROM article_consumption a GROUP BY a.id_article, a.id_user) d;