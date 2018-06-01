################################################################################################
##
## Implementation of the test infrastucture for the GAP Quickcheck package.
##
## Copyright (C) 2018 Univerisity of St. Andrews, North Haugh, St. Andrews, Fife
##                                                KY16 9SS, Scotland
##

#! @Arguments func
#! @Description
#!  Tests the provided function. See the tutorial for more detailed documentation.
DeclareGlobalFunction("Expect");

#! @Arguments new_max
#! @Description
#!  Sets the maximum size the Quickcheck will test to the provided new maximum.
DeclareGlobalFunction("SetQuickcheckMaxSize");

#! @Arguments new_no
#! @Description
#!  Set the number of tests Quickcheck will run for every size to the provided new number.
DeclareGlobalFunction("SetQuickcheckNumberOfReps");
