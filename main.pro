% Knowledge Base
role(roamer) :-
    retribution(no)
    burstDamage(no)
    aggressive(no)
    sukaHeal(no).

role(midLane) :- 
    retribution(no)
    burstDamage(no)
    aggressive(no)
    sukaHeal(yes).

role(expLane) :- 
    retribution(no)
    burstDamage(no)
    aggressive(yes).

role(goldLane) :- 
    retribution(no)
    burstDamage(yes).

role(jungler) :- 
    retribution(yes).

% Asking the user
retribution(X) :- menuask('memakai retribution', X, [yes,no]).
burstDamage(X) :- menuask('dengan hero burst damage', X, [yes,no]).
aggressive(X) :- menuask('bermain aggressive dalam war', X, [yes,no]).
sukaHeal(X) :- menuask('membantu heal dalam war', X, [yes,no])

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
