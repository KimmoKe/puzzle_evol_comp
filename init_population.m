% Evolutionary Computation
% Assignment - Edge Matching Puzzle
% Kimmo Kerminen 0358438

% Initialize population

function curPop = init_population(pieces, indxOri, indxOriEnd, popSize, numOfPieces, cornerSpots, otherBorder, otherLocs)
    
    % Initialize candidate
    curPop = zeros(popSize,numOfPieces*2+2); % Piece locations, orientations and fitness values (borders, edges)
    for i = 1:popSize
        % Initialize locations and randomize orientations
        posPieces = zeros(1,numOfPieces);
        oriPieces = randi([1 4],1,numOfPieces);
        % Go through the pieces
        for j = 1:numOfPieces
            % Check if the piece has black edges
            hasBlack = sum(ismember(pieces(j).colors, 'k'));
            if hasBlack == 2
                % Corner piece -> put in a corner
                pieceLoc = cornerSpots(randi(4));
                while sum(find(posPieces==pieceLoc)) > 0
                    pieceLoc = cornerSpots(randi(4));
                end
                posPieces(j) = pieceLoc;
            elseif hasBlack == 1
                % Other border piece -> put in on the border
                pieceLoc = otherBorder(randi(8));
                while sum(find(posPieces==pieceLoc)) > 0
                    pieceLoc = otherBorder(randi(8));
                end
                posPieces(j) = pieceLoc;
            else
                % Otherwise center of the board
                pieceLoc = otherLocs(randi(4));
                while sum(find(posPieces==pieceLoc)) > 0
                    pieceLoc = otherLocs(randi(4));
                end
                posPieces(j) = pieceLoc;
            end
        end
        % Save locations and orientations
        curPop(i,1:numOfPieces) = posPieces;
        curPop(i,indxOri:indxOriEnd) = oriPieces;
        % Evaluate fitness
        [borderFit, edgeFit] = fit_eval(pieces, curPop(i,:), indxOri, indxOriEnd);
        curPop(i,end-1) = borderFit;
        curPop(i,end) = edgeFit;
    end
end