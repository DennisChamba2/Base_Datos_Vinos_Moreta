/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     17/6/2023 9:34:57                            */
/*==============================================================*/


drop index CAMION_PK;

drop table CAMION;

drop index CAMIONERO_CAMION_FK;

drop index CAMIONERO_CAMION2_FK;

drop index CAMIONERO_CAMION_PK;

drop table CAMIONERO_CAMION;

drop index CHOFER_PK;

drop table CHOFER;

drop index CIUDAD_PK;

drop table CIUDAD;

drop index CLIENTE_PK;

drop table CLIENTE;

drop index DESCRIPCION_PAQUETE_FK;

drop index DESCRIPCION_PAQUETE2_FK;

drop index DESCRIPCION_PAQUETE_PK;

drop table DESCRIPCION_PAQUETE;

drop index CLIENTE_PAQUETE_FK;

drop index PAQUETE_CIUDAD_FK;

drop index CAMIONERO_PAQUETE_FK;

drop index PAQUETE_PK;

drop table PAQUETE;

drop index VINO_PK;

drop table VINO;

/*==============================================================*/
/* Table: CAMION                                                */
/*==============================================================*/
create table CAMION (
   MATRICULA            CHAR(8)              not null,
   POTENCIA             VARCHAR(50)          not null,
   MODELO               VARCHAR(15)          not null,
   TIPO                 VARCHAR(100)         not null,
   CAPACIDAD_KG         INT4                 not null,
   constraint PK_CAMION primary key (MATRICULA)
);

/*==============================================================*/
/* Index: CAMION_PK                                             */
/*==============================================================*/
create unique index CAMION_PK on CAMION (
MATRICULA
);

/*==============================================================*/
/* Table: CAMIONERO_CAMION                                      */
/*==============================================================*/
create table CAMIONERO_CAMION (
   MATRICULA            CHAR(8)              not null,
   CI                   CHAR(10)             not null,
   constraint PK_CAMIONERO_CAMION primary key (MATRICULA, CI)
);

/*==============================================================*/
/* Index: CAMIONERO_CAMION_PK                                   */
/*==============================================================*/
create unique index CAMIONERO_CAMION_PK on CAMIONERO_CAMION (
MATRICULA,
CI
);

/*==============================================================*/
/* Index: CAMIONERO_CAMION2_FK                                  */
/*==============================================================*/
create  index CAMIONERO_CAMION2_FK on CAMIONERO_CAMION (
CI
);

/*==============================================================*/
/* Index: CAMIONERO_CAMION_FK                                   */
/*==============================================================*/
create  index CAMIONERO_CAMION_FK on CAMIONERO_CAMION (
MATRICULA
);

/*==============================================================*/
/* Table: CHOFER                                                */
/*==============================================================*/
create table CHOFER (
   CI                   CHAR(10)             not null,
   NOMBRE               VARCHAR(50)          not null,
   TELEFONO             VARCHAR(15)          not null,
   DIRECCION            VARCHAR(100)         not null,
   SALARIO              MONEY                not null,
   EDAD                 INT4                 not null,
   constraint PK_CHOFER primary key (CI)
);

/*==============================================================*/
/* Index: CHOFER_PK                                             */
/*==============================================================*/
create unique index CHOFER_PK on CHOFER (
CI
);

/*==============================================================*/
/* Table: CIUDAD                                                */
/*==============================================================*/
create table CIUDAD (
   CODIGO_CIUDAD        CHAR(10)             not null,
   NOMBRE               VARCHAR(50)          not null,
   PROVINCIA            VARCHAR(50)          not null,
   constraint PK_CIUDAD primary key (CODIGO_CIUDAD)
);

/*==============================================================*/
/* Index: CIUDAD_PK                                             */
/*==============================================================*/
create unique index CIUDAD_PK on CIUDAD (
CODIGO_CIUDAD
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CEDULA               CHAR(10)             not null,
   NOMBRE               VARCHAR(50)          not null,
   EDAD                 INT4                 not null,
   DIRECCION            VARCHAR(100)         not null,
   TELEFONO             VARCHAR(15)          not null,
   constraint PK_CLIENTE primary key (CEDULA)
);

/*==============================================================*/
/* Index: CLIENTE_PK                                            */
/*==============================================================*/
create unique index CLIENTE_PK on CLIENTE (
CEDULA
);

/*==============================================================*/
/* Table: DESCRIPCION_PAQUETE                                   */
/*==============================================================*/
create table DESCRIPCION_PAQUETE (
   CODIGO_PAQUETE       CHAR(10)             not null,
   ID_VINO              TEXT                 not null,
   CANTIDAD             INT4                 not null,
   constraint PK_DESCRIPCION_PAQUETE primary key (CODIGO_PAQUETE, ID_VINO)
);

/*==============================================================*/
/* Index: DESCRIPCION_PAQUETE_PK                                */
/*==============================================================*/
create unique index DESCRIPCION_PAQUETE_PK on DESCRIPCION_PAQUETE (
CODIGO_PAQUETE,
ID_VINO
);

/*==============================================================*/
/* Index: DESCRIPCION_PAQUETE2_FK                               */
/*==============================================================*/
create  index DESCRIPCION_PAQUETE2_FK on DESCRIPCION_PAQUETE (
ID_VINO
);

/*==============================================================*/
/* Index: DESCRIPCION_PAQUETE_FK                                */
/*==============================================================*/
create  index DESCRIPCION_PAQUETE_FK on DESCRIPCION_PAQUETE (
CODIGO_PAQUETE
);

/*==============================================================*/
/* Table: PAQUETE                                               */
/*==============================================================*/
create table PAQUETE (
   CODIGO_PAQUETE       CHAR(10)             not null,
   CI_CHOFER            CHAR(10)             not null,
   CODIGO_CIUDAD        CHAR(10)             not null,
   CI_CLIENTE           CHAR(10)             not null,
   DIRECCION_PAQUETE    CHAR(100)            not null,
   FECHA_ENVIO          DATE                 not null,
   ESTADO               CHAR(40)             not null,
   COSTO_ENVIO          FLOAT(5)               not null,
   FECHA_ENTREGA        DATE                 not null,
   PRECIO               FLOAT(5)               not null,
   constraint PK_PAQUETE primary key (CODIGO_PAQUETE)
);

/*==============================================================*/
/* Index: PAQUETE_PK                                            */
/*==============================================================*/
create unique index PAQUETE_PK on PAQUETE (
CODIGO_PAQUETE
);

/*==============================================================*/
/* Index: CAMIONERO_PAQUETE_FK                                  */
/*==============================================================*/
create  index CAMIONERO_PAQUETE_FK on PAQUETE (
CI_CHOFER
);

/*==============================================================*/
/* Index: PAQUETE_CIUDAD_FK                                     */
/*==============================================================*/
create  index PAQUETE_CIUDAD_FK on PAQUETE (
CODIGO_CIUDAD
);

/*==============================================================*/
/* Index: CLIENTE_PAQUETE_FK                                    */
/*==============================================================*/
create  index CLIENTE_PAQUETE_FK on PAQUETE (
CI_CLIENTE
);

/*==============================================================*/
/* Table: VINO                                                  */
/*==============================================================*/
create table VINO (
   ID_VINO              TEXT                 not null,
   PRECIO               MONEY                not null,
   VOLUMEN_ML_          INT4                 not null,
   SABOR                TEXT                 not null,
   constraint PK_VINO primary key (ID_VINO)
);

/*==============================================================*/
/* Index: VINO_PK                                               */
/*==============================================================*/
create unique index VINO_PK on VINO (
ID_VINO
);

alter table CAMIONERO_CAMION
   add constraint FK_CAMIONER_CAMIONERO_CAMION foreign key (MATRICULA)
      references CAMION (MATRICULA)
      on delete restrict on update restrict;

alter table CAMIONERO_CAMION
   add constraint FK_CAMIONER_CAMIONERO_CHOFER foreign key (CI)
      references CHOFER (CI)
      on delete restrict on update restrict;

alter table DESCRIPCION_PAQUETE
   add constraint FK_DESCRIPC_DESCRIPCI_PAQUETE foreign key (CODIGO_PAQUETE)
      references PAQUETE (CODIGO_PAQUETE)
      on delete restrict on update restrict;

alter table DESCRIPCION_PAQUETE
   add constraint FK_DESCRIPC_DESCRIPCI_VINO foreign key (ID_VINO)
      references VINO (ID_VINO)
      on delete restrict on update restrict;

alter table PAQUETE
   add constraint FK_PAQUETE_CAMIONERO_CHOFER foreign key (CI_CHOFER)
      references CHOFER (CI)
      on delete restrict on update restrict;

alter table PAQUETE
   add constraint FK_PAQUETE_CLIENTE_P_CLIENTE foreign key (CI_CLIENTE)
      references CLIENTE (CEDULA)
      on delete restrict on update restrict;

alter table PAQUETE
   add constraint FK_PAQUETE_PAQUETE_C_CIUDAD foreign key (CODIGO_CIUDAD)
      references CIUDAD (CODIGO_CIUDAD)
      on delete restrict on update restrict;

-- REGISTROS --

-- tabla chofer
INSERT INTO chofer (CI, NOMBRE, TELEFONO, DIRECCION, SALARIO, EDAD) 
	VALUES ('1234567890', 'John Doe', '555-1234', '123 Main St', '500,00', 30);
INSERT INTO chofer (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725661183', 'Juan Perez', '555-1234', 'Calle Principal 123', '2500,00', 35);
INSERT INTO chofer (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725661191', 'Esteban Condor', '0982556319', 'Jose Marty OE50-887', '1800,00', 44);
INSERT INTO chofer (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725842991', 'Kevin Faraday', '0989876387', 'Eloy Alfaro OE20-754', '1900,00', 37);
INSERT INTO chofer (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725888739', 'Guillermo Pazmillo', '0989846397', 'Eloy Alfaro OE20-701', '2500,00', 29);
INSERT INTO chofer (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725888738', 'Luis Grifin', '0989846397', 'Eloy Alfaro OE20-81', '2500,00', 59);
INSERT INTO chofer (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1785618731', 'Laura Stewie', '0698746397', 'Eloy Alfaro OE10-66', '2500,00', 69);
INSERT INTO chofer (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725998236', 'Esteven Bosnia', '0852746397', 'Calle 10 OE6-71', '6500,00', 69);
INSERT INTO chofer (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1103077556', 'David Amaya', '0986774837', 'Calle 91 OE10-66', '1500,00', 42);
INSERT INTO chofer (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1714176813', 'Jorge Herrera', '0986852437', 'Calle Los rosales OE10-66', '600,00', 52);

select * from chofer

--Tabla camion

INSERT INTO Camion (Matricula, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('ABC123', '200 HP', 'Modelo A', 'Articulado', 1600);

INSERT INTO Camion (Matricula, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('DEF456', '180 HP', 'Modelo B', 'Articulado', 1800);

INSERT INTO Camion (Matricula, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('GHI789', '250 HP', 'Modelo C', 'Articulado', 2000);

INSERT INTO Camion (Matricula, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('JKL012', '220 HP', 'Modelo C', 'Rigido', 1900);

INSERT INTO Camion (Matricula, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('MNO345', '190 HP', 'Modelo C', 'Articulado', 1900);

INSERT INTO Camion (Matricula, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('PQR678', '300 HP', 'Modelo A', 'Rigido', 2500);

INSERT INTO Camion (Matricula, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('STU901', '280 HP', 'Modelo B', 'Rigido', 6300);

INSERT INTO Camion (Matricula, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('VWX234', '350 HP', 'Modelo B', 'Articulado', 1600);

INSERT INTO Camion (Matricula, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('YZA567', '240 HP', 'Modelo B', 'Articulado', 1800);

INSERT INTO Camion (Matricula, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('BCD870', '180 HP', 'Modelo B', 'Rigido', 1800);

select * from camion

--tabla camionero-camion
insert into camionero_camion values ('ABC123','1234567890');
insert into camionero_camion values ('DEF456','1725661183');
insert into camionero_camion values ('GHI789','1725661191');
insert into camionero_camion values ('JKL012','1725842991');
insert into camionero_camion values ('MNO345','1725888739');
insert into camionero_camion values ('PQR678','1725888738');
insert into camionero_camion values ('STU901','1785618731');
insert into camionero_camion values ('VWX234','1725998236');
insert into camionero_camion values ('YZA567','1103077556');
insert into camionero_camion values ('BCD870','1714176813');
select * from camionero_camion

--ciudad

INSERT INTO CIUDAD (CODIGO_CIUDAD, NOMBRE, PROVINCIA)
VALUES ('GYE', 'Guayaquil', 'Guayas');

INSERT INTO CIUDAD (CODIGO_CIUDAD, NOMBRE, PROVINCIA)
VALUES ('UIO', 'Quito', 'Pichincha');

INSERT INTO CIUDAD (CODIGO_CIUDAD, NOMBRE, PROVINCIA)
VALUES ('CUE', 'Cuenca', 'Azuay');

INSERT INTO CIUDAD (CODIGO_CIUDAD, NOMBRE, PROVINCIA)
VALUES ('SNC', 'Santo Domingo', 'Santo Domingo de los Tsáchilas');

INSERT INTO CIUDAD (CODIGO_CIUDAD, NOMBRE, PROVINCIA)
VALUES ('AMB', 'Ambato', 'Tungurahua');

INSERT INTO CIUDAD (CODIGO_CIUDAD, NOMBRE, PROVINCIA)
VALUES ('ESM', 'Esmeraldas', 'Esmeraldas');

INSERT INTO CIUDAD (CODIGO_CIUDAD, NOMBRE, PROVINCIA)
VALUES ('MNT', 'Manta', 'Manabí');

INSERT INTO CIUDAD (CODIGO_CIUDAD, NOMBRE, PROVINCIA)
VALUES ('LOJ', 'Loja', 'Loja');

INSERT INTO CIUDAD (CODIGO_CIUDAD, NOMBRE, PROVINCIA)
VALUES ('IBB', 'Ibarra', 'Imbabura');

INSERT INTO CIUDAD (CODIGO_CIUDAD, NOMBRE, PROVINCIA)
VALUES ('MAC', 'Machala', 'El Oro');

select * from ciudad

-- CLIENTE
INSERT INTO CLIENTE (CEDULA, NOMBRE, EDAD, DIRECCION, TELEFONO)
VALUES
   ('1303753618', 'ABAD NIETO PABLO MARCELO', 20, 'OE50-60 PABLO AROSEMENA', '0982556149'),
   ('1706172648', 'ABATA REINOSO BELLA NARCISA DEL PILAR', 19, 'CALLE 1', '0987633159'),
   ('0100967652', 'ABRIL ABRIL CARLOS ENRIQUE', 55, 'oe19-699', '0984632897'),
   ('1103037048', 'ACARO CASTILLO NARCISA DEL LOURDES', 62, 'OE20-701', '0986774239'),
   ('1704997012', 'ACEVEDO PALACIO SONIA CECILIA',30 , 'ALBORADAS Y PARQUE CENTRAL', '0989443618'),
   ('1714818299', 'ACOSTA VASQUEZ DAVID JOSE',40, 'OE33-102', '0987615755'),
   ('1713627071', 'ACURIO DEL PINO SANTIAGO MARTIN',25 , 'OE17-211', '0986771379'),
   ('0200982163', 'JAGUAGUINA MOYON GLADYS EUGENIA',29 , 'OE20-701', '0986376814'),
   ('0913537742', 'AGUAYO URGILES JULIO ALEJANDRO',22 , 'OE33-222', '0986774531'),
   ('0401197298', 'AGUILAR GORDON DARWIN EUGENIO',23 , 'OE20-690', '0988860320');
select * from cliente

--PAQUETE
INSERT INTO PAQUETE (CODIGO_PAQUETE, CI_CHOFER, CODIGO_CIUDAD, CI_CLIENTE, DIRECCION_PAQUETE, FECHA_ENVIO, ESTADO, COSTO_ENVIO, FECHA_ENTREGA, precio)
VALUES
   ('001', '1234567890', 'GYE', '1303753618', 'Av. Principal', '2023-06-01', 'Rechazado', 50.00, '2023-06-05', 280.00),
   ('002', '1725661183', 'UIO', '1706172648', 'Calle Principal', '2023-06-02', 'Entregado', 80.00, '2023-06-06', 750.00),
   ('003', '1725661191', 'CUE', '0100967652', 'Av. 9 de Octubre', '2023-06-03', 'Entregado', 100.00, '2023-06-04', 570.00),
   ('004', '1725842991', 'SNC', '1103037048', 'Av. Quito', '2023-06-04', 'Entregado', 70.00, '2023-06-07', 300.00),
   ('005', '1725888739', 'AMB', '1704997012', 'Av. 10 de Agosto', '2023-06-05', 'Rechazado', 120.00, '2023-06-08', 580.00),
   ('006', '1725888738', 'ESM', '1714818299', 'Av. Amazonas', '2023-06-06', 'Rechazado', 90.00, '2023-06-09', 200.00),
   ('007', '1785618731', 'MNT', '1713627071', 'Av. Solanda', '2023-06-07', 'Entregado', 60.00, '2023-06-10', 720.00),
   ('008', '1725998236', 'LOJ', '0200982163', 'Av. Los Alamos', '2023-06-08', 'Entregado', 150.00, '2023-06-11', 960.00),
   ('009', '1103077556', 'IBB', '0913537742', 'Av. 9 de Octubre', '2023-06-09', 'Entregado', 80.00, '2023-06-12', 180.00),
   ('010', '1714176813', 'MAC', '0401197298', 'Av. Juan Montalvo', '2023-06-10', 'Entregado', 110.00, '2023-06-13', 3600.00);
select * from paquete

--VINO
INSERT INTO VINO (ID_VINO, PRECIO, volumen_ML_, SABOR)
VALUES ('AF328', 7.00, 750, 'MORA');

INSERT INTO VINO (ID_VINO, PRECIO, volumen_ML_, SABOR)
VALUES ('AF329', 7.00, 750, 'UVA');

INSERT INTO VINO (ID_VINO, PRECIO, volumen_ML_, SABOR)
VALUES ('AF330', 7.00, 750, 'NARANJILLA');

SELECT * FROM VINO

--descripcion_paquete
INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', '001', 4),
	('AF329', '001', 5),
	('AF330', '001', 1);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', '002', 4),
	('AF330', '002', 5);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', '003', 4),
	('AF329', '003', 5),
	('AF330', '003', 1);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', '004', 40),
	('AF329', '004', 5),
	('AF330', '004', 1);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', '005', 1),
	('AF329', '005', 58),
	('AF330', '005', 1);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', '006', 14),
	('AF329', '006', 2),
	('AF330', '006', 10);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
	('AF329', '007', 5),
	('AF330', '007', 91);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', '008', 4),
	('AF329', '008', 5),
	('AF330', '008', 1);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', '009', 4),
	('AF329', '009', 15),
	('AF330', '009', 126);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', '010', 400);

SELECT * FROM DESCRIPCION_PAQUETE

