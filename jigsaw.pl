%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODULE USED
% This section imports all the modules used in the program
% lists -> provides predicates to work with list (member, append, nth0 etc)
% apply -> provides meta-predicates that apply a predicate on all members of a list (maplist)
% clpfd -> provides Constraint Logic Programming over Finite Domains (invs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(clpfd)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SETUP FUNCTION
% This section set up the environment by setting the prolog flag to display the whole answer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setup():- set_prolog_flag(answer_write_options,[quoted(true),portray(true),spacing(next_argument)]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Example Grid and Geometry Given %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grid(	[[3,_,_,_,_,_,_,_,4],
		[_,_,2,_,6,_,1,_,_],
		[_,1,_,9,_,8,_,2,_],
		[_,_,5,_,_,_,6,_,_],
		[_,2,_,_,_,_,_,1,_],
		[_,_,9,_,_,_,8,_,_],
		[_,8,_,3,_,4,_,6,_],
		[_,_,4,_,1,_,9,_,_],
		[5,_,_,_,_,_,_,_,7]]).
geometry([[[1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,1],[4,1],[4,2]],
		[[1,4],[2,4],[2,5],[2,6],[3,6],[3,7],[3,8],[4,8],[4,9]],
		[[1,5],[1,6],[1,7],[1,8],[1,9],[2,7],[2,8],[2,9],[3,9]],
		[[3,2],[3,3],[3,4],[3,5],[4,3],[5,1],[5,2],[5,3],[5,4]],
		[[4,4],[4,5],[4,6],[4,7],[5,5],[6,3],[6,4],[6,5],[6,6]],
		[[5,6],[5,7],[5,8],[5,9],[6,7],[7,5],[7,6],[7,7],[7,8]],
		[[6,1],[6,2],[7,2],[7,3],[7,4],[8,4],[8,5],[8,6],[9,6]],
		[[6,8],[6,9],[7,9],[8,7],[8,8],[8,9],[9,7],[9,8],[9,9]],
		[[7,1],[8,1],[8,2],[8,3],[9,1],[9,2],[9,3],[9,4],[9,5]]]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST CASES FOR TASK 1
% This section contains test cases for task 1
% To test the program, run 'badgrid(G), writeln(G),completegrid(G).'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bad grid, duplicate cells [9,8],[2,1]
badgrid([[[1,1],[1,2],[1,3],[2,1],[2,1],[2,2],[2,3],[2,4],[3,3]],
		 [[1,5],[1,6],[1,7],[1,8],[2,5],[2,6],[2,7],[3,7],[3,8]],
		 [[1,9],[2,8],[2,9],[3,9],[4,7],[4,8],[4,9],[5,8],[5,9]],
		 [[3,1],[4,1],[4,2],[3,2],[3,4],[4,3],[4,4],[5,3],[5,4]],
		 [[3,5],[3,6],[4,5],[4,6],[5,5],[6,4],[6,5],[7,4],[7,5]],
		 [[5,6],[5,7],[6,6],[6,7],[6,8],[6,9],[7,6],[7,8],[7,9]],
		 [[5,1],[5,2],[6,1],[6,2],[6,3],[7,1],[8,1],[8,2],[9,1]],
		 [[7,2],[7,3],[8,3],[8,4],[8,5],[9,2],[9,3],[9,4],[9,5]],
		 [[7,7],[8,6],[8,7],[8,8],[8,9],[9,6],[9,7],[9,8],[9,8]]]).
% Bad grid, missing a column
badgrid([[[1,1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,3],[2,4]],
		[[1,5],[1,6],[1,7],[1,8],[2,5],[2,6],[2,7],[3,7]],
		[[1,9],[2,8],[2,9],[3,9],[4,7],[4,8],[4,9],[5,8]],
		[[3,1],[4,1],[4,2],[3,2],[3,4],[4,3],[4,4],[5,3]],
		[[3,5],[3,6],[4,5],[4,6],[5,5],[6,4],[6,5],[7,4]],
		[[5,6],[5,7],[6,6],[6,7],[6,8],[6,9],[7,6],[7,8]],
		[[5,1],[5,2],[6,1],[6,2],[6,3],[7,1],[8,1],[8,2]],
		[[7,2],[7,3],[8,3],[8,4],[8,5],[9,2],[9,3],[9,4]],
		[[7,7],[8,6],[8,7],[8,8],[8,9],[9,6],[9,7],[9,8]]]).
% Bad grid, missing a row
badgrid([[[1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,2],[3,3],[3,4]],
		[[1,4],[1,5],[2,4],[2,5],[2,6],[2,7],[3,5],[3,6],[4,5]],
		[[1,6],[1,7],[1,8],[1,9],[2,8],[2,9],[3,9],[4,9],[5,9]],
		[[3,1],[4,1],[4,2],[5,2],[5,3],[6,2],[6,3],[7,2],[7,3]],
		[[4,3],[4,4],[5,4],[5,5],[5,6],[4,6],[6,4],[6,6],[6,7]],
		[[3,7],[3,8],[4,7],[4,8],[5,7],[5,8],[6,8],[6,9],[7,9]],
		[[5,1],[6,1],[7,1],[8,1],[9,1],[9,2],[8,2],[9,3],[9,4]],
		[[6,5],[7,4],[7,5],[8,3],[8,4],[8,5],[8,6],[9,5],[9,6]]]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST CASES FOR TASK 2
% This section contains test cases for task 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Positive tests: even though lengths for some of these regions are not 9, these regions are still all contiguous
% To test, run 'contiguous(R), contiguousgrid(R).' then press ';'
contiguous([[1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,2],[3,3],[3,4]]).
contiguous([[1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,2],[3,3]]).
contiguous([[1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,2]]).
contiguous([[1,1],[1,2],[1,3],[2,1],[2,2],[2,3]]).
contiguous([[1,1],[1,2],[1,3],[2,1],[2,2]]).
contiguous([[1,1],[1,2],[1,3],[2,1]]).
contiguous([[1,1],[1,2],[1,3]]).
contiguous([[1,1],[1,2]]).
contiguous([[1,1]]).
contiguous([]).
% To test, run 'noncontiguous(R), contiguousgrid(R).'
% Negative tests: regions that contain 2, 3, 4, 5 sub-regions
noncontiguous([[1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,2],[3,4]]).
noncontiguous([[1,1],[1,2],[1,3],[2,1],[2,3],[3,2],[3,4]]).
noncontiguous([[1,2],[1,3],[2,1],[2,3],[3,2],[3,4]]).
noncontiguous([[1,2],[2,1],[2,3],[3,2],[3,4]]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST CASES FOR TASK 3
% This section contains valid test cases for task 3
% To test the program, run 'test(N, Grid, Geom), solve(Grid, Geom).' and press ';' to move to the next test.
% Resource is found on https://krazydad.com/jigsawsudoku/sfiles/KD_Jigsaw_IM1_8_v1.pdf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test(1,
	[[3,_,_,_,_,_,_,_,4],
	[_,_,2,_,6,_,1,_,_],
	[_,1,_,9,_,8,_,2,_],
	[_,_,5,_,_,_,6,_,_],
	[_,2,_,_,_,_,_,1,_],
	[_,_,9,_,_,_,8,_,_],
	[_,8,_,3,_,4,_,6,_],
	[_,_,4,_,1,_,9,_,_],
	[5,_,_,_,_,_,_,_,7]],
	[[[1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,1],[4,1],[4,2]],
	[[1,4],[2,4],[2,5],[2,6],[3,6],[3,7],[3,8],[4,8],[4,9]],
	[[1,5],[1,6],[1,7],[1,8],[1,9],[2,7],[2,8],[2,9],[3,9]],
	[[3,2],[3,3],[3,4],[3,5],[4,3],[5,1],[5,2],[5,3],[5,4]],
	[[4,4],[4,5],[4,6],[4,7],[5,5],[6,3],[6,4],[6,5],[6,6]],
	[[5,6],[5,7],[5,8],[5,9],[6,7],[7,5],[7,6],[7,7],[7,8]],
	[[6,1],[6,2],[7,2],[7,3],[7,4],[8,4],[8,5],[8,6],[9,6]],
	[[6,8],[6,9],[7,9],[8,7],[8,8],[8,9],[9,7],[9,8],[9,9]],
	[[7,1],[8,1],[8,2],[8,3],[9,1],[9,2],[9,3],[9,4],[9,5]]]).
test(2,
	[[3,_,4,_,6,7,9,_,2],
	[_,2,_,_,_,_,_,5,_],
	[_,_,_,_,_,_,_,_,_],
	[_,_,_,2,_,4,_,_,_],
	[_,3,_,_,_,_,_,4,_],
	[_,_,_,9,_,2,_,_,_],
	[_,_,_,_,_,_,_,_,_],
	[_,8,_,_,_,_,_,1,_],
	[6,_,2,4,5,_,3,_,9]],
	[[[1,1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,3],[2,4],[3,3]],
	[[1,5],[1,6],[1,7],[1,8],[2,5],[2,6],[2,7],[3,7],[3,8]],
	[[1,9],[2,8],[2,9],[3,9],[4,7],[4,8],[4,9],[5,8],[5,9]],
	[[3,1],[4,1],[4,2],[3,2],[3,4],[4,3],[4,4],[5,3],[5,4]],
	[[3,5],[3,6],[4,5],[4,6],[5,5],[6,4],[6,5],[7,4],[7,5]],
	[[5,6],[5,7],[6,6],[6,7],[6,8],[6,9],[7,6],[7,8],[7,9]],
	[[5,1],[5,2],[6,1],[6,2],[6,3],[7,1],[8,1],[8,2],[9,1]],
	[[7,2],[7,3],[8,3],[8,4],[8,5],[9,2],[9,3],[9,4],[9,5]],
	[[7,7],[8,6],[8,7],[8,8],[8,9],[9,6],[9,7],[9,8],[9,9]]]).
test(3,
	[[_,_,_,_,_,_,2,_,_],
	[_,_,_,2,5,_,8,_,_],
	[_,_,_,_,4,_,_,_,_],
	[_,_,_,1,_,2,4,6,_],
	[6,_,_,_,_,_,_,_,7],
	[_,9,5,8,_,3,_,_,_],
	[_,_,_,_,6,_,_,_,_],
	[_,_,8,_,3,4,_,_,_],
	[_,_,1,_,_,_,_,_,_]],
	[[[1,1],[1,2],[1,3],[1,4],[1,5],[2,1],[2,2],[2,3],[3,1]],
	[[1,6],[1,7],[1,8],[1,9],[2,6],[2,7],[2,8],[2,9],[3,7]],
	[[2,4],[2,5],[3,2],[3,3],[3,4],[4,1],[4,2],[4,3],[5,2]],
	[[3,5],[3,6],[4,4],[4,5],[5,5],[6,5],[6,6],[7,4],[7,5]],
	[[5,1],[5,3],[5,4],[6,1],[6,2],[6,3],[6,4],[7,1],[7,2]],
	[[3,8],[3,9],[4,6],[4,7],[4,8],[4,9],[5,6],[5,7],[5,9]],
	[[8,1],[8,2],[8,3],[8,4],[9,1],[9,2],[9,3],[9,4],[7,3]],
	[[5,8],[6,7],[6,8],[6,9],[7,6],[7,7],[7,8],[8,5],[8,6]],
	[[7,9],[8,7],[8,8],[8,9],[9,5],[9,6],[9,7],[9,8],[9,9]]]).
test(4,
	[[_,3,4,_,_,_,_,_,6],
	 [_,_,_,2,_,_,8,1,_],
	 [_,_,_,1,6,_,_,_,_],
	 [_,_,_,_,_,_,9,_,_],
	 [9,5,_,_,_,_,_,7,4],
	 [_,_,7,_,_,_,_,_,_],
	 [_,_,_,_,7,5,_,_,_],
	 [_,4,8,_,_,1,_,_,_],
	 [2,_,_,_,_,_,7,3,_]],
	[[[1,1],[1,2],[1,3],[2,1],[2,2],[2,3],[3,2],[3,3],[3,4]],
	[[1,4],[1,5],[2,4],[2,5],[2,6],[2,7],[3,5],[3,6],[4,5]],
	[[1,6],[1,7],[1,8],[1,9],[2,8],[2,9],[3,9],[4,9],[5,9]],
	[[3,1],[4,1],[4,2],[5,2],[5,3],[6,2],[6,3],[7,2],[7,3]],
	[[4,3],[4,4],[5,4],[5,5],[5,6],[4,6],[6,4],[6,6],[6,7]],
	[[3,7],[3,8],[4,7],[4,8],[5,7],[5,8],[6,8],[6,9],[7,9]],
	[[5,1],[6,1],[7,1],[8,1],[9,1],[9,2],[8,2],[9,3],[9,4]],
	[[6,5],[7,4],[7,5],[8,3],[8,4],[8,5],[8,6],[9,5],[9,6]],
	[[7,6],[7,7],[7,8],[8,7],[8,8],[8,9],[9,7],[9,8],[9,9]]]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 1
% This section contains code for task 1
% completegrid/1 is the predicate to check if a geometry is a valid complete grid
% returns the grid if all the following conditions are satisified:
%   * The grid is 9 by 9 which means it has 9 rows and each row has 9 columns
%   * No sub-grid overlaps, which means that all [X,Y] pairs are unique
%   * The range of X and Y is from 1 to 9 inclusive
% Steps:
%	1. check whether the geometry list is 9 by 9
%	2. flatten the whole geometry list to a list containing all the points [X, Y]
%   3. check all points in the list to make sure that 1 <= X <= 9 and 1<= Y <= 9
%   4. use is_set predicate to verify that the list has no duplicate points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   TASK1 PREDICATE DESCRIPTIONS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% legalcell([X,Y]): predicate that checks whether a cell is legal by verifing that the range is between 1 and 9
% myflatten/2 : predicate that returns True if the second argument is the flatten version of the first nested list
% 									   False if not or if the first argument is not a nested list
% mylength/2: swap the order of arguments for the built-in length predicate for the use of maplist
% completegrid(Geom): predicate that checks whether the given geometry satisfy all conditions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   TASK1 CODE SECTION   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
legalcell([X,Y]):- between(1, 9, X), between(1, 9, Y).
myflatten([],[]).
myflatten([Row|Rest], Result):- myflatten(Rest, List), append(Row, List, Result).
mylength(Length, List):- length(List, Length).
completegrid(Geom):- length(Geom, 9), maplist(mylength(9), Geom), myflatten(Geom, Flat), maplist(legalcell, Flat), is_set(Flat).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 2
% This section contains code for task 2
% contiguousgrid/1 checks if region is contiguous
% Steps:
%	1. returns true for list that only contains one point or nothing
%   2. use the first point in the list, check if all other points are reachable using the first point
%   3. return true if all points are reachable, otherwise, false
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   TASK2 PREDICATE DESCRIPTIONS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% abs_less_than_one(A, B): predicate that returns true if abs(A - B) <= 1, otherwise, false
% isadjacent([X,Y], [U, V]): predicate that returns true if two points are adjacent to each other, otherwise, false
% isreachable / 4: predicate that checks whether B is reachable from A, true if reachable, false otherwise
% contiguousgrid/1 : predicate that returns true if the given region is contiguous, otherwise, false
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   TASK2 CODE SECTION   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
abs_less_than_one(A, B):- A > B, A - B =< 1,!.
abs_less_than_one(A, B):- B >= A, B - A =< 1.
isadjacent([X,Y], [U,V]) :- [X,Y] \= [U,V],
					(((Y is V), abs_less_than_one(X, U)),! ;
					((X is U), abs_less_than_one(Y, V))).
isreachable(A, Region, _, B):- member(A, Region), member(B, Region), isadjacent(A, B),!.
isreachable(A, Region, Visited, B):- A \= B,
									member(A, Region),
									member(B, Region),
									member(C, Region),
									not(member(C, Visited)),
									A \= C, B \= C,
									isadjacent(A, C),
									append([A], Visited, NewVisited),
									isreachable(C, Region, NewVisited,  B),!.
contiguousgrid([]):-!.
contiguousgrid(L):- length(L, 1),!.
contiguousgrid([First|Rest]):- maplist(isreachable(First, [First|Rest], []), Rest).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 3
% this section contains code for task 3
% solve/2 takes a Grid and the corresponding Geometry, returns false, if not solvable, otherwise, true		 
% Steps:
%	1. check whether the geometry given is a complete grid
%	2. check whether all regions in the geometry given are contiguous regions
%	3. check whether the grid given is 9 by 9
%	4. find a possible 9x9 grid based on the given grid
%   5. check whether each region contains only 9 distinct numbers from 1 to 9 inclusive
%   6. return only one possible solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   TASK3 PREDICATE DESCRIPTIONS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% getNumber(Grid, X, Y, Num): predicate that retrieves the Num located at [X, Y] in the Grid
% checkregion / 3: predicate that collects all the numbers for a specific region given a completed grid
% checkregions / 2: predicate that checks any regions have duplicates given a Grid and the Geometry
% solve / 2: predicate that returns true only if all the following conditions are satisfied:
%	* The Geometry given is complete which means it represents a 9 by 9 grid, coordinates range from 1 to 9
%	* All regions in the geometry are contiguous
%   * The Grid given is a 9 by 9 grid
%   * The puzzle is solvable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   TASK3 CODE SECTION   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getNumber(Grid, X, Y, Num):- nth1(X,Grid,Row), nth1(Y, Row, Num).
checkregion(_, [], []).
checkregion(Grid, [[X, Y]|Rest], [Num|Cdr]):- getNumber(Grid, X, Y, Num), checkregion(Grid, Rest, Cdr).
solve(Rows, Geom):-  completegrid(Geom),
					 maplist(contiguousgrid, Geom),
					 length(Rows, 9),
					 maplist(mylength(9), Rows),
					 append(Rows, Vs),
					 Vs ins 1..9,
					 maplist(all_distinct, Rows),
					 transpose(Rows, Columns),
					 maplist(all_distinct, Columns),
					 checkregions(Rows, Geom),!.
checkregions(_,[]).
checkregions(Grid, [First|Rest]):- checkregion(Grid, First, List), all_distinct(List), checkregions(Grid, Rest).
