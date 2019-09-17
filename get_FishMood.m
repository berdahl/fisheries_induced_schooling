function [ mood ] = get_FishMood( lowerLimit, upperLimit, GroupSize)
%GETFISHMOOD Summary of this function goes here
%   Detailed explanation goes here

    mood = 0;
    if(GroupSize>upperLimit)
        mood = 1;
    end
    if(GroupSize<lowerLimit)
        mood=-1;
    end


end

