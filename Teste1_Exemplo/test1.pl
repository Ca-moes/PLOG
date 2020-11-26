:- use_module(library(lists)).

%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

% madeItThrough(+Participant)
% Participante tem pelo menos 1 120
madeItThrough(Participant):-
	performance(Participant, List),
	find(List).
find([]):-fail.
find([Elem | _]):-
	Elem == 120.
find([_|Rest]):-
	find(Rest).

%________________

% juriTimes(+Participants, +JuriMember, -Times, -Total)
% Para uma lista de participantes e um Juri, retorna Tempos e o Total dos tempos
juriTimes(Participants, JuriMember, Times, Total):-
	part_to_times(Participants, JuriMember, TempTimes),
	inverter(TempTimes, Times),
	total_sum(Times, 0, Total).
	
total_sum(List, Result):- total_sum(List, 0, Result).
total_sum([], Count, Count).
total_sum([Head|Tail], Count, Final):-
	Coount1 is Count + Head,
	total_sum(Tail, Coount1, Final).

%Participant List to Juri Times list
part_to_times([], _, []).
part_to_times([Head|Tail], Juri, Result):-
	get_time_juri(Head, Juri, TempResult),
	part_to_times(Tail, Juri, TempList),
	append_t(TempList, [TempResult], Result).


%Participant Id and juri number, returns time 
get_time_juri(Participant, Juri, Time):-
	performance(Participant, List),
	Juri1 is Juri-1,
	nth0_(Juri1, List, Time).
	

nth0_(Index, [_|Tail], Result):-
	Index1 is Index-1,
	nth0_(Index1, Tail, Result).
nth0_(0, [Head|_], Head).

append_t([],L,L).
append_t([X|L1],L2,[X|L3]):- 
	append_t(L1,L2,L3). 

inverter(Lista,InvLista):- 
	rev(Lista,[],InvLista). 
rev([H|T],S,R):- 
	rev(T,[H|S],R). 
rev([],R,R). 

%________________

patientJuri(Juri):-
	get_juri_times(Juri, Times),
	got_2_120(Times, 0).

get_juri_times(Juri, Times):-
	get_participants(Participants),
	juriTimes(Participants, Juri, Times, _).
	

got_2_120(_, 2).
got_2_120([], _):- false.
got_2_120([Head|Tail], Counter):-
	Head == 120, Counter1 is Counter+1,
	got_2_120(Tail, Counter1).
got_2_120([_|Tail], Counter):-
	got_2_120(Tail, Counter).


get_participants(Participants) :- get_participants([], Participants).

get_participants(Acc, Participants):-
	performance(Id, _),
	\+ membro(Id, Acc),
	append_t(Acc, [Id], Acc2),
	get_participants(Acc2, Participants).
get_participants(X,X).

membro(X,L):- append_t(_,[X|_],L).

%________________

%bestParticipant(+P1, +P2, -P)
bestParticipant(P1, P2, P1):-
	performance(P1,P1List),
	total_sum(P1List, Result1),
	performance(P2,P2List),
	total_sum(P2List, Result2),
	Result1 > Result2.
bestParticipant(P1, P2, P2):-
	performance(P1,P1List),
	total_sum(P1List, Result1),
	performance(P2,P2List),
	total_sum(P2List, Result2),
	Result1 < Result2.
bestParticipant(P1, P2, P2):-
	performance(P1,P1List),
	total_sum(P1List, Result1),
	performance(P2,P2List),
	total_sum(P2List, Result2),
	Result1 == Result2, fail.

%________________

allPerfs:-
	get_participants(Participants),
	print_performance(Participants).

print_performance([]).
print_performance([Head|Tail]):-
	participant(Head, _, Performance),
	performance(Head,Times),
	format('~d:~s:', [Head, Performance]), write(Times), nl,
	print_performance(Tail).

%________________

% nSuccessfulParticipants(-T)
nSuccessfulParticipants(T):-
	get_participants(Participants),
	count_all_120(Participants, 0, T).

count_all_120([], Amount, Amount).
count_all_120([Head|Tail], Amount, Return):-
	got_all_120(Head), Amount1 is Amount+1, 
	count_all_120(Tail, Amount1, Return).
count_all_120([_|Tail], Amount, Return):-
	count_all_120(Tail, Amount, Return).

got_all_120(Participant):-
	performance(Participant,Times),
	length(Times, Size), 
	got_all_120(Times, Size, 0).

got_all_120([], Size, Size).
got_all_120([Head|Tail], Size, SoFar):-
	Head == 120, SoFar1 is SoFar+1,
	got_all_120(Tail, Size, SoFar1).

%__________________

% juriFans(juriFansList)

juriFans(L):-
	get_participants(Participants),
	juriFans(Participants, [], L).

juriFans([], Current, Current).
juriFans([Header|Tail], Current, Result):-
	get_120_juri_list(Header, List),
	append_t(Current, [Header-List], CurrentNew),
	juriFans(Tail, CurrentNew, Result).

get_120_juri_list(Participant, List):-
	performance(Participant,Times),
	count_120(Times, 1, TempList),
	inverter(TempList,List), !.

count_120([], _,[]).
count_120([Head|Tail], Counter, Return):-
	Head == 120, Counter1 is Counter+1,
	count_120(Tail, Counter1, TempReturn),
	append_t(TempReturn,[Counter],Return).
count_120([_|Tail], Counter, Return):-
	Counter1 is Counter+1,
	count_120(Tail, Counter1, Return).

%__________________

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).