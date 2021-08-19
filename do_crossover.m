% Evolutionary Computation
% Assignment - Edge Matching Puzzle
% Kimmo Kerminen 0358438

% Perform crossover for locations and orientations

function child = do_crossover(pieces, parent1, parent2, indxOri, indxOriEnd, numOfPieces, cornerSpots, otherBorder, otherLocs)

    % Initialize child
    child = zeros(1,numOfPieces*2+2);
    
    % Create temporary placeholders
    tmpPos = zeros(1,16);
    tmpOri = zeros(1,16);
    % Parent locations and orientations
    p1Pos = parent1(1:numOfPieces);
    p1Ori = parent1(indxOri:indxOriEnd);
    p2Pos = parent2(1:numOfPieces);
    p2Ori = parent2(indxOri:indxOriEnd);
    % Choose random crossover point
    crossPoint = randi(numOfPieces-1);
    % Take pieces from parent1 until crossover point
    tmpPos(1:crossPoint) = p1Pos(1:crossPoint);
    tmpOri(1:crossPoint) = p1Ori(1:crossPoint);
    % Update what locations are taken
    for i = 1:crossPoint
        cornerSpots = cornerSpots(cornerSpots~=tmpPos(i));
        otherBorder = otherBorder(otherBorder~=tmpPos(i));
        otherLocs = otherLocs(otherLocs~=tmpPos(i));
    end
    % Last pieces from parent2
    curPiece = crossPoint + 1;
    for i = curPiece:16
        curIter = 1;
        crossPoint = i;
        % What piece we have
        hasBlack = sum(ismember(pieces(i).colors, 'k'));
        if hasBlack == 2
            nextLoc = p2Pos(crossPoint);
            while sum(find(cornerSpots==nextLoc)) == 0
                curIter = curIter + 1;
                crossPoint = crossPoint + 1;
                if crossPoint > numOfPieces, crossPoint = 1; end
                nextLoc = p2Pos(crossPoint);
                if curIter > 1000,tmpPos, nextLoc,hasBlack,cornerSpots, otherBorder, otherLocs, pause(), end
            end
            tmpPos(i) = nextLoc;
            tmpOri(i) = p2Ori(crossPoint);
            cornerSpots = cornerSpots(cornerSpots~=tmpPos(i));
        elseif hasBlack == 1
            nextLoc = p2Pos(crossPoint);
            while sum(find(otherBorder==nextLoc)) == 0
                curIter = curIter + 1;
                crossPoint = crossPoint + 1;
                if crossPoint > numOfPieces, crossPoint = 1; end
                nextLoc = p2Pos(crossPoint);
                if curIter > 1000,tmpPos, nextLoc,hasBlack,cornerSpots, otherBorder, otherLocs, pause(), end
            end
            tmpPos(i) = nextLoc;
            tmpOri(i) = p2Ori(crossPoint);
            otherBorder = otherBorder(otherBorder~=tmpPos(i));
        else
             nextLoc = p2Pos(crossPoint);
            while sum(find(otherLocs==nextLoc)) == 0
                curIter = curIter + 1;
                crossPoint = crossPoint + 1;
                if crossPoint > numOfPieces, crossPoint = 1; end
                nextLoc = p2Pos(crossPoint);
                if curIter > 1000,tmpPos, nextLoc,hasBlack,cornerSpots, otherBorder, otherLocs, pause(), end
            end
            tmpPos(i) = nextLoc;
            tmpOri(i) = p2Ori(crossPoint);
            otherLocs = otherLocs(otherLocs~=tmpPos(i));
        end
    end
    child(1:numOfPieces) = tmpPos;
    child(indxOri:indxOriEnd) = tmpOri;
end









%     curPiece = crossPoint + 1;
%     for i = curPiece:16
%         % What piece we have
%         hasBlack = sum(ismember(pieces(i).colors, 'k'));
%         if hasBlack == 2
%             % Corner piece
%             tmpPos(i) = cornerSpots(1);
%             tmpOri(i) = p2Ori(i);
%             cornerSpots = cornerSpots(cornerSpots~=tmpPos(i));
%         elseif hasBlack == 1
%             % Corner piece
%             tmpPos(i) = otherBorder(1);
%             tmpOri(i) = p2Ori(i);
%             otherBorder = otherBorder(otherBorder~=tmpPos(i));
%         elseif hasBlack == 0
%             % Corner piece
%             tmpPos(i) = otherLocs(1);
%             tmpOri(i) = p2Ori(i);
%             otherLocs = otherLocs(otherLocs~=tmpPos(i));
%         end
%     end
%     child(1:numOfPieces) = tmpPos;
%     child(indxOri:indxOriEnd) = tmpOri;