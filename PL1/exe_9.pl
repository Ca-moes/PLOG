% aluno, cadeira
aluno(joao, paradigmas).
aluno(maria, paradigmas).  
aluno(joel, lab2). 
aluno(joel, estruturas). 

% aluno, universidade
frequenta(joao, feup). 
frequenta(maria, feup).  
frequenta(joel, ist). 

% docente, cadeira
professor(carlos, paradigmas). 
professor(ana_paula, estruturas).  
professor(pedro, lab2). 

% docente, universidade
funcionario(pedro, ist). 
funcionario(ana_paula, feup).  
funcionario(carlos, feup).

/*
a.  Quem são os alunos do professor X?
    | ?- professor(X,Cadeira),aluno(Y,Cadeira).
    X = carlos,
    Cadeira = paradigmas,
    Y = joao ? no
    X = carlos,
    Cadeira = paradigmas,
    Y = maria ? no
    X = ana_paula,
    Cadeira = estruturas,
    Y = joel ? no
    X = pedro,
    Cadeira = lab2,
    Y = joel ? no
    no

b.  Quem são as pessoas da universidade X? (alunos ou docentes) 
    | ?- frequenta(Aluno, X);funcionario(Docente, X).
    Aluno = joao,
    X = feup ? no
    Aluno = maria,
    X = feup ? no
    Aluno = joel,
    X = ist ? no
    X = ist,
    Docente = pedro ? no
    X = feup,
    Docente = ana_paula ? no
    X = feup,
    Docente = carlos ? no
    no

c. Quem é colega de quem? 
    Se aluno: é colega se for colega de disciplina ou 
                              colega de curso ou 
                              colega de universidade. 
    Se professor: se for professor da mesma universidade.


    | ?- funcionario(Prof1, Uni), funcionario(Prof2, Uni), Prof1@<Prof2; aluno(Al1, Dis), aluno(Al2, Dis), Al1@<Al2; frequenta(Al1, Uni), frequenta(Al2, Uni), Al1@<Al2.
    Prof1 = ana_paula,
    Uni = feup,
    Prof2 = carlos ? ;
    Al1 = joao,
    Dis = paradigmas,
    Al2 = maria ? ;
    Uni = feup,
    Al1 = joao,
    Al2 = maria ? ;
    no

*/