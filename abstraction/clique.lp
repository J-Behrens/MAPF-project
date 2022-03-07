max_level(1).
direction((X,Y)) :- X=-1..1, Y=-1..1, |X|+|Y|=1..2.

node(N,X,Y) :- init(object(node,N),value(at,(X,Y))).
node(N,0)   :-   node(N,_,_).
node(N,L)   :- clique(N,      L).
node(N,L)   :- clique(N,_,    L).
node(N,L)   :- clique(N,_,_,  L).
node(N,L)   :- clique(N,_,_,_,L).

edge((N,N2),0) :- direction((DX,DY)), node(N,X,Y), node(N2,X2,Y2), (X,Y)=(X2-DX,Y2-DY), (X2,Y2)=(X+DX,Y+DY).
edge((C,C2),L) :- n_is_in_c(C,N ,L), n_is_in_c(C2,N2 ,L), edge((N,N2),0), C<C2, L>0.

n_is_in_c(N,N,0)  :- node(N,0).
c_is_in_c(N,N ,L) :-   node(N,         L), L>0.
c_is_in_c(N,N2,L) :- clique(N,N2,      L).
c_is_in_c(N,N2,L) :- clique(N,N2,_ ,   L).
c_is_in_c(N,N2,L) :- clique(N,N2,_ ,_ ,L).
c_is_in_c(N,N3,L) :- clique(N,_ ,N3,   L).
c_is_in_c(N,N3,L) :- clique(N,_ ,N3,_ ,L).
c_is_in_c(N,N4,L) :- clique(N,_ ,_ ,N4,L).

n_is_in_c(C,N,L) :- c_is_in_c(C,C2,L), n_is_in_c(C2,N,L-1).

:- 1!={c_is_in_c(_,C,L+1)}, node(C,L), L<M, max_level(M).

{clique(N,         L+1);
 clique(N,N2,      L+1) : edge((N,N2),L);
 clique(N,N2,N3,   L+1) : edge((N,N2),L), edge((N,N3),L), edge((N2,N3),L);
 clique(N,N2,N3,N4,L+1) : edge((N,N2),L), edge((N,N3),L), edge((N2,N3),L), edge((N,N4),L), edge((N2,N4),L), edge((N3,N4),L)
} :- node(N,L), L<M , max_level(M).

 :- 1<{clique(N,L); clique(N,_,L); clique(N,_,_,L); clique(N,_,_,_,L)}, node(N,L-1).

% optimize:
%#minimize{1,N,L: node(N,L), L>0}.
#heuristic clique(N,         L). [4,false]
#heuristic clique(N,N2,      L). [3,false]
#heuristic clique(N,N2,N3,   L). [2,false]
#heuristic clique(N,N2,N3,N4,L). [1,false]

% clingraph:
graph(1..M) :- max_level(M).
#show graph/1. #show node/2. #show edge/2.
%#show clique/2. #show clique/3. #show clique/4. #show clique/5.
