numericLabeling = hashTable{A => 0, C => 1, G => 2, T => 3};
groupLabeling = hashTable{A => {0,0}, C => {0,1}, G => {1,0}, T => {1,1}};
leafPatterns3L = {(A,A,A),(A,C,C),(C,A,C),(C,C,A),(C,G,T)};
leafPatterns4L = {
    (A,A,A,A),(A,A,C,C),(A,C,C,A),(A,C,A,C),(A,C,G,T),
    (C,A,C,A),(C,A,A,C),(C,A,G,T),(C,C,A,A),(C,C,C,C),
    (C,G,T,A),(C,G,C,G),(C,G,A,T),(C,C,G,G),(C,G,G,C)
    };
leafPatternDict3L = getLeafPatternDict(leafPatterns3L,numericLabeling,groupLabeling);
leafPatternDict4L = getLeafPatternDict(leafPatterns4L,numericLabeling,groupLabeling);
