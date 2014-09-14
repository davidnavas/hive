set hive.support.concurrency=true;
set hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;
set hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;
set hive.enforce.bucketing=true;

create table acid_uat(ti tinyint,
                 si smallint,
                 i int,
                 bi bigint,
                 f float,
                 d double,
                 de decimal(5,2),
                 t timestamp,
                 dt date,
                 s string,
                 vc varchar(128),
                 ch char(36),
                 b boolean) clustered by (i) into 2 buckets stored as orc;

insert into table acid_uat
    select ctinyint,
           csmallint,
           cint,
           cbigint,
           cfloat,
           cdouble,
           cast(cfloat as decimal(5,2)),
           ctimestamp1,
           cast(ctimestamp2 as date),
           cstring1,
           cast(cstring1 as varchar(128)),
           cast(cstring2 as char(36)),
           cboolean1
        from alltypesorc where cint < 0 order by cint limit 10;

select * from acid_uat order by i;

update acid_uat set
    ti = 1,
    si = 2,
    i = 3,
    bi = 4,
    f = 3.14,
    d = 6.28,
    de = 5.99,
    t = '2014-09-01 09:44.23.23',
    dt = '2014-09-01',
    s = 'its a beautiful day in the neighbhorhood',
    vc = 'a beautiful day for a neighbor',
    ch = 'wont you be mine',
    b = true
  where s = '0ruyd6Y50JpdGRf6HqD';

select * from acid_uat order by i;

