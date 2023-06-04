SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public' -- Cambia 'public' al esquema de la base de datos que deseas consultar
  AND table_type = 'BASE TABLE';

drop index CAMIONERO_CAMION2_FK;

drop index CAMION_PK;

drop table CAMION;

drop index CAMIONERO_CAMION_FK;

drop index CAMIONERO_PK;

drop table CAMIONERO;

drop index CIUDAD_PK;

drop table CIUDAD;

drop index DESCRIPCION_PAQUETE2_FK;

drop index DESCRIPCION_PAQUETE_FK;

drop index DESCRIPCION_PAQUETE_PK;

drop table DESCRIPCION_PAQUETE;

drop index PAQUETE_CIUDAD2_FK;

drop index PAQUETE_CIUDAD_FK;

drop index ENVIO_PK;

drop table ENVIO;

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
   CI                   CHAR(10)             null,
   POTENCIA             VARCHAR(50)          not null,
   MODELO               VARCHAR(15)          not null,
   TIPO                 VARCHAR(100)         not null,
   CAPACIDAD_KG         INT4                 not null  check (CAPACIDAD_KG >= 0.0) Default 0.0,
   constraint PK_CAMION primary key (MATRICULA)
);

/*==============================================================*/
/* Index: CAMION_PK                                             */
/*==============================================================*/
create unique index CAMION_PK on CAMION (
MATRICULA
);

/*==============================================================*/
/* Index: CAMIONERO_CAMION2_FK                                  */
/*==============================================================*/
create  index CAMIONERO_CAMION_FK on CAMION (
CI
);

/*==============================================================*/
/* Table: CAMIONERO                                             */
/*==============================================================*/
create table CAMIONERO (
   CI                   CHAR(10)             not null,
   NOMBRE               VARCHAR(50)          not null,
   TELEFONO             VARCHAR(15)          not null,
   DIRECCION            VARCHAR(100)         not null,
   SALARIO              MONEY                not null default 420.00,
    CONSTRAINT check_salario_positive CHECK (Salario >= '00.0'),
   EDAD                 INT4                 not null,
   constraint PK_CAMIONERO primary key (CI)
);

/*==============================================================*/
/* Index: CAMIONERO_PK                                          */
/*==============================================================*/
create unique index CAMIONERO_PK on CAMIONERO (
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
/* Table: DESCRIPCION_PAQUETE                                   */
/*==============================================================*/
create table DESCRIPCION_PAQUETE (
   ID_VINO              CHAR(10)             not null,
   CODIGO_PAQUETE       CHAR(10)             not null,
   constraint PK_DESCRIPCION_PAQUETE primary key (ID_VINO, CODIGO_PAQUETE)
);

ALTER TABLE DESCRIPCION_PAQUETE
ADD COLUMN CANTIDAD INT NOT NULL;

/*==============================================================*/
/* Index: DESCRIPCION_PAQUETE_PK                                */
/*==============================================================*/
create unique index DESCRIPCION_PAQUETE_PK on DESCRIPCION_PAQUETE (
ID_VINO,
CODIGO_PAQUETE
);

/*==============================================================*/
/* Index: DESCRIPCION_PAQUETE_FK                                */
/*==============================================================*/
create  index DESCRIPCION_PAQUETE_FK on DESCRIPCION_PAQUETE (
ID_VINO
);

/*==============================================================*/
/* Index: DESCRIPCION_PAQUETE2_FK                               */
/*==============================================================*/
create  index DESCRIPCION_PAQUETE2_FK on DESCRIPCION_PAQUETE (
CODIGO_PAQUETE
);

/*==============================================================*/
/* Table: ENVIO                                                 */
/*==============================================================*/
create table ENVIO (
   ID_ENVIO             SERIAL               not null,
   CODIGO_PAQUETE       CHAR(10)             not null,
   CODIGO_CIUDAD_ORIGEN CHAR(10)             not null,
   CODIGO_CIUDAD_DESTINO CHAR(10)            not null,
   FECHO_ENVIO          DATE                 not null,
   constraint PK_ENVIO primary key (CODIGO_CIUDAD_DESTINO, CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, ID_ENVIO)
);

/*==============================================================*/
/* Index: ENVIO_PK                                              */
/*==============================================================*/
create unique index ENVIO_PK on ENVIO (
CODIGO_CIUDAD_DESTINO,
CODIGO_PAQUETE,
CODIGO_CIUDAD_ORIGEN,
ID_ENVIO
);

/*==============================================================*/
/* Index: PAQUETE_CIUDAD_FK                                     */
/*==============================================================*/
create  index PAQUETE_CIUDAD_FK on ENVIO (
CODIGO_PAQUETE
);

/*==============================================================*/
/* Index: PAQUETE_CIUDAD2_FK                                    */
/*==============================================================*/
create  index PAQUETE_CIUDAD2_FK on ENVIO (
CODIGO_CIUDAD_ORIGEN
);

/*==============================================================*/
/* Table: PAQUETE                                               */
/*==============================================================*/
create table PAQUETE (
   CODIGO_PAQUETE       CHAR(10)             not null,
   CI                   CHAR(10)             not null,
   DESCRIPCION          VARCHAR(50)          not null,
   DESTINATARIO         VARCHAR(15)          not null,
   DIRECCION_PAQUETE    VARCHAR(100)         not null,
   CI_CAMIONERO         CHAR(10)             not null,
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
CI
);

/*==============================================================*/
/* Table: VINO                                                  */
/*==============================================================*/
create table VINO (
   ID_VINO              CHAR(10)             not null,
   PRECIO               NUMERIC(4,2)         not null,
   CANTIDAD_ML_         INT4                 not null,
   SABOR                VARCHAR(10)           not null,
   constraint PK_VINO primary key (ID_VINO)
);

/*==============================================================*/
/* Index: VINO_PK                                               */
/*==============================================================*/
create unique index VINO_PK on VINO (
ID_VINO
);

alter table CAMION
   add constraint FK_CAMION_CAMIONERO_CAMIONER foreign key (CI)
      references CAMIONERO (CI)
      on delete restrict on update restrict;

alter table DESCRIPCION_PAQUETE
   add constraint FK_DESCRIPC_DESCRIPCI_VINO foreign key (ID_VINO)
      references VINO (ID_VINO)
      on delete restrict on update restrict;

alter table DESCRIPCION_PAQUETE
   add constraint FK_DESCRIPC_DESCRIPCI_PAQUETE foreign key (CODIGO_PAQUETE)
      references PAQUETE (CODIGO_PAQUETE)
      on delete restrict on update restrict;

alter table ENVIO
   add constraint FK_ENVIO_PAQUETE_C_PAQUETE foreign key (CODIGO_PAQUETE)
      references PAQUETE (CODIGO_PAQUETE)
      on delete restrict on update restrict;

alter table ENVIO
   add constraint FK_ENVIO_PAQUETE_C_CIUDAD foreign key (CODIGO_CIUDAD_ORIGEN)
      references CIUDAD (CODIGO_CIUDAD)
      on delete restrict on update restrict;

alter table PAQUETE
   add constraint FK_PAQUETE_CAMIONERO_CAMIONER foreign key (CI)
      references CAMIONERO (CI)
      on delete restrict on update restrict;

---- Ingreso de datos 

--tabla Camionero
INSERT INTO CAMIONERO (CI, NOMBRE, TELEFONO, DIRECCION, SALARIO, EDAD) 
	VALUES ('1234567890', 'John Doe', '555-1234', '123 Main St', '500.00', 30);
INSERT INTO Camionero (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725661183', 'Juan Perez', '555-1234', 'Calle Principal 123', '2500.00', 35);
INSERT INTO Camionero (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725661191', 'Esteban Condor', '0982556319', 'Jose Marty OE50-887', '1800.00', 44);
INSERT INTO Camionero (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725842991', 'Kevin Faraday', '0989876387', 'Eloy Alfaro OE20-754', '1900.00', 37);
INSERT INTO Camionero (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725888739', 'Guillermo Pazmillo', '0989846397', 'Eloy Alfaro OE20-701', '2500.00', 29);
INSERT INTO Camionero (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725888738', 'Luis Grifin', '0989846397', 'Eloy Alfaro OE20-81', '2500.00', 59);
INSERT INTO Camionero (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1785618731', 'Laura Stewie', '0698746397', 'Eloy Alfaro OE10-66', '2500.00', 69);
INSERT INTO Camionero (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1725998236', 'Esteven Bosnia', '0852746397', 'Calle 10 OE6-71', '6500.00', 69);
INSERT INTO Camionero (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1103077556', 'David Amaya', '0986774837', 'Calle 91 OE10-66', '1500.00', 42);
INSERT INTO Camionero (CI, Nombre, Telefono, Direccion, Salario, Edad)
	VALUES ('1714176813', 'Jorge Herrera', '0986852437', 'Calle Los rosales OE10-66', '600.00', 52);

select * from camionero

--Tabla camion

INSERT INTO Camion (Matricula, CI, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('ABC123', '1234567890', '200 HP', 'Modelo A', 'Articulado', 1600);

INSERT INTO Camion (Matricula, CI, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('DEF456', '1725661183', '180 HP', 'Modelo B', 'Articulado', 1800);

INSERT INTO Camion (Matricula, CI, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('GHI789', '1725661191', '250 HP', 'Modelo C', 'Articulado', 2000);

INSERT INTO Camion (Matricula, CI, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('JKL012', '1725842991', '220 HP', 'Modelo C', 'Rigido', 1900);

INSERT INTO Camion (Matricula, CI, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('MNO345', '1725888739', '190 HP', 'Modelo C', 'Articulado', 1900);

INSERT INTO Camion (Matricula, CI, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('PQR678', '1725888738', '300 HP', 'Modelo A', 'Rigido', 2500);

INSERT INTO Camion (Matricula, CI, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('STU901', '1785618731', '280 HP', 'Modelo B', 'Rigido', 6300);

INSERT INTO Camion (Matricula, CI, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('VWX234', '1725998236', '350 HP', 'Modelo B', 'Articulado', 1600);

INSERT INTO Camion (Matricula, CI, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('YZA567', '1103077556', '240 HP', 'Modelo B', 'Articulado', 1800);

INSERT INTO Camion (Matricula, CI, Potencia, Modelo, Tipo, Capacidad_Kg)
VALUES ('BCD870', '1103077556', '180 HP', 'Modelo B', 'Rigido', 1800);

select * from camion

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

--paquete
INSERT INTO PAQUETE (CODIGO_PAQUETE, CI, DESCRIPCION, DESTINATARIO, DIRECCION_PAQUETE, CI_CAMIONERO)
VALUES ('PQ01', '1234567890', '8 paquetes', 'John Smith', 'Dirección 1', '1234567890');

INSERT INTO PAQUETE (CODIGO_PAQUETE, CI, DESCRIPCION, DESTINATARIO, DIRECCION_PAQUETE, CI_CAMIONERO)
VALUES ('PQ02', '1725661183', '2 paquetes', 'Emma Johnson', 'Dirección 2', '1725661183');

INSERT INTO PAQUETE (CODIGO_PAQUETE, CI, DESCRIPCION, DESTINATARIO, DIRECCION_PAQUETE, CI_CAMIONERO)
VALUES ('PQ03', '1725661191', '6 paquetes', 'Michael Brown', 'Dirección 3', '1725661191');

INSERT INTO PAQUETE (CODIGO_PAQUETE, CI, DESCRIPCION, DESTINATARIO, DIRECCION_PAQUETE, CI_CAMIONERO)
VALUES ('PQ04', '1725842991', '8 paquetes', 'Olivia Davis', 'Dirección 4', '1725842991');

INSERT INTO PAQUETE (CODIGO_PAQUETE, CI, DESCRIPCION, DESTINATARIO, DIRECCION_PAQUETE, CI_CAMIONERO)
VALUES ('PQ05', '1725888739', '6 paquetes', 'Noah Wilson', 'Dirección 5', '1725888739');

INSERT INTO PAQUETE (CODIGO_PAQUETE, CI, DESCRIPCION, DESTINATARIO, DIRECCION_PAQUETE, CI_CAMIONERO)
VALUES ('PQ06', '1725888738', '1 paquete', 'Ava Anderson', 'Dirección 6', '1725888738');

INSERT INTO PAQUETE (CODIGO_PAQUETE, CI, DESCRIPCION, DESTINATARIO, DIRECCION_PAQUETE, CI_CAMIONERO)
VALUES ('PQ07', '1785618731', '2 paquetes', 'William Thomas', 'Dirección 7', '1785618731');

INSERT INTO PAQUETE (CODIGO_PAQUETE, CI, DESCRIPCION, DESTINATARIO, DIRECCION_PAQUETE, CI_CAMIONERO)
VALUES ('PQ08', '1725998236', '8 paquetes', 'Sophia Martinez', 'Dirección 8', '1725998236');

INSERT INTO PAQUETE (CODIGO_PAQUETE, CI, DESCRIPCION, DESTINATARIO, DIRECCION_PAQUETE, CI_CAMIONERO)
VALUES ('PQ09', '1103077556', '5 paquetes', 'James Thompson', 'Dirección 9', '1103077556');

INSERT INTO PAQUETE (CODIGO_PAQUETE, CI, DESCRIPCION, DESTINATARIO, DIRECCION_PAQUETE, CI_CAMIONERO)
VALUES ('PQ10', '1714176813', '8 paquetes', 'Isabella Garcia', 'Dirección 10', '1714176813');

select * from paquete

--Envio
INSERT INTO ENVIO (CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, CODIGO_CIUDAD_DESTINO, FECHO_ENVIO)
VALUES ('PQ01', 'AMB', 'UIO', '2023-07-3');

INSERT INTO ENVIO (CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, CODIGO_CIUDAD_DESTINO, FECHO_ENVIO)
VALUES ('PQ02', 'AMB', 'GYE', '2023-05-3');

INSERT INTO ENVIO (CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, CODIGO_CIUDAD_DESTINO, FECHO_ENVIO)
VALUES ('PQ03', 'AMB', 'SNC', '2023-05-3');

INSERT INTO ENVIO (CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, CODIGO_CIUDAD_DESTINO, FECHO_ENVIO)
VALUES ('PQ04', 'AMB', 'ESM', '2022-09-3');

INSERT INTO ENVIO (CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, CODIGO_CIUDAD_DESTINO, FECHO_ENVIO)
VALUES ('PQ05', 'AMB', 'MNT', '2022-04-3');

INSERT INTO ENVIO (CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, CODIGO_CIUDAD_DESTINO, FECHO_ENVIO)
VALUES ('PQ06', 'AMB', 'IBB', '2022-05-31');

INSERT INTO ENVIO (CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, CODIGO_CIUDAD_DESTINO, FECHO_ENVIO)
VALUES ('PQ07', 'AMB', 'GYE', '2023-01-31');

INSERT INTO ENVIO (CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, CODIGO_CIUDAD_DESTINO, FECHO_ENVIO)
VALUES ('PQ08', 'UIO', 'AMB', '2023-04-12');

INSERT INTO ENVIO (CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, CODIGO_CIUDAD_DESTINO, FECHO_ENVIO)
VALUES ('PQ09', 'UIO', 'UIO', '2023-02-15');

INSERT INTO ENVIO (CODIGO_PAQUETE, CODIGO_CIUDAD_ORIGEN, CODIGO_CIUDAD_DESTINO, FECHO_ENVIO)
VALUES ('PQ10', 'UIO', 'LOJ', '2023-04-11');

select * from envio

--VINO
INSERT INTO VINO (ID_VINO, PRECIO, CANTIDAD_ML_, SABOR)
VALUES ('AF328', 7.00, 750, 'MORA')

INSERT INTO VINO (ID_VINO, PRECIO, CANTIDAD_ML_, SABOR)
VALUES ('AF329', 7.00, 750, 'UVA')

INSERT INTO VINO (ID_VINO, PRECIO, CANTIDAD_ML_, SABOR)
VALUES ('AF330', 7.00, 750, 'NARANJILLA')

SELECT * FROM VINO

--descripcion_paquete
INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', 'PQ01', 4),
	('AF329', 'PQ01', 5),
	('AF330', 'PQ01', 1);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', 'PQ02', 4),
	('AF330', 'PQ02', 5);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', 'PQ03', 4),
	('AF329', 'PQ03', 5),
	('AF330', 'PQ03', 1);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', 'PQ04', 40),
	('AF329', 'PQ04', 5),
	('AF330', 'PQ04', 1);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', 'PQ05', 1),
	('AF329', 'PQ05', 58),
	('AF330', 'PQ05', 1);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', 'PQ06', 14),
	('AF329', 'PQ06', 2),
	('AF330', 'PQ06', 10);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
	('AF329', 'PQ07', 5),
	('AF330', 'PQ07', 91);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', 'PQ08', 4),
	('AF329', 'PQ08', 5),
	('AF330', 'PQ08', 1);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', 'PQ09', 4),
	('AF329', 'PQ09', 15),
	('AF330', 'PQ09', 126);

INSERT INTO DESCRIPCION_PAQUETE (ID_VINO, CODIGO_PAQUETE, CANTIDAD)
VALUES
    ('AF328', 'PQ10', 400);

SELECT * FROM DESCRIPCION_PAQUETE