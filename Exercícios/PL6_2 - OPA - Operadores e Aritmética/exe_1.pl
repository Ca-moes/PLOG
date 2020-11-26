/*
1.  :- op(500, xfx, na).
    :- op(500, xfy, ad).
    :- op(500, yfx, ae).

    a) a na b ae c.
        (a na b) ae c
    b) a na b ad c.
        ad é associativo á direita
    c) a ad b na c.
        a ad (b na c)
    d) a na b na c.
        Não se sabe a precedência
    e) a ad b ad c.
        a ad (b ad c)
    f) a ae b ae c.
        (a ae b) ae c
    g) a ad b ad c na d ae e ae f.
        a ad (b ad c na d ae e ae f)
        a ad (b ad (c na d ae e ae f))
        a ad (b ad ((c na d ae e) ae f))
        a ad (b ad (((c na d) ae e) ae f))

3.  
:-op (700, xfx, \\). 
:-op (600, xfx, //). 
:-op (600, xfy, ':'). 
:-op (400, yfx, para). 
:-op (400, xfx, de).

    a) Voo // Número de Orig para Dest \\ Dia: Hora: min. 
        (Voo // Número de Orig para Dest) \\ (Dia: Hora: min). 
        (Voo // ((Número de Orig) para Dest)) \\ (Dia: (Hora: (min))).
    
    b)  1 de A para C: 2 de B para C: 3 de A para B. 
        1 de A para C: (2 de B para C: 3 de A para B). 
        (1 de A) para C: ((2 de B) para C: ((3 de A) para B)). 

5.
:- op(300, xfx, joga).
:- op(200, xfy, e).

T1 = marcelo joga futebol e squash.
        marcelo joga (futebol e (squash)).
functor principal : joga
T2 = renata joga tenis e basquete e volei.
    renata joga (tenis e (basquete e (volei))).
functor principal : joga

7.
    a) A=1+0
    b) B=1+1+0
    c) 
    
    X+1 = 1+0+1+1
     X+1 = 1+0+1
     X1 = 1+1+0
*/

t(0+1, 1+0).            
t(X+0+1, X+1+0).
t(X+1+1, Z) :-             
    t(X+1, X1),                  
    t(X1+1, Z).