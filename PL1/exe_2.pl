pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

team('Breitling').
team('Red Bull').
team('Mediterranean Racing Team').
team('Cobra').
team('Matador').

plane('MX2').
plane('Edge540').

circuit('Istanbul').
circuit('Budapest').
circuit('Porto').

% inTeam(pilot, team)
inTeam('Lamb', 'Breitling').
inTeam('Besenyei', 'Red Bull').
inTeam('Chambliss', 'Red Bull').
inTeam('MacLean', 'Mediterranean Racing Team').
inTeam('Mangold', 'Cobra').
inTeam('Jones', 'Matador').
inTeam('Bonhomme', 'Matador').

% pilots(pilot, plane)
pilots('Lamb','MX2').
pilots('Besenyei','Edge540').
pilots('Chambliss','Edge540').
pilots('MacLean','Edge540').
pilots('Mangold','Edge540').
pilots('Jones','Edge540').
pilots('Bonhomme','Edge540').

% won(pilot, circuit)
won('Jones', 'Porto').
won('Mangold', 'Budapest').
won('Mangold', 'Istanbul').

% gates (circuit, number)
gates('Istanbul', 9).
gates('Budapest', 6).
gates('Porto', 5).

% wonTeam (team, circuit)
wonTeam(T, C):- won(P,C), inTeam(P,T).

/*
a.  Quem venceu a corrida no Porto? 
    | ?- won(X,'Porto').
    X = 'Jones' ? ;
    no

b.  Qual a equipa que ganhou no Porto? 
    | ?- wonTeam(T, 'Porto').
    T = 'Matador' ? ;
    no

c.  Quais os pilotos que venceram mais de um circuito? 
    | ?- won(X,C1), won(X,C2), C1@<C2.
    X = 'Mangold',
    C1 = 'Budapest',
    C2 = 'Istanbul' ? ;
    no

    
d.  Que circuitos têm mais de 8 gates?
    | ?- gates(X,G), G > 8.
    X = 'Istanbul',
    G = 9 ? ;
    no

e.  Que pilotos não pilotam um Edge540?
    | ?- pilots(Pilot, Plane), Plane \= 'Edge540'.
    Pilot = 'Lamb',
    Plane = 'MX2' ? ;
    no
    
*/