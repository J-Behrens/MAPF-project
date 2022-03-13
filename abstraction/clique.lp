max_level(2).
%#const horizon=4.
time(0..horizon).
direction((X,Y)) :- X=-1..1, Y=-1..1, |X|+|Y|=1..2.

% Nodes:
node(N,X,Y) :- init(object(node,N),value(at,(X,Y))).
node(N,0)   :-   node(N,_,_).
node(N,L)   :- clique(N,      L).
node(N,L)   :- clique(N,_,    L).
node(N,L)   :- clique(N,_,_,  L).
node(N,L)   :- clique(N,_,_,_,L).

% Keeping track of which node/clique is contained in which clique:
c_is_in_c(N,N ,L) :-   node(N,         L), L>0.
c_is_in_c(N,N2,L) :- clique(N,N2,      L).
c_is_in_c(N,N2,L) :- clique(N,N2,_ ,   L).
c_is_in_c(N,N2,L) :- clique(N,N2,_ ,_ ,L).
c_is_in_c(N,N3,L) :- clique(N,_ ,N3,   L).
c_is_in_c(N,N3,L) :- clique(N,_ ,N3,_ ,L).
c_is_in_c(N,N4,L) :- clique(N,_ ,_ ,N4,L).
n_is_in_c(N,N ,0) :-   node(N,         0).
n_is_in_c(C,N ,L) :- c_is_in_c(C,C2,L), n_is_in_c(C2,N,L-1).

% Nodes can not be contained in more than one clique:
:- 1!={c_is_in_c(_,C,L+1)}, node(C,L), L<M, max_level(M).
:- 1<{clique(N,L); clique(N,_,L); clique(N,_,_,L); clique(N,_,_,_,L)}, node(N,L-1).	% Special case because ID of first node in clique is also used as cliques ID

% Clique generation:
{clique(N,         L+1);
 clique(N,N2,      L+1) : edge((N,N2),L);
 clique(N,N2,N3,   L+1) : edge((N,N2),L), edge((N,N3),L), edge((N2,N3),L);
 clique(N,N2,N3,N4,L+1) : edge((N,N2),L), edge((N,N3),L), edge((N2,N3),L), edge((N,N4),L), edge((N2,N4),L), edge((N3,N4),L)
}1 :- node(N,L), L<M , max_level(M).

% Edges:
edge((N,N2),0) :- direction((DX,DY)), node(N,X,Y), node(N2,X2,Y2), (X,Y)=(X2-DX,Y2-DY), (X2,Y2)=(X+DX,Y+DY).
edge((C,C2),L) :- edge((N ,N2),0), n_is_in_c(C,N,L), n_is_in_c(C2,N2,L), C<C2, L>0.
edge((N,N2),L) :- edge((N2,N ),L).

% Starting positions:
at(R,C2,L,0) :- init(object(robot,R),value(at,(X,Y))), node(C,X,Y), n_is_in_c(C2,C,L), L<=M, max_level(M).

% New positions on highest level:
{at(R,C2,L,T+1) : edge((C,C2),L)}1 :- at(R,C,L,T), max_level(L), time(T+1).

% New positions from highest level downwards:
{at(R,C2,L,T+1) : c_is_in_c(C,C2,L+1), at(R,C3,L,T), edge((C2,C3),L), T<horizon, time(T)} :- at(R,C,L+1,_), L<M, max_level(M).

% Keep order of higher levels:
:- at(R,N,L,T), at(R,N2,L,T2), at(R,C,L+1,T3), at(R,C2,L+1,T4), c_is_in_c(C,N,L+1), c_is_in_c(C2,N2,L+1), T>T2, T3<T4.

% Goal:
goal(N) :- init(object(order,O),value(line,(A,_))), init(object(product,A),value(on,(S,_))), init(object(shelf,S),value(at,(X,Y))), node(N,X,Y).
at_goal(N,L) :- goal(N), n_is_in_c(C,N,L), at(R,C,L,_), init(object(robot,R),_), L<=M, max_level(M).
:- goal(N), not at_goal(N,L), L=0..M, max_level(M).

% Vertex collision:
:- { at(R,C,0,T) : init(object(robot,R),_) }  > 1, node(C,0), time(T).
 
% Edge collision:
:- at(R,C,0,T), at(R2,C2,0,T), at(R,C2,0,T+1), at(R2,C,0,T+1), time(T).

% Crossing collision:
:- at(R,N,0,T), at(R,N2,0,T+1),  at(R2,N3,0,T),  at(R2,N4,0,T+1), time(T),
   node(N,X,Y), node(N2,X+1,Y+1), node(N3,X+1,Y), node(N4,X,Y+1).

:- at(R,N,0,T),     at(R,N2,0,T+1), at(R2,N3,0,T),  at(R2,N4,0,T+1), time(T),
   node(N,X+1,Y+1), node(N2,X,Y),    node(N3,X,Y+1), node(N4,X+1,Y).
   
:- at(R,N,0,T), at(R,N2,0,T+1), at(R2,N3,0,T),  at(R2,N4,0,T+1), time(T),
   node(N,X,Y), node(N2,X+1,Y+1),    node(N3,X,Y+1),   node(N4,X+1,Y).
   
:- at(R,N,0,T), at(R,N2,0,T+1), at(R2,N3,0,T),  at(R2,N4,0,T+1), time(T),
   node(N,X+1,Y+1), node(N2,X,Y),    node(N3,X+1,Y),   node(N4,X,Y+1).

% Optimization:
#heuristic clique(N,         L). [4,false]
#heuristic clique(N,N2,      L). [3,false]
#heuristic clique(N,N2,N3,   L). [2,false]
#heuristic clique(N,N2,N3,N4,L). [1,false]

% Clingraph:
#script (python)
from clingo.symbol import String
def pos(x,y):
    return String(f"{str(x)},{str(y)}!")
#end.

maxY(MY) :- node(_,_,MY), MY=#max{Y : node(N,X,Y)}.
#show attr(node,N,pos,@pos(X,MY-Y)) : node(N,X,Y), maxY(MY).
graph(0..M) :- max_level(M).
#show attr(node, N, color, red) : at(_,N,0,_).
#show graph/1. #show node/2. #show edge/2.
