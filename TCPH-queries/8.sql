
CREATE TABLE LINEITEM (
        orderkey       INT,
        partkey        INT,
        suppkey        INT,
        linenumber     INT,
        quantity       DECIMAL,
        extendedprice  DECIMAL,
        discount       DECIMAL,
        tax            DECIMAL,
        returnflag     CHAR(1),
        linestatus     CHAR(1),
        shipdate       DATE,
        commitdate     DATE,
        receiptdate    DATE,
        shipinstruct   CHAR(25),
        shipmode       CHAR(10),
        comment        VARCHAR(44)
    );


CREATE TABLE ORDERS (
        orderkey       INT,
        custkey        INT,
        orderstatus    CHAR(1),
        totalprice     DECIMAL,
        orderdate      DATE,
        orderpriority  CHAR(15),
        clerk          CHAR(15),
        shippriority   INT,
        comment        VARCHAR(79)
    );

CREATE TABLE PART (
        partkey      INT,
        name         VARCHAR(55),
        mfgr         CHAR(25),
        brand        CHAR(10),
        type         VARCHAR(25),
        size         INT,
        container    CHAR(10),
        retailprice  DECIMAL,
        comment      VARCHAR(23)
    );


CREATE TABLE CUSTOMER (
        custkey      INT,
        name         VARCHAR(25),
        address      VARCHAR(40),
        nationkey    INT,
        phone        CHAR(15),
        acctbal      DECIMAL,
        mktsegment   CHAR(10),
        comment      VARCHAR(117)
    );

CREATE TABLE SUPPLIER (
        suppkey      INT,
        name         CHAR(25),
        address      VARCHAR(40),
        nationkey    INT,
        phone        CHAR(15),
        acctbal      DECIMAL,
        comment      VARCHAR(101)
    );

CREATE TABLE NATION (
        nationkey    INT,
        name         CHAR(25),
        regionkey    INT,
        comment      VARCHAR(152)
    );

CREATE TABLE REGION (
        regionkey    INT,
        name         CHAR(25),
        comment      VARCHAR(152)
    );



SELECT DISTINCT n2.name,
	   DATE_PART('year', o.orderdate) AS o_year,
	   l.extendedprice * (1-l.discount) AS volume
FROM   PART p, SUPPLIER s, LINEITEM l, ORDERS o, CUSTOMER c, NATION n1,
	   NATION n2, REGION r
WHERE  p.partkey = l.partkey
  AND  s.suppkey = l.suppkey
  AND  l.orderkey = o.orderkey
  AND  o.custkey = c.custkey
  AND  c.nationkey = n1.nationkey 
  AND  n1.regionkey = r.regionkey 
  AND  r.name = 'AMERICA'
  AND  s.nationkey = n2.nationkey
  AND  o.orderdate >= {d'1995-01-01'}
  AND  o.orderdate <= {d'1996-12-31'}
  AND  p.type = 'ECONOMY ANODIZED STEEL';