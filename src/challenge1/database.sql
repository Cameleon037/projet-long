CREATE DATABASE mogodb;
USE mogodb;

DROP TABLE IF EXISTS products;
CREATE TABLE products (c1 VARCHAR(20), c2 VARCHAR(20));
INSERT INTO products VALUES ('a', 'oui');
INSERT INTO products VALUES ('c', 'non');
INSERT INTO products VALUES ('b', 'oui');

DROP TABLE IF EXISTS users;
CREATE TABLE users (login VARCHAR(20), pass VARCHAR(20));
INSERT INTO users VALUES ('user', 'user');
INSERT INTO users VALUES ('root', 'root');
