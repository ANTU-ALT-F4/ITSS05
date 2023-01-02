CREATE DATABASE ITSS05
GO
USE ITSS05
GO

create table departments
(
 id varchar(20) primary key,
 name varchar(50)
)

create table locations
(
 id varchar(20) primary key,
 name varchar(50)
)

create table departmentlocations
(
id varchar(20) primary key,
departmentid varchar(20),
locationid varchar(20),
startdate date,
enddate date,
constraint fk_departmentlocations_departments foreign key (departmentid) references departments(id) ON DELETE CASCADE ON UPDATE CASCADE,
constraint fk_departmentlocations_locations foreign key (locationid) references locations(id)ON DELETE CASCADE ON UPDATE CASCADE,
)


create table parts
(
 id varchar(20) primary key,
 name varchar(50),
 effectivelife int,
 MinimumQuatity int,
 BatchNumberHasRequired int
 )
 

 CREATE TABLE suppliers
( id int identity(1,1) primary key,
  name varchar(100)
)

CREATE TABLE transactiontype(
	id int identity(1,1) primary key,
	name varchar(100)
)

CREATE TABLE warehouses
( id int identity(1,1) primary key,
  name varchar(100)
)

 create table assets
 (
 id varchar(20) primary key,
 assetsn varchar(50),
 assetname varchar(50),
 departmentlocationid varchar(20),
 employeeid varchar(20),
 assetgroupid varchar(20),
 description varchar(50),
 warrantydate date,
 constraint fk_assets_departmentlocations foreign key(departmentlocationid) references departmentlocations(id)ON DELETE CASCADE ON UPDATE CASCADE
 )
 go

  create table emergencymaintenances
 (
  id int identity(1,1) primary key,
  assetid varchar(20),
  priorityid varchar(20),
  descriptionemergency varchar(50),
  otherconsiderations varchar(50),
  emreportdate date,
  emstartdate date,
  emenddate date,
  emtechniciannote varchar(50),
  constraint fk_emergencymaintenances_assets foreign key(assetid) references assets(id),
 )


CREATE TABLE orders 
(	id int identity(1,1) primary key,
	transactiontypeid int,
	suppliersid int,
	EmergencyMaintenancesID int,
	sourcewarehouseid int,
	destinationwarehouseid int,
	date date,
	Time Time
	constraint fk_orders_suppliers foreign key (suppliersid) references suppliers(id),
	constraint fk_orders_transactiontype foreign key (transactiontypeid) references transactiontype(id),
	constraint fk_orders_EmergencyMaintenances foreign key (EmergencyMaintenancesID) references EmergencyMaintenances(id),
	constraint fk_sourcewarehouseid_warehouses foreign key (sourcewarehouseid) references warehouses(id),
	constraint fk_destinationwarehouseid_warehouses foreign key (destinationwarehouseid) references warehouses(id)
)

 CREATE TABLE orderitems
( id int identity(1,1) primary key,
  orderid int,
  partid varchar(20),
  amount FLOAT,
  UnitPrice FLOAT,
  batchnumber varchar(20),
  Stock varchar(20)
  constraint fk_orderitems_orders foreign key (orderid) references orders(id),
  constraint fk_orderitems_parts foreign key (partid) references parts(id)
)

insert into departments values ('d1','bo phan 1')
insert into departments values ('d2','bo phan 2')
insert into departments values ('d3','bo phan 3')
insert into departments values ('d4','bo phan 4')

insert into locations values ('l1','Yolka')
insert into locations values ('l2','Office Center')
insert into locations values ('l3','Kazan')
insert into locations values ('l4','tl')

insert into departmentlocations values('de1','d1','l1','2017-12-4','2019-8-5')
insert into departmentlocations values('de2','d2','l2','2017-12-3','2019-7-6')
insert into departmentlocations values('de3','d3','l3','2017-12-1','2019-3-5')
insert into departmentlocations values('de4','d4','l4','2017-12-1','2018-12-5')

insert into parts values ('p1','vp',1,2,0)
insert into parts values ('p2','xt',2,2,0)
insert into parts values ('p3','ns',3,2,1)
insert into parts values ('p4','ns',4,2,1)

insert into assets values ('ass1','03/05/009','moorning system','de1','em1','a1','good','2021/7/9')
insert into assets values ('ass2','01/11/0014','suction line','de2','em2','a2','good','2021/5/1')
insert into assets values ('ass3','03/05/0015','toyota hilux','de3','em3','a3','good','2021/3/4')
insert into assets values ('ass4','06/05/0015','sento hix','de4','em4','a4','good','2021/7/4')

insert into emergencymaintenances(assetid,priorityid,descriptionemergency,otherconsiderations,emreportdate,emstartdate,emenddate,emtechniciannote) values ('ass1','pr1','hong','hong','2021/1/2','2021/3/2','2021/4/2','dung han')
insert into emergencymaintenances(assetid,priorityid,descriptionemergency,otherconsiderations,emreportdate,emstartdate,emenddate,emtechniciannote) values ('ass2','pr2','hong','hong','2021/1/2','2021/4/3','2021/4/9','dung han')
insert into emergencymaintenances(assetid,priorityid,descriptionemergency,otherconsiderations,emreportdate,emstartdate,emenddate,emtechniciannote) values ('ass3','pr3','hong','hong','2021/5/2','2021/3/5','2021/8/6','dung han')
insert into emergencymaintenances(assetid,priorityid,descriptionemergency,otherconsiderations,emreportdate,emstartdate,emenddate,emtechniciannote) values ('ass4','pr4','hong','hong','2021/8/7','2021/1/5','2021/8/6','dung han')

insert into suppliers (name) values('Nha_Cung_Cap_1'),
								   ('Nha_Cung_Cap_2'),
								   ('Nha_Cung_Cap_3'),
								   ('Nha_Cung_Cap_4'),
								   ('Nha_Cung_Cap_5')

insert into transactiontype(name) values ('Purchase Order'),
										 ('Warehouse Management')

insert into warehouses(name) values ('Kho_Hang_1'),
								    ('Kho_Hang_2'),
								    ('Kho_Hang_3'),
								    ('Kho_Hang_4'),
								    ('Kho_Hang_5') 

INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('1','1','1','1','2','2019-8-5','19:26')
INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('1','2','1','2','3','2019-7-6','19:26')
INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('1','3','1','3','4','2019-3-5','19:26')
INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('2','4','1','4','5','2018-12-5','19:26')

INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('1','1','2','1','2','2019-8-5','19:26')
INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('1','3','2','3','4','2019-3-5','19:26')
INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('2','4','2','4','5','2018-12-5','19:26')

INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('1','2','3','2','3','2019-7-6','19:26')
INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('1','3','3','3','4','2019-3-5','19:26')
INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('2','4','3','4','5','2018-12-5','19:26')

INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('1','1','4','1','2','2019-8-5','19:26')
INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('1','2','4','2','3','2019-7-6','19:26')
INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('1','3','4','3','4','2019-3-5','19:26')
INSERT INTO orders (transactiontypeid, suppliersid, EmergencyMaintenancesID, sourcewarehouseid, destinationwarehouseid, date, Time) 
VALUES ('2','4','4','4','5','2018-12-5','19:26')



INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('1','p1','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('1','p1','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('2','p2','10','20000','ba02','stock02')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('2','p2','10','20000','ba02','stock02')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('3','p3','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('3','p3','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('4','p3','10','20000','ba02','stock02')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('4','p3','10','15000','ba02','stock02')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('5','p4','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('5','p4','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('6','p4','10','20000','ba02','stock02')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('6','p4','10','32000','ba02','stock02')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('7','p1','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('7','p3','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('8','p3','10','20000','ba02','stock02')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('8','p3','10','33000','ba02','stock02')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('9','p1','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('9','p1','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('10','p2','10','20000','ba02','stock02')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('10','p2','10','20000','ba02','stock02')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('11','p1','10','10000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('11','p1','10','11000','ba01','stock01')
INSERT INTO orderitems (orderid, partid, amount, UnitPrice, batchnumber, Stock) 
VALUES ('12','p2','10','20000','ba02','stock02')


select * from [dbo].[assets]
select * from [dbo].[departmentlocations]
select * from [dbo].[departments]
select * from [dbo].[emergencymaintenances]
select * from [dbo].[locations]
select * from [dbo].[parts]
select * from [dbo].[suppliers]
select * from [dbo].[transactiontype]
select * from [dbo].[warehouses]
select * from [dbo].[orderitems]
select * from [dbo].[orders]




--Cau 1:
select * from [dbo].[locations]
select * from [dbo].[departmentlocations]
select * from [dbo].[assets]
select * from [dbo].[emergencymaintenances]
select * from [dbo].[orders]
select * from [dbo].[orderitems]


SELECT locations.name as name,SUM(t1.UnitPrice) as t1, SUM(t2.UnitPrice) as t2,SUM(t3.UnitPrice) as t3,SUM(t4.UnitPrice) as t4 
FROM departmentlocations
INNER JOIN locations ON departmentlocations.locationid = locations.id
INNER JOIN assets ON assets.departmentlocationid = departmentlocations.id
INNER JOIN emergencymaintenances ON emergencymaintenances.assetid = assets.id
INNER JOIN orders ON orders.EmergencyMaintenancesID = emergencymaintenances.id
INNER JOIN orderitems ON orderitems.orderid = orders.id
LEFT JOIN orderitems as t1 ON YEAR(date) = '2019' AND MONTH(date) = '08'
LEFT JOIN orderitems as t2 ON YEAR(date) = '2019' AND MONTH(date) = '07'
LEFT JOIN orderitems as t3 ON YEAR(date) = '2019' AND MONTH(date) = '03'
LEFT JOIN orderitems as t4 ON YEAR(date) = '2018' AND MONTH(date) = '12'
GROUP BY locations.name
ORDER BY locations.name,SUM(t1.UnitPrice), SUM(t2.UnitPrice),SUM(t3.UnitPrice),SUM(t4.UnitPrice)

--Chi phí cao nhất
--Số nhiều nhất
select * from [dbo].[departments]
select * from [dbo].[departmentlocations]
select * from [dbo].[assets]
select * from [dbo].[emergencymaintenances]
select * from [dbo].[orders]
select * from [dbo].[orderitems]

select TOP(1) CONCAT(n1.name ,', ' , n1.name) as t1,CONCAT(n2.name ,', ' , n2.name)as t2,CONCAT(n3.name ,', ' , n3.name) as t3,CONCAT(n4.name ,', ' , n4.name) as t4
from departmentlocations
INNER JOIN departments ON departments.id = departmentlocations.departmentid
INNER JOIN assets ON assets.departmentlocationid = departments.id
INNER JOIN emergencymaintenances ON emergencymaintenances.assetid = assets.id
INNER JOIN orders ON orders.EmergencyMaintenancesID = emergencymaintenances.id
INNER JOIN orderitems ON orderitems.orderid = orders.id
LEFT JOIN orderitems as t1 ON YEAR(date) = '2019' AND MONTH(date) = '08'
LEFT JOIN orderitems as t2 ON YEAR(date) = '2019' AND MONTH(date) = '07'
LEFT JOIN orderitems as t3 ON YEAR(date) = '2019' AND MONTH(date) = '03'
LEFT JOIN orderitems as t4 ON YEAR(date) = '2018' AND MONTH(date) = '12'
RIGHT JOIN parts as n1 ON t1.partid = n1.id
RIGHT JOIN parts as n2 ON t2.partid = n2.id
RIGHT JOIN parts as n3 ON t3.partid = n3.id
RIGHT JOIN parts as n4 ON t4.partid = n4.id


