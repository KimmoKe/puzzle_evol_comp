% Evolutionary Computation
% Assignment - Edge Matching Puzzle
% Kimmo Kerminen 0358438

% Plotting the puzzle

function [] = plot_puzzle(pieces, pieceVect, indxOri, indxOriEnd, curGen)
    
    % To clear previous plot
    hold off;
    
    % Plot marker size and type, and width of edge lines
    plotMarkSize = 15;
    plotMarker = 'o';
    edgeLineWidth = 3;
    
    % Fitness of the solution
    borderFit = pieceVect(end-1);
    edgeFit = pieceVect(end);
    
    % Get locations and orientations of pieces
    posPieces = pieceVect(1:16); 
    oriPieces = pieceVect(indxOri:indxOriEnd);
    
    % We need to go through all the pieces
    stepper = 1;
    
    % Rotate pieces to match the orientations
    piecs = rotate_pieces(pieces, posPieces, oriPieces);
    
    % Place pieces on the board, starting from lower left corner and
    % advancing left to right, bottom to top until upper right corner is
    % reached
    hold on %, grid on;
    for r = 1:4
        for c = 1:4
            % Center point of the piece
            centerX = c+.5;
            centerY = r+.5;
            
            % Plot pieces on the board. The colors are plotted clockwise 
            % starting from the top edge of the piece
            plot(centerX,centerY+.25,[plotMarker, piecs(posPieces(stepper)).colors{1}],...
                    'MarkerSize',plotMarkSize,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor',piecs(posPieces(stepper)).colors{1});
            plot(centerX+.25,centerY,[plotMarker, piecs(posPieces(stepper)).colors{2}],...
                    'MarkerSize',plotMarkSize,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor',piecs(posPieces(stepper)).colors{2});
            plot(centerX,centerY-.25,[plotMarker, piecs(posPieces(stepper)).colors{3}],...
                    'MarkerSize',plotMarkSize,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor',piecs(posPieces(stepper)).colors{3});
            plot(centerX-.25,centerY,[plotMarker, piecs(posPieces(stepper)).colors{4}],...
                    'MarkerSize',plotMarkSize,...
                    'MarkerEdgeColor','k',...
                    'MarkerFaceColor',piecs(posPieces(stepper)).colors{4});
            
            % Draw colored lines to indicate which edges and borders are
            % correct
            upSide = line_color(piecs, posPieces, stepper, r, c, 1);
            line([c c+1], [r+1 r+1], 'Color', upSide,'LineWidth',edgeLineWidth);
            rightSide = line_color(piecs, posPieces, stepper, r, c, 2);
            line([c+1 c+1], [r r+1], 'Color', rightSide,'LineWidth',edgeLineWidth);
            botSide = line_color(piecs, posPieces, stepper, r, c, 3);
            line([c c+1], [r r], 'Color', botSide,'LineWidth',edgeLineWidth);
            leftSide = line_color(piecs, posPieces, stepper, r, c, 4);
            line([c c], [r r+1], 'Color', leftSide,'LineWidth',edgeLineWidth);
            
            % Move on to next piece
            stepper = stepper + 1;
        end
    end
    axis([0 6 0 6]);
    axis square;
    title(['Generation: ', num2str(curGen),...
           ' | Borders :', num2str(borderFit),...
           ' | Edges: ', num2str(edgeFit)]);
end