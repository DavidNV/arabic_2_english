`Please write a ruby script which translate arabic numerals into english numerals.

It should be like

$ ruby arabic2english.rb 1
one

$ ruby arabic2english.rb 11
eleven

$ ruby arabic2english.rb 100
one hundred
Please implement it with TDD so the result should consist of the commits of a new failed test, a code change to pass the failed test, and refactoring.`

Steps:
 1. Slice 3 digits from the input
 2. Declare things that will not change like tens root and it's permutations
 3. Define paths for the min values for the hundreds slice
 4. Consider special cases (0 between values, a full zeros slice, etc)
 5. Remove useless code.
