# MAPF-project
MAPF project about abstraction

## TO DO:
- [x] add 2-3 [benchmark instances](/instances)
- [x] modify [asprilo for 8-connected grids](/asprilo/m/action-M-8.lp)
  - [x] change definition of direction
  - [x] add crossing collision
- [ ] implement:
  - [ ] [abstraction](/abstraction/clique.lp) WIP
    - [x] cliques
    - [x] edges                        (inefficient)
    - [x] maximization of clique sizes (inefficient)
    - [ ] orphans
    - [x] level
  - [x] visualisation (clingraph)
  - [ ] solving of abstraction
  - [ ] extending asprilo with constraints from solved abstraction
- [ ] run benchmarks
- [ ] try other abstraction:
  - [ ] corridor
  - [ ] crossroads
  - [ ] like in G-TAPF paper



## Instances:
### 20x20:
![20x20 instance][instance_20]
### large:
![large instance][instance_xlarge]

[instance_20]: ./instances/20.png
[instance_xlarge]: ./instances/xlarge.png
