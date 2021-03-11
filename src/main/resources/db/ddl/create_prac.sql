-- Project Name : noname
-- Date/Time    : 2021/03/11 8:09:01
-- Author       : matsushitashun
-- RDBMS Type   : PostgreSQL
-- Application  : A5:SQL Mk-2

/*
  BackupToTempTable, RestoreFromTempTable疑似命令が付加されています。
  これにより、drop table, create table 後もデータが残ります。
  この機能は一時的に $$TableName のような一時テーブルを作成します。
*/

-- 組織テーブル
--* RestoreFromTempTable
create table m_organization (
  updated_at timestamp with time zone default now() not null
  , created_at timestamp with time zone default now() not null
  , org_name character varying(255) not null
  , org_id bigint not null
  , constraint m_organization_PKC primary key (org_id)
) ;

-- 所属組織ログ
--* RestoreFromTempTable
create table l_org_log (
  updated_at timestamp(6) with time zone default now() not null
  , created_at timestamp(6) with time zone default now() not null
  , new_org_name character varying(255) not null
  , new_org_id bigint not null
  , old_org_name character varying(255) not null
  , old_org_id bigint not null
  , l_log_id bigint not null
  , constraint l_org_log_PKC primary key (l_log_id)
) ;

create unique index l_org_log_pki
  on l_org_log(l_log_id);

-- 生産者
--* RestoreFromTempTable
create table m_producer (
  producer_id bigint not null
  , org_id bigint
  , name character varying(255) not null
  , created_at timestamp(6) without time zone default now() not null
  , updated_at timestamp(6) without time zone default now() not null
  , constraint m_producer_PKC primary key (producer_id)
) ;

create unique index m_producer_ix1
  on m_producer(producer_id);

-- 商品
--* RestoreFromTempTable
create table m_product (
  product_id bigint not null
  , name character varying(30) not null
  , price integer
  , created_at timestamp(6) with time zone default now() not null
  , updated_at timestamp(6) with time zone default now() not null
  , constraint m_product_PKC primary key (product_id)
) ;

create unique index m_product_ix1
  on m_product(product_id);

-- 商品_生産者関連
--* RestoreFromTempTable
create table r_product_producer (
  product_id integer not null
  , producer_id integer not null
  , constraint r_product_producer_PKC primary key (product_id,producer_id)
) ;

create unique index r_product_producer_ix1
  on r_product_producer(product_id,producer_id);

comment on table m_organization is '組織テーブル';
comment on column m_organization.updated_at is '更新日時';
comment on column m_organization.created_at is '登録日時';
comment on column m_organization.org_name is '組織名';
comment on column m_organization.org_id is '組織ID';

comment on table l_org_log is '所属組織ログ';
comment on column l_org_log.updated_at is '更新日時';
comment on column l_org_log.created_at is '登録日時';
comment on column l_org_log.new_org_name is '現所属組織名';
comment on column l_org_log.new_org_id is '現所属組織ID';
comment on column l_org_log.old_org_name is '旧所属組織名';
comment on column l_org_log.old_org_id is '旧所属組織ID';
comment on column l_org_log.l_log_id is 'ログID';

comment on table m_producer is '生産者';
comment on column m_producer.producer_id is 'ID';
comment on column m_producer.org_id is '組織ID';
comment on column m_producer.name is '生産者名';
comment on column m_producer.created_at is '作成日';
comment on column m_producer.updated_at is '更新日';

comment on table m_product is '商品';
comment on column m_product.product_id is 'ID:プライマリーキー';
comment on column m_product.name is '商品名';
comment on column m_product.price is '価格';
comment on column m_product.created_at is '作成日';
comment on column m_product.updated_at is '更新日';

comment on table r_product_producer is '商品_生産者関連';
comment on column r_product_producer.product_id is '商品ID';
comment on column r_product_producer.producer_id is '生産者ID';

