stabilizationIndex = method()
stabilizationIndex List := dimList -> (
    if #dimList < 2 then return 0;
    i := #dimList - 1;
    while i > 0 and dimList#(i-1) == dimList#i do i = i - 1;
    if i == #dimList - 1 then 0 else i + 1
    )
