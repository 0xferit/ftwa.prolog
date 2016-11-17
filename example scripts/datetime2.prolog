:- use_module(library(date)).


get_date_time_value(Key, Value) :-
 get_time(Stamp),
 stamp_date_time(Stamp, DateTime, local),
 date_time_value(Key, DateTime, Value).

rules([[time,0],[
    [1,[_],0,
            [it,is,HourLiteral,oclock,.],
            ['I',dont,know,the,time,.]]]]) :- get_date_time_value(hour, HourNumber), number_codes(HourNumber, HourString), atom_string(HourLiteral, HourString) .
