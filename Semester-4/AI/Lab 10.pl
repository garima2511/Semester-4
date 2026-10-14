criminal(P) :- american(P), weapon(Q), sells(P,Q,R).
owns(A,t1).
missile(t1).
sells(robert,P,A):- missile(P), owns(A,P).
weapon(P):- missile(P).
hostile(P):- enemy(P, america).
american(robert).
enemy(A, america).
