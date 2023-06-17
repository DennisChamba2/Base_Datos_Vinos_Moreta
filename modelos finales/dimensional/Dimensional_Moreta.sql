/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     17/6/2023 9:47:44                            */
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

drop index HECHOS_ENTREGAS_PK;

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
   FECHA_ENVIO          DATE                 not null,
   MES                  INT4                 not null,
   ANO                  INT4                 not null,
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
   NOMBRE               VARCHAR(50)          not null,
   PROVINCIA            VARCHAR(50)          not null,
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
   COSTO_ENVIO          FLOAT5               not null,
   PAQUETES_ENVIADOS    INT4                 not null,
   INGRESOS             FLOAT5               not null,
   PORCENTAJE_ENTREGAS_EXITOSAS FLOAT4               not null,
   constraint PK_HECHOS_ENTREGAS primary key (ID_CIUDAD, TIEMPO_ID, ID_CLIENTE)
);

/*==============================================================*/
/* Index: HECHOS_ENTREGAS_PK                                    */
/*==============================================================*/
create unique index HECHOS_ENTREGAS_PK on HECHOS_ENTREGAS (
ID_CIUDAD,
TIEMPO_ID,
ID_CLIENTE
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

