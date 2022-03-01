max_level(1).
direction((X,Y)) :- X=-1..1, Y=-1..1, |X|+|Y|=1..2.

node(N,X,Y) :- init(object(node,N),value(at,(X,Y))).
node(N,0)   :-   node(N,_,_).
node(N,L)   :- clique(N,      L).
node(N,L)   :- clique(N,_,    L).
node(N,L)   :- clique(N,_,_,  L).
node(N,L)   :- clique(N,_,_,_,L).

edge((N,N2),0) :- direction((DX,DY)), node(N,X,Y), node(N2,X2,Y2), (X,Y)=(X2-DX,Y2-DY), (X2,Y2)=(X+DX,Y+DY).
edge((N,N2),L) :- is_in(N,N3 ,L), is_in(N2,N4 ,L), edge((N3,N4),L-1), N!=N2. 

is_in(N,N ,L) :-   node(N,         L), L>0.
is_in(N,N2,L) :- clique(N,N2,      L).
is_in(N,N2,L) :- clique(N,N2,_ ,   L).
is_in(N,N2,L) :- clique(N,N2,_ ,_ ,L).
is_in(N,N3,L) :- clique(N,_ ,N3,   L).
is_in(N,N3,L) :- clique(N,_ ,N3,_ ,L).
is_in(N,N4,L) :- clique(N,_ ,_ ,N4,L).

:- 1!={is_in(_,N,L+1)}, node(N,L), L<M, max_level(M).

{clique(N,         L+1) : L<M, max_level(M), node( N    ,L)}.
{clique(N,N2,      L+1) : L<M, max_level(M), edge((N,N2),L)}.
{clique(N,N2,N3,   L+1) : L<M, max_level(M), edge((N,N2),L), edge((N,N3),L), edge((N2,N3),L)}.
{clique(N,N2,N3,N4,L+1) : L<M, max_level(M), edge((N,N2),L), edge((N,N3),L), edge((N2,N3),L), edge((N,N4),L), edge((N2,N4),L), edge((N3,N4),L)}.

 :- 1<{clique(N,L); clique(N,_,L); clique(N,_,_,L); clique(N,_,_,_,L)}, node(N,L-1).

% optimize:
#minimize{1,N,L: node(N,L), L>0}.

% clingraph:
graph(1..M) :- max_level(M).
#show graph/1. #show node/2. #show edge/2.
%#show clique/2. #show clique/3. #show clique/4. #show clique/5.
