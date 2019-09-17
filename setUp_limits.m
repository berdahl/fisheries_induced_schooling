function [ fishLimits ] = setUp_limits( popSize, method_limits )
%SETUP_LIMITS Summary of this function goes here
%   Detailed explanation goes here


fishLimits = ones(popSize,2);
%all random
if(method_limits==44)
    for i=1:popSize
        fishLimits(i,:) = sort(round(rand(1,2)*2000));
    end
end

%some other things to try:

%all the same
if(method_limits==1)
    fishLimits(:,1) = 400*ones(popSize,1);
    fishLimits(:,2) = 500*ones(popSize,1);
end

%all random
if(method_limits==2)
    for i=1:popSize
        fishLimits(i,:) = sort(round(rand(1,2)*100));
    end
end

%all random, but same size
if(method_limits==3)
    for i=1:popSize/2
        fishLimits(i,1) = round(rand(1,1)*100);
        fishLimits(i,2) = fishLimits(i,1) + 50;
    end
    for i=(popSize/2+1):popSize
        fishLimits(i,1) = 200 + round(rand(1,1)*100);
        fishLimits(i,2) = fishLimits(i,1) + 50;
    end
end





end

