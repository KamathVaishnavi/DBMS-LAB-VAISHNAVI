create database insureancevck;
use  insureancevck;
create table car(
reg_num varchar(10),
model varchar(10),
year int,
primary key(reg_num));
create table person(
driver_id varchar(10),
name varchar(20),
address varchar(20),
primary key(driver_id)); 
create table accident(
report_num int,
accident_date date,
location varchar(20),
primary key(report_num));
create table owns(
driver_id varchar(10),
reg_num varchar(10),
primary key(driver_id,reg_num),
foreign key(driver_id) references person(driver_id)
on delete cascade,
foreign key(reg_num) references car(reg_num)
on delete cascade);
create table participated(
driver_id varchar(10),
reg_num varchar(10),
report_num int,
damage_amount int,
primary key(driver_id,reg_num,report_num),
foreign key(driver_id) references person(driver_id)
on delete cascade,
foreign key(reg_num) references car(reg_num)
on delete cascade,
foreign key(report_num) references accident(report_num)
on delete cascade);
insert into person values ('A01','Richard','Srinivas Nagar'),('A02','Pradeep','Rajaji Nagar'),('A03','Smith','Ashok Nagar'),('A04','Venu','N R Colony'),('A05','Jhon','Hanumanth Nagar');
insert into car values ('KA052250','Indica',1990),('KA031181','Lancer',1957),('KA095477','Toyota',1998),('KA053408','Honda',2008),('KA041702','Audi',2005);
insert into accident values (11,'2003-01-01','Mysore Road'),(12,'2004-02-02','South End Circle'),(13,'2003-01-21','Bull temple Road'),(14,'2008-02-17','Mysore Road'),(15,'2004-03-05','Kanakpura Road');
insert into owns values ('A01','KA052250'),('A02','KA053408'),('A03','KA031181'),('A04','KA095477'),('A05','KA041702');
INSERT INTO participated values ('A01','KA052250',11,10000),('A02','KA053408',12,50000),('A03','KA095477',13,25000),('A04','KA031181',14,3000),('A05','KA041702',15,5000);
update participated set damage_amount=25000 where reg_num='KA053408' and report_num=12;
select * from participated;
select count(distinct driver_id) CNT
from participated a,accident b
where a.report_num=b.report_num and b.accident_date like '2008%';
insert into owns values ('A04','KA052250');
insert into accident values(16,'2008-03-08','Domlur')
select accident_date,location from accident;
select driver_id from participated where damage_amount>=25000;
select * from participated order by damage_amount desc;
select avg(damage_amount) from participated;
delete from participated where damage_amount<(select avg(damage_amount) from participated);
select name from person a, participated b where a.driver_id=b.driver_id and damage_amount>(select avg(damage_amount) from participated);
select max(damage_amount) from participated;