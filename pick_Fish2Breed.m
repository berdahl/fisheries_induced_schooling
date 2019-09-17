function [ numBabies ] = pick_Fish2Breed( weights, popSize )
%PICKFISH Summary of this function goes here
%   Detailed explanation goes here

    x = cumsum([0 weights(:).'/sum(weights(:))]);
    x(end) = 1e3*eps + x(end);
    picker = rand(popSize,1);
    numBabies = histc(picker,x);
    numBabies(end)=[];

end


