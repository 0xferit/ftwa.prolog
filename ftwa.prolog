:- use_module(library(date)).

%% RULES DECLARATION -BEGIN

male(X) :- not(female(X)).

parent_of(X,Y) :- child_of(Y,X).

spouse_of(X,Y) :- spouse(Y,X).
spouse_of(X,Y) :- spouse(X,Y).

sister_of(X,Y) :- siblings(X,Y), female(X).

brother_of(X,Y) :- siblings(X,Y), not(female(X)).

siblings(X,Y) :- child_of(X,A), child_of(Y,A), not(X=Y).


damat(X,Y) :- parent_of(X, Z), female(Z), spouse_of(Z,Y).
gelin(X,Y) :- parent_of(X, Z), not(female(Z)), spouse_of(Z,Y).

%% RULES DECLARATION -END


% add_3_and_double(X,Y) :- Y is (X+3)*2.

%% FAMILY DECLARATION -BEGIN
uid('Ayşe', 1).
uid('Erdem', 2).
uid('Seda', 5).
uid('Ali', 6).
uid('Ali', 7).
uid('Deniz', 8). 

female(1).
female(5).
female(8).

birthdate(1, date(1925,1,1)).
birthdate(2, date(1920,1,1)).
birthdate(5, date(1952,1,1)).
birthdate(6, date(1948,1,1)).
birthdate(7, date(1960,1,1)).
birthdate(8, d(1960,1,1)).



%% FAMILY DECLARATION -END
%% RELATIONS DECLARATION -BEGIN

spouse(1, 2).
spouse(5, 6).
spouse(7, 8).

child_of(5, 1).
child_of(5, 2).

child_of(7, 1).
child_of(7, 2).

%% RELATIONS DECLARATION -END

%% FUNCTIONS DECLARATION -BEGIN
list:-
	uid(Input, Output),
	write('The UID of '), write(Input),
	write(' is '), write(Output), write('.').

%! relation(X,Y):-
%	position(Input, Output),
%	write('The position of '), write(Input),
%	write(' is '), write(Output), write('.').
%

% age(+Birthday, -Age)
%
age(UID, Age) :-
	birthdate(UID, date(Y2, M2, D2)),
	get_date_time_value(year, Y1),
	get_date_time_value(month, M1),
	get_date_time_value(day, D1),
	A is Y1 - Y2,
	( ( M1 < M2 ; M1 == M2, D1 < D2 ) -> Age is A - 1 ; Age = A).


%% UTILITY FUNCTIONS DECLARATION -BEGIN
get_date_now(Value) :-
 get_time(Stamp),
 stamp_date_time(Stamp, DateTime, local),
 date_time_value(date, DateTime, Value).

get_date_time_value(Key, Value) :-
 get_time(Stamp),
 stamp_date_time(Stamp, DateTime, local),
 date_time_value(Key, DateTime, Value).

%get_time_diff

%% UTILITY FUNCTIONS DECLARATION -END
%% FUNCTIONS DECLARATION -END
