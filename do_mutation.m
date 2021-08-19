% Evolutionary Computation
% Assignment - Edge Matching Puzzle
% Kimmo Kerminen 0358438

% Perform mutation by swapping locations and orientations between pieces

function mutatedChild = do_mutation(normalChild, indxOri, indxOriEnd, cornerSpots, otherBorder, otherLocs)
    mutProb = 0.4;
    % Initialize mutated child
    mutatedChild = normalChild;
    
    % Piece locations and orientations
    piecLoc = normalChild(1:16);
    piecOri = normalChild(indxOri:indxOriEnd);
    
    % Swap two corner pieces with each other
    if rand() < mutProb
        tmpLoc = piecLoc;
        tmpOri = piecOri;
        a = randi(4);
        b = randi(4);
        while a == b
            b = randi(4);
        end
        corner1 = cornerSpots(a);
        corner2 = cornerSpots(b);
        loc1 = find(piecLoc==corner1);
        loc2 = find(piecLoc==corner2);
        piecLoc(loc1) = tmpLoc(loc2);
        piecLoc(loc2) = tmpLoc(loc1);
        newOri1 = randi(4); newOri2 = randi(4);
        while newOri1 == tmpOri(loc1) && newOri2 == tmpOri(loc2)
            newOri1 = randi(4); newOri2 = randi(4);
        end
        piecOri(loc1) = newOri1;
        piecOri(loc2) = newOri2;
    end
%     piecOri(loc1) = tmpOri(loc2);
%     piecOri(loc2) = tmpOri(loc1);
    
    
    % Swap two other border pieces with each other
    if rand() < mutProb
        tmpLoc = piecLoc;
        tmpOri = piecOri;
        a = randi(8);
        b = randi(8);
        while a == b
            b = randi(8);
        end
        corner1 = otherBorder(a);
        corner2 = otherBorder(b);
        loc1 = find(piecLoc==corner1);
        loc2 = find(piecLoc==corner2);
        piecLoc(loc1) = tmpLoc(loc2);
        piecLoc(loc2) = tmpLoc(loc1);
        newOri1 = randi(4); newOri2 = randi(4);
        while newOri1 == tmpOri(loc1) && newOri2 == tmpOri(loc2)
            newOri1 = randi(4); newOri2 = randi(4);
        end
        piecOri(loc1) = newOri1;
        piecOri(loc2) = newOri2;
    end
%     piecOri(loc1) = tmpOri(loc2);
%     piecOri(loc2) = tmpOri(loc1);
    
    % Swap two center pieces with each other
    if rand() < mutProb
        tmpLoc = piecLoc;
        tmpOri = piecOri;
        a = randi(4);
        b = randi(4);
        while a == b
            b = randi(4);
        end
        corner1 = otherLocs(a);
        corner2 = otherLocs(b);
        loc1 = find(piecLoc==corner1);
        loc2 = find(piecLoc==corner2);
        piecLoc(loc1) = tmpLoc(loc2);
        piecLoc(loc2) = tmpLoc(loc1);
        newOri1 = randi(4); newOri2 = randi(4);
        while newOri1 == tmpOri(loc1) && newOri2 == tmpOri(loc2)
            newOri1 = randi(4); newOri2 = randi(4);
        end
        piecOri(loc1) = newOri1;
        piecOri(loc2) = newOri2;
    end
%     piecOri(loc1) = tmpOri(loc2);
%     piecOri(loc2) = tmpOri(loc1);
    
    
    mutatedChild(1:16) = piecLoc;
    mutatedChild(indxOri:indxOriEnd) = piecOri;
end