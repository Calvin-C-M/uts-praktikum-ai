% Knowledge Base
role(roamer) :-
    heroType(tank).
role(midLane) :- 
    heroType(mage); heroType(support)
role(goldLane) :- 
    heroType(assassin); heroType(marksman)
role(expLane) :- 
    heroType(fighter); heroType(tank)
role(jungler) :- 
    heroType(assassin); heroType(marksman)

