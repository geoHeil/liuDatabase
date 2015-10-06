(:function for recursive query for query 5:)
declare function local:expertsRecommendedByX($node) {
    typeswitch ($node) case element() return
        element {fn:node-name($node)} {
            $node/@*,
            $node/ node() ! local:expertsRecommendedByX(.)
        }
        default return $node
};

(:query 1:)
for $expert in doc("data.xml")/knowledgeDatabase/experts/expert
return $expert[expert_in_topics/expert_in_topic = "t1"],

(:query 2:)
for $topic in doc("data.xml")/knowledgeDatabase/topics/topic
return $topic[@superTopic = "t2"],

(:query 3:)
for $expert in doc("data.xml")/knowledgeDatabase/experts/expert
let $expertTopic := $expert[expert_in_topics/expert_in_topic = "t1"]
return $expertTopic[recommendations/recommendation/@recommender = "e1"],

(:query 4:)
let $expert :=  doc("data.xml")/knowledgeDatabase/experts/expert
let $expertTopic := $expert[expert_in_topics/expert_in_topic = "t1"]
for $expertsByExperts in $expertTopic[recommendations/recommendation/@recommender="e1"]
return $expertTopic[recommendations/recommendation/@recommender=$expertsByExperts/@expert_id],

(:query 5:)
let $expertX := doc("data.xml")/knowledgeDatabase/experts/expert[@expert_id="e1"]
return local:expertsRecommendedByX($expertX)