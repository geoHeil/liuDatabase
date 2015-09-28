DROP TABLE IF EXISTS recommendation;
DROP TABLE IF EXISTS subarea;
DROP TABLE IF EXISTS topicarea;
DROP TABLE IF EXISTS subtopic;
DROP TABLE IF EXISTS area;
DROP TABLE IF EXISTS expertise;
DROP TABLE IF EXISTS topic;
DROP TABLE IF EXISTS expert;


CREATE TABLE expert (
  expert_id   INT NOT NULL AUTO_INCREMENT,
  lastname    VARCHAR(80),
  firstname   VARCHAR(80),
  email       VARCHAR(255),
  description VARCHAR(800),
  PRIMARY KEY (expert_id)
) ENGINE=InnoDB;

CREATE TABLE area (
  id          INT NOT NULL AUTO_INCREMENT,
  name        VARCHAR(80),
  description VARCHAR(255),
  PRIMARY KEY (id)  
) ENGINE=InnoDB;

CREATE TABLE topic (
  id          INT NOT NULL AUTO_INCREMENT,
  name        VARCHAR(80),
  description VARCHAR(255),
  originator  INT,  
  PRIMARY KEY (id),
  FOREIGN KEY (originator) 
    REFERENCES expert(expert_id) 
    ON DELETE SET NULL
) ENGINE=InnoDB;



CREATE TABLE subtopic (
  parent      INT NOT NULL,
  child       INT NOT NULL,
  PRIMARY KEY (parent, child),
  FOREIGN KEY (parent) 
    REFERENCES topic(id) 
    ON DELETE CASCADE,
  FOREIGN KEY (child) 
    REFERENCES topic(id)  
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE subarea (
  parent      INT NOT NULL,
  child       INT NOT NULL,
  PRIMARY KEY (parent, child),
  FOREIGN KEY (parent) 
    REFERENCES area(id) 
    ON DELETE CASCADE,
  FOREIGN KEY (child) 
    REFERENCES area(id)     
    ON DELETE CASCADE  
) ENGINE=InnoDB;


CREATE TABLE expertise (
  id          INT NULL AUTO_INCREMENT,
  name        VARCHAR(255),
  description VARCHAR(800),
  PRIMARY KEY(id)
) ENGINE=InnoDB;


CREATE TABLE topicarea (
  topic       INT NOT NULL,
  area        INT NOT NULL,
  PRIMARY KEY (topic, area),
  FOREIGN KEY (topic) 
    REFERENCES topic(id) 
    ON DELETE CASCADE,
  FOREIGN KEY (area) 
    REFERENCES area(id) 
    ON DELETE CASCADE    
) ENGINE=InnoDB;

CREATE TABLE recommendation (
  recommender INT,
  recommendee INT NOT NULL,
  rec_area    INT NOT NULL,
  description VARCHAR(255),
  PRIMARY KEY (recommender, recommendee, rec_area),
  FOREIGN KEY (recommender)
    REFERENCES expert(expert_id) 
    ON DELETE CASCADE,  
  FOREIGN KEY (recommendee)
    REFERENCES expert(expert_id) 
    ON DELETE CASCADE,
  FOREIGN KEY (rec_area)
    REFERENCES area(id) 
    ON DELETE CASCADE 
) ENGINE=InnoDB;  