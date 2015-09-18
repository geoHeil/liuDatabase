declare function local:sumOfTime($players as element(player)*) as xs:double
{
    sum(for $player in $players
    return
        $player/answer/@time)
};

declare function local:averageTime($players as element(player)*) as xs:double
{
    avg(for $player in $players
    return
        $player/answer/@time)
};

declare function local:countAnswers($players as element(player)*) as xs:double
{
    count(for $player in $players
    return
        $player/answer)
};

<stats>
    {
        for $user in //user
        order by $user/@name ascending
        return
            element {$user/@name} {
                attribute sumTime {local:sumOfTime(//player[@ref = data($user/@name)])},
                attribute avgTime {
                    if (local:countAnswers(//player[@ref = data($user/@name)]) = 0)
                    then 0
                    else local:averageTime(//player[@ref = data($user/@name)])
                },
                element answerCount {
                    if (local:countAnswers(//player[@ref = data($user/@name)]) = 0)
                    then "No answers for this user found"
                    else local:countAnswers(//player[@ref = data($user/@name)])
                }
            }
    }
</stats>