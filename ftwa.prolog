parent_of(X,Y) :- child_of(Y,X).
sister_of(X,Y) :- siblings(X,Y), female(X).
brother_of(X,Y) :- siblings(X,Y), male(X).
siblings(X,Y) :- child_of(X,A), child_of(Y,A), not(X=Y).

uid('Ayşe', 1).
uid('Erdem', 2).
uid('Seda', 5).
uid('Ali', 6).
uid('Ali', 7).
uid('Deniz', 8). 

spouse_of(1, 2).
spouse_of(5, 6).
spouse_of(7, 8).

child_of(5, 1).
child_of(5, 2).

child_of(7, 1).
child_of(7, 2).

