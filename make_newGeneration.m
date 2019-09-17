function [ new_fishLimits ] = make_newGeneration( popSize, fitness, fishLimits, evoNoise )
%MAKE_NEWGENERATION Summary of this function goes here
%   Detailed explanation goes here

    new_fishLimits = zeros(popSize,2);
    
    [ numBabies ] = pick_Fish2Breed( fitness, popSize );
    
    counter = 0;
    for i = 1:popSize
        for j = 1:numBabies(i)
            counter = counter + 1;
            new_fishLimits(counter,:) =  make_oneBaby( fishLimits(i,:), evoNoise );
        end
    end


end

