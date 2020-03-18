DROP SCHEMA IF EXISTS internet_provider CASCADE;
CREATE SCHEMA internet_provider;

DROP TABLE IF EXISTS internet_provider.contracts CASCADE;
DROP TABLE IF EXISTS internet_provider.internet CASCADE;
DROP TABLE IF EXISTS internet_provider.mobile CASCADE;
DROP TABLE IF EXISTS internet_provider.pc CASCADE;
DROP TABLE IF EXISTS internet_provider.roles CASCADE;
DROP TABLE IF EXISTS internet_provider.services CASCADE;
DROP TABLE IF EXISTS internet_provider.statuses CASCADE;
DROP TABLE IF EXISTS internet_provider.tariffs CASCADE;
DROP TABLE IF EXISTS internet_provider.tv CASCADE;
DROP TABLE IF EXISTS internet_provider.users CASCADE;

CREATE TABLE internet_provider.roles (
                         id  SERIAL NOT NULL,
                         name VARCHAR(45) NOT NULL,
                         PRIMARY KEY (id),
                         UNIQUE (id),
                         UNIQUE (name));


CREATE TABLE internet_provider.statuses (
                            id  SERIAL NOT NULL,
                            name VARCHAR(45) NOT NULL,
                            PRIMARY KEY (id),
                            UNIQUE (id),
                            UNIQUE (name));

CREATE TABLE internet_provider.internet (
                            id  SERIAL NOT NULL,
                            speed INT NOT NULL,
                            technology VARCHAR(45) NOT NULL,
                            PRIMARY KEY (id));

CREATE TABLE internet_provider.users (
                         id  SERIAL NOT NULL,
                         login VARCHAR(45) NOT NULL,
                         password VARCHAR(45) NOT NULL,
                         email VARCHAR(45),
                         idRole INT NOT NULL,
                         idStatus INT NOT NULL,
                         bill  double precision NOT NULL,
                         PRIMARY KEY (id),
                         UNIQUE (id),
                         UNIQUE (login),
                         UNIQUE (email),
                         CONSTRAINT fk_user_role
                             FOREIGN KEY (idRole)
                                 REFERENCES roles (id)
                                 ON DELETE CASCADE
                                 ON UPDATE CASCADE,
                         CONSTRAINT fk_user_status
                             FOREIGN KEY (idStatus)
                                 REFERENCES statuses (id)
                                 ON DELETE CASCADE
                                 ON UPDATE CASCADE);

CREATE TABLE internet_provider.pc (
                      id  SERIAL NOT NULL,
                      numOfConnectedPC INT NOT NULL,
                      PRIMARY KEY (id));


CREATE TABLE internet_provider.tv (
                      id  SERIAL NOT NULL,
                      type VARCHAR(45) NOT NULL,
                      numOfChannels INT NOT NULL,
                      PRIMARY KEY (id)
);

CREATE TABLE internet_provider.mobile (
                          id  SERIAL NOT NULL,
                          numOfMinutesInside INT NOT NULL,
                          numOfMinutesOutside INT NOT NULL,
                          numOfSMS INT NOT NULL,
                          numOfMbts INT NOT NULL,
                          PRIMARY KEY (id));

CREATE TABLE internet_provider.services (
                           id  SERIAL NOT NULL,
                            idPC INT,
                            idTV INT,
                            idMobile INT,
                            idInternet INT,
                            PRIMARY KEY (id),
                            UNIQUE  (id),
                            CONSTRAINT fk_service_pc
                                FOREIGN KEY (idPC)
                                    REFERENCES pc (id)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE,
                            CONSTRAINT fk_service_tv
                                FOREIGN KEY (idTV)
                                    REFERENCES tv (id)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE,
                            CONSTRAINT fk_service_mobile
                                FOREIGN KEY (idMobile)
                                    REFERENCES mobile (id)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE,
                            CONSTRAINT fk_service_internet
                                FOREIGN KEY (idInternet)
                                    REFERENCES internet (id)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE
);

CREATE TABLE internet_provider.tariffs (
                           id  SERIAL NOT NULL,
                           name VARCHAR(45) NOT NULL,
                           price INT NOT NULL,
                           idService INT NOT NULL,
                           durationInDays INT NOT NULL,
                           PRIMARY KEY (id),
                           UNIQUE (id),
                           CONSTRAINT fk_tarif_service
                               FOREIGN KEY (idService)
                                   REFERENCES services (id)
                                   ON DELETE CASCADE
                                   ON UPDATE CASCADE);

CREATE TABLE internet_provider.contracts (
                             id  SERIAL NOT NULL,
                             idUser INT NOT NULL,
                             idTariff INT NOT NULL,
                             idStatus INT NOT NULL,
                             contractConclusionDate date NOT NULL,
                             PRIMARY KEY (id),
                             UNIQUE (id),
                             CONSTRAINT fk_contract_user
                                 FOREIGN KEY (idUser)
                                     REFERENCES users (id)
                                     ON DELETE CASCADE
                                     ON UPDATE CASCADE,
                             CONSTRAINT fk_contract_tariff
                                 FOREIGN KEY (idTariff)
                                     REFERENCES tariffs (id)
                                     ON DELETE CASCADE
                                     ON UPDATE CASCADE);



INSERT INTO internet_provider.roles (name) VALUES ('admin');
INSERT INTO internet_provider.roles (name) VALUES ('client');
INSERT INTO internet_provider.statuses (name) VALUES ('waiting');
INSERT INTO internet_provider.statuses (name) VALUES ('registered');
INSERT INTO internet_provider.statuses (name) VALUES ('blocked');
INSERT INTO internet_provider.statuses (name) VALUES ('missed');
INSERT INTO internet_provider.users (login, password,email, idRole, idStatus, bill) VALUES ('admin','adminpass','user@gmail.com', '1','2','100.0');
INSERT INTO internet_provider.users (login, password,email, idRole, idStatus, bill)  VALUES ('client','clientpass','user2@gmail.com', '2','2','200.0');
INSERT INTO internet_provider.internet (speed, technology) VALUES ( '640', '4G');
INSERT INTO internet_provider.internet (speed, technology)  VALUES ('800', '5G');
INSERT INTO internet_provider.internet (speed, technology)  VALUES ('1000', '4G');
INSERT INTO internet_provider.pc (numOfConnectedPC) VALUES ('1');
INSERT INTO internet_provider.pc (numOfConnectedPC) VALUES ('10');
INSERT INTO internet_provider.tv (type,numOfChannels) VALUES ('Analog','100');
INSERT INTO internet_provider.tv (type,numOfChannels) VALUES ('IP-TV','150');
INSERT INTO internet_provider.tv (type,numOfChannels) VALUES ('Smart-TV','200');
INSERT INTO internet_provider.mobile (numOfMinutesInside,numOfMinutesOutside,numOfSMS,numOfMbts) VALUES ('100','20','50','7000');
INSERT INTO internet_provider.mobile (numOfMinutesInside,numOfMinutesOutside,numOfSMS,numOfMbts) VALUES  ('50','100','25','8000');
INSERT INTO internet_provider.mobile (numOfMinutesInside,numOfMinutesOutside,numOfSMS,numOfMbts) VALUES ('300','100','50','0');
INSERT INTO internet_provider.services (idTV,idInternet) VALUES ('1', '1');
INSERT INTO internet_provider.services (idTV) VALUES ('2');
INSERT INTO internet_provider.services (idPC,idInternet) VALUES ('1', '2');
INSERT INTO internet_provider.services (idMobile,idInternet) VALUES ('2','1');
INSERT INTO internet_provider.services (idPC,idInternet) VALUES ('2','2');
INSERT INTO internet_provider.services (idMobile) VALUES ('3');
INSERT INTO internet_provider.services (idTV,idInternet) VALUES ('3','2');
INSERT INTO services (idMobile,idInternet) VALUES ('2','2');
INSERT INTO internet_provider.tariffs (name, price, idService,durationInDays) VALUES ('Analog TV', '100', '1','30');
INSERT INTO internet_provider.tariffs (name, price, idService,durationInDays) VALUES ('IP-TV', '150', '2','30');
INSERT INTO internet_provider.tariffs (name, price, idService,durationInDays) VALUES('Usual pc', '125', '5','30');
INSERT INTO internet_provider.tariffs (name, price, idService,durationInDays) VALUES('Usual mobile', '150', '4','30');
INSERT INTO internet_provider.tariffs (name, price, idService,durationInDays) VALUES ('Pro pc', '175', '3','28');
INSERT INTO internet_provider.tariffs (name, price, idService,durationInDays) VALUES ('Mobile for speak', '125', '6','28');
INSERT INTO internet_provider.tariffs (name, price, idService,durationInDays) VALUES ('Pro mobile', '125', '8','28');
INSERT INTO internet_provider.tariffs (name, price, idService,durationInDays) VALUES ('Smart-TV', '250', '7','28');
