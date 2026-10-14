american(west).
enemy(nono, america).

missile(m1).
owns(nono, m1).

sells(west, m1, nono).

weapon(X) :-
    missile(X).

hostile(X) :-
    enemy(X, america).

criminal(X) :-
    american(X),
    weapon(Y),
    sells(X, Y, Z),
    hostile(Z).
