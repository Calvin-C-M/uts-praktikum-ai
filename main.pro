% Knowledge Base
role('Jungler') :- 
    retribution(yes).

role('Gold Laner') :- 
    retribution(no),
    burstDamage(yes).

role('Exp Laner') :- 
    retribution(no),
    burstDamage(no),
    aggressive(yes).

role('Mid Laner') :- 
    retribution(no),
    burstDamage(no),
    aggressive(no),
    sukaHeal(yes).

role('Roamer') :-
    retribution(no),
    burstDamage(no),
    aggressive(no),
    sukaHeal(no).

% Asking the user
retribution(X) :- menuask('memakai retribution', X, [yes,no]).
burstDamage(X) :- menuask('dengan hero burst damage', X, [yes,no]).
aggressive(X) :- menuask('bermain aggresive dalam war', X, [yes,no]).
sukaHeal(X) :- menuask('membantu heal dalam war', X, [yes,no])

/* Menus for user & Remembering the answer*/
menuask(A, V, _):-
    known(yes, A, V), % succeed if true
    !. % stop looking
menuask(A,V,_):-
    known(_,A,V),
    !.
menuask(A, V, MenuList) :-
    write('Apakah player suka '), write(A), write('?'), nl,
    write(MenuList), nl,
    read(X),
    check_val(X, A, V, MenuList),
    asserta( known(yes, A, X) ),
    X == V. 

/* Check input */
check_val(X, _A, _V, MenuList) :-
    member(X, MenuList),
    !.
check_val(X, A, V, MenuList) :-
    write(X), write(' bukan nilai yang valid, mohon coba lagi'), nl,
    menuask(A, V, MenuList). 

/* Member rules */
member(X,[X|_]).
member(X,[_|T]):-member(X,T).
% End User Interface

% Start Simple Shell
/* Simple shell */
top_goal(X) :- role(X). 

solve :-
    abolish(known, 4),
    top_goal(X),
    write('Role yang cocok untuk player adalah '), write(X), nl.
solve :-
    write('Tidak ada role yang cocok untuk player'), nl. 

/* Command loop */
main :-  
    greeting,
    repeat,
    write('> '),
    read(X),
    do(X),
    X == stop.

greeting :-
    write('=================================='),nl,
    write('=    PICK ROLE MOBILE LEGENDS    ='),nl,
    write('=================================='),nl,
    write('Ketik mulai atau stop pada terminal dibawah'), nl.

/* Running Program */
do(mulai) :-
    solve,
    !. 

/* Quit Program */
do(stop).
do(X) :-
    write(X),
    write(' bukan command yang valid'), nl,
    fail. 
% End Simple Shell

/* handle undefined procedure */
:- unknown(trace, fail).