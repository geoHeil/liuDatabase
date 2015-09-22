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

-- assumption each expert writes a own recommendation
CREATE TABLE recommendation (
  recommendation_id INTEGER PRIMARY KEY DEFAULT nextval('seq_recommendation'),
  text              VARCHAR(1000),
  recomendededBy    INTEGER REFERENCES expert (expert_id),
  isRrecomendeded   INTEGER REFERENCES expert (expert_id)
);


-- add content into the table
INSERT INTO expert (email, name, address, description)
VALUES ('e1@expert.com', 'e1name', 'e1address', '<em>some xml description</em>');
INSERT INTO expert (email, name, address, description)
VALUES ('e2@expert.com', 'e2name', 'e2address', '<em>some xml description</em>');
INSERT INTO expert (email, name, address, description)
VALUES ('e3@expert.com', 'e3name', 'e3address', '<em>some xml description</em>');
INSERT INTO expert (email, name, address, description)
VALUES ('e4@expert.com', 'e4name', 'e4address', '<em>some xml description</em>');


INSERT INTO topic (expertise_area, originator, heading, text) VALUES ('area1', 1, 'heading1', 'text1');
INSERT INTO topic (expertise_area, originator, heading, text) VALUES ('area2', 2, 'heading2', 'text2');
INSERT INTO topic (expertise_area, originator, heading, text) VALUES ('area1', 1, 'heading3', 'text3');
INSERT INTO topic (expertise_area, originator, heading, text) VALUES ('area1', 1, 'heading4', 'text4');
INSERT INTO topic (expertise_area, originator, heading, text) VALUES ('area1', 1, 'heading5', 'text5');

INSERT INTO expert_topic (expert_id, topic_id) VALUES (1, 1);
INSERT INTO expert_topic (expert_id, topic_id) VALUES (1, 2);
INSERT INTO expert_topic (expert_id, topic_id) VALUES (1, 3);
INSERT INTO expert_topic (expert_id, topic_id) VALUES (2, 2);
INSERT INTO expert_topic (expert_id, topic_id) VALUES (2, 3);
INSERT INTO expert_topic (expert_id, topic_id) VALUES (3, 2);
INSERT INTO expert_topic (expert_id, topic_id) VALUES (3, 1);

INSERT INTO subtopic (superTopic, subTopic) VALUES (1, 3);
INSERT INTO subtopic (superTopic, subTopic) VALUES (1, 4);
INSERT INTO subtopic (superTopic, subTopic) VALUES (4, 5);

INSERT INTO recommendation (text, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 1, 3);
INSERT INTO recommendation (text, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 1, 2);
INSERT INTO recommendation (text, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 2, 3);
INSERT INTO recommendation (text, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 3, 4);
