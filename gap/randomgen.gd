################################################################################################
##
## Declaration of random argument generator functions for the GAP Quickcheck package.
##
## Copyright (C) 2018 University of St. Andrews, North Haugh, St. Andrews, Fife
##                                                KY16 9SS, Scotland
##

#! @Arguments max, randomsource
#! @Returns a random integer
#! @Description
#!  Creates a random integer in the range of 1-max using the random source provided.
DeclareGlobalFunction("QuickcheckInt");

#! @Arguments generator
#! @Returns a function that creates a random list
#! @Description
#!  Makes a function that takes in two arguments- a maximum size and a random source, and 
#!  returns a list of size less than or equal to max of objects created by the generator
#!  function. The generator function must also take in two arguments- a maximum size and a random
#!  source.
DeclareGlobalFunction("QuickcheckList");

#! @Arguments generator
#! @Returns a function that creates a random set
#! @Description
#!  Makes a function that takes in two arguments- a maximum size and a random source, and
#!  returns a set of size less than or equal to max of objects created by the generator function.
#!  The generator function must also take in two arguments- a maximum size and a random source.
DeclareGlobalFunction("QuickcheckSet");

#! @Arguments constructor, arg_gens
#! @Returns a function that creates a random object
#! @Description
#!  Makes a function that, given a maximum size and a random source, generates an object using
#!  the constructor function provided, whose arguments are generated by the arg_gens list.
#!  arg_gens must be a list of functions, each of which takes a maximum size and a random 
#!  source.
DeclareGlobalFunction("QuickcheckObject");

#! @Arguments attribute_names, arg_gens
#! @Returns a function that creates a random record
#! @Description
#!  Makes a function that, given a maximum size and a random source, generates a record whose
#!  fields have the names given by attribute_names and values generated by arg_gens. 
#!  attribute_names must be a list of strings. arg_gens
#!  must be a list of functions, each of which takes a maximum size and a random source.
DeclareGlobalFunction("QuickcheckRecord");

#! @Arguments max, randomsource
#! @Returns a random permutation
#! @Description
#!  Generates a permutation of size no more than the given maximum with the random source 
#!  provided using Floyd's algorithm.
DeclareGlobalFunction("QuickcheckPermutation");

#! @Arguments max, randomsource
#! @Returns a random Abelian group
#! @Description
#!  Generates an Abelian group of size no more than the maximum size given by creating a list of
#!  random integers using the provided random source and constructing the group with those.
DeclareGlobalFunction("QuickcheckAbelianGroup");

#! @Arguments max, randomsource
#! @Returns a quaternion group
#! @Description
#!  Generates a quaternion group of maximum size given rounded up to the nearest multiple of 4.
DeclareGlobalFunction("QuickcheckQuaternionGroup");

#! @Arguments max, randomsource
#! @Returns a dihedral group
#! @Description
#!  Generates a dihedral group of the maximum size given rounded up to the nearest multiple of 4.
DeclareGlobalFunction("QuickcheckDihedralGroup");

#! @Arguments max, randomsource
#! @Returns a random permutation group.
#! @Description
#!  Generates a permutation group by creating a list of permutations of size no more than the
#!  given maximum and constructing the group using that list.
DeclareGlobalFunction("QuickcheckPermutationGroup");

#! @Arguments max, randomsource
#! @Returns a random small permutation group
#! @Description
#!  Selects a random group of size max from the Small Groups package.
DeclareGlobalFunction("QuickcheckSmallPermutationGroup");

#! @Arguments max, randomsource
#! @Returns a random coset
#! @Description
#!  Generates a coset by multiplying a random permutation group and a random permutation.
DeclareGlobalFunction("QuickcheckCoset");

#! @Arguments max, randomsource
#! @Returns a random digraph
#! @Description
#!  Generates a digraph by creating a range of enumerated nodes of size no more than the given
#!  maximum and also source and range lists that are random samples of that list.
DeclareGlobalFunction("QuickcheckDigraph");

#! @Arguments max, randomsource
#! @Returns a cyclic group
#! @Description
#!  Generates the cyclic group of the size provided.
DeclareGlobalFunction("QuickcheckCyclicGroup");

#! @Arguments max, randomsource
#! @Returns a free Abelian group
#! @Description
#!  Generate the free Abelian group of the size provided.
DeclareGlobalFunction("QuickcheckFreeAbelianGroup");

#! @Arguments max, randomsource
#! @Returns a random group.
#! @Description
#!  Selects a random group constructor and calls it with the max and randomsource arguments.
DeclareGlobalFunction("QuickcheckGroup");
