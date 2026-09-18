leafPattern3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)}
numericLabeling3L = hashTable{A => 0, C => 1, G => 2, T => 3}
groupLabeling3L = hashTable{A => {0,0}, C => {0,1}, G => {1,0}, T => {1,1}}
leafPatternDict3L = getLeafPatternDict(leafPattern3L,numericLabeling3L,groupLabeling3L)
