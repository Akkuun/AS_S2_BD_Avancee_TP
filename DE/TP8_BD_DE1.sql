/*1/ creation du modele*/

CREATE TABLE Members (
                        id VARCHAR(45) NOT NULL ,
                        first_name VARCHAR(45) NOT NULL,
                        last_name VARCHAR(45) NOT NULL,
                        address VARCHAR(100) NOT NULL,
                        account_balance DECIMAL(10,2) NOT NULL DEFAULT '0.00',
                        discount INT NOT NULL DEFAULT '0',
                        PRIMARY KEY (id)
);



CREATE TABLE Movies (
                       barcode int(15) NOT NULL,
                       id VARCHAR(45) NOT NULL ,
                       title VARCHAR(100) NOT NULL,
                       summary TEXT NOT NULL,
                       release_date DATE NOT NULL,
                       category VARCHAR(45) NOT NULL,
                       PRIMARY KEY (id)
);

CREATE TABLE States (
                        barcode int(15) NOT NULL,
                        moovieState VARCHAR(45) NOT NULL ,
                        PRIMARY KEY (barcode),
                        foreign key (barcode) references  Movies(barcode) on delete cascade  on update cascade
);



CREATE TABLE Locations  (
                        barcode int(15) NOT NULL,
                        id VARCHAR(45) NOT NULL ,
                        start_location date NOT NULL,
                        release_date date not null ,
                        PRIMARY KEY (id,barcode),
                        foreign key (id) references Members(ID) on delete cascade on update cascade ,
                        foreign key (barcode) references  Movies(barcode) on delete cascade  on update cascade
);

