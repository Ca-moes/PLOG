:- use_module(library(clpfd)).

quad3(L):-
  L = [A, B, C, D, E, F, G, H, I],
  domain(L, 1, 9),
  all_distinct(L),
  A+B+C #= S,
  D+E+F #= S,
  G+H+I #= S,
  A+D+G #= S,
  B+E+H #= S,
  C+F+I #= S,
  A+E+I #= S,
  C+E+G #= S,
  A #< C, A #< G, C#<G,
  labeling([], L).
  