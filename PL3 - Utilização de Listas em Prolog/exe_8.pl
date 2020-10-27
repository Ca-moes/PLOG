% a) Lista L tem N elementos
conta([], 0).
conta(L, N):-
    N > 0,
    L = [_|L1],
    N1 is N - 1,
    conta(L1,N1).

% b) List L tem N elementos X

conta_elem(_, [], 0).

conta_elem(X, L, N):-
    N > 0,
    L = [Y|L1],
    Y \= X,
    conta_elem(X, L1, N).

conta_elem(X, L, N):-
    N > 0,
    L = [X|L1],
    N1 is N-1,
    conta_elem(X, L1, N1).
