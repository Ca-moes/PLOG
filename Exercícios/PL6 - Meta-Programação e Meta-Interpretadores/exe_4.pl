% 4.a)
functor_(Term,F,N):- Term=..[F|Args], length(Args,N).

% 4.b)
arg_(N,Term,Arg):- Term=..[F|Args], position(N,Args,Arg). 

position(1,[X|_],X). 
position(N,[_|Xs],Y):-
    N>1, 
    N1 is N-1, 
    position(N1,Xs,Y).