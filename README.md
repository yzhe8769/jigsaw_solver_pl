# jigsaw sudoku solver by Yixing Zheng
# 2017/11

# modules used
* lists -> provides predicates to work with list (member, append, nth0 etc)
* apply -> provides meta-predicates that apply a predicate on all members of a list (maplist)
* clpfd -> provides Constraint Logic Programming over Finite Domains (invs)
# predicates and functionalities
* setup / 0 : set up the environment by setting the prolog flag to display the whole answer
* legalcell / 1: predicate that checks whether a cell is legal by verifing that the range is between 1 and 9
* myflatten/2 : predicate that returns
    *  True if the second argument is the flatten version of the first nested list 		
    *  False if not or if the first argument is not a nested list
* mylength / 2: swap the order of arguments for the built-in length predicate for the use of maplist
* completegrid / 1: predicate that checks whether the given geometry satisfy all conditions
* abs_less_than_one / 2: predicate that returns true if abs(A - B) <= 1, otherwise, false
* isadjacent / 2: predicate that returns true if two points are adjacent to each other, otherwise, false
* isreachable / 4: predicate that checks whether B is reachable from A, true if reachable, false otherwise
* contiguousgrid / 1 : predicate that returns true if the given region is contiguous, otherwise, false
* getNumber / 4: predicate that retrieves the Num located at [X, Y] in the Grid
* checkregion / 3: predicate that collects all the numbers for a specific region given a completed grid
* checkregions / 2: predicate that checks any regions have duplicates given a Grid and the Geometry
* solve / 2: predicate that returns true only if all the following conditions are satisfied:
	* The Geometry given is complete which means it represents a 9 by 9 grid, coordinates range from 1 to 9
	* All regions in the geometry are contiguous
   * The Grid given is a 9 by 9 grid
   * The puzzle is solvable
# How to Test
* ## Load the file
    * run ```[jigsaw].``` to load the prolog program
* ## Setup
    * run ```setup().``` to set the flag to expand all answers
* ## Task 1
    *  run ```badgrid(G), writeln(G),completegrid(G).```
* ## Task 2
    * Positive tests: run ```contiguous(R), contiguousgrid(R).``` then press ';'
    * Negative tests: run ```noncontiguous(R), contiguousgrid(R).```
* ## Task 3
    *  run ```test(N, Grid, Geom), solve(Grid, Geom).``` and press ';' to move to the next test. 
![jigsaw](https://github.com/yzhe8769/comp3109_assignment4_jigsaw/blob/master/jigsaw_puzzle.jpg)
