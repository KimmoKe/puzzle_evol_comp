% Evolutionary Computation
% Assignment - Edge Matching Puzzle
% Kimmo Kerminen 0358438

% Plot coloring

function lineColor = line_color(pieces, posPieces, stepper, r, c, side)
    
    % On which side of the piece the line goes
    if side == 1
        % Top side
        if r == 4
            % Top row, if piece edge is black -> black line, else red line
            if strcmp(pieces(posPieces(stepper)).colors(side), 'k') == 1
                lineColor = 'k';
            else
                lineColor = 'r';
            end
        else
            % Other than top row, if color matches with the piece above ->
            % green line, else red line
            if strcmp(pieces(posPieces(stepper)).colors(side), ...
                      pieces(posPieces(stepper+4)).colors(3)) == 1
                lineColor = 'g';
            else
                lineColor = 'r';
            end
        end
    elseif side == 2
        % Right side
        if c == 4
            % Last column, if piece edge is black -> black line, else red
            % line
            if strcmp(pieces(posPieces(stepper)).colors(side), 'k') == 1
                lineColor = 'k';
            else
                lineColor = 'r';
            end
        else
            % Other than last column, if color matches with the piece on
            % the right -> green line, else red line
            if strcmp(pieces(posPieces(stepper)).colors(side), ...
                      pieces(posPieces(stepper+1)).colors(4)) == 1
                lineColor = 'g';
            else
                lineColor = 'r';
            end
        end
    elseif side == 3
        % Bottom side
        if r == 1
            % Bottom row, if piece edge is black -> black line, else red line
            if strcmp(pieces(posPieces(stepper)).colors(side), 'k') == 1
                lineColor = 'k';
            else
                lineColor = 'r';
            end
        else
            % Other than bottom row, if color matches with the piece below 
            % -> green line, else red line
            if strcmp(pieces(posPieces(stepper)).colors(side), ...
                      pieces(posPieces(stepper-4)).colors(1)) == 1
                lineColor = 'g';
            else
                lineColor = 'r';
            end
        end
    elseif side == 4
        % Left side
        if c == 1
            % First column, if piece edge is black -> black line, else red
            % line
            if strcmp(pieces(posPieces(stepper)).colors(side), 'k') == 1
                lineColor = 'k';
            else
                lineColor = 'r';
            end
        else
            % Other than first column, if color matches with the piece on
            % the left -> green line, else red line
            if strcmp(pieces(posPieces(stepper)).colors(side), ...
                      pieces(posPieces(stepper-1)).colors(2)) == 1
                lineColor = 'g';
            else
                lineColor = 'r';
            end
        end
    end

end