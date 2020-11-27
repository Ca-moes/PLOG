%player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

%game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

:-dynamic played/4.
%played(Player, Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

% 1. Implemente o predicado playedALot(+Player) que sucede se o jogador Player jogou pelo menos 50h em algum jogo.

playedALot(Player):-
    played(Player, _, Hours, _), Hours >= 50.


% 2. Implemente o predicado isAgeAppropriate(+Name, +Game) que sucede se Game é um jogo adequado à idade da pessoa Name.

isAgeAppropriate(Name, Game):-
    player(Name, _, Age),
    game(Game, _, Age2), Age >= Age2.

/*
3. Implemente o predicado updatePlayer(+Player, +Game, +Hours, +Percentage) que
atualiza a base de conhecimento relativamente ao número de horas que o jogador Player
jogou o jogo Game.
*/

updatePlayer(Player, Game, Hours, Percentage):-
    retract(played(Player, Game, PrevHours, PrevPercentage)),
    NewHours is PrevHours+Hours, 
    NewPercentage is PrevPercentage+Percentage,
    assert(played(Player, Game, NewHours, NewPercentage)).

/*
4. Implemente o predicado listGamesOfCategory(+Cat) que imprime na consola os títulos
de todos os jogos que se enquadram na categoria Cat, indicando ainda a idade mínima
recomendada para cada jogo. Note que o predicado sucede sempre.
*/
listGamesOfCategory(Cat):-
    game(Game, Categories, Age),
    membro(Cat, Categories),
    format('~s (~d)\n', [Game, Age]), fail.
listGamesOfCategory(_).


/*
5. Implemente o predicado timePlayingGames(+Player, +Games, -ListOfTimes, -SumTimes)
que determina o número total de horas que o jogador Player investiu a jogar cada um dos
jogos indicados na lista Games, retornando em ListOfTimes os tempos de cada um dos
jogos na ordem respetiva, e em SumTimes o número total de horas.
*/

timePlayingGames(Player, Games, ListOfTimes, SumTimes):-
    timePlayingGames(Player, Games, ListOfTimes),
    sumList(ListOfTimes, SumTimes).

timePlayingGames(_, [], []).
timePlayingGames(Player, [Game|Rest], [Hours|ListOfTimes]):-
    played(Player, Game, Hours, _Percent),
    timePlayingGames(Player, Rest, ListOfTimes).

/*
6. Implemente o predicado fewHours(+Player, -Games), que devolve em Games a lista de
jogos nos quais o jogador Player investiu menos de 10h a jogar.
*/

fewHours(Player, Games):-
    fewHours_aux(Player, [], Games), !.

fewHours_aux(Player, Accumulator, Games):-
    played(Player, Game, Hours, _),
    Hours < 10, 
    \+ membro(Game, Accumulator),
    fewHours_aux(Player, [Game|Accumulator], Games).
fewHours_aux(_, L, L).

/*
7. Implemente o predicado ageRange(+MinAge, +MaxAge, -Players) que devolve em Players
a lista dos nomes dos jogadores com idade compreendida entre MinAge e MaxAge (limites
inclusivos).
*/
    
ageRange(MinAge, MaxAge, Players):-
    findall(Player,
        (player(Player, _, Age), (Age >= MinAge, Age =< MaxAge) ), 
        Players).
    
/*
8. Implemente o predicado averageAge(+Game, -AverageAge) que determina a idade média
dos jogadores que jogam o jogo Game.
*/

averageAge(Game, AverageAge):-
    findall(
        Age,
        (played(Player, Game, _, _), player(_, Player, Age)), 
        List),
    average(List, AverageAge).
    
average(List, Average):-
    sumList(List, Sum),
    length(List, Length),
    Average is Sum/Length.
    
/*
9. Implemente o predicado mostEffectivePlayers(+Game, -Players) que determina o jogador
ou jogadores que jogam o jogo Game com maior eficiência. O jogador mais eficiente é
aquele que conseguiu alcançar uma maior percentagem de conclusão do jogo num
menor número de horas.
*/

mostEffectivePlayers(Game, Players):-
    findall(
    Eff-Player, 
    (played(Player, Game, Hours, Percentage), Eff is Percentage/Hours), 
    Playerss),
    mEPaux(Playerss, Playerss, Players), !.

mEPaux([], _, []).
mEPaux([E-P|T], [Eff-Player|_], [P|TempList]):-
    E == Eff, 
    mEPaux(T, [Eff-Player|_], TempList).
mEPaux([_|T], [Eff-Player|_], TempList):-
    mEPaux(T, [Eff-Player|_], TempList).

/*
Auxiliar
*/
sumList([], 0).
sumList([H|T], Sum) :-
    sumList(T, Rest),
   Sum is H + Rest.

membro(X,L):- append(_,[X|_],L).


%______________

whatDoesItDo(Player):-
    player(_, Player, Age), !,
    \+ ( played(Player, Game, _, _),
    game(Game, _, MinAge),
    MinAge > Age ).

% played(Player, Game, HoursPlayed, PercentUnlocked)
% game(Name, Categories, MinAge).
