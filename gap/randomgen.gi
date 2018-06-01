################################################################################################
##
## Implementation of random argument generator functions for the GAP Quickcheck package.
##
## Copyright (C) 2018 University of St. Andrews, North Haugh, St. Andrews, Fife
##                                                KY16 9SS, Scotland
##

InstallGlobalFunction(QuickcheckInt, function(max, randomsource)
  return Random(randomsource, [1..max]);
end);

InstallGlobalFunction(QuickcheckList, function(generator)
  return function(max, randomsource)
    local length, result, i;
    length := Random(randomsource, [1..max]);
    result := [];
    for i in [1..length] do
      Add(result, generator(max, randomsource));
    od;
    return result;
  end;
end);

InstallGlobalFunction(QuickcheckSet, function(generator)
  return function(max, randomsource)
    local length, result, i, member;
    length := Random(randomsource, [1..max]);
    result := [];
    for i in [0..length] do
      member := generator(max, randomsource);
      while member in result do
        member := generator(max, randomsource);
      od;
      Add(result, member);
    od;
    return Set(result);
  end;
end);

InstallGlobalFunction(QuickcheckObject, function(constructor, arg_gens)
  return function(max, randomsource)
    local arg, arg_list;
    arg_list := [];
    for arg in arg_gens do
      Add(arg_list, arg(max, randomsource));
    od;
    return CallFuncList(constructor, arg_list);
  end;
end);

InstallGlobalFunction(QuickcheckRecord, function(attribute_names, arg_gens)
  return function(max, randomsource)
    local result, i;
    result := rec();
    for i in [1..Length(arg_gens)] do
      result.(attribute_names[i]) := arg_gens[i](max, randomsource);
    od;
    return result;
  end;
end);

InstallGlobalFunction(QuickcheckPermutation, function(max, randomsource)
  return PermList(FLOYDS_ALGORITHM(randomsource,max,true));
end);

InstallGlobalFunction(QuickcheckAbelianGroup, function(max, randomsource)
  local i, size, ints;
  size := Random(randomsource, [1..max]);
  ints := [];
  for i in [0..size] do
    Add(ints, Random(randomsource, [1..max]));
  od;
  return AbelianGroup(ints);
end);

InstallGlobalFunction(QuickcheckQuaternionGroup, function(max, randomsource)
  local rounded_size;
  rounded_size := max;
  while rounded_size mod 4 <> 0 do
    rounded_size := rounded_size + 1;
  od;
  return QuaternionGroup(rounded_size);
end);

InstallGlobalFunction(QuickcheckDihedralGroup, function(max, randomsource)
  local rounded_size;
  rounded_size := max;
  while rounded_size mod 4 <> 0 do
    rounded_size := rounded_size + 1;
  od;
  return DihedralGroup(rounded_size);
end);

InstallGlobalFunction(QuickcheckPermutationGroup, function(max, randomsource)
  local length, permutation_list, i;
  length := Random(randomsource, [1..max]);
  permutation_list := [];
  for i in [1..length] do
    Add(permutation_list, QuickcheckPermutation(max, randomsource));
  od;
  return CallFuncList(Group, permutation_list);
end);

InstallGlobalFunction(QuickcheckSmallPermutationGroup, function(max, randomsource)
  local size, number;
  size := Random(randomsource, [1..max]);
  number := Random(randomsource, [1..NrSmallGroups(size)]);
  return Range(IsomorphismPermGroup(SmallGroup(size,number)));
end);

InstallGlobalFunction(QuickcheckCoset, function(max, randomsource)
  return QuickcheckPermutationGroup(max, randomsource) * QuickcheckPermutation(max,randomsource);
end);

InstallGlobalFunction(QuickcheckDigraph, function(max, randomsource)
  local length, nodes, no_links, source, range, i;
  length := Random(randomsource, [1..max]);
  no_links := Random(randomsource, [1..length]);
  nodes := [1..length];
  source := [];
  range := [];
  for i in [1..no_links] do
    Add(source, Random(randomsource, nodes));
    Add(range, Random(randomsource, nodes));
  od;
  return Digraph(nodes, source, range);
end);

InstallGlobalFunction(QuickcheckCyclicGroup, function(max, randomsource)
  return CyclicGroup(max);
end);

InstallGlobalFunction(QuickcheckFreeAbelianGroup, function(max, randomsource)
  return FreeAbelianGroup(max);
end);

InstallGlobalFunction(QuickcheckGroup, function(max, randomsource)
  local type, size, group_types;
  group_types := [
    QuickcheckCyclicGroup,
    QuickcheckAbelianGroup,
    QuickcheckFreeAbelianGroup,
    QuickcheckDihedralGroup,
    QuickcheckQuaternionGroup,
    QuickcheckPermutationGroup,
    QuickcheckSmallPermutationGroup
  ];
  type := Random(randomsource, [1..Length(group_types)]);
  size := Random(randomsource, [1..max]);
  return group_types[type](size, randomsource);
end);
