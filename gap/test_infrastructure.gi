################################################################################################
##
## Implementation of the test infrastucture for the GAP Quickcheck package.
##
## Copyright (C) 2018 Univerisity of St. Andrews, North Haugh, St. Andrews, Fife
##                                                KY16 9SS, Scotland
##

max_size := 100;
no_reps := 1;
cache_file_name := ".gap-quickcheck-cache.g";
seed_db := fail;

SaveSeed := function()
  PrintTo(cache_file_name, "seed_db:=", seed_db, ";");
end;

GetSeed := function(func_name)
  if seed_db = fail then
    if IsExistingFile(cache_file_name) then
      Read(cache_file_name);
    else
      seed_db := rec();
    fi;
  fi;

  if IsBound(seed_db.(func_name)) then
    return seed_db.(func_name)[1];
  else
    return Random([1..10000]);
  fi;
end;

AddSeed := function(func_name, seed)
  if not IsBound(seed_db.(func_name)) then
    seed_db.(func_name) := [];
  fi;
  if not seed in seed_db.(func_name) then
    Add(seed_db.(func_name), seed);
  fi;
  SaveSeed();
end;

RemoveSeed := function(func_name, seed)
  local position;
  if not IsBound(seed_db.(func_name)) then
    return;
  fi;

  position := Position(seed_db.(func_name), seed);
  if position = fail then
    return;
  fi;

  Remove(seed_db.(func_name), position);
  SaveSeed();
end;

InstallGlobalFunction(Expect, function(func)
  local given, seed, rs;
  seed := GetSeed(NameFunction(func));
  rs := RandomSource(IsMersenneTwister, seed);
  given := function(arg_gens)
    local to_have_properties, to_equal, to_not_break, to_break;

    to_have_properties := function(props_list...)
      local result, args_list, i, j, arg, prop, tests_failed;
      tests_failed := 0;
      for i in [1..no_reps] do
        for j in [1..max_size] do
          args_list := [];
          for arg in arg_gens do
            Add(args_list, arg(j, rs));
          od;
          result := CallFuncList(func, args_list);
          for prop in props_list do
            if not prop(result) then
              tests_failed := tests_failed + 1;
              Print("Test failed with arguments:\n");
              AddSeed(NameFunction(func), seed);
              for arg in args_list do
                Print(arg, "\n");
              od;
            fi;
          od;
        od;
      od;
      Print(tests_failed, " tests failed, ", max_size * no_reps - tests_failed, " tests passed\n");
      if tests_failed = 0 then
        RemoveSeed(NameFunction(func), seed);
      fi;
    end;

    to_equal := function(func2)
      local on_arguments;
      on_arguments := function(list_of_indices)
          local result1, args_list, i, j, arg, tests_failed, index, args_list2, result2;
          tests_failed := 0;
          for i in [1..no_reps] do
            for j in [1..max_size] do
              args_list := [];
              for arg in arg_gens do
                Add(args_list, arg(j,rs));
              od;
              result1 := CallFuncList(func, args_list);
              # assemble the set of arguments for the second function
              args_list2 := [];
              for index in list_of_indices do
                Add(args_list2, args_list[index]);
              od;
              result2 := CallFuncList(func2, args_list2);
              if not result1 = result2 then
                tests_failed := tests_failed + 1;
                Print("Test failed with arguments:\n");
                AddSeed(NameFunction(func), seed);
                for arg in args_list do
                  Print(arg, "\n");
                od;
              fi;
            od;
          od;
          Print(tests_failed, " tests failed, ", max_size * no_reps - tests_failed, " tests passed\n");
      if tests_failed = 0 then
        RemoveSeed(NameFunction(func), seed);
      fi;
      end;
      return rec(on_arguments := on_arguments);
    end;

    to_not_break := function()
      local prev_value, args_list, i, j, exited_cleanly, tests_failed, arg;
      prev_value := BreakOnError;
      BreakOnError := false;
      tests_failed := 0;
      for i in [1..no_reps] do
        for j in [1..max_size] do
          args_list := [];
          for arg in arg_gens do
            Add(args_list, arg(j,rs));
          od;
          exited_cleanly := CALL_WITH_CATCH(func, args_list)[1];
          if not exited_cleanly then
              Print("Test failed with arguments:\n");
              AddSeed(NameFunction(func), seed);
              for arg in args_list do
                Print(arg, "\n");
              od;
              tests_failed := tests_failed + 1;
          fi;
        od;
      od;
      Print(tests_failed, " tests failed, ", max_size * no_reps - tests_failed, " tests passed\n");
      if tests_failed = 0 then
        RemoveSeed(NameFunction(func), seed);
      fi;
      BreakOnError := prev_value;
    end;

    to_break := function()
      local prev_value, args_list, i, j, exited_cleanly, tests_failed, arg;
      prev_value := BreakOnError;
      BreakOnError := false;
      tests_failed := 0;
      for i in [1..no_reps] do
        for j in [1..max_size] do
          args_list := [];
          for arg in arg_gens do
            Add(args_list, arg(j, rs));
          od;
          exited_cleanly := CALL_WITH_CATCH(func, args_list)[1];
          if exited_cleanly then
              Print("Test failed with arguments:\n");
              AddSeed(NameFunction(func), seed);
              for arg in args_list do
                Print(arg, "\n");
              od;
              tests_failed := tests_failed + 1;
          fi;
        od;
      od;
      Print(tests_failed, " tests failed, ", max_size * no_reps - tests_failed, " tests passed\n");
      if tests_failed = 0 then
        RemoveSeed(NameFunction(func), seed);
      fi;
      BreakOnError := prev_value;
    end;
    return rec(
    to_have_properties := to_have_properties,
    to_equal := to_equal,
    to_not_break := to_not_break,
    to_break := to_break
    );
  end;

  return rec(given := given);
end);

InstallGlobalFunction(SetQuickcheckMaxSize, function(new_max)
  max_size := new_max;
end);

InstallGlobalFunction(SetQuickcheckNumberOfReps, function(new_no)
  no_reps := new_no;
end);
