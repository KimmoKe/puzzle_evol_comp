% Evolutionary Computation
% Assignment - Edge Matching Puzzle
% Kimmo Kerminen 0358438

clear all;clc;close all;

% Recording runtime
tic

% Load puzzle pieces
load pieces.mat
% The pieces are in a 1x16 struct that has the edge colors of each piece.
% The possible orientations for each piece are referred to as 1, 2, 3 and
% 4, this tells which edge of the piece is the top one. During plotting,
% the edge colors are plotted clockwise starting from the top edge.

% VARIABLES
% Do you want to plot the best candidate between generations? Also, after
% how many generations should the plot be updated?
plotGenBest = 1;
plotUpdateInterval = 10;
% Current generation
curGen = 1;
% Maximum number of generations
maxGen = 5000;
% Size of population
popSize = 3200;
% Mutation probability
mutProb = 0.4;
% Number of puzzle pieces
numOfPieces = 16;
% Indexes for finding the orientation of the pieces in the solution
% candidate vector
indxOri = numOfPieces+1;
indxOriEnd = numOfPieces*2;
% Specific spots on the board for different pieces
cornerSpots = [1 4 13 16];
otherBorder = [2 3 5 8 9 12 14 15];
otherLocs = [6 7 10 11];

% Initialize current population and find the best candidate
curPop = init_population(pieces, indxOri, indxOriEnd, popSize, numOfPieces, cornerSpots, otherBorder, otherLocs);
bestCandidateIndx = find_best(curPop);

% Plot current best candidate if needed
if plotGenBest == 1
    plot_puzzle(pieces,curPop(bestCandidateIndx,:),indxOri,indxOriEnd,curGen);
    drawnow;
end

% Initialize new population
newPop = curPop;

% Do crossover, mutation, survivor selection and check stopping criterion.
% In this case, until a solution is found or the maximum limit for
% generations is reached
while (curPop(bestCandidateIndx,end-1) ~= 16 || curPop(bestCandidateIndx,end) ~= 24) &&...
       curGen <= maxGen

    % Display number of every 100th generation
    if mod(curGen,100) == 0, disp(['Generation number: ', num2str(curGen)]); end

    % Create new generation
    for i = 1:popSize
        % Parent selection
        parent1 = curPop(i,1:end-2);
        parent2 = curPop(mod(i,popSize)+1,1:end-2);
        
        % Get child by crossover
        child = do_crossover(pieces, parent1, parent2, indxOri, indxOriEnd, numOfPieces, cornerSpots, otherBorder, otherLocs);
        
        % Mutate child
        child = do_mutation(child, indxOri, indxOriEnd, cornerSpots, otherBorder, otherLocs);
        newPop(i,:) = child;
        
        % Fitness evaluation
        [borderFit, edgeFit] = fit_eval(pieces, newPop(i,:), indxOri, indxOriEnd);
        newPop(i,end-1) = borderFit; newPop(i,end) = edgeFit;
    end
    
    % Survivor selection (tournament selection), prioritize correct borders
    % first then correct edges
    for i = 1:popSize
        if newPop(i,end-1) > curPop(i,end-1)
            curPop(i,:) = newPop(i,:);
        elseif newPop(i,end-1) == curPop(i,end-1)
            if newPop(i,end) > curPop(i,end)
                curPop(i,:) = newPop(i,:);
            end
        end
    end
    
    % Find current best candidate
    bestCandidateIndx = find_best(curPop);
    newBest = curPop(bestCandidateIndx, :);
    curGen = curGen + 1;
    
    % Plot the current best solution if flag is set
    if plotGenBest == 1 && mod(curGen,plotUpdateInterval) == 0 
        plot_puzzle(pieces,newBest,indxOri,indxOriEnd,curGen);
        drawnow;
    end
end
% end % while curGen <= maxGen

% Find best candidate
bestCandidateIndx = find_best(curPop);
plot_puzzle(pieces,curPop(bestCandidateIndx,:),indxOri,indxOriEnd,curGen);
drawnow;

% All's done
totalRuntime = datevec(toc./(60*60*24));
runHours = floor(totalRuntime(4));
runMinutes = floor(totalRuntime(5));
runSeconds = round(totalRuntime(6));

fprintf('Done\nTotal runtime: %d hours %d minutes %d seconds\n', ...
                               runHours, runMinutes, runSeconds);