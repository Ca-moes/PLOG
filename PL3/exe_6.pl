% a) 
delete_one(X, L1, L2):-
    append(La, [X|Lb], L1),
    append(La, Lb, L2).
    
% b)
delete_all(X, L1, L2):-
    \+member(X, L1),
    L2 = L1.
    
delete_all(X, L1, L2):-
    delete_one(X, L1, L),
    delete_all(X, L, L2).

% c
delete_all_list(Lx, L1, L2):-
    Lx = [],
    L2 = L1.

delete_all_list(Lx, L1, L2):-
    Lx = [X|Lx1],
    delete_all(X, L1, L),
    delete_all_list(Lx1, L, L2).