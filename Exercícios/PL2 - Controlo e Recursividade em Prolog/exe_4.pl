% factorial(0,1)
% factorial(1,1) 1
% factorial(2,2) 2*1 = 2 * 1!
% factorial(3,6) 3*2*1 = 3 * 2!

factorial(0,1).
factorial(N, Valor) :-
    N > 0,
    N1 is N-1, factorial(N1, F1),
    Valor is N * F1.
