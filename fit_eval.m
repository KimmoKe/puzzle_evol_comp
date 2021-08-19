% Evolutionary Computation
% Assignment - Edge Matching Puzzle
% Kimmo Kerminen 0358438

% Evaluating fitness
% The fitness is evaluated using two objectives, i.e. the outer edges of
% the puzzle must be black and the inner edge colors must match

function [borderFit, edgeFit] = fit_eval(pieces, pieceVect, indxOri, indxOriEnd)
    
    % For debugging
    borderDebug = 0; % max 16
    edgeDebug = 0; % max 24
    
    % Initialize fitness values
    borderFit = 0;
    edgeFit = 0;
    
    % Get locations and orientations of pieces
    posPieces = pieceVect(1:16); 
    oriPieces = pieceVect(indxOri:indxOriEnd);
    
    % We need to go through all the pieces
    stepper = 1;
    
    % Rotate pieces to match the orientations
    piecs = rotate_pieces(pieces, posPieces, oriPieces);
    
    % Go through the pieces, starting from lower left corner and
    % advancing left to right, bottom to top until upper right corner is
    % reached
    for r = 1:4
        for c = 1:4
            % Border check
            if c == 1 && r == 1
                % Lower left corner
                if strcmp(piecs(posPieces(stepper)).colors(3),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('ll 3'); end
                end
                if strcmp(piecs(posPieces(stepper)).colors(4),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('ll 4'); end
                end
            elseif c == 4 && r == 1
                % Lower right corner
                if strcmp(piecs(posPieces(stepper)).colors(2),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('lr 2'); end
                end
                if strcmp(piecs(posPieces(stepper)).colors(3),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('lr 3'); end
                end
            elseif c == 1 && r == 4
                % Upper left corner
                if strcmp(piecs(posPieces(stepper)).colors(1),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('ul 1'); end
                end
                if strcmp(piecs(posPieces(stepper)).colors(4),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('ul 4'); end
                end
            elseif c == 4 && r == 4
                % Upper right corner
                if strcmp(piecs(posPieces(stepper)).colors(1),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('ur 1'); end
                end
                if strcmp(piecs(posPieces(stepper)).colors(2),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('ur 2'); end
                end
            elseif c == 1 && (r ~= 1 && r ~= 4)
                % Left side, not corner piece
                if strcmp(piecs(posPieces(stepper)).colors(4),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('ls 4'); end
                end
            elseif c == 4 && (r ~= 1 && r ~= 4)
                % Right side, not corner piece
                if strcmp(piecs(posPieces(stepper)).colors(2),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('rs 2'); end
                end
            elseif r == 1 && (c ~= 1 && c ~= 4)
                % Bottom row, not corner piece
                if strcmp(piecs(posPieces(stepper)).colors(3),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('br 3'); end
                end
            elseif r == 4 && (c ~= 1 && c ~= 4)
                % Upper row, not corner piece
                if strcmp(piecs(posPieces(stepper)).colors(1),'k') == 1
                    borderFit = borderFit + 1;
                    if borderDebug==1, disp('ur 1'); end
                end
            end
            
            % Edge check
            % Here we check the edges of each piece as follows. 
            % On the first row for each piece, except the one in column 4, 
            % we check if the color matches with the piece on the right.
            % On rows 2, 3 and 4 we check the if the edges match with the
            % piece on the right and below, except the pieces on column 4.
            % For pieces in column 4 on rows 2, 3 and 4, we check if  the 
            % edges match with the piece below.
            if r == 1 && c ~= 4
                if strcmp(piecs(posPieces(stepper)).colors(2), ...
                          piecs(posPieces(stepper+1)).colors(4)) == 1
                    % First row, check the right edge
                    edgeFit = edgeFit + 1;
                    if edgeDebug==1, disp('r1 24'); end
                end
            elseif r ~= 1 && c ~= 4
                if strcmp(piecs(posPieces(stepper)).colors(2), ...
                          piecs(posPieces(stepper+1)).colors(4)) == 1
                    % Row 2,3 or 4, check the right edge
                    edgeFit = edgeFit + 1;
                    if edgeDebug==1, disp('rx cx 24'); end
                end
                if strcmp(piecs(posPieces(stepper)).colors(3), ...
                          piecs(posPieces(stepper-4)).colors(1)) == 1
                    % Row 2,3 or 4, check the bottom edge
                    edgeFit = edgeFit + 1;
                    if edgeDebug==1, disp('rx cx 31'); end
                end
            elseif r ~= 1 && c == 4
                if strcmp(piecs(posPieces(stepper)).colors(3), ...
                          piecs(posPieces(stepper-4)).colors(1)) == 1
                    % Last column on row 2, 3 or 4, check the bottom edge
                    edgeFit = edgeFit + 1;
                    if edgeDebug==1, disp('rx c4 31'); end
                end
            end
            
            % Move on to next piece
            stepper = stepper + 1;
        end
    end

end