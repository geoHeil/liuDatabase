CREATE SEQUENCE seq_expert;
CREATE SEQUENCE seq_recommendation;
CREATE SEQUENCE seq_topic;

CREATE TABLE expert (
  expert_id   INTEGER PRIMARY KEY DEFAULT nextval('seq_expert'),
  email       VARCHAR(200),
  name        VARCHAR(200),
  address     VARCHAR(500),
  description VARCHAR(1000)
);

CREATE TABLE topic (
  topic_id       INTEGER PRIMARY KEY DEFAULT nextval('seq_topic'),
  expertise_area VARCHAR(500),
  originator     INTEGER REFERENCES expert (expert_id),
  heading        VARCHAR(100),
  text           VARCHAR(1000)
);


CREATE TABLE expert_topic (
  expert_id INTEGER REFERENCES expert (expert_id),
  topic_id  INTEGER REFERENCES topic (topic_id)
);

CREATE TABLE subtopic (
  superTopic INTEGER REFERENCES topic (topic_id),
  subTopic   INTEGER REFERENCES topic (topic_id)
);

CREATE TABLE recommendation (
  recommendation_id INTEGER PRIMARY KEY DEFAULT nextval('seq_recommendation'),
  text              VARCHAR(1000),
  recomendededBy    INTEGER REFERENCES expert (expert_id),
  isRrecomendeded INTEGER REFERENCES expert(expert_id)
);
