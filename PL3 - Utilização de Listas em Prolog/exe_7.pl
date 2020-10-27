% a) L = [_ A [_ B _]]

before(A, B, L):-
    append(_, [A|L1], L),
    append(_, [B|_], L1).