(:query 1:)
for $expert in doc("data.xml")/knowledgeDatabase/experts/expert
return $expert[expert_in_topics/expert_in_topic="t1"],

(:query 2:)
for $topic in doc("data.xml")/knowledgeDatabase/topics/topic
return $topic[@superTopic="t2"],

(:query 3:)
for $expert in doc("data.xml")/knowledgeDatabase/experts/expert
     let $expertTopic := $expert[expert_in_topics/expert_in_topic="t1"]
 return $expertTopic[recommendations/recommendation/@recommender="e1"]

(:query 4:)


(:query 5:)
