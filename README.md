# MAPF-project
MAPF project about abstraction

## TO DO:
- [x] add 2-3 [benchmark instances](/instances)
- [x] modify [asprilo for 8-connected grids](/asprilo/m/action-M-8.lp)
  - [x] change definition of direction
  - [x] add crossing collision
- [x] implement:
  - [x] [abstraction](/abstraction/clique.lp)
    - [x] cliques
    - [x] edges                        (inefficient)
    - [x] "minimization" of clique sizes (via heuristic)
    - [ ] (orphans)
    - [x] level
  - [x] visualisation (clingraph)
  - [x] solving of abstraction
  - [x] solving of original instance using information of higher level solutions
- [ ] run benchmarks
- [ ] try other abstraction:
  - [ ] corridor
  - [ ] crossroads
  - [ ] like in G-TAPF paper



## Instances:
### 0-shaped:
![0 instance][instance_0]
### 8-shaped:
![8 instance][instance_8]
### 20x20:
![20x20 instance][instance_20]
### large:
![large instance][instance_xlarge]

[instance_0]: ./instances/0.png
[instance_8]: ./instances/8.png
[instance_20]: ./instances/20.png
[instance_xlarge]: ./instances/xlarge.png
