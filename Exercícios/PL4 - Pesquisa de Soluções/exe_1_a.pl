:- use_module(library(lists)).

ligado(a,b). 
ligado(b,d).
ligado(a,c).
ligado(b,e).
ligado(b,f).
ligado(c,g). 
ligado(d,h). 
ligado(d,i).
ligado(f,i). 
ligado(f,j).
ligado(f,k).
ligado(g,l).
ligado(g,m).
ligado(k,n). 
ligado(l,o). 
ligado(i,f). 

/**
 * Ni - nó inicial
 * Nf - nó final
 * P - (Path) Lista de nós por onde passa
 * Fp - (Final Path) Lista final
 * e.g prof(a, n, L).
*/
prof(Ni, Nf, P):-
    pesq_prof(Ni, Nf, [], P).

pesq_prof(Nf, Nf, P, Fp):-
    Fp = P.
pesq_prof(Ni, Nf, P, Fp):-
    ligado(Ni, Nm),
    \+ member(Nm, P),
    append(P,[Nm], Pr),
    pesq_prof(Nm, Nf, Pr, Fp).
    