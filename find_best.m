% Evolutionary Computation
% Assignment - Edge Matching Puzzle
% Kimmo Kerminen 0358438

% Find best candidate
function indxBest = find_best(population)
    
    % Check if we have canditates that have correct borders
    allBordersIndx = find(population(:,end-1) == 16);
    
    if isempty(allBordersIndx) == 0
        % If we have candidates that have correct borders, check how many
        numOfCands = max(size(allBordersIndx));
        if numOfCands == 1
            % Just one candidate, return it
            indxBest = allBordersIndx;
        else
            % Many candidates, find the one with most correct edges
            temp = population(allBordersIndx,:);
            population(:,:) = NaN;
            population(allBordersIndx,:) = temp;
            [~,idx] = max(population(:,end));
            indxBest = idx;
        end
    else
        % No candidate has correct borders, find the ones with most corred
        % borders
        maxBorders = max(population(:,end-1));
        bestBorders = find(population(:,end-1) == maxBorders);
        % Check how many we have
        numOfCands = max(size(bestBorders));
        if numOfCands == 1
            % Just one candidate, return it
            indxBest = bestBorders;
        else
            % Many candidates, find the one with most correct edges
            temp = population(bestBorders,:);
            population(:,:) = NaN;
            population(bestBorders,:) = temp;
            [~,idx] = max(population(:,end));
            indxBest = idx;
        end
    end
    
end