parent_of(X,Y) :- child_of(Y,X).

spouse_of(X,Y) :- spouse(Y,X).
spouse_of(X,Y) :- spouse(X,Y).

sister_of(X,Y) :- siblings(X,Y), female(X).

brother_of(X,Y) :- siblings(X,Y), not(female(X)).

siblings(X,Y) :- child_of(X,A), child_of(Y,A), not(X=Y).

damat(X,Y) :- parent_of(X, Z), female(Z), spouse_of(Z,Y).
gelin(X,Y) :- parent_of(X, Z), not(female(Z)), spouse_of(Z,Y).

uid('Ayşe', 1).
uid('Erdem', 2).
uid('Seda', 5).
uid('Ali', 6).
uid('Ali', 7).
uid('Deniz', 8). 

female(1).
female(5).
female(8).

spouse(1, 2).
spouse(5, 6).
spouse(7, 8).

child_of(5, 1).
child_of(5, 2).

child_of(7, 1).
child_of(7, 2).



list:-
	uid(Input, Output),
	write('The UID of '), write(Input),
	write(' is '), write(Output), write('.').

relation_of(X,Y):-
	position(Input, Output),
	write('The position of '), write(Input),
	write(' is '), write(Output), write('.').
