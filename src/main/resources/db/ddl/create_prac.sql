-- Project Name : Prac
-- Date/Time    : 2021/02/23 18:59:11
-- Author       : S_M
-- RDBMS Type   : PostgreSQL
-- Application  : A5:SQL Mk-2

/*
  BackupToTempTable, RestoreFromTempTable疑似命令が付加されています。
  これにより、drop table, create table 後もデータが残ります。
  この機能は一時的に $$TableName のような一時テーブルを作成します。
*/

-- 商品_生産者関連
--* BackupToTempTable
drop table if exists r_product_producer cascade;

--* RestoreFromTempTable
create table r_product_producer (
  product_id integer not null
  , producer_id integer not null
) ;

create unique index r_product_producer_PKI
  on r_product_producer(product_id,producer_id);

alter table r_product_producer
  add constraint r_product_producer_PKC primary key (product_id,producer_id);

-- 生産者
--* BackupToTempTable
drop table if exists m_producer cascade;

--* RestoreFromTempTable
create table m_producer (
  producer_id bigint not null
  , name character varying(255) not null check(name<>")
  , created_at timestamp default now() not null
  , updated_at timestamp default now() not null
) ;

create unique index m_producer_PKI
  on m_producer(producer_id);

alter table m_producer
  add constraint m_producer_PKC primary key (producer_id);

-- 商品
--* BackupToTempTable
drop table if exists m_product cascade;

--* RestoreFromTempTable
create table m_product (
  product_id bigint not null
  , name character varying(30) not null
  , price integer
  , created_at timestamp with time zone default now() not null
  , updated_at timestamp with time zone default now() not null
) ;

create unique index m_product_PKI
  on m_product(product_id);

alter table m_product
  add constraint m_product_PKC primary key (product_id);

alter table r_product_producer
  add constraint r_product_producer_FK1 foreign key (producer_id) references m_producer(producer_id)
  on delete cascade
  on update cascade;

alter table r_product_producer
  add constraint r_product_producer_FK2 foreign key (product_id) references m_product(product_id)
  on delete cascade
  on update cascade;

comment on table r_product_producer is '商品_生産者関連';
comment on column r_product_producer.product_id is '商品ID';
comment on column r_product_producer.producer_id is '生産者ID';

comment on table m_producer is '生産者';
comment on column m_producer.producer_id is 'ID';
comment on column m_producer.name is '生産者名';
comment on column m_producer.created_at is '作成日';
comment on column m_producer.updated_at is '更新日';

comment on table m_product is '商品';
comment on column m_product.product_id is 'ID:プライマリーキー';
comment on column m_product.name is '商品名';
comment on column m_product.price is '価格';
comment on column m_product.created_at is '作成日';
comment on column m_product.updated_at is '更新日';

