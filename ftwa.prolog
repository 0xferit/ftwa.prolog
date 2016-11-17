:- use_module(library(date)).
:- discontiguous(spouse/2).

%% FAMILY DECLARATION -BEGIN TODO Ailenin geri kalani yazilacak
uid(1, 'Ayşe').
uid(2, 'Erdem').
uid(5, 'Seda').
uid(6, 'Ali').
uid(7, 'Ali').
uid(8, 'Deniz'). 


female(1).
female(5).
female(8).

birthdate(date(1925,1,1), 1).
birthdate(date(1920,1,1), 2).
birthdate(date(1952,1,1), 5).
birthdate(date(1948,1,1), 6).
birthdate(date(1960,1,1), 7).
birthdate(date(1960,1,1), 8).



%% FAMILY DECLARATION -END


%% RELATIONS DECLARATION -BEGIN

spouse(1, 2).
spouse(5, 6).
spouse(7, 8).

child(5, 1).
child(5, 2).

child(7, 1).
child(7, 2).

%% RELATIONS DECLARATION -END


%% RULES DECLARATION -BEGIN

male(X) :- not(female(X)).

parent(X,Y) :- child(Y,X).

spouse_of(X,Y) :- spouse(Y,X); spouse(X,Y).


sibling(X,Y) :- child(X,A), child(Y,A), not(X=Y).

kari(X,Y) :-		spouse_of(X,Y), female(X).
koca(X,Y) :-		spouse_of(X,Y), male(X).
anne(X,Y) :- 		parent(X,Y), 	female(X).
baba(X,Y) :- 		parent(X,Y), 	male(X).
ogul(X,Y) :- 		child(X,Y), 	male(X).
kiz(X,Y) :- 		child(X,Y), 	female(X).
erkek_kardes(X,Y) :- 	sibling(X,Y), 	male(X), 	not(older(X,Y)).
kiz_kardes(X,Y) :- 	sibling(X,Y), 	female(X), 	not(older(X,Y)).
abi(X,Y) :- 		sibling(X,Y), 	male(X), 	older(X,Y).
abla(X,Y) :- 		sibling(X,Y), 	female(X), 	older(X,Y).

amca(X,Y) :- 		parent(Z, Y), 	male(Z), 	sibling(X, Z), male(X).
hala(X,Y) :- 		parent(Z, Y), 	male(Z), 	sibling(X, Z), female(X).
dayi(X,Y) :- 		parent(Z, Y), 	female(Z), 	sibling(X, Z), male(X).
teyze(X,Y) :- 		parent(Z, Y), 	female(Z), 	sibling(X, Z), female(X).

yegen(X,Y) :-		sibling(Z, Y), 	parent(Z, X).
kuzen(X,Y) :-		parent(Z, X), 	parent(U, Y), 	sibling(Z,U).

%eniste(X,Y) :-TODO 
%yenge(X,Y) :- TODO

kayinpeder(X,Y) :-	damat(Y,X).	
kayinvalide(X,Y) :-	gelin(Y,X).
damat(X,Y) :- 		parent(Y, Z), 	female(Z), 	spouse_of(Z,X).
gelin(X,Y) :- 		parent(Y, Z), 	male(Z), 	spouse_of(Z,X).

bacanak(X,Y) :-		spouse_of(X,Z), spouse_of(Y,U), 	male(X), male(Y), female(Z), female(U), sibling(Z,U).
baldiz(X,Y) :-		sibling(X,Z), 	spouse_of(Z,Y), 	male(Y), female(X), female(Z).
elti(X,Y) :-		spouse_of(X,Z), spouse_of(Y,U), 	female(X), female(Y), male(Z), male(U), sibling(Z,U).
kayinbirader(X,Y) :-	spouse_of(Z,Y), sibling(Z,X), 	male(X).



%% RULES DECLARATION -END


% add_3_and_double(X,Y) :- Y is (X+3)*2.




%% FUNCTIONS DECLARATION -BEGIN


list:-
	uid(Input, Output),
	write('The UID of '), write(Input),
	write(' is '), write(Output), write('.').

relation(X, Y, RELATIO_):- koca(X,Y), functor(koca(X,Y), RELATIO_, _);
 			kari(X,Y), functor(kari(X,Y), RELATIO_, _);
 			anne(X,Y), functor(anne(X,Y), RELATIO_, _);
  			baba(X,Y), functor(baba(X,Y), RELATIO_, _);
 			ogul(X,Y), functor(ogul(X,Y), RELATIO_, _);
 			kiz(X,Y), functor(kiz(X,Y), RELATIO_, _);
 			erkek_kardes(X,Y), functor(erkek_kardes(X,Y), RELATIO_, _);
			kiz_kardes(X,Y), functor(kiz_kardes(X,Y), RELATIO_, _);
			abi(X,Y), functor(abi(X,Y), RELATIO_, _);
			abla(X,Y), functor(abla(X,Y), RELATIO_, _);
			amca(X,Y), functor(amca(X,Y), RELATIO_, _);
			hala(X,Y), functor(hala(X,Y), RELATIO_, _);
			dayi(X,Y), functor(dayi(X,Y), RELATIO_, _);
			teyze(X,Y), functor(teyze(X,Y), RELATIO_, _);
			yegen(X,Y), functor(yegen(X,Y), RELATIO_, _);
			kuzen(X,Y), functor(kuzen(X,Y), RELATIO_, _);
			kayinpeder(X,Y), functor(kayinpeder(X,Y), RELATIO_, _);
			kayinvalide(X,Y), functor(kayinvalide(X,Y), RELATIO_, _);
			damat(X,Y), functor(damat(X,Y), RELATIO_, _);
			gelin(X,Y), functor(gelin(X,Y), RELATIO_, _);
			bacanak(X,Y), functor(bacanak(X,Y), RELATIO_, _);
			baldiz(X,Y), functor(baldiz(X,Y), RELATIO_, _);
			elti(X,Y), functor(elti(X,Y), RELATIO_, _);
			kayinbirader(X,Y), functor(kayinbirader(X,Y), RELATIO_, _).

relation(X,Y):-
	relation(X, Y, RELATION),
	write(X), write(' is '),
	write(RELATION), write(' of '), write(Y).


% age(+Birthday, -Age)
%
age(UID, Age) :-
	birthdate(date(Y2, M2, D2), UID),
	get_date_time_value(year, Y1),
	get_date_time_value(month, M1),
	get_date_time_value(day, D1),
	A is Y1 - Y2,
	( ( M1 < M2 ; M1 == M2, D1 < D2 ) -> Age is A - 1 ; Age = A).

older(UID, UID2) :-
	birthdate(date(Y2, M2, D2), UID2),
	birthdate(date(Y1, M1, D1), UID),
	(Y1 > Y2; Y1=Y2, M1 > M2; Y1==Y2, M1==M2, D1 > D2).



%% UTILITY FUNCTIONS DECLARATION -BEGIN
get_date_now(Value) :-
	get_time(Stamp),
	stamp_date_time(Stamp, DateTime, local),
	date_time_value(date, DateTime, Value).

get_date_time_value(Key, Value) :-
	get_time(Stamp),
 	stamp_date_time(Stamp, DateTime, local),
	date_time_value(Key, DateTime, Value).

%% UTILITY FUNCTIONS DECLARATION -END


%% FUNCTIONS DECLARATION -END
