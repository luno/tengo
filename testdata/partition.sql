SET foreign_key_checks=0;
SET sql_log_bin=0;
CREATE DATABASE partitionparty;
use partitionparty

CREATE TABLE prange (
	id int unsigned NOT NULL AUTO_INCREMENT,
	customer_id int unsigned NOT NULL,
	info text,
	PRIMARY KEY (id, customer_id)
) ENGINE=InnoDB ROW_FORMAT=REDUNDANT PARTITION BY RANGE (customer_id) (
	PARTITION p0 VALUES LESS THAN (123),
	PARTITION p1 VALUES LESS THAN (456),
	PARTITION p2 VALUES LESS THAN MAXVALUE
);

CREATE TABLE prangecol (
	a INT,
	b INT,
	c CHAR(3),
	d INT
) PARTITION BY RANGE COLUMNS(a, `d`,c) (
	PARTITION p0 VALUES LESS THAN (5,10,'ggg'),
	PARTITION p1 VALUES LESS THAN (10,20,'mmm'),
	PARTITION p2 VALUES LESS THAN (15,30,'sss'),
	PARTITION p3 VALUES LESS THAN (MAXVALUE,MAXVALUE,MAXVALUE)
);

CREATE TABLE plist (
	id   INT,
	name VARCHAR(35)
)
PARTITION BY LIST (`id`) (
	PARTITION r0 VALUES IN (1, 5, 9),
	PARTITION r1 VALUES IN (2, 6, 10),
	PARTITION r2 VALUES IN (3, 7, 11),
	PARTITION r3 VALUES IN (4, 8, 12)
);

CREATE TABLE plistcol (
	first int,
	second int
)
PARTITION BY LIST COLUMNS(`first`,second) (
	PARTITION p0 VALUES IN( (0,0), (NULL,NULL) ),
	PARTITION p1 VALUES IN( (0,1), (0,2), (0,3), (1,1), (1,2) ),
	PARTITION p2 VALUES IN( (1,0), (2,0), (2,1), (3,0), (3,1) ),
	PARTITION p3 VALUES IN( (1,3), (2,2), (2,3), (3,2), (3,3) )
);

CREATE TABLE pkey (col1 INT, col2 CHAR(5), col3 DATE)
	PARTITION BY KEY ALGORITHM = 2 (col3, `col1`) 
	PARTITIONS 5;

CREATE TABLE pkeyalgo1 (col1 INT, col2 CHAR(5), col3 DATE)
	PARTITION BY KEY ALGORITHM = 1 (col3) 
	PARTITIONS 2;

CREATE TABLE pkeypk (
	a int NOT NULL,
	b int NOT NULL,
	c varchar(20),
	PRIMARY KEY (a, b)
) ENGINE=InnoDB
PARTITION BY KEY() PARTITIONS 3;

CREATE TABLE plinearkey (col1 INT, col2 CHAR(5), col3 DATE)
PARTITION BY LINEAR KEY (col1) PARTITIONS 2;

CREATE TABLE phash (
	c1 INT,
	c2 INT,
	c3 VARCHAR(25)
)
PARTITION BY HASH(c1 + `c2`)
PARTITIONS 3;

CREATE TABLE plinearhash (
	c1 INT,
	c2 INT,
	c3 VARCHAR(25)
)
PARTITION BY LINEAR HASH(c1)
PARTITIONS 4;

CREATE TABLE phashexplicit (
	c1 int,
	c2 int,
	c3 varchar(10)
) PARTITION BY HASH(c1 + c2)
PARTITIONS 4 (
	PARTITION p0,
	PARTITION p1,
	PARTITION p2 COMMENT 'lol',
	PARTITION p3
);

