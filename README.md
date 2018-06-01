The GAP 4 package `GAPQuickcheck'
==============================
This is a prototype of a property testing package, taking inspiration from the Haskell 
Quickcheck[1], Python Hypothesis[2] and Node.js Chai[3] libraries.

## Current Functionality

- Random generation of integers, permutations, some groups and other basic types.
- Generation of dependent types: lists, records and objects with more complex constructors.
- Running of a randomised test suite with properties that the result is expected to have or the
expected result.
- Saving seeds that resulted in failed tests cases to avoid untraceable bugs.

## Development Plans

- Allow filters to be passed to generators to generate more specific input.
- Shrink failed tests to the smallest failures.
- Compile into proper GAP package.

## API
The "randomgen.g" file contains functions for generating random input. All of these have the format of taking in a maximum size and returning an argument of that size or smaller. An exxception is the list generator, which takes another generator as an argument and returns a function for generating a list of those.

The "test_infrastructure.g" file has the functionality for running the tests. Currently available
testing functions are:

- Probing the result of a function for a list of given properties.

```gap
Expect(func).given(list_of_argument_generators).to_have_properties(list_of_expected_properties);
```

- Testing that two functions, if given access to the same set of arguments, produce the same
result. The test would call `func1` on the generated arguments and call `func2` on the 
arguments of `func` indicated by the provided list of indices.

```gap
Expect(func1).given(list_of_argument_generators).to_equal(func2).on_arguments(list_of_indices);
```

- Verifying that the function breaks, or doesn't break.
```gap
Expect(func).given(list_of_argument_generators).to_break();
```
```gap
Expect(func).given(list_of_argument_generators).to_not_break();
```

The maximum input size and the number of repetitions for each size can be changed with the functions `SetQuickcheckMaxSize` and `SetQuickcheckNumberOfReps` respectively.

## References

- [1] Haskell Quickcheck: https://hackage.haskell.org/package/QuickCheck
- [2] Hypothesis: https://hypothesis.works/
- [3] Node.js Chai: http://www.chaijs.com/
