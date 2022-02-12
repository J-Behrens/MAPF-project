direction((X,Y)) :- X=-1..1, Y=-1..1, |X|+|Y|=1..2.

nextto((X,Y),(DX,DY),(X',Y')) :- direction((DX,DY)), position((X,Y)), position((X',Y')), (X,Y)=(X'-DX,Y'-DY), (X',Y')=(X+DX,Y+DY).

nextto(P,P2) :- nextto(P,D,P2).

in_clique(P) :- 1={clique(P);
                   clique(P,_); clique(_,P);
                   clique(P,_,_); clique(_,P,_); clique(_,_,P);
                   clique(P,_,_,_); clique(_,P,_,_); clique(_,_,P,_); clique(_,_,_,P)},
                   position(P).

:- not in_clique(P), position(P).

{clique(P)             : position(P)}.
{clique(P,P')          : nextto(P,P')}.
{clique(P,P',P'')      : nextto(P,P'), nextto(P,P''), nextto(P',P'')}.
{clique(P,P',P'',P''') : nextto(P,P'), nextto(P,P''), nextto(P,P'''), nextto(P',P''), nextto(P',P'''), nextto(P'',P''')}.

#show clique/4.
#show clique/3.
#show clique/2.
#show clique/1.
