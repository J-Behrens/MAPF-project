direction((X,Y)) :- X=-1..1, Y=-1..1, |X|+|Y|=1..2.

nextto((X,Y),(DX,DY),(X',Y')) :- direction((DX,DY)), position((X,Y)), position((X',Y')), (X,Y)=(X'-DX,Y'-DY), (X',Y')=(X+DX,Y+DY).
nextto(P,P2) :- nextto(P,D,P2).

dimx(X2) :- X2=#max{X : position((X,_))}.
{clique(1,I,(X,Y)) : position((X,Y)), I=(X-1)/2 + ((Y-1)/2)* (DIMX/2), dimx(DIMX) }.

in_clique(P) :- 1={clique(1,_,P)}, position(P).
:- not in_clique(P), position(P).

#show clique/3.
