DROP TABLE IF EXISTS recommendation;
DROP TABLE IF EXISTS subtopic;
DROP TABLE IF EXISTS expert_topic;
DROP TABLE IF EXISTS topic;
DROP TABLE IF EXISTS expert;


CREATE TABLE expert (
  expert_id   INTEGER AUTO_INCREMENT,
  email       VARCHAR(200),
  name        VARCHAR(200),
  address     VARCHAR(500),
  description VARCHAR(1000),
  PRIMARY KEY (expert_id)
);

CREATE TABLE topic (
  topic_id       INTEGER PRIMARY KEY DEFAULT AUTO_INCREMENT,
  originator     INTEGER,
  heading        VARCHAR(100),
  desription     VARCHAR(1000),
  FOREIGN KEY (originator) REFERENCES expert (expert_id)
);


CREATE TABLE expert_topic (
  expert_id INTEGER,
  topic_id  INTEGER,
  FOREIGN KEY (expert_id) REFERENCES expert (expert_id),
  FOREIGN KEY (topic_id)  REFERENCES topic (topic_id)
);

CREATE TABLE subtopic (
  superTopic INTEGER,
  subTopic   INTEGER,
  FOREIGN KEY (superTopic) REFERENCES topic (topic_id),
  FOREIGN KEY (subTopic) REFERENCES topic (topic_id)
);

-- assumption each expert writes a own recommendation
-- Every recommendation pertains to one topic area (not several).
CREATE TABLE recommendation (
  description       VARCHAR(1000),
  recomendededBy    INTEGER,
  isRecommended     INTEGER,
  topic             INTEGER,
  FOREIGN KEY (topic) REFERENCES topic (topic_id),
  FOREIGN KEY (recommendedBy) REFERENCES expert (expert_id),
  FOREIGN KEY (isRecommended) REFERENCES expert (expert_id),
  PRIMARY KEY (recommendedBy, isRecommended, topic)
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
INSERT INTO expert (email, name, address, description)
VALUES ('e5@expert.com', 'e5name', 'e5address', '<em>some xml description</em>');
INSERT INTO expert (email, name, address, description)
VALUES ('e6@expert.com', 'e6name', 'e6address', '<em>some xml description</em>');
INSERT INTO expert (email, name, address, description)
VALUES ('e7@expert.com', 'e7name', 'e7address', '<em>some xml description</em>');

INSERT INTO topic (topic, originator, heading, text) VALUES ('area1', 1, 'heading1', 'text1');
INSERT INTO topic (topic, originator, heading, text) VALUES ('area2', 2, 'heading2', 'text2');
INSERT INTO topic (topic, originator, heading, text) VALUES ('area1', 1, 'heading3', 'text3');
INSERT INTO topic (topic, originator, heading, text) VALUES ('area1', 1, 'heading4', 'text4');
INSERT INTO topic (topic, originator, heading, text) VALUES ('area1', 1, 'heading5', 'text5');

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

INSERT INTO recommendation (description, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 1, 3);
INSERT INTO recommendation (description, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 1, 2);
INSERT INTO recommendation (description, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 2, 3);
INSERT INTO recommendation (description, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 3, 4);
INSERT INTO recommendation (description, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 2, 5);
INSERT INTO recommendation (description, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 3, 6);
INSERT INTO recommendation (description, recomendededBy, isRrecomendeded) VALUES ('recommendation awesome foo', 5, 7);
