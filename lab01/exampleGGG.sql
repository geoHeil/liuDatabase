create sequence seq_firma
   increment by 10
   minvalue 10
   no cycle;

create sequence seq_kommission;
create sequence seq_abteilung;
create sequence seq_praktikum;

CREATE TABLE Firma (
 FaNr INTEGER PRIMARY KEY DEFAULT nextval('seq_firma'),
 Name VARCHAR(50),
 Standort VARCHAR(50)
);

CREATE TABLE Kommission (
 Id INTEGER PRIMARY KEY DEFAULT nextval('seq_kommission') ,
 Standort VARCHAR(40),
 Name VARCHAR(50),
 uebergeordnet INTEGER CONSTRAINT komm_fk REFERENCES Kommission(Id) DEFERRABLE INITIALLY DEFERRED,
 koordiniert VARCHAR(12) 

 --FOREIGN KEY (uebergeordnet) REFERENCES Kommission (Id)
);

CREATE TABLE Mitarbeiter (
 SVNR VARCHAR(12) NOT NULL PRIMARY KEY,
 Name VARCHAR(50),
 Anschrift VARCHAR(50),
 beschaeftigtSeit DATE,
 Gehaltsklasse VARCHAR(2) check (Gehaltsklasse in ('M1', 'M2', 'M3', 'C1', 'C2')),
 arbeitet INTEGER CONSTRAINT arbeitet_fk REFERENCES Kommission(Id) DEFERRABLE INITIALLY DEFERRED -- delete?
);
ALTER TABLE Kommission ADD CONSTRAINT koordiniert_fk FOREIGN KEY (koordiniert) REFERENCES Mitarbeiter (SVNR) DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE Student (
 SVNR INT NOT NULL PRIMARY KEY,
 Anschrift VARCHAR(60),
 Name VARCHAR(50),
 Studienkennzahl VARCHAR(10),
 MatrNr INT
);

CREATE TABLE Abteilung (
 AbtNr INTEGER DEFAULT nextval('seq_abteilung'),
 FaNr INT NOT NULL,
 AbtName CHAR(10),
 PRIMARY KEY (AbtNr,FaNr),

 FOREIGN KEY (FaNr) REFERENCES Firma (FaNr)
);

CREATE TABLE Austauschprogramm (
 Land VARCHAR(50) NOT NULL,
 Jahr INT NOT NULL,
 Name VARCHAR(50) NOT NULL,
 Bewerbungsfrist TIMESTAMP CHECK(extract(year from Bewerbungsfrist) <= Jahr),
 Id INT REFERENCES Kommission (Id),
 PRIMARY KEY (Land,Jahr,Name)
);

CREATE TABLE Betreuer (
 SVNR VARCHAR(12) NOT NULL PRIMARY KEY,
 Bonus NUMERIC(7,2) CHECK (Bonus >= 0),
 FOREIGN KEY (SVNR) REFERENCES Mitarbeiter (SVNR)
);


CREATE TABLE Bewerbungsunterlagen (
 SVNR INT NOT NULL PRIMARY KEY,
 Dokument bytea,
 FOREIGN KEY (SVNR) REFERENCES Student (SVNR)
);


CREATE TABLE bewirbt_ap (
 SVNR INT,
 Land VARCHAR(50),
 Jahr INT,
 Name VARCHAR(50),
 --Bewerbungsfrist DATE,
PRIMARY KEY (SVNR, Land, Jahr, Name),
 FOREIGN KEY (SVNR) REFERENCES Student (SVNR),
 FOREIGN KEY (Land,Jahr,Name) REFERENCES Austauschprogramm (Land,Jahr,Name)
);

CREATE TABLE Praktikum (
 PrNr INTEGER DEFAULT nextval('seq_praktikum'),
 AbtNr INTEGER NOT NULL,
 FaNr INT NOT NULL,
 bis DATE,
 von DATE check (von <= bis),
 AufgBereich VARCHAR(60),
 Beschr VARCHAR(600),

 PRIMARY KEY (PrNr,AbtNr,FaNr),

 FOREIGN KEY (AbtNr,FaNr) REFERENCES Abteilung (AbtNr,FaNr)
);

CREATE TABLE ShortlistedStudent (
 SVNR INT NOT NULL PRIMARY KEY,
 FOREIGN KEY (SVNR) REFERENCES Student (SVNR)
);


CREATE TABLE zustaendig (
 FaNr INT,
 SVNR VARCHAR(12),

 FOREIGN KEY (FaNr) REFERENCES Firma (FaNr),
 FOREIGN KEY (SVNR) REFERENCES Betreuer (SVNR)
);


CREATE TABLE ausgeschrieben (
 Land VARCHAR(50),
 Jahr INT,
 Name VARCHAR(50),
 PrNr INT,
 AbtNr INTEGER,
 FaNr INT,

 PRIMARY KEY (Land, Jahr, Name, PrNr, AbtNr, FaNr),
 FOREIGN KEY (Land,Jahr,Name) REFERENCES Austauschprogramm (Land,Jahr,Name),
 FOREIGN KEY (PrNr,AbtNr,FaNr) REFERENCES Praktikum (PrNr,AbtNr,FaNr)
);


CREATE TABLE bewirbt_pa (
 PrNr INT NOT NULL,
 AbtNr INTEGER NOT NULL,
 FaNr INT NOT NULL,
 PraeferenzNr INT,
 SVNR INT,

 PRIMARY KEY (PrNr,AbtNr,FaNr, SVNR),

 FOREIGN KEY (PrNr,AbtNr,FaNr) REFERENCES Praktikum (PrNr,AbtNr,FaNr),
 FOREIGN KEY (SVNR) REFERENCES ShortlistedStudent (SVNR)
);

CREATE TABLE MatchedStudent (
 SVNR INT NOT NULL PRIMARY KEY,
 FOREIGN KEY (SVNR) REFERENCES ShortlistedStudent (SVNR)
);

CREATE TABLE betreut (
 SVNR INT NOT NULL,
 PrNr INT NOT NULL,
 AbtNr INTEGER NOT NULL,
 FaNr INT NOT NULL,
 SVNR_0 VARCHAR(12) NOT NULL,

 PRIMARY KEY (SVNR,PrNr,AbtNr,FaNr,SVNR_0),

 FOREIGN KEY (SVNR) REFERENCES MatchedStudent (SVNR),
 FOREIGN KEY (PrNr,AbtNr,FaNr) REFERENCES Praktikum (PrNr,AbtNr,FaNr),
 FOREIGN KEY (SVNR_0) REFERENCES Betreuer (SVNR)
);
