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

insert into departments values ('d1','pb 1')
insert into departments values ('d2','pb 2')
insert into departments values ('d3','pb 3')
insert into departments values ('d4','pb 4')

insert into locations values ('l1','nv')
insert into locations values ('l2','tp')
insert into locations values ('l3','gd')
insert into locations values ('l4','tl')

insert into departmentlocations values('de1','d1','l1','2021-3-4','2021-6-5')
insert into departmentlocations values('de2','d2','l2','2021-8-3','2021-5-6')
insert into departmentlocations values('de3','d3','l3','2021-7-1','2021-9-5')
insert into departmentlocations values('de4','d4','l4','2021-4-1','2021-5-5')

insert into parts values ('p1','vp',1,2,3)
insert into parts values ('p2','xt',2,2,3)
insert into parts values ('p3','ns',3,2,3)
insert into parts values ('p4','ns',4,2,3)

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

select * from [dbo].[assets]
select * from [dbo].[departmentlocations]
select * from [dbo].[departments]
select * from [dbo].[emergencymaintenances]
select * from [dbo].[locations]
select * from [dbo].[orderitems]
select * from [dbo].[orders]
select * from [dbo].[parts]
select * from [dbo].[suppliers]
select * from [dbo].[transactiontype]
select * from [dbo].[warehouses]