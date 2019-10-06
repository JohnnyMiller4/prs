-- create and select database
drop database if exists prs;
create database prs;
use prs;

create table user (
		id			int				not null primary key,
        username	varchar(20)		not null,
        password	varchar(10)		not null,
        firstName	varchar(20)		not null,
        lastName	varchar(20)		not null,
        phoneNumber	varchar(12)		not null,
        email		varchar(75)		not null,
        isReviewer	tinyint(1)		not null,
        isAdmin		tinyint(1)		not null,
        
		CONSTRAINT uname unique (username)
);

Insert into user (id, username, password, firstName, lastName, phoneNumber, email, isReviewer, isAdmin)
values (1, 'jkillaz224', 'Quiet1sh0t', 'Johnny', 'Miller IV', '513-141-080', 'mgssocialbros@gmail.com', 0, 0);
Insert into user (id, username, password, firstName, lastName, phoneNumber, email, isReviewer, isAdmin)
values (2, 'Reylo4Lyfe', 'kylo8pak', 'Marie', 'Greedo', '513-113-800', 'bensoloishot@gmail.com', 0, 0);

create table request (
		id				int				not null primary key,
        userID			int				not null,
        description		varchar(100)	not null,
        justification	varchar(255)	not null,
        dateNeeded		date			not null,
        deliveryMode	varchar(25)		not null,
        status			varchar(20)		not null,
        total			decimal(10,2)	not null,
        submittedDate	datetime		not null,
        reasonForRejection	varchar(100),
        
        FOREIGN KEY (userID) REFERENCES user(id)
);

create table vendor (
	id			int				not null primary key,
    code		varchar(10)		not null,
    name		varchar(255)	not null,
    address		varchar(255)	not null,
    city		varchar(255)	not null,
    state		varchar(2)		not null,
    zip			varchar(5)		not null,
    phoneNumber	varchar(12)		not null,
    email		varchar(100)	not null,
    
    CONSTRAINT vcode unique (code)
);

Insert into vendor (id, code, name, address, city, state, zip, phoneNumber, email)
values (1, 'WM', 'Wal-Mart', '9145 Chamber Dr.', 'Batavia', 'OH', '45103', '513-602-1664', 'walmartgang69@gmail.com');

create table product (
	id			int				not null primary key,
    vendorID	int				not null,
    partNumber	varchar(50)		not null,
    name		varchar(150)	not null,
    price		decimal(10,2)	not null,
    unit		varchar(255),
    photoPath	varchar(255),
    
    FOREIGN KEY (vendorID) REFERENCES vendor(id),
    CONSTRAINT ven_pt unique (vendorID, partNumber)
);

Insert into product (id, vendorID, partNumber, name, price, unit, photoPath)
values (1, 1, 'WM77', 'Ben Swolo Body Pillow', 11.38, null, null);
Insert into product (id, vendorID, partNumber, name, price, unit, photoPath)
values (2, 1, 'WM15', 'Kylo Ren Mask', 38.11, null, null);

create table lineItem (
		id				int		not null primary key,
        requestID		int		not null,
        productID		int		not null,
        quantity		int,
        
        FOREIGN KEY (requestID) REFERENCES request(id),
		FOREIGN KEY (productID) REFERENCES product(id),
		CONSTRAINT req_pdt unique (requestID, productID)
);


DROP USER IF EXISTS prs_user@localhost;
CREATE USER prs_user@localhost IDENTIFIED BY 'sesame';
GRANT SELECT, INSERT, DELETE, UPDATE ON prs.* TO prs_user@localhost;