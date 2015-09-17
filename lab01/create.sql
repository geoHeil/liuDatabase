CREATE SEQUENCE seq_expert;
CREATE SEQUENCE seq_recommendation;
CREATE SEQUENCE seq_expertise_area;
CREATE SEQUENCE seq_topic;

CREATE TABLE expert (
  expert_id   INT PRIMARY KEY DEFAULT nextval('seq_expert'),
  email       VARCHAR(200),
  name        VARCHAR(200),
  address     VARCHAR(500),
  description VARCHAR(1000)
);

CREATE TABLE expertise_area (
  expertise_area_id INT PRIMARY KEY DEFAULT nextval('seq_expertise_area'),
  name              VARCHAR(200)
);

CREATE TABLE recommendation (
  recommendation_id INT PRIMARY KEY DEFAULT nextval('seq_recommendation'),
  text              VARCHAR(1000),
  FOREIGN KEY (expertise_area_id) REFERENCES expertise_area (expertise_area_id),
  FOREIGN KEY (originator) REFERENCES expert (expert_id)
);

CREATE TABLE topic (
  topic_id          INT PRIMARY KEY DEFAULT nextval('seq_topic'),
  expertise_area_id INT NOT NULL,
  originator        INT NOT NULL,
  heading           VARCHAR(100),
  text              VARCHAR(1000)
);

CREATE TABLE subtopic (
  FOREIGN KEY (super_topic_id,
               expertise_area_id,
               originator)
  REFERENCES topic (topic_id,
                    expertise_area_id,
                    originator)
);

ALTER TABLE subtopic ADD CONSTRAINT PK_subtopic PRIMARY KEY (super_topic_id, expertise_area_id, originator);
