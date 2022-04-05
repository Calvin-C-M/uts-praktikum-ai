% Knowledge Base
role(roamer) :-
    ganking(yes),
    heroType(tank).

role(midLane) :- 
    heroType(mage); heroType(support)

role(goldLane) :- 
    heroType(assassin); heroType(marksman)

role(expLane) :- 
    heroType(fighter); heroType(tank)

role(jungler) :- 
    spell(retribution),
    mengambilJungle(yes),
    ganking(yes),
    heroType(assassin); heroType(marksman)

% Member Rules
member(X,[X|_]).
member(X,[_|T]) :- member(X,T).

% Menu Rules
menu(A,V,_) :- known(yes,A,V),!.

menu(A,V,_) :- alreadyAsked(yes,A),!,fail.

menu(A,V,MenuList) :-
    write(A), write('?'), nl,
    write(MenuList), nl,
    read(X),
    checkVal(X,A,V,MenuList),
    asserta(known(yes,A,X)),
    asserta(alreadyAsked(yes,A)),
    X==V.

% Check input 
check_val(X, _A, _V, MenuList) :-
    member(X, MenuList),
    !.
check_val(X, A, V, MenuList) :-
    write(X), write(' is not a legal value, try again.'), nl,
    menuask(A, V, MenuList). 

% Running Program
do(start) :- solve,!.

% Quit Program
do(quit).
do(X) :- 
    write(X),nl,
    fail.

:- unknown(trace,fail).
