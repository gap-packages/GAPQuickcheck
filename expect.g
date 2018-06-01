#! @Chapter Expect Function.

#! The core of this package is the Expect function. It lets the user encapsulate a function that
#! that they wish to test and define the test. Currently, there are four ways to use Expect:
#! - To test that the result of a function satisfies certain predicates. To do this, encapsulate
#!   the function in Expect, pass it the argument generators using .given and call 
#!   .to_have_properties on it, listing the predicates that the result should satisfy.
#! @BeginExample
func := function(l)
  Sort(l);
  return l;
end;
Expect(func).given([QuickcheckList(QuickcheckInt)])
.to_have_properties(IsSortedList);
#! @EndExample

#! - To test that two functions, given the same data, return the same result. To do this, wrap
#!   one of the functions in Expect, pass it the argument generators it requires using
#!   .given, and the second function using .to_equal. To specify what arguments need to be given
#!   to the second function, the final function in the chain, .on_arguments, takes in a list
#!   of indices that specify which arguments of the ones given to the first function should be
#!   given to the second one.
#! @BeginExample
func1 := function(G, H)
  return Set(Intersection(G,H));
end;
func2 := function(G, H)
  return Intersection(Set(G), Set(H));
end;
Expect(func1)
.given([QuickcheckSmallPermutationGroup, QuickcheckSmallPermutationGroup])
.to_equal(func2)
.on_arguments([1,2]);
#! @EndExample

#! - To test that a function does not break. To do this, wrap the function in Expect, give it
#!   argument generators using .given and call .to_not_break on it. This test will only fail if
#!   the function breaks.
#! @BeginExample
Expect(Size)
.given([QuickcheckGroup])
.to_not_break();
#! @EndExample

#! - To test that a function breaks. This works in exactly the same way as the test for a 
#!   function not breaking but fails in all cases where .to_no_break passes and vice versa.
