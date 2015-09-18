-- Queries

-- Query A

SELECT
  e.expert_id,
  e.name,
  ea.name
FROM expert e
  JOIN expert_expertise_area eea
    ON e.expert_id = eea.expert_id
  JOIN expertise_area ea
    ON eea.expertise_area_id = ea.expertise_area_id
WHERE ea.expertise_area_id = X;

-- Query B

-- Query C

-- Query D

-- Query E
