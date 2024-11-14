show databases;
use sakila;
select * from actor; 

-- 반드시 한칸띄워야 주석이 됩니다.
#이거는 안띄워도 주석입니다.
/*이것도 그냥 주석입니다.*/

CREATE USER 'dev01'@'%' IDENTIFIED WITH MYSQL_NATIVE_PASSWORD BY '1234';

CREATE database dev;

USE dev;

CREATE TABLE customers (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45) NOT NULL,
email varchar(45),
phone varchar(45) not null,
address varchar(45) );

INSERT INTO dev.customers (id, name, email, phone, address)
 VALUES ( 1,  'John Doe', 'john@mail.com', '010-0000-000', '');

select * from customers;

-- 다운그레이드 버전으로 시작
#어디서도 접속할수 있도록 identified with MYSQL_NATIVE_PASSWORD
create user 'dev01'@'%' identified with MYSQL_NATIVE_PASSWORD by '1234';

create database dev;
#with grant option : 권한부여 할수 있는 옵션
grant all privileges on dev.* to 'dev01'@'%' with grant option;
#설정을 변경할때, mysql을 즉각 반영할수 있도록 하는 명령어. mysql 전용
flush privileges;















