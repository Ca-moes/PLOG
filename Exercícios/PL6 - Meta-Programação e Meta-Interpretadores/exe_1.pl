%my_map(List, TermName, Result)
my_map([], _, []).
my_map([H | Tail], TermName, [Result|AuxResult]):-
    Term =.. [TermName, H, Result],
    Term,
    my_map(Tail, TermName, AuxResult).