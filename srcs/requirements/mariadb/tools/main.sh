#!/bin/sh

mariadb

CREATE DATABASE wordpress;
USE wordpress;

CREATE TABLE users {
    id  CHAR(10) PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(50)
};
#CREATE OR REPLACE USER admin@'%' IDENTIFIED BY 'ASecurePassword';