(:query 1:)
for $expert in doc("data.xml")/knowledgeDatabase/experts/expert
let $topicsArea  :=  knowledgeDatabase/topics//topic[expertise_area="some area 1"]/data(@topic_id)

return $expert/expert_in_topics[expert_in_topic="t1"]

(:query 2:)
(:query 3:)
(:query 4:)
(:query 5:)
