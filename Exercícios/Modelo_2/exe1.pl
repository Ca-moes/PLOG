:- use_module(library(lists)).
:- use_module(library(clpfd)).
/* p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),
    gen(L3,L2).

test([]).
test([_]).
test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 < X2, X2 < X3; X1 > X2, X2 > X3),
    test(Xs). */

/*
embrulha([100,45,70], [12,50,14,8,10,90,24], S).
S = [2,3,3,2,1,1,2] ? ;
S = [3,3,2,3,1,1,2] ? ;
*/
embrulha(Rolos, Presentes, RolosSelecionados):-
    length(Presentes, PresentesL),
    length(Rolos, RolosL),
    length(RolosSelecionados, PresentesL),
    domain(RolosSelecionados, 1, RolosL),

    make_machines(1, Rolos, Machines),
    make_tasks(RolosSelecionados, Presentes, Tasks),

    cumulatives(Tasks, Machines, [bound(upper)]),
    labeling([], RolosSelecionados).

make_machines(_, [], []).
make_machines(Id, [Rolo | RestRolos], [machine(Id, Rolo) | Machines]):-
    Id1 is Id + 1,
    make_machines(Id1, RestRolos, Machines).

make_tasks(_, [], []).
make_tasks([Result|Rest], [Presente | PresentesRest], [task(0,1,1, Presente, Result)|Tasks]):-
    make_tasks(Rest, PresentesRest, Tasks).


/* 
    receitas(30,100,[6,4,12,20,6],[20,50,10,20,15],OvosUsados,Receitas).
OvosUsados = 28,
Receitas = [1,2,3,5]
    receitas(50,100,[6,4,12,20,6],[20,50,10,20,15],OvosUsados,Receitas).
OvosUsados = 44,
Receitas = [1,3,4,5] 
*/

receitas(NOvos,TempoMax,OvosPorReceita,TempoPorReceita,OvosUsados,Receitas):-
    length(OvosPorReceita, OvosPorReceitaL),
    Receitas = [R1, R2, R3, R4],
    domain(Receitas, 1, OvosPorReceitaL),
    all_distinct(Receitas),

    element(R1, OvosPorReceita, O1),
    element(R1, TempoPorReceita, T1),

    element(R2, OvosPorReceita, O2),
    element(R2, TempoPorReceita, T2),

    element(R3, OvosPorReceita, O3),
    element(R3, TempoPorReceita, T3),

    element(R4, OvosPorReceita, O4),
    element(R4, TempoPorReceita, T4),

    O1+O2+O3+O4 #= OvosUsados,
    OvosUsados #=< NOvos,
    T1+T2+T3+T4 #= SumT,
    SumT #=< TempoMax,

    labeling([maximize(OvosUsados)], Receitas).
    