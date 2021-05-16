function placeCell = selectPlaceCell(path)
    %{
    Given the path, return a boolean vector in the same length as number of 
    total neurons in that session, with 1 corrsponding to place cells to 
    include in further analysis, 0 elsewhere
    %}
    
    load(path);
    sig = processed.splithalf.wholemap_unmatched.p < 0.05;
    placeCell = processed.exclude.SFPs & sig;
    
end