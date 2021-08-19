% Evolutionary Computation
% Assignment - Edge Matching Puzzle
% Kimmo Kerminen 0358438

% Rotate pieces according to their orientations
% Used during plotting and fitness evaluation

function orientedPieces = rotate_pieces(pieces, posPieces, oriPieces)
    
    % Initialize output
    orientedPieces = pieces;
    
    % Rotate the pieces
    for i = 1:16
        % Current orientation
        curOri = oriPieces(i);
        % Perform rotation
        for j = 1:4
            orientedPieces(posPieces(i)).colors(j) = ...
                    pieces(posPieces(i)).colors(curOri);
            if curOri == 4, curOri = 1; else curOri = curOri + 1; end
        end
    end
    
end