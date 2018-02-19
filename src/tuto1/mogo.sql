CREATE DATABASE mogodb;
USE mogodb;

DROP TABLE IF EXISTS products;
CREATE TABLE products (cameras VARCHAR(20), wifi VARCHAR(20), prix VARCHAR(20));
INSERT INTO products VALUES ('MoGo 64Go', 'oui', '170.0');
INSERT INTO products VALUES ('MoGo 32Go', 'non', '145.0');
INSERT INTO products VALUES ('MoGo 16Go', 'non', '120.0');
INSERT INTO products VALUES ('MoGoHD 128Go', 'oui', '215.0');
INSERT INTO products VALUES ('MoGoHD 64Go', 'oui', '190.0');
INSERT INTO products VALUES ('MoGoHD 32Go', 'non', '165.0');

DROP TABLE IF EXISTS users;
CREATE TABLE users (login VARCHAR(20), pass VARCHAR(20));
INSERT INTO users VALUES ('Jean', 'jeanjeandu64');
INSERT INTO users VALUES ('Admin', 'wazabisdu31');
INSERT INTO users VALUES ('Test', 'test');
