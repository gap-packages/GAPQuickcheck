#! @Chapter Argument Generators
LoadPackage("GAPQuickcheck");

#! Functions in GAP Quickcheck are tested with random arguments. In order to provide those 
#! arguments, the package defines generator functions that take in two arguments- a maximum
#! size and a random source. From now on, we will refer to functions of that form as generator
#! functions. The random source has to be provided so that he testing engine has
#! a possibility of caching seeds that result in failing tests.
#! @BeginExample
rs := RandomSource(IsMersenneTwister, 42);
Print(QuickcheckInt(10, rs), "\n");
Print(QuickcheckPermutation(10, rs), "\n");
Print(QuickcheckSmallPermutationGroup(10, rs), "\n");
#! @EndExample

#! Generators are simply passed to the Expect function, which creates a random source and 
#! constructs arguments for the tested function.
#! @BeginExample
Expect(Size)
.given([QuickcheckGroup])
.to_not_break();
#! @EndExample

#! The package also exposes functions for creating composite arguments. The simplest of these are
#! list and set generators. They take a generator function and return a generator function:
#! @BeginExample
listgen := QuickcheckList(QuickcheckInt);
Print(listgen(10, rs), "\n");
setgen := QuickcheckSet(QuickcheckInt);
Print(setgen(10, rs), "\n");
#! @EndExample

#! One can also generate more complex objects using the object 
#! generator. This takes in a constructor and a list of arguments generators and creates a
#! generator function for the specific object. For example, one can construct an Abelian Group
#! this way (although a generator for it is already defined in the package).
#! @BeginExample
abeliangen := QuickcheckObject(AbelianGroup, [QuickcheckList(QuickcheckInt)]);
Print(abeliangen(10, rs), "\n");
#! @EndExample

#! Finally, a user can define their own generators. As mentioned earlier, a generator is a 
#! function that takes in a maximum size and a random source and produces an object. We can
#! therefore define a new generator for positive and negative integers.
#! @BeginExample
PosAndNegIntGen := function(max, randomsource)
  local coin;
  coin := Random(randomsource, [0..1]);
  if coin = 0 then
    return -QuickcheckInt(max, randomsource);
  else
    return QuickcheckInt(max, randomsource);
  fi;
end;
Print(QuickcheckList(PosAndNegIntGen)(10, rs), "\n");
#! @EndExample
