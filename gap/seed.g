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
