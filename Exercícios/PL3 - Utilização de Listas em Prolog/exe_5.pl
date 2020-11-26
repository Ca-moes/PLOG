% a) verificar se X está na lista L.
% L = [H | T]

membro(X, [Y|T]) :- 
    X=Y; 
    membro(X, T).

member_(X, [X,L]).
member_(X, [Y,L]) :-
    X \== Y,
    member_(X,L).


% b)
% Tenda criar a lista L com o elemento X lá no meio, usando as lista _L1 e _L2, que podem ter conteudo ou ser vazias

membro_b(X,L):-
    append(_L1, [X| _L2], L).

% _ é um placeholder para alguma coisa, não são necessáriamente iguais
membro_b_alt(X,L):-
    append(_, [X| _], L).

% c)
last(L, X):-
    append(_,[X],L).

% d)

nth_membro(1,[M|_],M).
nth_membro(N,[_|T],M):- 
    N>1,  
    N1 is N-1,  
    nth_membro(N1,T,M).
