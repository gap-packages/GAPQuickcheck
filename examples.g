#! @Chapter Examples of GAP Quickcheck package.

#! @BeginExample
func1 := function(G, H)
  return Set(Intersection(G,H));
end;
func2 := function(G, H)
  return Intersection(Set(G), Set(H));
end;
Expect(func1)
.given([QuickcheckSmallPermutationGroup, QuickcheckSmallPermutationGroup])
.to_equal(func2).on_arguments([1,2]);
#! @EndExample

# example for predicate checking with list sorting
func := function(l)
  Sort(l);
  return l;
end;
Expect(func).given([QuickcheckList(QuickcheckInt)]).to_have_properties(IsSortedList);

# examples for checking for breaks
Expect(Size).given([QuickcheckGroup]).to_not_break();
