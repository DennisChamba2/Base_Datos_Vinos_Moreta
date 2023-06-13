/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     12/6/2023 16:11:40                           */
/*==============================================================*/


drop index DIM_CLIENTE_PK;

drop table DIM_CLIENTE;

drop index DIM_TIEMPO_PK;

drop table DIM_TIEMPO;

drop index DIM_UBICACION_PK;

drop table DIM_UBICACION;

drop index RELATIONSHIP_3_FK;

drop index RELATIONSHIP_2_FK;

drop index RELATIONSHIP_1_FK;

drop table HECHOS_ENTREGAS;

/*==============================================================*/
/* Table: DIM_CLIENTE                                           */
/*==============================================================*/
create table DIM_CLIENTE (
   ID_CLIENTE           SERIAL               not null,
   CEDULA               CHAR(10)             not null,
   NOMBRE               VARCHAR(50)          not null,
   EDAD                 INT4                 not null,
   constraint PK_DIM_CLIENTE primary key (ID_CLIENTE)
);

/*==============================================================*/
/* Index: DIM_CLIENTE_PK                                        */
/*==============================================================*/
create unique index DIM_CLIENTE_PK on DIM_CLIENTE (
ID_CLIENTE
);

/*==============================================================*/
/* Table: DIM_TIEMPO                                            */
/*==============================================================*/
create table DIM_TIEMPO (
   TIEMPO_ID            SERIAL               not null,
   FECHA_ENVIO          date                 not null,
   MES                  CHAR(10)             not null,
   ANO                  INT4             not null,
   constraint PK_DIM_TIEMPO primary key (TIEMPO_ID)
);

/*==============================================================*/
/* Index: DIM_TIEMPO_PK                                         */
/*==============================================================*/
create unique index DIM_TIEMPO_PK on DIM_TIEMPO (
TIEMPO_ID
);

/*==============================================================*/
/* Table: DIM_UBICACION                                         */
/*==============================================================*/
create table DIM_UBICACION (
   ID_CIUDAD            SERIAL               not null,
   CODIGO_CIUDAD        CHAR(10)             not null,
   NOMBRE               VARCHAR(50)          null,
   PROVINCIA            VARCHAR(50)          null,
   constraint PK_DIM_UBICACION primary key (ID_CIUDAD)
);

/*==============================================================*/
/* Index: DIM_UBICACION_PK                                      */
/*==============================================================*/
create unique index DIM_UBICACION_PK on DIM_UBICACION (
ID_CIUDAD
);

/*==============================================================*/
/* Table: HECHOS_ENTREGAS                                       */
/*==============================================================*/
create table HECHOS_ENTREGAS (
   ID_CIUDAD            INT4                 not null,
   TIEMPO_ID            INT4                 not null,
   ID_CLIENTE           INT4                 not null,
   COSTO_ENVIO          MONEY                null,
   CANTIDAD_PAQUETES_ENVIADOS INT4                 null,
   TOTAL_INGRESOS       MONEY                null,
   PORCENTAJE_ENTREGAS_EXITOSOS DECIMAL(4,2)         null
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_1_FK on HECHOS_ENTREGAS (
ID_CIUDAD
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_2_FK on HECHOS_ENTREGAS (
TIEMPO_ID
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_3_FK on HECHOS_ENTREGAS (
ID_CLIENTE
);

alter table HECHOS_ENTREGAS
   add constraint FK_HECHOS_E_RELATIONS_DIM_UBIC foreign key (ID_CIUDAD)
      references DIM_UBICACION (ID_CIUDAD)
      on delete restrict on update restrict;

alter table HECHOS_ENTREGAS
   add constraint FK_HECHOS_E_RELATIONS_DIM_TIEM foreign key (TIEMPO_ID)
      references DIM_TIEMPO (TIEMPO_ID)
      on delete restrict on update restrict;

alter table HECHOS_ENTREGAS
   add constraint FK_HECHOS_E_RELATIONS_DIM_CLIE foreign key (ID_CLIENTE)
      references DIM_CLIENTE (ID_CLIENTE)
      on delete restrict on update restrict;

-- ingreso de registros
--dim_clientes
select * from dim_cliente

INSERT INTO DIM_CLIENTE (CEDULA, NOMBRE, EDAD)
VALUES ('1303753618', 'ABAD NIETO PABLO MARCELO', 20),
		('1706172648', 'ABATA REINOSO BELLA NARCISA DEL PILAR', 19),
		('0100967652', 'ABRIL ABRIL CARLOS ENRIQUE', 55),
		('1103037048', 'ACARO CASTILLO NARCISA DEL LOURDES', 62),
		('1704997012', 'ACEVEDO PALACIO SONIA CECILIA',30);

-- dim_ubicacion
select * from dim_ubicacion

insert into dim_ubicacion (codigo_ciudad, nombre, provincia)
values ('GYE', 'Guayaquil', 'Guayas'),
		('UIO', 'Quito', 'Pichincha'),
		('CUE', 'Cuenca', 'Azuay'),
		('SNC', 'Santo Domingo', 'Santo Domingo de los Tsáchilas'),
		('AMB', 'Ambato', 'Tungurahua');
		
-- dim_tiempo
select * from dim_tiempo

INSERT INTO DIM_TIEMPO (FECHA_ENVIO, MES, ANO)
VALUES ('2023-01-01', 'Enero', '2023');

INSERT INTO DIM_TIEMPO (FECHA_ENVIO, MES, ANO)
VALUES ('2023-02-15', 'Febrero', '2023');

INSERT INTO DIM_TIEMPO (FECHA_ENVIO, MES, ANO)
VALUES ('2023-03-10', 'Marzo', '2023');

INSERT INTO DIM_TIEMPO (FECHA_ENVIO, MES, ANO)
VALUES ('2023-04-20', 'Abril', '2023');

INSERT INTO DIM_TIEMPO (FECHA_ENVIO, MES, ANO)
VALUES ('2023-05-05', 'Mayo', '2023');

--hechos_entregas
select * from hechos_entregas

INSERT INTO HECHOS_ENTREGAS (ID_CIUDAD, TIEMPO_ID, ID_CLIENTE, COSTO_ENVIO, CANTIDAD_PAQUETES_ENVIADOS, TOTAL_INGRESOS, PORCENTAJE_ENTREGAS_EXITOSOS)
VALUES
  -- Registro 1
  ((SELECT ID_CIUDAD FROM DIM_UBICACION WHERE CODIGO_CIUDAD = 'GYE'), (SELECT TIEMPO_ID FROM DIM_TIEMPO WHERE MES = 'Enero' AND ANO = '2023'), (SELECT ID_CLIENTE FROM DIM_CLIENTE WHERE CEDULA = '1303753618'), 50.00, 3, 150.00, 0.80),
  -- Registro 2
  ((SELECT ID_CIUDAD FROM DIM_UBICACION WHERE CODIGO_CIUDAD = 'UIO'), (SELECT TIEMPO_ID FROM DIM_TIEMPO WHERE MES = 'Febrero' AND ANO = '2023'), (SELECT ID_CLIENTE FROM DIM_CLIENTE WHERE CEDULA = '1706172648'), 75.50, 5, 250.50, 0.90),
  -- Registro 3
  ((SELECT ID_CIUDAD FROM DIM_UBICACION WHERE CODIGO_CIUDAD = 'CUE'), (SELECT TIEMPO_ID FROM DIM_TIEMPO WHERE MES = 'Marzo' AND ANO = '2023'), (SELECT ID_CLIENTE FROM DIM_CLIENTE WHERE CEDULA = '0100967652'), 100.00, 2, 200.00, 0.75),
  -- Registro 4
  ((SELECT ID_CIUDAD FROM DIM_UBICACION WHERE CODIGO_CIUDAD = 'SNC'), (SELECT TIEMPO_ID FROM DIM_TIEMPO WHERE MES = 'Abril' AND ANO = '2023'), (SELECT ID_CLIENTE FROM DIM_CLIENTE WHERE CEDULA = '1103037048'), 45.80, 4, 183.20, 0.85),
  -- Registro 5
  ((SELECT ID_CIUDAD FROM DIM_UBICACION WHERE CODIGO_CIUDAD = 'AMB'), (SELECT TIEMPO_ID FROM DIM_TIEMPO WHERE MES = 'Mayo' AND ANO = '2023'), (SELECT ID_CLIENTE FROM DIM_CLIENTE WHERE CEDULA = '1704997012'), 60.00, 1, 60.00, 0.95);
  