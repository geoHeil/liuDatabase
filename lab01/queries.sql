-- Queries

-- Query A
SELECT
  e.expert_id,
  e.name
FROM expert e
  JOIN expert_topic et ON e.expert_id = et.expert_id
  JOIN topic t ON e.expert_id = t.originator
WHERE t.topic_id = 1;

-- Query B
WITH subTopicIds AS (
    SELECT
      t.topic_id,
      st.subtopic
    FROM topic t
      JOIN subtopic st ON t.topic_id = st.supertopic
    --   specify topic Y here
    WHERE t.topic_id = 1
)
SELECT t.topic_id
FROM topic t
  JOIN subTopicIds ON t.topic_id = subTopicIds.subtopic;

-- Query C
WITH expertAreaY AS (
    SELECT
      e.expert_id,
      e.name
    FROM expert e
      JOIN expert_topic et ON e.expert_id = et.expert_id
      JOIN topic t ON e.expert_id = t.originator
    --       specify area Y here
    WHERE t.topic_id = 2
)

SELECT DISTINCT
  e.name,
  e.expert_id
FROM expert e
  JOIN recommendation r ON e.expert_id = r.isrrecomendeded
  JOIN expertAreaY eAY ON eAY.expert_id = e.expert_id
--       choose expert X here
WHERE r.recomendededby = 1;

-- Query D
WITH expertRecommendedByX AS (
    SELECT DISTINCT e.expert_id
    FROM expert e
      JOIN recommendation r ON e.expert_id = r.isrrecomendeded
    --   JOIN expertAreaY eAY ON eAY.expert_id = e.expert_id
  --       choose expert X here
    WHERE r.recomendededby = 1
)
SELECT DISTINCT r.isrrecomendeded
FROM expertRecommendedByX eX
  JOIN recommendation r ON eX.expert_id = r.recomendededby
  JOIN expert_topic et ON r.isrrecomendeded = et.expert_id
  JOIN topic t ON t.topic_id = et.topic_id
--       specify area Y here
WHERE t.topic_id = 1;

-- Query E

-- TODO check is recursive NEEDED

WITH RECURSIVE expertsLinks (expert_id) AS (
  SELECT e.expert_id
  FROM recommendation r
    JOIN expert e ON e.expert_id = r.isrrecomendeded
  -- choose expert X here
  WHERE r.recomendededby = 1

  UNION ALL
  SELECT e.expert_id
  FROM recommendation r
    --         this is NOT recursive -- but does work as well
    --         TODO check if that is correct
    JOIN expert e ON e.expert_id = r.isrrecomendeded
)
SELECT DISTINCT el.expert_id
FROM expertsLinks el
  JOIN expert_topic et ON el.expert_id = et.expert_id
  JOIN topic t ON el.expert_id = t.originator
--       specify area Y here
WHERE t.topic_id = 2
