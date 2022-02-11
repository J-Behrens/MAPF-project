direction((X,Y)) :- X=-1..1, Y=-1..1, |X|+|Y|=1..2.

nextto((X,Y),(DX,DY),(X',Y')) :- direction((DX,DY)), position((X,Y)), position((X',Y')), (X,Y)=(X'-DX,Y'-DY), (X',Y')=(X+DX,Y+DY).

nextto(P,P2) :- nextto(P,D,P2).

clique(1).

1{clique(I,P) : clique(I)} :- position(P).
:- clique(I,P), clique(I,P'), not nextto(P,P'), P>P'.
clique(I+1) :- not clique(_,P), position(P), clique(I).

% Verbundenheit von cliques: wenn 2 position aus 2 cliques verbunden dann sind die cliques verbunden

#show clique/2.
