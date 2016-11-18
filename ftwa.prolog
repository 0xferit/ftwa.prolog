:- use_module(library(date)).
:- discontiguous(spouse/2).
:- dynamic uid/1.
:- dynamic name/2.
:- dynamic surname/2.
:- dynamic gender/2.
:- dynamic birthdate/2.
:- dynamic deathdate/2.
:- dynamic spouse/2.
:- dynamic child/2.
:- dynamic parent/2.

%% FAMILY DECLARATION -BEGIN TODO Ailenin geri kalani yazilacak


uid(1).
uid(2).
uid(3).
uid(4).
uid(5).
uid(6).
uid(7).
uid(8).
uid(9).
uid(10).
uid(11).
uid(12).
uid(13).
uid(14).
uid(15).



name('Ayşe', 1).
name('Erdem', 2).
name('Erdi', 3).
name('Sibel', 4).
name('Seda', 5).
name('Ali', 6).
name('Ali', 7).
name('Deniz', 8).
name('Melis', 9).
name('Ahmet', 10).
name('Güneş', 11).
name('Seçil', 12).
name('Orhan', 13).
name('Derya', 14).
name('Tolga', 15).


female(1).
female(4).
female(5).
female(8).
female(9).
female(12).
female(14).




birthdate(date(1925,1,1), 1).
birthdate(date(1920,1,1), 2).
birthdate(date(1950,1,1), 3).
birthdate(date(1949,1,1), 4).
birthdate(date(1952,1,1), 5).
birthdate(date(1948,1,1), 6).
birthdate(date(1960,1,1), 7).
birthdate(date(1960,1,1), 8).
birthdate(date(1961,1,1), 9).
birthdate(date(1960,1,1), 10).
birthdate(date(1980,1,1), 11).
birthdate(date(1971,1,1), 12).
birthdate(date(1978,1,1), 13).
birthdate(date(1982,1,1), 14).
birthdate(date(1982,1,1), 15).



%% FAMILY DECLARATION -END


%% RELATIONS DECLARATION -BEGIN

spouse(1, 2).
spouse(3, 4).
spouse(5, 6).
spouse(7, 8).
spouse(9, 10).


child(3, 1).
child(3, 2).

child(5, 1).
child(5, 2).

child(7, 1).
child(7, 2).

child(9, 1).
child(9, 2).


child(11, 3).
child(11, 4).

child(12,5).
child(12,6).

child(13,5).
child(13,6).

child(14 ,7).
child(14, 8).

child(15, 9).
child(15, 10).


%% RELATIONS DECLARATION -END


%% RULES DECLARATION -BEGIN

male(X) :- not(female(X)).

parent(X,Y) :- child(Y,X).
grandparent(X,Y):- dede(X,Y); anneanne(X,Y); babaanne(X,Y).
grandchild(X,Y):- grandparent(Y,X).

spouse_of(X,Y) :- (spouse(Y,X); spouse(X,Y)), not(child(X,Y), parent(X,Y), grandchild(X,Y), grandparent(X,Y), sibling(X,Y), amca(X,Y), hala(X,Y), dayı(X,Y), yenge(X,Y)).


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

amca(X,Y) :- 		parent(Z, Y), 	male(Z), 	sibling(X, Z), 	male(X).
hala(X,Y) :- 		parent(Z, Y), 	male(Z), 	sibling(X, Z), 	female(X).
dayi(X,Y) :- 		parent(Z, Y), 	female(Z), 	sibling(X, Z), 	male(X).
teyze(X,Y) :- 		parent(Z, Y), 	female(Z), 	sibling(X, Z), 	female(X).

yegen(X,Y) :-		sibling(Z, Y), 	parent(Z, X).
kuzen(X,Y) :-		parent(Z, X), 	parent(U, Y), 	sibling(Z,U).

%eniste(X,Y) :-TODO 
%yenge(X,Y) :- TODO

kayinpeder(X,Y) :-	damat(Y,X).	
kayinvalide(X,Y) :-	gelin(Y,X).
damat(X,Y) :- 		parent(Y, Z), 	female(Z), 	spouse_of(Z,X).
gelin(X,Y) :- 		parent(Y, Z), 	male(Z), 	spouse_of(Z,X).

bacanak(X,Y) :-		spouse_of(X,Z), spouse_of(Y,U), male(X), 	male(Y), 	female(Z), female(U), sibling(Z,U).
baldiz(X,Y) :-		sibling(X,Z), 	spouse_of(Z,Y), male(Y), 	female(X), 	female(Z).
elti(X,Y) :-		spouse_of(X,Z), spouse_of(Y,U), female(X), 	female(Y), 	male(Z), male(U), sibling(Z,U).
kayinbirader(X,Y) :-	spouse_of(Z,Y), sibling(Z,X), 	male(X).


dede(X,Y) :- 	child(Y,Z), child(Z,X), male(X).
torun(X,Y) :- 	child(X,Z), child(Z,Y).
anneanne(X,Y):- child(Y, Z), child(Z, X), female(Z), female(X).
babaanne(X,Y):- child(Y, Z), child(Z, X), male(Z), female(X).




%% RULES DECLARATION -END


% add_3_and_double(X,Y) :- Y is (X+3)*2.




%% FUNCTIONS DECLARATION -BEGIN


list:-
	findall(Input,uid(Input),Z),
	write(Z).
relation(X, Y, RELATION):- koca(X,Y), functor(koca(X,Y), RELATION, _);
 			kari(X,Y), functor(kari(X,Y), RELATION, _);
 			anne(X,Y), functor(anne(X,Y), RELATION, _);
  			baba(X,Y), functor(baba(X,Y), RELATION, _);
 			ogul(X,Y), functor(ogul(X,Y), RELATION, _);
 			kiz(X,Y), functor(kiz(X,Y), RELATION, _);
 			erkek_kardes(X,Y), functor(erkek_kardes(X,Y), RELATION, _);
			kiz_kardes(X,Y), functor(kiz_kardes(X,Y), RELATION, _);
			abi(X,Y), functor(abi(X,Y), RELATION, _);
			abla(X,Y), functor(abla(X,Y), RELATION, _);
			amca(X,Y), functor(amca(X,Y), RELATION, _);
			hala(X,Y), functor(hala(X,Y), RELATION, _);
			dayi(X,Y), functor(dayi(X,Y), RELATION, _);
			teyze(X,Y), functor(teyze(X,Y), RELATION, _);
			yegen(X,Y), functor(yegen(X,Y), RELATION, _);
			kuzen(X,Y), functor(kuzen(X,Y), RELATION, _);
			kayinpeder(X,Y), functor(kayinpeder(X,Y), RELATION, _);
			kayinvalide(X,Y), functor(kayinvalide(X,Y), RELATION, _);
			damat(X,Y), functor(damat(X,Y), RELATION, _);
			gelin(X,Y), functor(gelin(X,Y), RELATION, _);
			bacanak(X,Y), functor(bacanak(X,Y), RELATION, _);
			baldiz(X,Y), functor(baldiz(X,Y), RELATION, _);
			elti(X,Y), functor(elti(X,Y), RELATION, _);
			kayinbirader(X,Y), functor(kayinbirader(X,Y), RELATION, _);
			dede(X,Y), functor(dede(X,Y), RELATION, _);
			torun(X,Y), functor(torun(X,Y), RELATION, _).

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
