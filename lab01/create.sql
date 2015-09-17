create sequence seq_expert;
create sequence seq_recommendation;
create sequence seq_expertise_area;
create sequence seq_topic;

CREATE TABLE expert (
 expert_id INT PRIMARY KEY DEFAULT nextval('seq_expert'),
 email VARCHAR(200),
 name VARCHAR(200),
 address VARCHAR(500),
 description VARCHAR(1000)
);

CREATE TABLE expertise_area (
 expertise_area_id INT PRIMARY KEY DEFAULT nextval('seq_expertise_area'),
 name VARCHAR(200)
);

CREATE TABLE recommendation (
 recommendation_id INT NOT NULL,
 text VARCHAR(10)
);

ALTER TABLE recommendation ADD CONSTRAINT PK_recommendation PRIMARY KEY (recommendation_id);


CREATE TABLE topic (
 topic_id INT NOT NULL,
 expertise_area_id INT NOT NULL,
 originator INT NOT NULL,
 heading VARCHAR(10),
 text VARCHAR(10)
);

ALTER TABLE topic ADD CONSTRAINT PK_topic PRIMARY KEY (topic_id,expertise_area_id,originator);


CREATE TABLE subtopic (
 super_topic_id INT NOT NULL,
 expertise_area_id INT NOT NULL,
 originator INT NOT NULL
);

ALTER TABLE subtopic ADD CONSTRAINT PK_subtopic PRIMARY KEY (super_topic_id,expertise_area_id,originator);


ALTER TABLE topic ADD CONSTRAINT FK_topic_0 FOREIGN KEY (expertise_area_id) REFERENCES expertise_area (expertise_area_id);
ALTER TABLE topic ADD CONSTRAINT FK_topic_1 FOREIGN KEY (originator) REFERENCES expert (expert_id);


ALTER TABLE subtopic ADD CONSTRAINT FK_subtopic_0 FOREIGN KEY (super_topic_id,expertise_area_id,originator) REFERENCES topic (topic_id,expertise_area_id,originator);


