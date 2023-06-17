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
   COSTO_ENVIO          FLOAT5               not null,
   FECHA_ENTREGA        DATE                 not null,
   PRECIO               FLOAT5               not null,
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

