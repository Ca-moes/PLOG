% X max 4, Y max 3
initial(0-0).
final(2-_Y).

next(_X-Y, 0-Y, e1).
next(X-_Y, X-0, e2).

next(_X-Y, 4-Y, f1).
next(X-_Y, X-3, f2).

next(X-Y, X1-Y1, to12):-
    Y<3, 


